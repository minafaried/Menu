using eComm.FirebaseConfigModel;
using Firebase.Storage;
using Google.Cloud.Firestore;
using where.Models.CategoryModels;
using where.Models.PlaceModels;

namespace where.Services
{
    public class PlaceServices : IPlaceServices
    {
        FireStoreConfig firebaseConfig;
        CollectionReference placesCollection;
        CategoryServices categoryServices;


        public PlaceServices()
        {
            firebaseConfig = new FireStoreConfig();
            placesCollection = firebaseConfig.firestoreDb.Collection("Places");
            categoryServices = new CategoryServices();
        }
        public async Task<List<Place>> getAllPlaces()
        {
            try
            {
                QuerySnapshot allCitiesQuerySnapshot = await placesCollection.GetSnapshotAsync();
                List<Place> places = new List<Place>();
                foreach (DocumentSnapshot documentSnapshot in allCitiesQuerySnapshot.Documents)
                {
                    Dictionary<string, object> data = documentSnapshot.ToDictionary();

                    Category category = await categoryServices.getCategotyById(data["categoryId"].ToString());

                    List<string> menuImages = new List<string>();
                    if (data.ContainsKey("menuImages"))
                        foreach (var el in (List<object>)data["menuImages"])
                        {
                            menuImages.Add(el.ToString());
                        }
                    Dictionary<string, int> userRates = new Dictionary<string, int>();
                    if (data.ContainsKey("userRates"))
                        foreach (var el in (Dictionary<string, object>)data["userRates"])
                        {
                            userRates.Add(el.Key, int.Parse(el.Value.ToString()));
                        }
                    Place place = new Place(documentSnapshot.Id, data["name"].ToString(), data["location"].ToString(), menuImages, category, userRates);

                    places.Add(place);
                }
                return places;
            }
            catch
            {
                return null;
            }
        }
        public async Task<List<Place>> getPlacesByCategoryId(string id)
        {
            try
            {
                QuerySnapshot allCitiesQuerySnapshot = await placesCollection.WhereEqualTo("categoryId", id).GetSnapshotAsync();
                List<Place> places = new List<Place>();
                foreach (DocumentSnapshot documentSnapshot in allCitiesQuerySnapshot.Documents)
                {
                    Dictionary<string, object> data = documentSnapshot.ToDictionary();

                    Category category = await categoryServices.getCategotyById(data["categoryId"].ToString());

                    List<string> menuImages = new List<string>();
                    if (data.ContainsKey("menuImages"))
                        foreach (var el in (List<object>)data["menuImages"])
                        {
                            menuImages.Add(el.ToString());
                        }
                    Dictionary<string, int> userRates = new Dictionary<string, int>();
                    if (data.ContainsKey("userRates"))
                        foreach (var el in (Dictionary<string, object>)data["userRates"])
                        {
                            userRates.Add(el.Key, int.Parse(el.Value.ToString()));
                        }
                    Place place = new Place(documentSnapshot.Id, data["name"].ToString(), data["location"].ToString(), menuImages, category, userRates);

                    places.Add(place);
                }
                return places;
            }
            catch
            {
                return null;
            }
        }
        public async Task<List<Place>> getRatedPlacesByUserID(string id)
        {
            try
            {
                QuerySnapshot allCitiesQuerySnapshot = await placesCollection.WhereGreaterThanOrEqualTo("userRates." + id, 0).GetSnapshotAsync();
                List<Place> places = new List<Place>();
                foreach (DocumentSnapshot documentSnapshot in allCitiesQuerySnapshot.Documents)
                {
                    Dictionary<string, object> data = documentSnapshot.ToDictionary();

                    Category category = await categoryServices.getCategotyById(data["categoryId"].ToString());

                    List<string> menuImages = new List<string>();
                    if (data.ContainsKey("menuImages"))
                        foreach (var el in (List<object>)data["menuImages"])
                        {
                            menuImages.Add(el.ToString());
                        }
                    Dictionary<string, int> userRates = new Dictionary<string, int>();
                    if (data.ContainsKey("userRates"))
                        foreach (var el in (Dictionary<string, object>)data["userRates"])
                        {
                            userRates.Add(el.Key, int.Parse(el.Value.ToString()));
                        }
                    Place place = new Place(documentSnapshot.Id, data["name"].ToString(), data["location"].ToString(), menuImages, category, userRates);

                    places.Add(place);
                }
                return places;
            }
            catch
            {
                return null;
            }
        }

