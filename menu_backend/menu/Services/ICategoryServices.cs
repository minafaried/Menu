using where.Models.CategoryModels;

namespace where.Services
{
    public interface ICategoryServices
    {
        Task<Category> addCategory(CategotyDto categotyDto);
        Task<Category> editCategoty(Category req);
        Task<List<Category>> GetCategories();
        Task<Category> getCategotyById(string id);
    }
}