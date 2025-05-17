using scrweb_blazor.Data;
using scrweb_blazor.Models.General;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.Data.SqlClient;
using Microsoft.FluentUI.AspNetCore.Components;
using System.Data;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity; 

namespace scrweb_blazor.Services.Identity
{
    /// <summary>
    /// La idea de esta clase es obtener el usuario que se ha authenticado 
    /// Normalmente este código es ejecutado cada vez que el usaurio abre una página (page) y el programa 
    ///  necesita tener los datos del usuario. 
    ///  Nota: supuestamente, cuando esta función es ejecutada cuando se abre una página, debe haber un usuario authenticado, 
    ///  pues la página siempre comienza con algo como: @attribute [Authorize(Roles = "admin, user")], lo cual quiere decir que 
    ///  *hay un usuario authenticado* 
    ///  Nota 2: un ejemplo del uso de este usuario es su id para saber cual es la cia Contab seleccionada 
    ///  Nota 3: authenticationStateTask se recibe en el page, como un CascadingParameter: 
    ///  [CascadingParameter]
    /// 
    /// private Task<AuthenticationState>? authenticationStateTask { get; set; }
    /// UserManeger se injecta en el page: 
    /// @inject UserManager<ApplicationUser> _UserManager
    /// </summary>
    public class GetAuthenticatedUser
    {
        private Task<AuthenticationState>? _authenticationStateTask;
        private UserManager<ApplicationUser> _userManager;

        private System.Security.Claims.ClaimsPrincipal? _currentUser;
        private ApplicationUser? _user;

        public GetAuthenticatedUser(Task<AuthenticationState>? authenticationStateTask, UserManager<ApplicationUser> UserManager)
        {
            _authenticationStateTask = authenticationStateTask;
            _userManager = UserManager;
        }

        public async Task<dynamic> GetUser()
        {
            string message = string.Empty;

            // Get the current logged in user
            if (_authenticationStateTask is not null)
            {
                _currentUser = (await _authenticationStateTask).User;

                if (_currentUser?.Identity is not null && !_currentUser.Identity.IsAuthenticated)
                {
                    message = @"Nada se ha hecho en esta página. Ud. no es un usuario que se haya autenticado en el programa. Debe hacer un login antes.";
                }
            }
            else
            {
                message = @"Nada se ha hecho en esta página. Ud. no es un usuario que se haya autenticado en el programa. Debe hacer un login antes.";
            }

            if (message != string.Empty)
            {
                return new
                {
                    error = true,
                    message
                };
            }

            // obtenemos el user
            _user = await _userManager.FindByNameAsync(_currentUser!.Identity!.Name!);

            if (_user is null)
            {
                // en desarrollo, si cambiamos de compañía Contab, el user puede venir authenticado, pero cuando se busca no se encuentra
                message = @"Aparentemente, Ud. no está <em>authenticado</em>. Por favor haga un login en el programa.";

                return new
                {
                    error = true,
                    message
                };
            }

            return new
            {
                error = false,
                message,
                user = _user
            };
        }
    }
}
