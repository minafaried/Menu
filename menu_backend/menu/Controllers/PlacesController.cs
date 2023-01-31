using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using where.Models.PlaceModels;
using where.Models.UserModels;
using where.Services;

namespace where.Controllers
{
    [Route("api/Places")]
    [ApiController]
    public class PlacesController : ControllerBase
    {
        IPlaceServices _placeServices;
        public PlacesController( IPlaceServices placeServices)
        {
            _placeServices = placeServices;
        }


        [HttpGet]
        [Route("getAllPlaces")]
        public async Task<IActionResult> getAllPlaces()
        {

            List<Place> places = await _placeServices.getAllPlaces();
            if (places == null)
            {
                return BadRequest();
            }
            return Ok(places);
        }
        [HttpPost]
        [Route("addPlace")]
        public async Task<IActionResult> addPlace([FromForm]PlaceDto placeDto)
        {

            Place place = await _placeServices.addPlace(placeDto);
            if (place == null)
            {
                return BadRequest();
            }
            return Ok(place);
        }
        [HttpPost]
        [Route("editUserRate")]
        public async Task<IActionResult> editUserRate(string placeId, [FromBody] RateDto rateDto)
        {

            Place place = await _placeServices.editUserRate(placeId,rateDto);
            if (place == null)
            {
                return BadRequest();
            }
            return Ok(place);
        }
    }
}
