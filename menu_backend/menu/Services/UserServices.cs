using eComm.FirebaseConfigModel;
using Google.Cloud.Firestore;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;
using where.Models.UserModels;

namespace where.Services
{
    public class UserServices : IUserServices
    {
        FireStoreConfig firebaseConfig;
        CollectionReference userCollection;

        public UserServices()
        {
            firebaseConfig = new FireStoreConfig();
            userCollection = firebaseConfig.firestoreDb.Collection("Users");
        }
        public string hashingPassword(string passwoed)
        {
            var sha = SHA256.Create();
            var asByteArray = Encoding.Default.GetBytes(passwoed);
            var hashedPassword = sha.ComputeHash(asByteArray);
            return Convert.ToBase64String(hashedPassword);

        }
        public async Task<User> logIn(LogInModelDto logInModelDto)
        {
            try
            {
                QuerySnapshot allCitiesQuerySnapshot = await userCollection.
                WhereEqualTo("email", logInModelDto.email).
                WhereEqualTo("password", hashingPassword(logInModelDto.password)).
                GetSnapshotAsync();
                if (allCitiesQuerySnapshot.Count == 0)
                {
                    return null;
                }
                Dictionary<string, object> data = allCitiesQuerySnapshot.Documents[0].ToDictionary();
                User user = new User(allCitiesQuerySnapshot.Documents[0].Id,
                    data["email"].ToString(),
                    data["name"].ToString(),
                    data["password"].ToString(),
                    new Dictionary<string, int>());
                return user;
            }
            catch (Exception) { return null; }

        }
        public async Task<User> signUp(UserDto userDto)
        {
            try
            {
                if (userDto.name == null || userDto.name == "" || userDto.email == "" || userDto.email == null || userDto.password == "" || userDto.password == null)
                {
                    return null;
                }
                userDto.password = hashingPassword(userDto.password);
                DocumentReference DocRef = await userCollection.AddAsync(userDto);
                User user = new User(DocRef.Id,
                                     userDto.email,
                                     userDto.name,
                                     userDto.password,
                                     new Dictionary<string, int>());

                return user;
            }
            catch (Exception) { return null; }

        }
    }
}
