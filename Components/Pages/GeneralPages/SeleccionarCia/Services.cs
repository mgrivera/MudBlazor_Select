using Dapper;
using Microsoft.Data.SqlClient;
using Microsoft.FluentUI.AspNetCore.Components;
using System.Data;

namespace scrweb_blazor.Components.Pages.GeneralPages.SeleccionarCia
{
    public class Services
    {
        private string _connectionString = string.Empty;

        public Services(string connectionString)
        {
            _connectionString = connectionString;
        }

        // ===================================================================================================
        // para leer y regresar una lista simple de compañías 
        public async Task<List<Empresa_Simple>> ListaEmpresas()
        {
            string query;

            var listaEmpresas = new List<Empresa_Simple>();

            query = $@"Select Id, Nombre, Abreviatura 
                    From Empresa
                    Order By Nombre";

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    listaEmpresas = (await db.QueryAsync<Empresa_Simple>(query)).AsList();
                }
                catch (Exception ex)
                {
                    var msg = ex.Message;
                }
            }

            return listaEmpresas;
        }

        // ===================================================================================================
        // para seleccionar una compañia para el usuario - grabamos un registro en CiaSeleccionada
        // para el usuario y compañía 
        public async Task<dynamic> SeleccionarEmpresa(string empresaId, string userId)
        {
            string query;
            object parameters;

            // ===================================================================================================
            // primero debemos saber si el usuario ya tiene un registro en la tabla 
            query = @"Select ID From CiaSeleccionada Where Usuario = @userId";

            parameters = new { userId };
            int? recordId = null;

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                recordId = await db.QuerySingleOrDefaultAsync<int?>(query, parameters);
            }

            // siempre leemos el nombre y nombreCorto de la compañía que se intenta seleccionar, pues al final, es el resultado de este method 
            query = @"Select Id, Nombre, Abreviatura From Empresa Where Id = @empresaId";
            parameters = new { empresaId };

            Empresa_Simple empresaSeleccionada;

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    empresaSeleccionada = await db.QueryFirstAsync<Empresa_Simple>(query, parameters);
                }
                catch (Exception ex)
                {
                    string message = ex.Message;
                    return new { error = true, message };
                }
            }

            if (recordId is null)
            {
                // no hay un registro en la tabla CiaSeleccionada; agregamos uno 
                // ya tenemos el nombre y nombreCorto de la compañía; ahora agregamos un registro en CiaSeleccionada 
                query = $@"Insert Into CiaSeleccionada (CiaSeleccionada, Nombre, Abreviatura, Usuario) 
                                    Values (@empresaId, @Nombre, @Abreviatura, @userId)";
                parameters = new { empresaId, empresaSeleccionada.Nombre, empresaSeleccionada.Abreviatura, userId };
            }
            else
            {
                // ya hay un registro en la tabla; simplemente, actualizamos 
                parameters = new { empresaId, userId };
                query = "Update CiaSeleccionada Set CiaSeleccionada = @empresaId Where Usuario = @userId";
            }

            int affectedRows;

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    affectedRows = await db.ExecuteAsync(query, parameters);
                }
                catch (Exception ex)
                {
                    string message = ex.Message;
                    return new { error = true, message }; 
                }
            }

            return new
            {
                error = false,
                empresaSeleccionada
            }; 
        }

        // =================================================================================================
        // para leer la empresa que el usuario ha seleccionado, desde la tabla CiaSeleccionada 
        public async Task<dynamic> LeerEmpresaSeleccionada(string userId)
        {
            CiaSeleccionada_Simple? empresaSeleccionada;

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
                    empresaSeleccionada = await db.QueryFirstOrDefaultAsync<CiaSeleccionada_Simple>(query, parameters);
                }
                catch (Exception ex)
                {
                    string message = ex.Message;
                    return new { error = true, message };
                }
            }

            return new { error = false, empresaSeleccionada };
        }
    }
}
