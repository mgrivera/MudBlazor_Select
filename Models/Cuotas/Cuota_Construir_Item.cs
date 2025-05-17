namespace scrweb_blazor.Models.Cuotas
{
    // ===================================================================================
    // para pasar los datos básicos al método que permite constrir las cuotas desde 
    // una entidad 

    // Nota: el origen es la entidad a la cual corersponderan las cuotas: 'fac', ... 
    // el origen permite determinar donde buscar la compañía que se usará 
    // por Nosotros. Por ejemplo, para el origen 'fac', la compañia Nosostros se 
    // sustituye por la compañia del riesgo 

    // Con este record se construye una lista de compañías para las cuales el método 
    // construirá las cuotas 
    public record Cuota_Construir_Item(string Origen, int EntidadId, string EntidadNumero, string CompaniaId, bool Nosotros, string MonedaId, decimal Monto); 
}
