using Microsoft.FluentUI.AspNetCore.Components;
using scrweb_blazor.Models.General;
using Microsoft.EntityFrameworkCore;
using MudBlazor;
using scrweb_blazor.Models.EF_Core;

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

        AlertSettings _alertSettings = new(Severity.Info, false, "");

        protected override async Task OnInitializedAsync()
        {
            _coberturas = GetListItems();
            _ramos = GetRamoItems();

            // para mostrar un mensaje al usuario 
            string message = $"Ok, hemos leído <b>{10}</b> coberturas desde la base de datos.";
            _alertSettings = new(Severity.Info, true, message);
        }

        // ===============================================================================
        // para ocultar el MudAlert 
        private void CloseAlert()
        {
            _alertSettings = new(Severity.Info, false, "");
            StateHasChanged();
        }

        private List<Cobertura_Form_Item> GetListItems()
        {
            var list = new List<Cobertura_Form_Item>() {
                new Cobertura_Form_Item { Id = "number 1", Descripcion = "number 1", Abreviatura = "number 1", RamoId = "ramo 1" },
                new Cobertura_Form_Item { Id = "number 2", Descripcion = "number 2", Abreviatura = "number 2", RamoId = "ramo 2" },
                new Cobertura_Form_Item { Id = "number 3", Descripcion = "number 3", Abreviatura = "number 3", RamoId = "ramo 3" },
                new Cobertura_Form_Item { Id = "number 4", Descripcion = "number 4", Abreviatura = "number 4", RamoId = "ramo 4" },
                new Cobertura_Form_Item { Id = "number 5", Descripcion = "number 5", Abreviatura = "number 5", RamoId = "ramo 5" },
                new Cobertura_Form_Item { Id = "number 6", Descripcion = "number 6", Abreviatura = "number 6", RamoId = "ramo 1" },
                new Cobertura_Form_Item { Id = "number 7", Descripcion = "number 7", Abreviatura = "number 7", RamoId = "ramo 2" },
                new Cobertura_Form_Item { Id = "number 8", Descripcion = "number 8", Abreviatura = "number 8", RamoId = "ramo 3" },
                new Cobertura_Form_Item { Id = "number 9", Descripcion = "number 9", Abreviatura = "number 9", RamoId = "ramo 4" },
                new Cobertura_Form_Item { Id = "number 10", Descripcion = "number 10", Abreviatura = "number 10", RamoId = "ramo 5" },
            };

            return list;
        }

        private List<Ramo> GetRamoItems()
        {
            var list = new List<Ramo>() {
                new Ramo ("ramo 1", "ramo 1"),
                new Ramo ("ramo 2", "ramo 2"),
                new Ramo ("ramo 3", "ramo 3"),
                new Ramo ("ramo 4", "ramo 4"),
                new Ramo ("ramo 5", "ramo 5"),
            };

            return list;
        }

        // =====================================================================================================
        // para leer los ramos desde el db 
        private record Ramo(string Id, string Descripcion);

        // ===============================================================================================================
        // para mostrar un mensaje al usuario con MudAlert 
        private record AlertSettings(Severity Tipo, bool Show, string Text);
    }
}
