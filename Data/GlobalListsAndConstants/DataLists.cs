namespace scrweb_blazor.Data.GlobalListsAndConstants
{
    // ==============================================================================================
    // tablas y constantes que son usados en el programa pero que no existen en el db 
    public static class DataLists
    {
        public static List<SiniestroStatus> SiniestroStatusList { get; } = new()
        {
            new SiniestroStatus("pending", "Pending"),
            new SiniestroStatus("closed", "Closed"),
            new SiniestroStatus("declined", "Declined"),
            new SiniestroStatus("withdrawn", "Withdrawn"),
            new SiniestroStatus("underInvestigation", "Under investigation"),
            new SiniestroStatus("underDeductNoFees", "Under deductible - no fees"),
            new SiniestroStatus("underDeductWithFees", "Under deductible - with fees")
        };

        public static List<SiniestroTipoMovimiento> SiniestroTipoMovimientoList { get; } = new()
        {
            new SiniestroTipoMovimiento("reserva", "Reserva"),
            new SiniestroTipoMovimiento("pago", "Pago"),
            new SiniestroTipoMovimiento("fee", "Fee"),
        };

        public static List<DocumentoTipo> DocumentoTipoList { get; } = new()
        {
            new DocumentoTipo("poliza", "Póliza"),
            new DocumentoTipo("cesion", "Cesión"),
            new DocumentoTipo("recibo", "Recibo"),
            new DocumentoTipo("siniestNum", "Número de siniestro")
        }; 
    }

    public record SiniestroStatus(string Id, string Descripcion); 
    public record SiniestroTipoMovimiento(string Id, string Descripcion); 
    public record DocumentoTipo(string Id, string Descripcion);


}
