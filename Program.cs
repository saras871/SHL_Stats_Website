var builder = WebApplication.CreateBuilder(args);

// ✅ Lägg till controllers
builder.Services.AddControllers();
builder.Services.AddScoped<GoalieRepository>();
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        policy => policy
            .AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader());
});

var app = builder.Build();

app.UseCors("AllowAll");

// ✅ Aktivera controllers
app.MapControllers();


app.Run();
