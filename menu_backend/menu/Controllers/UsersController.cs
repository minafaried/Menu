using Microsoft.AspNetCore.Mvc;
using where.Models.PlaceModels;
using where.Models.UserModels;
using where.Services;

namespace where.Controllers
{
    [Route("api/Users")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        IUserServices _userServices;
        IPlaceServices _placeServices;
        public  UsersController(IUserServices userServices,IPlaceServices placeServices)
        {
            _userServices= userServices;
            _placeServices=placeServices;
        }

        
        [HttpPost]
        [Route("logIn")]
        public async Task<IActionResult> logIn([FromBody]LogInModelDto logInModelDto)
        {

            User user = await _userServices.logIn(logInModelDto);
            if(user == null)
            {
                return Unauthorized();
            }
            return Ok(user);

        }
        
        [HttpPost]
        [Route("signUp")]
        public async Task<IActionResult> signUp([FromBody] UserDto userDto)
        {

            User user = await _userServices.signUp(userDto);
            if (user == null)
            {
                return BadRequest();
            }
            return Ok(user);
        }
        
        [HttpGet]
        [Route("getRatedPlacesByUserID")]
        public async Task<IActionResult> getRatedPlacesByUserID(string id)
        {
            List<Place> places = await _placeServices.getRatedPlacesByUserID(id);
            if (places == null)
            {
                return BadRequest();
            }
            return Ok(places);
        }
                
    }
}
