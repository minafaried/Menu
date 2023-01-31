
using Microsoft.AspNetCore.Mvc;
using where.Models.CategoryModels;
using where.Models.PlaceModels;
using where.Services;

namespace eComm.CategoriesController
{
    [Route("api/Categories")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        ICategoryServices _categoryServices;
        IPlaceServices _placeServices;

        public CategoriesController(ICategoryServices categoryServices,IPlaceServices placeServices)
        {
            _categoryServices = categoryServices;
            _placeServices = placeServices;
        }
        
        [HttpGet]
        [Route("getCategories")]
        public async Task<IActionResult> GetCategories()
        {
            List<Category> categories = await _categoryServices.GetCategories();
            if (categories == null)
            {
                return BadRequest();
            }
            return Ok(categories);
        }
        
        [HttpPost]
        [Route("addCategory")]
        public async Task<IActionResult> addCategory([FromBody]CategotyDto categotyDto)
        {
            Category category = await _categoryServices.addCategory(categotyDto);
            if (category == null)
            {
                return BadRequest();
            }
            return Ok(category);
        }
        
        [HttpPut]
        [Route("editCategoty")]
        public async Task<IActionResult> editCategoty([FromBody] Category newCategory)
        {

            Category category= await _categoryServices.editCategoty(newCategory);
            if(category == null) { return BadRequest(); }
            return Ok(category);
        }
        

        [HttpGet]
        [Route("getPlacesByCategoryId")]
        public async Task<IActionResult> getPlacesByCategoryId(string id)
        {

            List<Place> places =await _placeServices.getPlacesByCategoryId(id);
            if (places == null)
            {
                return BadRequest();
            }
            return Ok(places);
        }
    }
}
