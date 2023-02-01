using FluentAssertions;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using where.CategoriesController;
using where.Controllers;
using where.Models.CategoryModels;
using where.Models.PlaceModels;
using where.Services;

namespace TestProject.Controllers
{
    public class PlaceControllerTest
    {
        [Fact]
        public async Task getAllPlaces_Oktest()
        {
            PlacesController placesController = new PlacesController(new PlaceServices());

            var result = await placesController.getAllPlaces();

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(OkObjectResult));
        }
        [Fact]
        public async Task addPlaceNullValue_test()
        {
            PlacesController placesController = new PlacesController(new PlaceServices());

            var result = await placesController.addPlace(new PlaceDto());


            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(BadRequestResult));
        }
        [Fact]
        public async Task addCategoryEmptyValue_test()
        {
            PlacesController placesController = new PlacesController(new PlaceServices());

            var result = await placesController.addPlace(new PlaceDto() { name="",location="12354",categoryId="",menuImages=new List<Microsoft.AspNetCore.Http.IFormFile>()});


            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(BadRequestResult));
        }
    

    }
}
