using cara.api;
using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<CaraDbContext>();
builder.Services.AddScoped<IRecipeService, RecipeService>();

// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

// sollte für production eingeschränkt werden, verhindert cors fehler in localhost dev
builder.Services.AddCors(o =>
{
    o.AddPolicy("default", policy =>
    {
        policy.AllowAnyHeader();
        policy.AllowAnyMethod();
        policy.AllowAnyOrigin();
    });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.MapScalarApiReference();
}

app.UseHttpsRedirection();

app.UseCors("default");
app.UseStaticFiles();

app.MapGet("/recipes", (IRecipeService recipeService) => recipeService.GetRecipes());

app.MapGet("/recipes/{id}", (IRecipeService recipeService, int id) => recipeService.GetRecipe(id));

app.MapPost("/recipes",
    (IRecipeService recipeService, string title, string description, int durationInMinutes, IFormFile? image) =>
        recipeService.AddRecipeAsync(title, description, durationInMinutes, image)).DisableAntiforgery();

app.MapPut("/recipes/{id}",
    (IRecipeService recipeService, int id, string? title = null, string? description = null,
            int? durationInMinutes = null, IFormFile? image = null)
        => recipeService.UpdateRecipe(id, title, description, durationInMinutes, image)
).DisableAntiforgery();

app.MapDelete("/recipes/{id}", (IRecipeService recipeService, int id) => recipeService.DeleteRecipe(id));

app.MapGet("/recipes/random", (IRecipeService recipeService) => recipeService.GetRandomRecipe());

// Migrations beim Start ausführen, um sicherzustellen, dass die Datenbank aktuell ist
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<CaraDbContext>();
    await db.Database.MigrateAsync();
}

app.Run();