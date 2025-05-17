using System;
using System.Security.Cryptography;
using System.Text;

namespace scrweb_blazor.Services.Generales
{
    public class GenerateUniqueString()
    {
        // para obtener un id de un tamaño específico (ej: 10 chars) a partir de un string 
        public static string Generate(string inputString, int desiredLength)
        {
            if (desiredLength > 64)
            {
                throw new ArgumentOutOfRangeException(nameof(desiredLength), "Desired length cannot be greater than 64");
            }

            // Hash the input string using SHA-256 (you can choose a different hash function if needed)
            var hashedValue = SHA256.HashData(Encoding.UTF8.GetBytes(inputString));

            // Convert the byte array to a hex string (more concise representation)
            var hashedString = BitConverter.ToString(hashedValue.ToArray()).Replace("-", "");

            // Extract the desired substring from the hashed value
            return hashedString.Substring(0, desiredLength);
        }
    }
}