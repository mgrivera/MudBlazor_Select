using System.ComponentModel.DataAnnotations;

namespace scrweb_blazor.Models.Riesgos
{
    public class RiesgoCoberturas
    {
        public int Id { get; set; }
        public int RiesgoId { get; set; }
        public string CoberturaId { get; set; } = string.Empty;
        public string MonedaId { get; set; } = string.Empty;
        public short? Cantidad { get; set; }
        public decimal? SumaAseguradaUnidad { get; set; }
        public decimal SumaAsegurada { get; set; }
        public decimal? Limite { get; set; }
        public decimal? Tasa { get; set; }
        public decimal Prima { get; set; }
    }
}