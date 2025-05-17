using DocumentFormat.OpenXml.InkML;
using Microsoft.EntityFrameworkCore;
using scrweb_blazor.Models.EF_Core;

namespace scrweb_blazor.Services.EF_Core
{
    public class ProcesosUsuario_EF_Service
    {
        // ===========================================================================================================
        // para leer y regresar la cantidad de registros que tiene el usuario en la tabla ProcesosUsuario 
        public async Task<dynamic> CountByUser(dbContext? dbcontext, string userName)
        {
            if (dbcontext is null)
            {
                return new { error = true, message = "Error: (ef core) dbContext is null (???!!!) en <em>ProcesosUsuario_EF_Service.CountByUser</em>." };
            }

            int count = await dbcontext.ProcesosUsuarios.Where(x => x.Usuario == userName).CountAsync();

            return new
            {
                error = false,
                count
            };
        }

        // ===========================================================================================================
        // para leer y regresar la cantidad de registros que tiene el usuario en la tabla ProcesosUsuario 
        public async Task<dynamic> Agregar(dbContext? dbcontext, ProcesosUsuarios procesoUsuario)
        {
            if (dbcontext is null)
            {
                return new { error = true, message = "Error: (ef core) dbContext is null (???!!!) en <em>ProcesosUsuario_EF_Service.CountByUser</em>." };
            }

            // This just attaches.
            dbcontext.ProcesosUsuarios.Add(procesoUsuario);

            try
            {
                await dbcontext.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                string message = ex.Message;
                if (ex.InnerException is not null && !string.IsNullOrWhiteSpace(ex.InnerException.Message))
                {
                    message += $"<br />{ex.InnerException.Message}";
                }

                return new { error = true, message };
            }

            return new
            {
                error = false, 
                procesoUsuario
            };
        }
    }
}
