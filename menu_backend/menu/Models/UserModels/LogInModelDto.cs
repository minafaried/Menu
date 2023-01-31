using Google.Cloud.Firestore;

namespace where.Models.UserModels
{
    [FirestoreData]
    public class LogInModelDto
    {
        [FirestoreProperty]
        public string email { get; set; }
        [FirestoreProperty]
        public string password { get; set; }

    }
}
