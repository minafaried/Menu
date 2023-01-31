using Google.Cloud.Firestore;

namespace where.Models.PlaceModels
{
    [FirestoreData]
    public class RateDto
    {
        [FirestoreProperty]
        public string userId { get; set; }
        [FirestoreProperty]
        public int rate { get; set; }
    }
}
