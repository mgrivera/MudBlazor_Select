using Dapper;
using Microsoft.Data.SqlClient;
using scrweb_blazor.Components.Pages.GeneralPages.SeleccionarCia;
using System.Data;

namespace scrweb_blazor.Services.Generales
{
    public class LeerEmpresaUsuariaSeleccionada
    {
        private string _connectionString = string.Empty;

        public LeerEmpresaUsuariaSeleccionada(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<dynamic> LeerEmpresaSeleccionada(string userId)
        {
            CiaSeleccionada_Simple? empresaUsuariaSeleccionada;

            string query;
            object parameters;

            query = $@"Select Id, CiaSeleccionada, Nombre, Abreviatura  
                       From CiaSeleccionada  
                       Where Usuario = @userId";

            parameters = new { userId };

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    empresaUsuariaSeleccionada = await db.QueryFirstOrDefaultAsync<CiaSeleccionada_Simple>(query, parameters);
                }
                catch (Exception ex)
                {
                    string message = ex.Message;
                    return new { error = true, message };
                }
            }

            if (empresaUsuariaSeleccionada is not null)
            {
                // Ok, el usuario tiene una empresa seleccionada en la tabla CiaSeleccionada - La regresamos ... 
                return new { error = false, empresaUsuariaSeleccionada }; 
            }

            // el usuario *no tiene* una empresa seleccionada 
            // leemos la cantidad de empresas usuarias; si solo hay una, la seleccionamos para el usuario 
            int cantidadEmpresas; 
            query = "Select Count(*) From Empresa";

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    cantidadEmpresas = await db.QueryFirstAsync<int>(query);
                }
                catch (Exception ex)
                {
                    string message = ex.Message;
                    return new { error = true, message };
                }
            }

            if (cantidadEmpresas == 1)
            {
                // Ok, solo hay 1 empresa en la tabla Empresa; la seleccionamos para el usuario 
                Empresa_Simple empresa;
                query = "Select Id, Nombre, Abreviatura From Empresa";

                using (IDbConnection db = new SqlConnection(_connectionString))
                {
                    try
                    {
                        empresa = await db.QueryFirstAsync<Empresa_Simple>(query);
                    }
                    catch (Exception ex)
                    {
                        string message = ex.Message;
                        return new { error = true, message };
                    }
                }

                // Ok, tenemos la empresa; la seleccionamos (automáticamente) para el usuario
                query = "Insert Into CiaSeleccionada(CiaSeleccionada, Nombre, Abreviatura, Usuario) Values (@Id, @Nombre, @Abreviatura, @userId)";
                parameters = new { empresa.Id, empresa.Nombre, empresa.Abreviatura, userId };
                int affectedRecords; 

                using (IDbConnection db = new SqlConnection(_connectionString))
                {
                    try
                    {
                        affectedRecords = await db.ExecuteAsync(query, parameters);

                        // aunque seleccionamos para el usuario, en forma automática, la *única* empresa que existe, regresamos con un error para que el usuario 
                        // regrese a Home y luego intente nuevamente esta página para que la compañía sea seleccionada en forma normal 
                        return new { 
                            error = true, 
                            message = @"Error inesperado al intentar leer una empresa usuaria seleccionada para el usuario.<br /> 
                                        <b><i>Por favor regrese a Home y luego regrese nuevamente a esta página.</i></b>" 
                        };
                    }
                    catch (Exception ex)
                    {
                        string message = ex.Message;
                        return new { error = true, message };
                    }
                }
            }

            return new { 
                error = true, 
                message = @"Error: aparentente Ud. no ha seleccionado una compañía.<br /> 
                            Por favor seleccione una compañía antes de intentar continuar con esta función." 
            };
        }

        // ============================================================================================================
        // para leer la cantidad de empresas usuarias que se han registrado en la tabla Empresa
        // si hay *solo una*, no mostramos la opción que permite al usuario seleccionada una cia usuaria 
        public async Task<int?> EmpresasUsuariasCount(string userId)
        {
            string query;
            int? cantidadEmpresas;
            query = "Select Count(*) From Empresa";

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                cantidadEmpresas = await db.QueryFirstOrDefaultAsync<int?>(query);
            }

            return cantidadEmpresas; 
        }
    }
}
