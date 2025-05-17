using System.ComponentModel.DataAnnotations;

namespace contab_blazor2.Models
{
    // ===========================================================================================
    // para validar el contenido de una lista contra un type (T) 
    public static class ModelValidator
    {
        public static dynamic ValidateList<T>(List<T> items)
        {
            if (items.Count == 0) return false;

            bool isValid = true;
            var errorMessages = new List<string>();
            int lineNumber = 0; 


            foreach (var item in items)
            {
                lineNumber++; 
                if (item is null) continue;

                var context = new ValidationContext(item);
                var results = new List<ValidationResult>();

                bool isvalid = Validator.TryValidateObject(item, context, results, true);

                if (!isvalid)
                {
                    results.ForEach(x => errorMessages.Add(x.ErrorMessage is null ? "n/a - no error message" : $"(linea {lineNumber}) {x.ErrorMessage}"));
                    isValid = false; 
                }
            }

            return new
            {
                isValid,
                errorMessages
            }; 
        }

        //public bool ValidarItemsEnLaLista(List<Asegurado_Form_Item> items)
        //{
        //    bool listIsValid = true;

        //    foreach (var item in items)
        //    {
        //        var context = new ValidationContext(item, serviceProvider: null, items: null);
        //        var errorResults = new List<ValidationResult>();

        //        // carry out validation.
        //        var isValid = Validator.TryValidateObject(item, context, errorResults, true);

        //        if (!isValid)
        //        {
        //            listIsValid = false;
        //            break;
        //        }
        //    }

        //    return listIsValid;
        //}
    }
}
