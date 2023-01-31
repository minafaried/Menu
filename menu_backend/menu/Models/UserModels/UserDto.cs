using Google.Cloud.Firestore;

namespace where.Models.UserModels
{
    [FirestoreData]
    public class UserDto
    {
        [FirestoreProperty]
        public string email { get; set; }
        [FirestoreProperty]
        public string name { get; set; }
        [FirestoreProperty]
        public string password { get; set; }
    }
}
