using Microsoft.AspNetCore.Http.HttpResults;
using System.ComponentModel.DataAnnotations;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace scrweb_blazor.Models.Riesgos
{
    // Nota importante: aunque la vigencia original en el db *no* es Not Null, ponemos aquí los valores como nullable pues el FluentDatePicker 
    // lo exige así. Una mejor solución podría ser que tuviésemos un model especificamente para el editForm y otro para recibir el item desde el db 
    public class Riesgo
    {
        public int Id  { get; set; }
        
        public int Numero { get; set; }

        [Required(ErrorMessage = "Ud. debe indicar un valor para el Estado del riesgo")]
        [StringLength(10, MinimumLength = 1, ErrorMessage = "Debe indicar un Estado.")]
        public string Estado { get; set; } = string.Empty;

        [Required(ErrorMessage = "Ud. debe indicar un valor para el número de endoso")]
        public short Endoso { get; set; }

        [Required(ErrorMessage = "Ud. debe indicar un valor para el valor Tipo de Endoso")]
        [StringLength(6, MinimumLength = 1, ErrorMessage = "Debe indicar un Tipo para el Endoso.")]
        public string TipoEndoso { get; set; } = string.Empty;

        [Required(ErrorMessage = "Ud. no puede dejar la fecha de emisión en blanco")]
        public DateTime? FechaEmision { get; set; }

        [StringLength(16, MinimumLength = 0, ErrorMessage = "Aparentemente, el valor indicado para la Referencia es muy grande.")]
        public string Referencia { get; set; } = null!;

        [Required(ErrorMessage = "Ud. debe indicar un valor para el año de suscripción del riesgo")]
        [Range(1990, 2050, ErrorMessage = "El valor para el año de suscripción debe ser un año válido. Ej: 2022, 2023, 2024, ....")]
        public short? AnoSuscripcion { get; set; }

        public DateTime?  Desde_original { get; set; }
        public DateTime? Hasta_original { get; set; }
        public short? Dias_original { get; set; }

        public DateTime? Desde_aceptacion  { get; set; }
        public DateTime? Hasta_aceptacion { get; set; }
        public short? Dias_aceptacion { get; set; }

        [Required(ErrorMessage = "Ud. debe indicar un valor para la Moneda del riesgo")]
        [StringLength(10, MinimumLength = 1, ErrorMessage = "Debe indicar una Moneda.")]
        public string Moneda  { get; set; } = string.Empty;

        [Required(ErrorMessage = "Ud. debe indicar un valor para la Compañía del riesgo")]
        [StringLength(10, MinimumLength = 1, ErrorMessage = "Debe indicar una Compañía.")]
        public string Cedente  { get; set; } = string.Empty;

        public string? Corredor { get; set; }

        [Required(ErrorMessage = "Ud. debe indicar un valor para el Ramo del riesgo")]
        [StringLength(10, MinimumLength = 1, ErrorMessage = "Debe indicar un Ramo.")]
        public string Ramo { get; set; } = string.Empty;

        [Required(ErrorMessage = "Ud. debe indicar un valor para el Tipo del riesgo")]
        [StringLength(10, MinimumLength = 1, ErrorMessage = "Debe indicar un Tipo.")]
        public string Tipo { get; set; } = string.Empty;

        [Required(ErrorMessage = "Ud. debe indicar un valor para el Asegurado del riesgo")]
        [StringLength(10, MinimumLength = 1, ErrorMessage = "Debe indicar un Asegurado.")]
        public string Asegurado { get; set; } = string.Empty;

        [Required(ErrorMessage = "Ud. debe indicar un valor para el País del riesgo")]
        [StringLength(6, MinimumLength = 1, ErrorMessage = "Debe indicar un País.")]
        public string Pais { get; set; } = string.Empty;

        public string Cia { get; set; } = string.Empty;

        public DateTime? UploadDate { get; set; }

        public string? Observaciones { get; set; }
    }
}