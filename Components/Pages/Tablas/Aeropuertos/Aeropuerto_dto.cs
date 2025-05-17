using DocumentFormat.OpenXml.Wordprocessing;
using System.ComponentModel.DataAnnotations;

namespace scrweb_blazor.Components.Pages.Tablas.AeropuertosPage
{
    public class Aeropuerto_dto
    {
        [Key]
        public int Id { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Ud. debe indicar un valor para campo {0}")]
        [StringLength(50, MinimumLength = 1, ErrorMessage = "Por favor, indique un valor para {0} (desde 1 hasta 50 chars)")]
        public string Nombre { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "Ud. debe indicar un valor para el campo {0}")]
        [StringLength(15, MinimumLength = 1, ErrorMessage = "Por favor, indique un valor para {0} (desde 1 hasta 15 chars)")]
        public string Abreviatura { get; set; } = null!;

        [Required(AllowEmptyStrings = false, ErrorMessage = "Ud. debe indicar un valor para el campo {0}")]
        [StringLength(6, MinimumLength = 1, ErrorMessage = "Por favor, indique un valor para {0} (desde 1 hasta 6 chars)")]
        [Display(Name = "Ciudad")]
        public string CiudadId { get; set; } = null!;

        public short? EditMode { get; set; }
    }
}
