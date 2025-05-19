using MudBlazor;

namespace scrweb_blazor.Components.Pages.Tablas.Coberturas
{
    public partial class Coberturas
    {
        // Detail's List 
        private List<Item_model>? _items;

        // Parent's List 
        private List<Option>? _options; 

        // Just to use Alerts from MudBlazor 
        AlertSettings _alertSettings = new(Severity.Info, false, "");

        protected override async Task OnInitializedAsync()
        {
            _items = GetListItems();
            _options = GetRamoItems();

            // para mostrar un mensaje al usuario 
            string message = $"Ok, we've read <b>{10}</b> items - They are shown in the list.";
            _alertSettings = new(Severity.Info, true, message);
        }

        // ===============================================================================
        // para ocultar el MudAlert 
        private void CloseAlert()
        {
            _alertSettings = new(Severity.Info, false, "");
            StateHasChanged();
        }

        private List<Item_model> GetListItems()
        {
            var list = new List<Item_model>() {
                new Item_model { Id = "Id 1", Description = "number 1", OptionId = "Id 1" },
                new Item_model { Id = "Id 2", Description = "number 2", OptionId = "Id 2" },
                new Item_model { Id = "Id 3", Description = "number 3", OptionId = "Id 3" },
                new Item_model { Id = "Id 4", Description = "number 4", OptionId = "Id 4" },
                new Item_model { Id = "Id 5", Description = "number 5", OptionId = "Id 5" },
                new Item_model { Id = "Id 6", Description = "number 6", OptionId = "Id 1" },
                new Item_model { Id = "Id 7", Description = "number 7", OptionId = "Id 2" },
                new Item_model { Id = "Id 8", Description = "number 8", OptionId = "Id 3" },
                new Item_model { Id = "Id 9", Description = "number 9", OptionId = "Id 4" },
                new Item_model { Id = "Id 10", Description = "number 10", OptionId = "Id 5" },
            };

            return list;
        }

        private List<Option> GetRamoItems()
        {
            var list = new List<Option>() {
                new Option ("Id 1", "Option 1"),
                new Option ("Id 2", "Option 2"),
                new Option ("Id 3", "Option 3"),
                new Option ("Id 4", "Option 4"),
                new Option ("Id 5", "Option 5"),
            };

            return list;
        }

        // =====================================================================================================
        // this is the type for the List items 
        public class Item_model
        {
            public string Id { get; set; } = string.Empty;

            public string Description { get; set; } = string.Empty;

            public string? OptionId { get; set; } = string.Empty;
        }

        // =====================================================================================================
        // this is the Type for the Select items
        private record Option(string Id, string Description);

        // ===============================================================================================================
        // para mostrar un mensaje al usuario con MudAlert 
        private record AlertSettings(Severity Type, bool Show, string Text);
    }
}
