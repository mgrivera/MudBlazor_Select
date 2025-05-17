//using Microsoft.AspNetCore.Components.Authorization;
//using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.FluentUI.AspNetCore.Components;
using scrweb_blazor.Components;
//using scrweb_blazor.Components.Account;
//using scrweb_blazor.Data;
//using scrweb_blazor.Models.EF_Core;
using MudBlazor.Services;

var builder = WebApplication.CreateBuilder(args);

//builder.Services.AddControllers();

// to add globalization to the app, we needed to add an MVC Controller 
builder.Services.AddControllers();

// Add services to the container.
builder.Services.AddRazorComponents().AddInteractiveServerComponents();
builder.Services.AddFluentUIComponents();

// Add MudBlazor components 
builder.Services.AddMudServices();

////builder.Services.AddCascadingAuthenticationState();
//builder.Services.AddScoped<IdentityUserAccessor>();
//builder.Services.AddScoped<IdentityRedirectManager>();
//builder.Services.AddScoped<AuthenticationStateProvider, IdentityRevalidatingAuthenticationStateProvider>();

//builder.Services.AddAuthentication(options =>
//    {
//        options.DefaultScheme = IdentityConstants.ApplicationScheme;
//        options.DefaultSignInScheme = IdentityConstants.ExternalScheme;
//    })
//    .AddIdentityCookies();

var connectionString = builder.Configuration.GetConnectionString("scrweb_blazor") ?? throw new InvalidOperationException("Connection string 'scrweb_blazor' not found.");

//builder.Services.AddDbContext<ApplicationDbContext>(options => options.UseSqlServer(connectionString));
builder.Services.AddDatabaseDeveloperPageExceptionFilter();

//builder.Services.AddIdentityCore<ApplicationUser>(options => options.SignIn.RequireConfirmedAccount = true)
//    //.AddRoles<IdentityRole>()
//    .AddEntityFrameworkStores<ApplicationDbContext>()
//    //.AddSignInManager()
//    //.AddDefaultTokenProviders()
//    ;

//builder.Services.AddIdentityCore<ApplicationUser>(options => options.SignIn.RequireConfirmedAccount = true)
//    //.AddEntityFrameworkStores<ApplicationDbContext>()
//    ;

//builder.Services.AddSingleton<IEmailSender<ApplicationUser>, IdentityNoOpEmailSender>();

// Register factory and configure the options (and pass the connection string to the context) 
//builder.Services.AddDbContextFactory<dbContext>(options => options.UseSqlServer(connectionString));
//builder.Services.AddDatabaseDeveloperPageExceptionFilter();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseMigrationsEndPoint();
}
else
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseAntiforgery();

// to add globalization to the app, we have to add an MVC Controller 
app.MapControllers();

app.MapRazorComponents<App>().AddInteractiveServerRenderMode();

// Add additional endpoints required by the Identity /Account Razor components.
//app.MapAdditionalIdentityEndpoints();

app.Run();
