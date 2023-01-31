namespace where.Models.UserModels
{
    public class User
    {
        public string id { get; set; }
        public string email { get; set; }
        public string name { get; set; }
        public string password { get; set; }
        Dictionary<string, int> rates { get; set; }
        public User(string id, string email, string name, string password, Dictionary<string, int> rates)
        {
            this.id = id;
            this.email = email;
            this.name = name;
            this.password = password;
            this.rates = rates;
        }
    }
}
