using Google.Cloud.Firestore;

namespace where.Models.CategoryModels
{
    [FirestoreData]
    public class CategotyDto
    {
        [FirestoreProperty]
        public string name { get; set; }
    }
}
