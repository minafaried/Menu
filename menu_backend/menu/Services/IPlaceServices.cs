using where.Models.PlaceModels;

namespace where.Services
{
    public interface IPlaceServices
    {
        Task<Place> addPlace(PlaceDto placeDto);
        Task<Place> editUserRate(string placeId, RateDto rateDto);
        Task<List<Place>> getAllPlaces();
        Task<List<Place>> getPlacesByCategoryId(string id);
        Task<List<Place>> getRatedPlacesByUserID(string id);
    }
}