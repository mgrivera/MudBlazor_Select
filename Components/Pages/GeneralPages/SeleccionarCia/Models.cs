
namespace scrweb_blazor.Components.Pages.GeneralPages.SeleccionarCia
{
    public record Empresa_Simple(string Id, string Nombre, string Abreviatura);

    public record CiaSeleccionada_Simple(int Id, string CiaSeleccionada, string Nombre, string Abreviatura);
}


//(System.Int32 Id, System.String Nombre, System.String Abreviatura)