using MongoDB.Bson.Serialization.Attributes;

namespace scrweb_blazor.Models.Mongodb.Catalogos
{
    // when finding in the collection, ignore elements that are not in the model 
    [BsonIgnoreExtraElements]
    public class Ramo_mongo
    {
        public string _id { get; set; } = string.Empty;
        public string descripcion { get; set; } = string.Empty;
        public string abreviatura { get; set; } = string.Empty;
    }
}
