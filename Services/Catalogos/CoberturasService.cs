using Dapper;
using Microsoft.Data.SqlClient;
using scrweb_blazor.Models.Catalogos;
using System.Data;

namespace scrweb_blazor.Services.Catalogos
{
    public class CoberturasService
    {
        private string _connectionString = string.Empty;

        public CoberturasService(string connectionString)
        {
            _connectionString = connectionString;
        }

        // ========================================================================================
        // leemos la tabla desde el db y la regresamos con una linea en blanco 
        // esta es la lista para el FluentSelect 
        public async Task<List<Cobertura_sql>> leerCoberturas()
        {
            string query;
            List<Cobertura_sql>? list;

            query = $@"Select Null as Id, '' as Descripcion, '' as Abreviatura
                       Union 
                       Select Id, Descripcion, Abreviatura From Coberturas Order By Descripcion";

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                list = (await db.QueryAsync<Cobertura_sql>(query)).ToList();
            }

            return list;
        }

        // ========================================================================================
        // Para leer una cobertura a la tabla 
        public async Task<dynamic> LeerCobertura(string id)
        {
            string query;
            object parameters;

            query = $@"Select Id, Descripcion, Abreviatura From Coberturas Where Id = @id";

            parameters = new { id };
            Cobertura_sql? cobertura;

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    cobertura = await db.QueryFirstOrDefaultAsync<Cobertura_sql>(query, parameters);
                }
                catch (Exception ex)
                {
                    return new { error = true, message = ex.Message };
                }

            }

            return new
            {
                error = false,
                cobertura
            };
        }

        // ========================================================================================
        // Para agregar una cobertura a la tabla 
        public async Task<dynamic> AgregarCobertura(Cobertura_sql cobertura)
        {
            string query;
            int affectedRecords;

            query = $@"Insert Into Coberturas(Id, Descripcion, Abreviatura) Values (@Id, @Descripcion, @Abreviatura)
        ";

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    affectedRecords = await db.ExecuteAsync(query, cobertura);
                }
                catch (Exception ex)
                {
                    return new { error = true, message = ex.Message };
                }

            }

            return new { error = false };
        }

        // ========================================================================================
        // Para modificar una cobertura a la tabla 
        public async Task<dynamic> ModificarCobertura(Cobertura_sql cobertura)
        {
            string query;
            int affectedRecords;

            query = $@"Update Coberturas Set Descripcion = @Descripcion, Abreviatura = @Abreviatura Where Id = @Id";

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    affectedRecords = await db.ExecuteAsync(query, cobertura);
                }
                catch (Exception ex)
                {
                    return new { error = true, message = ex.Message };
                }

            }

            return new { error = false };
        }

        // ========================================================================================
        // Para eliminar una cobertura de la tabla (sql) 
        public async Task<dynamic> EliminarCobertura(string itemId)
        {
            string query;
            object parameters;
            int affectedRecords;

            query = $@"Delete From Coberturas Where Id = @Id";
            parameters = new { Id = itemId };

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    affectedRecords = await db.ExecuteAsync(query, parameters);
                }
                catch (Exception ex)
                {
                    return new { error = true, message = ex.Message };
                }

            }

            return new { error = false, affectedRecords };
        }
    }
}
