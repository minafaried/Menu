namespace where.Models.CategoryModels
{
    public class Category
    {
        public string id { get; set; }
        public string name { get; set; }
        public Category(string id, string name)
        {
            this.id = id;
            this.name = name;
        }
    }
}
