using Microsoft.FluentUI.AspNetCore.Components;

namespace scrweb_blazor.Models.General
{
    public class FluentMessageBar_params
    {
        public string Title { get; set; } = string.Empty;
        public MessageIntent Intent { get; set; } = MessageIntent.Info;
        public bool Visible { get; set; } = false;
        public string Text { get; set; } = string.Empty;
    }
}
