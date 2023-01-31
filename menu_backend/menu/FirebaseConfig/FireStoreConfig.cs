using Google.Cloud.Firestore;

namespace eComm.FirebaseConfigModel
{
    public class FireStoreConfig
    {
        string projectId;
        public FirestoreDb firestoreDb;
        public FireStoreConfig()
        {
           
            this.projectId = "where-bf478";
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", GetPathRelativeToExecutingAssemblyLocation());
            this.firestoreDb=FirestoreDb.Create(projectId);
        }
        public string GetPathRelativeToExecutingAssemblyLocation()
        {
            string pathOfExecutingAssembly = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
            string settingsPath = pathOfExecutingAssembly + "\\FirebaseConfig\\where-bf478-firebase-adminsdk-wqfwp-6c31642ffe.json";
            return settingsPath;
        }
    }
}
