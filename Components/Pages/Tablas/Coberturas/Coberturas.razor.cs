using MudBlazor;

namespace scrweb_blazor.Components.Pages.Tablas.Coberturas
{
    public partial class Coberturas
    {
        // Detail's List 
        private List<Cobertura_Form_Item>? _coberturas;

        // Parent's List 
        private List<Ramo>? _ramos; 

        // Just to use Alerts from MudBlazor 
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
                new Cobertura_Form_Item { Id = "number 1", Descripcion = "number 1", RamoId = "ramo 1" },
                new Cobertura_Form_Item { Id = "number 2", Descripcion = "number 2", RamoId = "ramo 2" },
                new Cobertura_Form_Item { Id = "number 3", Descripcion = "number 3", RamoId = "ramo 3" },
                new Cobertura_Form_Item { Id = "number 4", Descripcion = "number 4", RamoId = "ramo 4" },
                new Cobertura_Form_Item { Id = "number 5", Descripcion = "number 5", RamoId = "ramo 5" },
                new Cobertura_Form_Item { Id = "number 6", Descripcion = "number 6", RamoId = "ramo 1" },
                new Cobertura_Form_Item { Id = "number 7", Descripcion = "number 7", RamoId = "ramo 2" },
                new Cobertura_Form_Item { Id = "number 8", Descripcion = "number 8", RamoId = "ramo 3" },
                new Cobertura_Form_Item { Id = "number 9", Descripcion = "number 9", RamoId = "ramo 4" },
                new Cobertura_Form_Item { Id = "number 10", Descripcion = "number 10", RamoId = "ramo 5" },
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
        // this is the type for the List items 
        public class Cobertura_Form_Item
        {
            public string Id { get; set; } = string.Empty;

            public string Descripcion { get; set; } = string.Empty;

            public string? RamoId { get; set; } = string.Empty;
        }

        // =====================================================================================================
        // this is the Type for the Select items
        private record Ramo(string Id, string Descripcion);

        // ===============================================================================================================
        // para mostrar un mensaje al usuario con MudAlert 
        private record AlertSettings(Severity Tipo, bool Show, string Text);
    }
}
