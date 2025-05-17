using Microsoft.AspNetCore.Components;
using Microsoft.FluentUI.AspNetCore.Components;

namespace scrweb_blazor.Services.Generales
{
    public class FluentUI_Dialog_Services()
    {
        // =========================================================================================
        // para abrir un fluentUI dialog y mostrar un mensaje al usuario
        public async Task Open_FluentUI_DialogAsync(IDialogService FluentUI_DialogService, string title, RenderFragment renderFragment)
        {
            DialogParameters parameters = new()
            {
                Title = title,
                PrimaryAction = "Cerrar",
                PrimaryActionEnabled = true,
                SecondaryAction = "",
                Width = "500px",
                TrapFocus = false,
                Modal = false,
                PreventScroll = true
            };

            var dialogInstance = await FluentUI_DialogService.ShowDialogAsync(renderFragment, parameters);

            var result = await dialogInstance.Result;
        }

        // =========================================================================================
        // para abrir un fluentUI dialog, mostrar un mensaje y permitir cancelar el dialog 
        public async Task<DialogResult?> Open_FluentUI_OkCancel_DialogAsync(IDialogService FluentUI_DialogService, string title, RenderFragment renderFragment)
        {
            DialogParameters parameters = new()
            {
                Title = title,
                PrimaryAction = "Aceptar",
                PrimaryActionEnabled = true,
                SecondaryAction = "Cancelar",
                SecondaryActionEnabled = true, 
                Width = "500px",
                TrapFocus = false,
                Modal = false,
                PreventScroll = true
            };

            var dialogInstance = await FluentUI_DialogService.ShowDialogAsync(renderFragment, parameters);

            DialogResult? result = await dialogInstance.Result;

            return result; 
        }
    }
}
