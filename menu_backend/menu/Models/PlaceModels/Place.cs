using where.Models.CategoryModels;

namespace where.Models.PlaceModels
{
    public class Place
    {
        public string id { get; set; }
        public string name { get; set; }
        public string location { get; set; }
        public List<string>menuImages { get; set; }
        public Category category { get; set; }
        public Dictionary<string, int> userRates { get; set; }
        public Place(string id, string name, string location, List<string> menuImages, Category category, Dictionary<string, int> userRates)
        {
            this.id = id;
            this.name = name;
            this.location = location;
            this.menuImages = menuImages;
            this.category = category;
            this.userRates = userRates;
        }
    }
}
