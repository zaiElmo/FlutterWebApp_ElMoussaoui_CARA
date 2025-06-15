namespace cara.api;

public class RecipeService : IRecipeService
{
    private readonly CaraDbContext _context;
    private readonly IWebHostEnvironment _environment;

    public RecipeService(CaraDbContext context, IWebHostEnvironment environment)
    {
        _context = context;
        _environment = environment;
    }

    public IEnumerable<RecipeListEntry> GetRecipes()
    {
        return _context.Recipes.Select(r => new RecipeListEntry(r.Id, r.Title, r.ImagePath));
    }

    public Recipe? GetRecipe(int id)
    {
        return _context.Recipes.Find(id);
    }

    public async Task<Recipe> AddRecipeAsync(string title, string description, int durationInMinutes, IFormFile? image)
    {
        string? imagePath = null;
        if (image != null)
        {
            var fileName = $"{Guid.NewGuid()}-{Path.GetFileName(image.FileName)}";
            var dirPath = Path.Combine(_environment.WebRootPath, "images");

            Directory.CreateDirectory(dirPath);
            
            await using (var stream = new FileStream(Path.Combine(dirPath, fileName), FileMode.Create))
            {
                await image.CopyToAsync(stream);
            }

            imagePath = Path.Combine("images", fileName);
        }
        
        var recipe = _context.Recipes.Add(new Recipe
        {
            Title = title,
            Description = description,
            DurationInMinutes = durationInMinutes,
            ImagePath = imagePath
        });

        await _context.SaveChangesAsync();

        return recipe.Entity;
    }
    
    public async Task<Recipe> UpdateRecipe(int id, string? title = null, string? description = null,
        int? durationInMinutes = null,
        IFormFile? image = null)
    {
        var recipe = _context.Recipes.Find(id);
        if (recipe == null) 
            throw new Exception("Recipe not found");
        if (title != null) 
            recipe.Title = title;
        if (description != null) 
            recipe.Description = description;
        if (durationInMinutes != null) 
            recipe.DurationInMinutes = durationInMinutes.Value;
        
        if (image != null)
        {
            var fileName = $"{Guid.NewGuid()}-{Path.GetFileName(image.FileName)}";
            var filePath = Path.Combine(_environment.WebRootPath, "images", fileName);

            if (!string.IsNullOrEmpty(recipe.ImagePath))
            {
                var oldFilePath = Path.Combine(_environment.WebRootPath, recipe.ImagePath);
                if (File.Exists(oldFilePath))
                {
                    File.Delete(oldFilePath);
                }
            }

            await using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await image.CopyToAsync(stream);
            }

            recipe.ImagePath = Path.Combine("images", fileName);
        }
        
        await _context.SaveChangesAsync();
        return recipe;
    }

    public void DeleteRecipe(int id)
    {
        var recipe = _context.Recipes.Find(id);
        if (recipe == null) 
            throw new Exception("Recipe not found");
        _context.Recipes.Remove(recipe);
        _context.SaveChanges();
        
        if (recipe.ImagePath != null)
        {
            var fullPath = Path.Combine(_environment.WebRootPath, recipe.ImagePath);

            if (File.Exists(fullPath))
            {
                File.Delete(fullPath);
            }
        }
    }

    public Recipe? GetRandomRecipe()
    {
        var count = _context.Recipes.Count();
        if (count == 0) 
            return null;

        var skip = Random.Shared.Next(0, count);
        var randomRecipe = _context.Recipes.OrderBy(r => r.Id).Skip(skip).Take(1).First();
        return randomRecipe;
    }
}