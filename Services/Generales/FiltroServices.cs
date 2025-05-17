using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;

namespace scrweb_blazor.Services.Generales
{
    public class FiltrosServices
    {
        private string _connectionString = string.Empty;

        public FiltrosServices(string connectionString)
        {
            _connectionString = connectionString;
        }

        // =============================================================================================
        // para leer un filtro en la tabla Filtros, para una forma y usuario en particular 
        public async Task<string?> LeerFiltro(string formName, string userId)
        {
            string? filtro = string.Empty;

            string query;
            object parameters;

            query = $@"Select filtro as filtro  
                       From Filtros 
                       Where userId = @userId And nombreForma = @formName";
            parameters = new { userId, formName };

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                filtro = await db.QueryFirstOrDefaultAsync<string>(query, parameters);
            }

            return filtro;
        }

        // =============================================================================================
        // para leer registrar un filtro en la tabla Filtros, para una forma y usuario en particular 
        public async Task GuardarFiltro(string formName, string userId, string filtro)
        {
            // intentamos leer un filtro; si existe uno, hacemos un update; de otra forma, hacemos un insert 
            int? id;
            string query;
            object parameters;

            query = $@"Select id 
                       From Filtros 
                       Where userId = @userId And nombreForma = @formName";
            parameters = new { userId, formName };

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                id = await db.QueryFirstOrDefaultAsync<int>(query, parameters);
            }

            if (id is not null && id != 0)
            {
                // el filtro existe, lo actualizamos con un update 
                query = $@"Update Filtros Set filtro = @filtro Where id = @id";
                parameters = new { filtro, id };
            }
            else
            {
                // el filtro *no* existe; lo agregamos con un insert 
                query = $@"Insert Filtros (userId, nombreForma, filtro) Values (@userId, @formName, @filtro)";
                parameters = new { userId, formName, filtro };
            }

            int affectedRecords;

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                affectedRecords = await db.ExecuteAsync(query, parameters);
            }
        }
    }
}

