using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Linq;

namespace contab_blazor2.Models
{
    // ======================================================================================
    // para validar que una propiedad contenga solo ciertos valores 
    public sealed class ContainsAttribute : ValidationAttribute
    {
        private readonly IEnumerable<string> _values;

        public ContainsAttribute(string[] values)
        {
            _values = values;
        }

        public ContainsAttribute(int[] values)
        {
            _values = values.Select(x => x.ToString());
        }

        public ContainsAttribute(double[] values)
        {
            _values = values.Select(x => x.ToString(CultureInfo.InvariantCulture));
        }

        protected override ValidationResult IsValid(object? value, ValidationContext validationContext)
        {
            if (value == null)
                return ValidationResult.Success!;

            if (_values != null && !_values.Contains(value))
            {
                var valuesString = string.Join(", ", _values.Select(x => $"'{x}'"));
                var message = $"El valor indicado para {validationContext.MemberName} no es válido. Los valores posibles son: {valuesString}.";
                return new ValidationResult(message);
            }

            return ValidationResult.Success!;
        }
    }
}
