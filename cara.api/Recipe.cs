namespace cara.api;

public class Recipe
{
    public int Id { get; set; }
    public required string Title { get; set; } 
    public required string Description { get; set; } 
    public int DurationInMinutes { get; set; }
    public string? ImagePath { get; set; }
}