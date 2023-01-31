using Google.Cloud.Firestore;
using where.Models.CategoryModels;

namespace where.Models.PlaceModels
{
    [FirestoreData]
    public class PlaceDto
    {
        [FirestoreProperty]
        public string name { get; set; }
        [FirestoreProperty]
        public string location { get; set; }
        [FirestoreProperty]
        public List<IFormFile> menuImages { get; set; }
        [FirestoreProperty]
        public string categoryId { get; set; }
    }
}
