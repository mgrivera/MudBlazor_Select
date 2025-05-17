using MongoDB.Bson.Serialization.Attributes;

namespace scrweb_blazor.Models.Mongodb.Catalogos
{
    // when finding in the collection, ignore elements that are not in the model 
    [BsonIgnoreExtraElements]
    public class Compania_mongo
    {
        public string _id { get; set; } = string.Empty; 
        public bool nosotros { get; set; }
        public string nombre { get; set; } = string.Empty;
        public string abreviatura { get; set; } = string.Empty;
        public string tipo { get; set; } = string.Empty;
        public string? direccion { get; set; } 
        public string? rif { get; set; } 
    }
}