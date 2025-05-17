using Microsoft.FluentUI.AspNetCore.Components;
using scrweb_blazor.Models.General;
using Microsoft.EntityFrameworkCore;
using MudBlazor;

namespace scrweb_blazor.Components.Pages.Tablas.Coberturas
{
    public partial class Coberturas
    {
        // =====================================================================================
        // para que esta variable tenga valores desde el inicio y no falle el FluentMessage por valores en null
        FluentMessageBar_params? fluentUIMessageBar = new FluentMessageBar_params();

        // aquí es donde leemos cuando se abre la página 
        private List<Cobertura_Form_Item>? _coberturas;

        // leemos los ramos en una lista pues el usuario puede asociar un ramo a cada cobertura 
        private List<Ramo>? _ramos; 

        // el usuario puede indicar un filtro para filtrar la lista 
        private string _userFilter = string.Empty;

        private string _connectionString = string.Empty;

        // para bloquear el Id en items que ya existen. El usuario solo puede editar en items nuevos 
        private bool _lockIdInputField = false;

        AlertSettings _alertSettings = new(Severity.Info, false, "");
        private bool _readOnly = true;
        private bool _userIsEditing = false;
        private bool _grabarLoading = false;

        protected override async Task OnInitializedAsync()
        {
            dynamic result = new { };

            // ---------------------------------------------------------------------------------------
            // nótese cómo obtenemos el connection string
            _connectionString = Configuration.GetSection("ConnectionStrings")["scrweb_blazor"]!;

            // lo primero que debemos hacer es intentar leer el item en el db; puede venir o no (null) ...
            var services = new Services(_connectionString);
            result = await services.LeerCoberturas();

            if (result.error)
            {
                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>ScrWeb - Tablas - Coberturas</h5>",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = result.message
                };

                StateHasChanged(); 
                return;
            }

            _coberturas = result.coberturas;

            // ---------------------------------------------------------------------------------------
            // usamos el dbFactory para instanciar un dbContext
            using var dbcontext = DbFactory!.CreateDbContext();

            // ---------------------------------------------------------------------------------------
            // leemos los ramos desde el db 
            _ramos = await dbcontext.Ramos.OrderBy(x => x.Descripcion)
                                    .Select(x => new Ramo(x.Id, x.Descripcion, x.Abreviatura))
                                    .ToListAsync();
        }

        // ===============================================================================
        // para ocultar el MudAlert 
        private void CloseAlert()
        {
            _alertSettings = new(Severity.Info, false, "");
            StateHasChanged();
        }

        // ============================================================================================
        // para mostrar la descripción del ramo en el grid, cuando el usuario *no* está editando 
        private string RamoDescripcion(string? ramoId)
        {
            if (ramoId is null)
            {
                return "";
            }

            if (_ramos is null)
            {
                return "<indefinido>";
            }

            var ramo = _ramos.Where(x => x.Id == ramoId).FirstOrDefault();

            if (ramo is null)
            {
                return "<indefinido>";
            }

            return ramo.Descripcion;
        }

        // =====================================================================================================
        // para leer los ramos desde el db 
        private record Ramo(string Id, string Descripcion, string Abreviatura);

        // ===============================================================================================================
        // para mostrar un mensaje al usuario con MudAlert 
        private record AlertSettings(Severity Tipo, bool Show, string Text);
    }
}
