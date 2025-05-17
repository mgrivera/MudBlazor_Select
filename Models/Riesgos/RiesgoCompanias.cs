namespace scrweb_blazor.Models.Riesgos
{
    public record RiesgoCompanias(int Id, int RiesgoId, string CompaniaId, bool Nosotros, string MonedaId, decimal OrdenPorc,
                                  decimal SumaAsegurada, decimal SumaReasegurada, short Dias, decimal Prima, short DiasOrden,
                                  decimal PrimaProrrata, decimal PrimaBruta, decimal ComPorc, decimal Comision, decimal  ResPorc, decimal Reserva,
                                  decimal  CorrPorc, decimal Corretaje, decimal ImpPorc, decimal Impuesto, decimal PrimaNeta); 
}