        public async Task<Place> addPlace(PlaceDto placeDto)
        {
            try
            {
                if (placeDto.name==null|| placeDto.name == "" ||
                    placeDto.location == null || placeDto.location == "" ||
                    placeDto.categoryId == null || placeDto.categoryId == "" ||
                    placeDto.menuImages.Count == 0 || placeDto.menuImages == null )
                {
                    return null;
                }
                FirebasePlaceDto firebasePlaceDto = new FirebasePlaceDto
                {
                    name = placeDto.name,
                    location = placeDto.location,
                    categoryId = placeDto.categoryId,
                    menuImages = new List<string>(),
                    userRates = new Dictionary<string, int>()
                };
                DocumentReference DocRef = await placesCollection.AddAsync(firebasePlaceDto);

                for (int i = 0; i < placeDto.menuImages.Count; i++)
                {
                    var task = new FirebaseStorage("where-bf478.appspot.com")
                                                .Child("placesMenusImages")
                                                .Child(i + "_" + DocRef.Id + ".png")
                                                .PutAsync(placeDto.menuImages[i].OpenReadStream());
                    task.Progress.ProgressChanged += (s, e) => Console.WriteLine($"Progress: {e.Percentage} %");

                    // await the task to wait until upload completes and get the download url
                    var downloadUrl = await task;
                    firebasePlaceDto.menuImages.Add(downloadUrl);
                }
                await placesCollection.Document(DocRef.Id).SetAsync(firebasePlaceDto);
                Category category = await categoryServices.getCategotyById(placeDto.categoryId);
                Place place = new Place(DocRef.Id, placeDto.name, placeDto.location, firebasePlaceDto.menuImages, category, new Dictionary<string, int>());
                return place;
            }
            catch { return null; }
        }
        public async Task<Place> editUserRate(string placeId, RateDto rateDto)
        {
            try
            {
                DocumentReference documentReference = placesCollection.Document(placeId);
                DocumentSnapshot documentSnapshot = await documentReference.GetSnapshotAsync();
                Dictionary<string, object> data = documentSnapshot.ToDictionary();

                Category category = await categoryServices.getCategotyById(data["categoryId"].ToString());

                List<string> menuImages = new List<string>();
                if (data.ContainsKey("menuImages"))
                    foreach (var el in (List<object>)data["menuImages"])
                    {
                        menuImages.Add(el.ToString());
                    }
                Dictionary<string, int> userRates = new Dictionary<string, int>();
                if (data.ContainsKey("userRates"))
                    foreach (var el in (Dictionary<string, object>)data["userRates"])
                    {
                        userRates.Add(el.Key, int.Parse(el.Value.ToString()));
                    }

                if (userRates.ContainsKey(rateDto.userId))
                    userRates[rateDto.userId] = rateDto.rate;
                else
                    userRates.Add(rateDto.userId, rateDto.rate);

                Place place = new Place(documentSnapshot.Id, data["name"].ToString(), data["location"].ToString(), menuImages, category, userRates);
                FirebasePlaceDto firebasePlaceDto = new FirebasePlaceDto
                {
                    name = place.name,
                    location = place.location,
                    categoryId = place.category.id,
                    menuImages = place.menuImages,
                    userRates = userRates

                };
                await documentReference.SetAsync(firebasePlaceDto);
                return place;
            }
            catch { return null; }
        }
    }
}
