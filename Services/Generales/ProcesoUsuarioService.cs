using Dapper;
using Microsoft.Data.SqlClient;
using scrweb_blazor.Models.General;
using System.Data;

namespace scrweb_blazor.Services.Generales
{
    public class ProcesoUsuarioService
    {
        private string _connectionString = string.Empty;

        public ProcesoUsuarioService(string connectionString)
        {
            _connectionString = connectionString;
        }

        // ==================================================================================
        // para agregar un registro a la base de datos 
        public async Task<dynamic> Agregar(ProcesoUsuario procesoUsuario)
        {
            string query;
            int insertedItemId = 0;

            // Nótese lo que hacemos para obtener el Id del nuevo item 
            // 1) usamos la opción Output Inserted.Id (en el Sql Server Select) 
            // 2) usamos el método QuerySingle<int>, en vez de ExecuteAsync, en Dapper 
            query = $@"Insert Into ProcesosUsuarios(Fecha, Categoria, SubCategoria, Descripcion, Usuario, SubTituloReport)
                              OUTPUT INSERTED.Id
                              Values (@Fecha, @Categoria, @SubCategoria, @Descripcion, @Usuario, @SubTituloReport)";

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    if (!string.IsNullOrWhiteSpace(procesoUsuario.SubTituloReport) && procesoUsuario.SubTituloReport.Length > 100)
                    {
                        // nos aseguramos que el subtítulo no tenga más de 100 chars 
                        procesoUsuario.SubTituloReport = procesoUsuario.SubTituloReport.Substring(0, 100);
                    }
                        
                    insertedItemId = await db.QuerySingleAsync<int>(query, procesoUsuario);
                }
                catch (Exception ex)
                {
                    return new { error = true, message = ex.Message };
                }
            }

            return new
            {
                error = false,
                insertedItemId
            };
        }

        // ==================================================================================
        // para contar y regresar la cantidad de registros en la tabla para un usuario 
        // determinado 
        public async Task<dynamic> CountByUser(string userName)
        {
            string query;
            object parameters;
            int recCount; 

            query = $@"Select Count(*) as Count From ProcesosUsuarios Where Usuario = @userName";
            parameters = new { userName }; 

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    recCount = await db.QueryFirstOrDefaultAsync<int>(query, parameters);
                }
                catch (Exception ex)
                {
                    return new { error = true, message = ex.Message };
                }

            }

            return new
            {
                error = false,
                count = recCount 
            };
        }
    }
}