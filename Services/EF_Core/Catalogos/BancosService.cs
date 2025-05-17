using Microsoft.EntityFrameworkCore;
using scrweb_blazor.Models.EF_Core;

namespace scrweb_blazor.Services.EF_Core.Catalogos
{
    public class BancosService
    {
        // ===========================================================================================================
        // para leer y regresar todos los items desde el db 
        public async Task<dynamic> LeerItems(dbContext? dbcontext)
        {
            if (dbcontext is null)
            {
                return new { error = true, message = "Error: (ef core) dbContext is null (???!!!) en <em>ProcesosUsuario_EF_Service.CountByUser</em>." };
            }

            var items = await dbcontext.Bancos.OrderBy(x => x.Nombre).ToListAsync();

            return new
            {
                error = false,
                items
            };
        }

        // ===========================================================================================================
        // para recibir un item y agregar al db 
        public async Task<dynamic> Agregar(dbContext? dbcontext, Bancos banco)
        {
            if (dbcontext is null)
            {
                return new { error = true, message = "Error: (ef core) dbContext is null (???!!!) en <em>ProcesosUsuario_EF_Service.CountByUser</em>." };
            }

            // This just attaches.
            dbcontext.Bancos.Add(banco);

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
                banco
            };
        }

        // ===========================================================================================================
        // para recibir un item y modificarlo en el  db 
        public async Task<dynamic> Modificar(dbContext? dbcontext, Bancos banco)
        {
            if (dbcontext is null)
            {
                return new { error = true, message = "Error: (ef core) dbContext is null (???!!!) en <em>ProcesosUsuario_EF_Service.CountByUser</em>." };
            }

            // This just attaches.
            //dbcontext.Bancos.ExecuteUpdateAsync<Bancos>(banco);

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
                banco
            };
        }
    }
}
