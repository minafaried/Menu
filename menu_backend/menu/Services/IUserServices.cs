using where.Models.UserModels;

namespace where.Services
{
    public interface IUserServices
    {
        string hashingPassword(string passwoed);
        Task<User> logIn(LogInModelDto logInModelDto);
        Task<User> signUp(UserDto userDto);
    }
}