using FluentAssertions;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using where.CategoriesController;
using where.Models.CategoryModels;
using where.Services;

namespace TestProject.Controllers
{
    public class CategoryComtrollerTest
    {
        [Fact]
        public async Task GetCategoriesOK_testAsync()
        {
            CategoriesController categoriesController = new CategoriesController(new CategoryServices(), new PlaceServices());
           
            var result = await categoriesController.GetCategories();

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(OkObjectResult));
        }
        [Fact]
        public async Task addCategoryNullValue_test()
        {
            CategoriesController categoriesController = new CategoriesController(new CategoryServices(), new PlaceServices());

            var result = await categoriesController.addCategory(new CategotyDto());

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(BadRequestResult));
        }
        [Fact]
        public async Task addCategoryEmptyValue_test()
        {
            CategoriesController categoriesController = new CategoriesController(new CategoryServices(), new PlaceServices());

            var result = await categoriesController.addCategory(new CategotyDto() { name=""});

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(BadRequestResult));
        }
        [Fact]
        public async Task getPlacesByCategoryId_Oktest()
        {
            CategoriesController categoriesController = new CategoriesController(new CategoryServices(), new PlaceServices());

            var result = await categoriesController.getPlacesByCategoryId("BrZj5p2OOomgMFxlGrwQ");

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(OkObjectResult));
        }
        [Fact]
        public async Task getPlacesByCategoryId_NotFoundtest()
        {
            CategoriesController categoriesController = new CategoriesController(new CategoryServices(), new PlaceServices());

            var result = await categoriesController.getPlacesByCategoryId("");

            //Assert
            result.Should().NotBeNull();
            result.Should().BeOfType(typeof(OkObjectResult));
        }
    }
}
