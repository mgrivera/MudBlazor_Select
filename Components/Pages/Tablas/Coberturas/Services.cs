using Dapper;
using Microsoft.Data.SqlClient;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace scrweb_blazor.Components.Pages.Tablas.Coberturas
{
    public class Services
    {
        private string _connectionString = string.Empty;

        public Services(string connectionString)
        {
            _connectionString = connectionString;
        }

        // ==========================================================================================================
        // para leer las coberturas desde el db y regresarlas en una lista 
        public async Task<dynamic> LeerCoberturas()
        {
            string query = string.Empty;
            List<Cobertura_Form_Item> coberturas;

            query = $@"Select c.Id, c.Descripcion, c.Abreviatura, c.RamoId, r.Abreviatura as RamoAbreviatura  
                       From Coberturas c Left Join Ramos r On c.RamoId = r.Id 
                       Order by c.Descripcion";

            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                try
                {
                    coberturas = (await db.QueryAsync<Cobertura_Form_Item>(query)).ToList();
                }
                catch (Exception ex)
                {
                    var message = ex.Message;

                    return new
                    {
                        error = true,
                        message
                    };
                }
            }

            return new
            {
                error = false,
                message = "",
                coberturas
            };
        }

        // ==========================================================================================================
        // para validar los items en la lista 
        public bool ValidarItemsEnLaLista(List<Cobertura_Form_Item> items)
        {
            bool listIsValid = true; 

            foreach (var item in items)
            {
                var context = new ValidationContext(item, serviceProvider: null, items: null);
                var errorResults = new List<ValidationResult>();

                // carry out validation.
                var isValid = Validator.TryValidateObject(item, context, errorResults, true);

                if (!isValid)
                {
                    listIsValid = false;
                    break; 
                }
            }


            return listIsValid; 
        }

        public async Task<dynamic> GrabarCoberturas(List<Cobertura_Form_Item> coberturas)
        {
            string query = string.Empty;
            int affectedRecords;

            int itemsInserted = 0, itemsUpdated = 0, itemsDeleted = 0;

            foreach (var item in coberturas)
            {
                // nota: las coberturas pueden o no tener un ramo asociado. Si no hay uno, debe venir un null (y no un empty string) 
                if (string.IsNullOrEmpty(item.RamoId))
                {
                    item.RamoId = null; 
                }

                switch (item.EditMode)
                {
                    case 1:
                        query = $@"Insert Into Coberturas (Id, Descripcion, Abreviatura, RamoId) Values (@Id, @Descripcion, @Abreviatura, @RamoId)";
                        itemsInserted++; 
                        break;
                    case 2:

                        query = $@"Update Coberturas Set Descripcion = @Descripcion, Abreviatura = @Abreviatura, RamoId = @RamoId Where Id = @Id";
                        itemsUpdated++; 
                        break;
                    case 3:

                        query = $@"Delete From Coberturas Where Id = @Id";
                        itemsDeleted++; 
                        break;
                }

                using (IDbConnection db = new SqlConnection(_connectionString))
                {
                    try
                    {
                        affectedRecords = await db.ExecuteAsync(query, item); 
                    }
                    catch (Exception ex)
                    {
                        return new { error = true, message = ex.Message };
                    }
                }
            }
            
            return new
            {
                error = false,
                message = $@"Ok, las modificaciones que Ud. ha efectuado han sido grabadas. 
                             <b>{itemsInserted}</b> items han sido agregados; <b>{itemsUpdated}</b> modificados y <b>{itemsDeleted}</b> eliminados.",
                coberturas
            };
        }
    }
}
