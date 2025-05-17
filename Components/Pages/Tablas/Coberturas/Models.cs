using System.ComponentModel.DataAnnotations;

namespace scrweb_blazor.Components.Pages.Tablas.Coberturas
{
    public class Cobertura_Form_Item
    {
        [Required(ErrorMessage = "Ud. debe indicar un valor para el Id")]
        [StringLength(10, MinimumLength = 1, ErrorMessage = "El Id no debe tener más de 10 caracteres.")]
        public string Id { get; set; } = string.Empty;

        [Required(ErrorMessage = "Ud. debe indicar un valor para la Descripción")]
        [StringLength(70, MinimumLength = 1, ErrorMessage = "La Descripción no debe tener más de 70 caracteres.")]
        public string Descripcion { get; set; } = string.Empty;

        [Required(ErrorMessage = "Ud. debe indicar un valor para la Abreviatura")]
        [StringLength(15, MinimumLength = 1, ErrorMessage = "La abreviatura no debe tener más de 15 caracteres.")]
        public string Abreviatura { get; set; } = string.Empty;

        public string? RamoId { get; set; } = string.Empty;

        public byte? EditMode { get; set; }                 // para marcar los items que el usuario ha editado en la lista
    }
}
