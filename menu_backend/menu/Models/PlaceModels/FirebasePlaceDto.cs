using Google.Cloud.Firestore;

namespace where.Models.PlaceModels
{
    [FirestoreData]
    public class FirebasePlaceDto
    {
        [FirestoreProperty]
        public string name { get; set; }
        [FirestoreProperty]
        public string location { get; set; }
        [FirestoreProperty]
        public List<string> menuImages { get; set; }
        [FirestoreProperty]
        public string categoryId { get; set; }
        [FirestoreProperty]
        public Dictionary<string, int> userRates { get; set; }
    }
}
