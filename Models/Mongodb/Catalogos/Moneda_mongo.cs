using MongoDB.Bson.Serialization.Attributes;
using System.Security.Cryptography;

namespace scrweb_blazor.Models.Mongodb.Catalogos
{
    // when finding in the collection, ignore elements that are not in the model 
    [BsonIgnoreExtraElements]
    public class Moneda_mongo
    {
        public string _id { get; set; } = string.Empty;
        public string descripcion { get; set; } = string.Empty;
        public string simbolo { get; set; } = string.Empty;
        public bool defecto { get; set; }
    }
}
