namespace cara.api;

public interface IRecipeService
{
    IEnumerable<RecipeListEntry> GetRecipes();
    Recipe? GetRecipe(int id);
    Task<Recipe> AddRecipeAsync(string title, string description, int durationInMinutes, IFormFile? image);
    Task<Recipe> UpdateRecipe(int id, string? title = null, string? description = null, int? durationInMinutes = null,
        IFormFile? image = null);
    void DeleteRecipe(int id);
    Recipe? GetRandomRecipe();
}