using MongoDB.Bson.Serialization.Attributes;

namespace scrweb_blazor.Models.Mongodb.Catalogos
{
    // when finding in the collection, ignore elements that are not in the model 
    [BsonIgnoreExtraElements]
    public class EmpresaUsuaria_mongo
    {
        public string _id { get; set; } = string.Empty;
        public string nombre { get; set; } = string.Empty;
        public string nombreCorto { get; set; } = string.Empty;
        public string abreviatura { get; set; } = string.Empty;
        public string? companiaNosotros { get; set; }
    }
}
