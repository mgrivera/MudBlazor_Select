using System.Security.Cryptography;

namespace scrweb_blazor.Models.Mongodb.Catalogos
{
    public class Catalogos_DeletedItems_mongo
    {
        public string _id { get; set; } = string.Empty;
        public string collection { get; set; } = string.Empty; 
        public string itemId { get; set; } = string.Empty;
        public DateTime fecha { get; set; } 
    }
}