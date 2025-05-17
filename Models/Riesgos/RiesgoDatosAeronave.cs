namespace scrweb_blazor.Models.Riesgos
{
    public class RiesgoDatosAeronave
    {
        public int Id { get; set; }

        public int RiesgoId { get; set; }

        public short Year { get; set; }

        public string Make { get; set; } = string.Empty;

        public string Model { get; set; } = string.Empty;

        public string Wings { get; set; } = string.Empty;

        public short Pax { get; set; }

        public short Crew  { get; set;  }

        public short Baby  { get; set;  }

        public string Registration { get; set; } = string.Empty;

        public string UsedFor { get; set; } = string.Empty;

        public string CountryId { get; set; } = string.Empty;

        public string? Engine { get; set; }

        public string? EngineType { get; set; }

        public string? Operation { get; set; }

        public string? Serial { get; set; }

        public int? AeropuertoId { get; set; }
    }
}