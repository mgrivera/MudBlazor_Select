using Microsoft.AspNetCore.Identity;
using System.Data;
using scrweb_blazor.Data;
using scrweb_blazor.Models.General;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.FluentUI.AspNetCore.Components;

namespace scrweb_blazor.Components.Pages.Administracion
{
    public partial class Administracion
    {
        // ==============================================================================================
        // el objetivo de esta página es:
        // 1) agregar el rol 'admin' si no existe
        // 2) agregar el rol 'user' si no existe
        // 3) agregar el current user al rol 'admin' si admin no tiene usuarios asignados
        // ==============================================================================================

        [CascadingParameter]
        private Task<AuthenticationState>? authenticationStateTask { get; set; }

        // ================================================================================================
        // para que esta variable tenga valores desde el inicio y no falle el FluentMessage por valores en null
        FluentMessageBar_params? fluentUIMessageBar = new FluentMessageBar_params();

        string ADMINISTRATION_ROLE = "admin";
        string USER_ROLE = "user";

        System.Security.Claims.ClaimsPrincipal? currentUser;

        bool buttonDisabled = true;

        // para construir una lista de usuarios y mostrar para asignar el rol 'user' a uno de ellos
        IEnumerable<ApplicationUser>? userList;
        string? selectedUserFromList;
        ApplicationUser? selectedUser;

        // to show a loading image in the button while the task is excecuting
        bool loadingButton1 = false;
        bool loadingButton2 = false;

        protected override async Task OnInitializedAsync()
        {
            string message = string.Empty;

            // Get the current logged in user
            if (authenticationStateTask is not null)
            {
                currentUser = (await authenticationStateTask).User;

                if (currentUser?.Identity is not null && !currentUser.Identity.IsAuthenticated)
                {
                    message = @"Nada se ha hecho en esta página. Ud. no es un usuario que se haya autenticado en el programa. Debe hacer un login antes.";

                    // mostramos un mensaje al usuario vía fluent ui messageBar
                    fluentUIMessageBar = new FluentMessageBar_params
                    {
                        Title = "<h5>Administración de usuarios y roles</h5>",
                        Intent = MessageIntent.Error,
                        Visible = true,
                        Text = message
                    };

                    return;
                }
            }
            else
            {
                message = @"Nada se ha hecho en esta página. Ud. no es un usuario que se haya autenticado en el programa. Debe hacer un login antes.";

                // mostramos un mensaje al usuario vía fluent ui messageBar
                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>Administración de usuarios y roles</h5>",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = message
                };

                return;
            }

            message = @$"Hola <b><em>{currentUser!.Identity!.Name!}!</em></b> (tienes una cuenta e hicistes un <em>login</em> en el programa). <br />";
            message += @"<b><em>Nota importante:</em></b> este es un mecanismo <em>temporal</em> para manejar, de forma inicial, la autenticación y
                     autorización de los usuarios al programa. <br />";

            // mostramos un mensaje al usuario vía fluent ui messageBar
            fluentUIMessageBar = new FluentMessageBar_params
            {
                Title = "<h5>Administración de usuarios y roles</h5>",
                Intent = MessageIntent.Info,
                Visible = true,
                Text = message
            };
        }

