using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components;
using Microsoft.FluentUI.AspNetCore.Components;
using scrweb_blazor.Data;
using scrweb_blazor.Models.General;
using scrweb_blazor.Services.Identity;

namespace scrweb_blazor.Components.Pages.GeneralPages.SeleccionarCia
{
    public partial class SeleccionarCia
    {
        [CascadingParameter]
        private Task<AuthenticationState>? authenticationStateTask { get; set; }

        // ================================================================================================
        // para que esta variable tenga valores desde el inicio y no falle el FluentMessage por valores en null
        FluentMessageBar_params? fluentUIMessageBar = new FluentMessageBar_params();

        List<Empresa_Simple>? _listaEmpresas;

        string _connectionString = string.Empty;
        ApplicationUser? _user;

        protected override async Task OnInitializedAsync()
        {
            string message = string.Empty;

            // ======================================================================
            // intentamos leer el identity del user authenticated
            dynamic result = await leerInfoUsuario();

            if (result.error)
            {
                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>ScrWeb - Generales - Seleccionar una empresa</h5>",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = result.message
                };

                return;
            }

            _user = result.user;

            _connectionString = Configuration.GetSection("ConnectionStrings")["scrweb_blazor"]!;

            // ===============================================================================================================================
            // lo primero que hacemos es leer las compañías para mostrarlas en el grid
            var services = new Services(_connectionString);
            _listaEmpresas = await services.ListaEmpresas();

            // ===============================================================================================================================
            // ahora leemos la cia Contab seleccionada para indicar al usuario si hay o no una cia ya seleccionada (previamente) 
            result = await services.LeerEmpresaSeleccionada(_user!.Id);         // *siempre* vendrá un user aquí

            if (result.error)
            {
                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>ScrWeb - Generales - Seleccionar una empresa</h5>",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = result.message
                };

                return;
            }

            CiaSeleccionada_Simple? empresaSeleccionada = result.empresaSeleccionada;

            if (empresaSeleccionada is null)
            {
                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>ScrWeb - Generales - Seleccionar una compañía</h5>",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = @$"<b>No hay</b> una compañía seleccionada para el usuario ahora.<br /> Por favor seleccione una en la lista. "
                };
            }
            else
            {
                message = $"<em>{empresaSeleccionada.Nombre}</em> está ahora seleccionada por el usuario.<br /> Ud. puede seleccionar una diferente, " +
                           "si hace <em>click</em> en alguna en la lista.";

                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>ScrWeb - Generales - Seleccionar una compañía</h5>",
                    Intent = MessageIntent.Info,
                    Visible = true,
                    Text = message
                };
            }
        }

        private async Task<dynamic> leerInfoUsuario()
        {
            var getAuthenticatedUser = new GetAuthenticatedUser(authenticationStateTask, _UserManager);
            dynamic result = await getAuthenticatedUser.GetUser();

            return result;
        }

        // =========================================================================================================================
        // el usuario seleccionó una empresa en la lista; la registramos en la tabla CiaSeleccionada como su empresa seleccionada 
        private async Task registrarEmpresaSeleccionada(string empresaId)
        {
            string message = string.Empty;

            // =====================================================================
            // el user debe tener un valor para poder continuar 
            if (_user is null)
            {
                message = @$"Error inesperado: no hemos podido leer los datos del usuario que se ha authenticado al programa.";

                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>ScrWeb - Generales - Seleccionar una empresa</h5>",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = message
                };

                StateHasChanged();
                return;
            }

            var services = new Services(_connectionString);
            dynamic result = await services.SeleccionarEmpresa(empresaId, _user.Id);

            if (result.error)
            {
                message = @$"Error: se ha producido un error al intentar ejecutar esta función.<br />{result.message}.";

                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>ScrWeb - Generales - Seleccionar una empresa</h5>",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = message
                };

                StateHasChanged();
                return;
            }

            Empresa_Simple companiaContab = result.empresaSeleccionada;

            message = @$"Ok, la empresa <em>{companiaContab.Nombre}</em> ha sido seleccionada.";

            fluentUIMessageBar = new FluentMessageBar_params
            {
                Title = "<h5>ScrWeb - Generales - Seleccionar una empresa</h5>",
                Intent = MessageIntent.Info,
                Visible = true,
                Text = message
            };

            StateHasChanged();
        }
    }
}
