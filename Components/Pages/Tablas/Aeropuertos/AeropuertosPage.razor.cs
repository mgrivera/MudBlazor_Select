
using Microsoft.EntityFrameworkCore;
using MudBlazor;

namespace scrweb_blazor.Components.Pages.Tablas.AeropuertosPage
{
    public partial class AeropuertosPage
    {
        private List<Ciudad_dto>? _ciudades;
        private List<Aeropuerto_dto>? _aeropuertos;

        AlertSettings _alertSettings = new(Severity.Info, false, "");

        private bool _grabarLoading = false; 

        protected override async Task OnInitializedAsync()
        {
            string message;

            _aeropuertos = [];
            _ciudades = [];

            await LeerListasDesdeDB();
            await LeerAeropuertosDesdeDB();

            // para mostrar un mensaje al usuario 
            message = $"Ok, hemos leído <b>{_aeropuertos.Count}</b> aeropuertos desde la base de datos.";
            _alertSettings = new(Severity.Info, true, message);
        }

        // ===============================================================================
        // para ocultar el MudAlert 
        private void CloseAlert()
        {
            _alertSettings = new(Severity.Info, false, "");
            StateHasChanged();
        }

        private async Task LeerListasDesdeDB()
        {
            // usamos el dbFactory para instanciar un dbContext
            using var dbcontext = DbFactory!.CreateDbContext();

            _ciudades = await dbcontext.Ciudades.OrderBy(x => x.Nombre)
                                                .Select(x => new Ciudad_dto
                                                {
                                                    Id = x.Id,
                                                    Nombre = x.Nombre
                                                })
                                                .ToListAsync();
        }

        private async Task LeerAeropuertosDesdeDB()
        {
            // usamos el dbFactory para instanciar un dbContext
            using var dbcontext = DbFactory!.CreateDbContext();

            _aeropuertos = await dbcontext.Aeropuertos.OrderBy(x => x.Nombre)
                                                .Select(x => new Aeropuerto_dto
                                                {
                                                    Id = x.Id,
                                                    Nombre = x.Nombre,
                                                    Abreviatura = x.Abreviatura,
                                                    CiudadId = x.CiudadId
                                                })
                                                .ToListAsync();
        }

        // ===============================================================================================================
        // para mostrar un mensaje al usuario con MudAlert 
        private record AlertSettings(Severity Tipo, bool Show, string Text);
    }
}
