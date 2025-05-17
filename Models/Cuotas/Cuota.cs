
namespace scrweb_blazor.Models.Cuotas
{
    public class Cuota
    {
        public int Id { get; set; }

        public int Source_EntityId { get; set; }

        public int? Source_SubEntityId { get; set; }
        public string Source_Origen { get; set; } = string.Empty;

        public string Source_Numero { get; set; } = string.Empty;

        public string Compania { get; set; } = string.Empty;

        public string Moneda { get; set; } = string.Empty;

        public short Numero { get; set; }

        public short Cantidad { get; set; }

        public DateTime FechaEmision { get; set; }

        public DateTime Fecha { get; set; }

        public short DiasVencimiento { get; set; }

        public DateTime FechaVencimiento { get; set; }

        public decimal MontoOriginal { get; set; }

        public decimal Factor { get; set; }

        public decimal Monto { get; set; }

        public string Cia { get; set; } = string.Empty;
    }
}