        // =====================================================================================================
        // para crear los roles admin y user *solo* si no existen.
        // Además, para asignar el role admin al current user si no hay usuarios en este rol (admin)
        // La idea es tener un mecanismo *inicial* para que el primer user de la apliación sea admin
        private async Task LeerYCrearRolesAdminYUser()
        {
            loadingButton1 = true;

            string message = string.Empty;
            string _connectionString = Configuration.GetSection("ConnectionStrings")["dbContab"]!;

            // ================================================================================================
            // ensure there is a ADMINISTRATION_ROLE
            var RoleResult = await _RoleManager.FindByNameAsync(ADMINISTRATION_ROLE);
            if (RoleResult == null)
            {
                // Create ADMINISTRATION_ROLE Role
                await _RoleManager.CreateAsync(new IdentityRole(ADMINISTRATION_ROLE));
                message += @$"El rol {ADMINISTRATION_ROLE} ha sido creado. <br />";
            }
            else
            {
                message += @$"El rol <em>{ADMINISTRATION_ROLE}</em> existe, pues había sido creado antes. <br />";
            }

            // ================================================================================================
            // ensure there is a USER_ROLE
            RoleResult = await _RoleManager.FindByNameAsync(USER_ROLE);
            if (RoleResult == null)
            {
                // Create USER_ROLE Role
                await _RoleManager.CreateAsync(new IdentityRole(USER_ROLE));
                message += @$"El rol {USER_ROLE} ha sido creado. <br />";
            }
            else
            {
                message += @$"El rol <em>{USER_ROLE}</em> existe, pues había sido creado antes. <br />";
            }

            // nota: aquí sabemos que el rol "admin" ha sido agregado antes
            var roleAdmin = await _RoleManager.FindByNameAsync("admin");

            // =====================================================================================================
            // determinamos la cantidad de users in rol admin
            var usersInRoleAdmin_list = await _UserManager.GetUsersInRoleAsync("admin");

            var usersInAdminRole = usersInRoleAdmin_list.Count();

            message += @$"<b>Nota:</b> antes de ejecutar este proceso, se habían agregado <b>{usersInAdminRole.ToString()}</b> usuarios al rol <em>{ADMINISTRATION_ROLE}</em>. <br />";

            //  *solo* si no hay usuarios en el rol admin; agregamos el current user
            if (usersInAdminRole == 0 && currentUser?.Identity is not null && currentUser.Identity.IsAuthenticated)
            {
                var thisUser = await _UserManager.FindByNameAsync(currentUser!.Identity!.Name!);
                await _UserManager.AddToRoleAsync(thisUser!, ADMINISTRATION_ROLE);

                message += @$"Su cuenta de usuario, '<em>{currentUser!.Identity!.Name!}</em>', ha sido agregada, en forma automática, al rol '<em>{ADMINISTRATION_ROLE}</em>'. <br />";
            }

            // finalmente, determinamos si el usuario es un administrador y lo informamos en el messageBar
            var user = await _UserManager.FindByNameAsync(currentUser!.Identity!.Name!);
            var isAdmin = await _UserManager.IsInRoleAsync(user!, "admin");

            if (isAdmin)
            {
                message += @$"Ud. es un administrador, pues se le asignado el rol <em>admin</em>. <br />";
            }

            // si el usuario no es admin ni user, permitimos asignar el rol 'user'
            var isUser = await _UserManager.IsInRoleAsync(user!, "user");

            if (isUser)
            {
                message += @$"Ud. es un <em>user</em>, pues se le asignado el rol <em>user</em>. <br />";
            }

            if (!isAdmin && !isUser)
            {
                message += @$"Ud. no es miembro de <b>ningún</b> rol en el programa. Debe pedir a un usuario <em>admin</em> que le asigne un rol, para poder usar las funciones del programa.<br />";
            }

            // only admins can assign rol 'user' to users
            if (isAdmin)
            {
                buttonDisabled = false;
            }

            // =====================================================================================================
            // construimos una lista con los usuarios registrados. La idea es permitir asignar el rol User a uno de ellos
            userList = _UserManager.Users.AsEnumerable<ApplicationUser>();

            // seleccionamos siempre el 1er. usuario en la lista, pues no ocurre en forma automática
            selectedUser = userList.FirstOrDefault();

            // mostramos un mensaje al usuario vía fluent ui messageBar
            fluentUIMessageBar = new FluentMessageBar_params
            {
                Title = "<h5>Administración de usuarios y roles</h5>",
                Intent = MessageIntent.Info,
                Visible = true,
                Text = message
            };

            // to stop showing the loading image in the button
            loadingButton1 = false;
        }

        // =====================================================================================================
        // para asignar el rol 'user'  al user seleccionado en la lista
        private async Task asignarRolUser()
        {
            loadingButton2 = true;
            string message = string.Empty;

            // el usuario (admin) debe seleccionar un usuario de la lista (para asignar el rol admin)
            if (selectedUser is null)
            {
                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>Administración de usuarios y roles</h5>",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = "Ud. debe seleccionar un usuario en la lista."
                };

                loadingButton2 = false;
                return;
            }

            try
            {
                await Task.Delay(1000);
                await _UserManager.AddToRoleAsync(selectedUser!, USER_ROLE);
                message = $"Ok, hemos asignado el rol '<b><em>user</em></b>' al usuario <em>{selectedUser.UserName}</em>. ";

                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>Administración de usuarios y roles</h5>",
                    Intent = MessageIntent.Info,
                    Visible = true,
                    Text = message
                };

                loadingButton2 = false;
                StateHasChanged();

            }
            catch (Exception ex)
            {
                message = $"Error: hemos encontrado un error al intentar asignar el rol 'user' al usuario seleccionado en la lista.<br />{ex.Message}";

                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "<h5>Administración de usuarios y roles</h5>",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = message
                };

                loadingButton2 = false;
                StateHasChanged();
            }
        }
    }
}
