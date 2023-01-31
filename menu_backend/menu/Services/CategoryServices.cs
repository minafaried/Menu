using eComm.FirebaseConfigModel;
using Google.Cloud.Firestore;
using where.Models.CategoryModels;

namespace where.Services
{
    public class CategoryServices:ICategoryServices
    {
        FireStoreConfig firebaseConfig;
        CollectionReference categoryCollection;

        public CategoryServices()
        {
            firebaseConfig = new FireStoreConfig();
            categoryCollection = firebaseConfig.firestoreDb.Collection("Categories");
        }
        public async Task<List<Category>> GetCategories()
        {
            try {
                QuerySnapshot allCitiesQuerySnapshot = await categoryCollection.GetSnapshotAsync();
                List<Category> categories = new List<Category>();
                foreach (DocumentSnapshot documentSnapshot in allCitiesQuerySnapshot.Documents)
                {
                    Dictionary<string, object> data = documentSnapshot.ToDictionary();
                    Category category = new Category(documentSnapshot.Id, data["name"].ToString());
                    categories.Add(category);
                }
                return categories;
            } catch {
                return null;
            }
        }
        public async Task<Category> getCategotyById(string id)
        {
            try
            {
                DocumentSnapshot DocRef =await  categoryCollection.Document(id).GetSnapshotAsync();
                Dictionary<string, object> data = DocRef.ToDictionary();
                Category category =new Category(id, data["name"].ToString());
                return category;
            }
            catch
            {
                return null;
            }

        }
        public async Task<Category> addCategory(CategotyDto categotyDto)
        {
            try{
                DocumentReference DocRef = await categoryCollection.AddAsync(categotyDto);
                var category = new Category(DocRef.Id, categotyDto.name);
                return category;
            }
            catch (Exception ex) { return null; }
        }
        public async Task<Category> editCategoty(Category req)
        {
            try
            {
                DocumentReference DocRef = categoryCollection.Document(req.id);
                CategotyDto categotyDto = new CategotyDto();
                categotyDto.name = req.name;

                await DocRef.SetAsync(categotyDto);
                return req;
            }
            catch
            {
                return null;
            }
            
        }
    }
}
