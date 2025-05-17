using Microsoft.AspNetCore.Http.HttpResults;

namespace scrweb_blazor.Models.General
{
    public class ProcesoUsuario
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        public string Categoria { get; set; } = string.Empty; 
        public string SubCategoria { get; set; } = string.Empty;
        public string Descripcion { get; set; }  = string.Empty; 
        public string Usuario { get; set; }  = string.Empty; 
        public string? SubTituloReport { get; set; }
    }
}