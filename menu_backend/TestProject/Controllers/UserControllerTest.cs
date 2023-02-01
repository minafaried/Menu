
using FakeItEasy;
using FluentAssertions;
using Google.Rpc;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using where.Controllers;
using where.Models.UserModels;
using where.Services;

namespace TestProject.Controllers
{
    public class UserControllerTest
    {
        [Fact]
        public async Task logInOK_testAsync()
        {
            UsersController usersController = new UsersController(new UserServices(),new PlaceServices());
            LogInModelDto logInModelDto = new LogInModelDto { email= "admin@admin.com", password="123"};
            var result = await usersController.logIn(logInModelDto);

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(OkObjectResult));
        }
        [Fact]
        public async Task logInNotfound_testAsync()
        {
            UsersController usersController = new UsersController(new UserServices(), new PlaceServices());
            LogInModelDto logInModelDto = new LogInModelDto { email = "admin", password = "123" };
            var result = await usersController.logIn(logInModelDto);

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(UnauthorizedResult));
        }
        [Fact]
        public async Task getRatedPlacesByUserIDOK_test()
        {
            UsersController usersController = new UsersController(new UserServices(), new PlaceServices());
            var result = await usersController.getRatedPlacesByUserID("QpuBrRFMNmmCyvu9f1cc");

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(OkObjectResult));
        }
        [Fact]
        public async Task getRatedPlacesByUserIDNotfound_test()
        {
            UsersController usersController = new UsersController(new UserServices(), new PlaceServices());
            var result = await usersController.getRatedPlacesByUserID("156");

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(OkObjectResult));
        }
        [Fact]
        public async Task signUpNullValue_test()
        {
            UsersController usersController = new UsersController(new UserServices(), new PlaceServices());

            var result = await usersController.signUp(new UserDto());

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(BadRequestResult));
        }
        [Fact]
        public async Task signUpEmptyValue_test()
        {
            UsersController usersController = new UsersController(new UserServices(), new PlaceServices());

            var result = await usersController.signUp(new UserDto() { email="",name="mina",password="123"});

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(BadRequestResult));
        }

    }
}
