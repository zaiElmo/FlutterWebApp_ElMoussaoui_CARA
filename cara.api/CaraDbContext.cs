using Microsoft.EntityFrameworkCore;

namespace cara.api;

public class CaraDbContext(IConfiguration configuration) : DbContext
{
    public DbSet<Recipe> Recipes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder options)
    {
        options.UseSqlite(configuration.GetConnectionString(nameof(CaraDbContext)) ??
                          throw new InvalidOperationException(
                              $"Connection string {nameof(CaraDbContext)} is missing."
                          )
        );
    }
}