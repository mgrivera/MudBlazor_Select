namespace scrweb_blazor.Models.Cuotas
{
    // ===================================================================================
    // para pasar al method que construye las cuotas los datos necesarios para hacerlo 
    public record Cuota_Info_Construir(short? Cantidad, DateTime FechaBase, string? DiasEntreCuotas, string? MesesEntreCuotas, string? DiasVencimiento, string? MesesVencimiento);
}
