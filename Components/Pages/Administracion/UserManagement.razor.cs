using Microsoft.FluentUI.AspNetCore.Components;
using scrweb_blazor.Data;
using scrweb_blazor.Models.General; 

namespace scrweb_blazor.Components.Pages.Administracion
{
    public partial class UserManagement
    {
        // para construir una lista de usuarios y mostrarlos en un grid
        // para usar esta lista en el datagrid, debemos instalar el package apropiado desde github, para usar EF para hacerlo. 
        // preferimos, simplemente, convertir la lista a una lista normal y usar en forma directa en el grid 
        IEnumerable<ApplicationUser>? userList;
        List<user_item> users = new List<user_item>();

        // para mostrar en la forma, los datos del usuario seleccionado en la lista 
        private user_item userModel = new user_item();

        // ================================================================================================
        // para que esta variable tenga valores desde el inicio y no falle el FluentMessage por valores en null
        FluentMessageBar_params? fluentUIMessageBar = new FluentMessageBar_params();

        protected override void OnInitialized()
        {
            // =====================================================================================================
            // construimos una lista con los usuarios registrados. La idea es permitir asignar el rol User a uno de ellos
            userList = _UserManager.Users.AsEnumerable<ApplicationUser>();
            users = new List<user_item>();

            foreach (var u in userList)
            {
                var x = new user_item { id = u.Id, name = u.UserName!, email = u.Email!, emailConfirmed = u.EmailConfirmed ? "Ok" : "" };
                users.Add(x);
            }

            // el usuario debe seleccionar una compañía en la lista
            fluentUIMessageBar = new FluentMessageBar_params
            {
                Title = "contab - Administración de usuarios",
                Intent = MessageIntent.Success,
                Visible = true,
                Text = @$"Ok, ahora existen <b>{users.Count().ToString()}</b> usuarios registrados en el programa. "
            };
        }

        public void userSelected(string userId)
        {
            // cuando el usuario selecciona un item en la lista, lo mostramos en la forma 
            userModel = users!.First(u => u.id == userId);
            StateHasChanged();
        }

        public async Task handleDeleteUser()
        {
            //First Fetch the User you want to Delete
            var user = await _UserManager.FindByIdAsync(userModel.id);
            if (user == null)
            {
                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "contab - Administración de usuarios",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = @$"Error inesperado: no hemos logrado leer la información del usuario que se quiere eliminar. "
                };

                return;
            }

            var result = await _UserManager.DeleteAsync(user);
            if (result.Succeeded)
            {
                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "contab - Administración de usuarios",
                    Intent = MessageIntent.Success,
                    Visible = true,
                    Text = @$"Ok, el usuario ha sido eliminado. Su cuenta ya no existe en la tabla de usuarios del programa. "
                };

                // =====================================================================================================
                // volvemos a construir la lista para refrescarla en la página
                userList = _UserManager.Users.AsEnumerable<ApplicationUser>();
                users = new List<user_item>();

                foreach (var u in userList)
                {
                    var x = new user_item { id = u.Id, name = u.UserName!, email = u.Email! };
                    users.Add(x);
                }

                // para quitar el usuario de la forma (editForm)
                userModel = new user_item();

                StateHasChanged();
            }
            else
            {
                string message = string.Empty;

                foreach (var error in result.Errors)
                {
                    message += error.Description;
                }

                fluentUIMessageBar = new FluentMessageBar_params
                {
                    Title = "contab - Administración de usuarios",
                    Intent = MessageIntent.Error,
                    Visible = true,
                    Text = @$"Error: por alguna razón, el usuario no se ha podido eliminar. <br /><br />{message}"
                };
            }
        }

        // este es el model que usamos para mantener el usuario seleccionado en la lista y para mostrarlo en la forma 
        private class user_item
        {
            public string id { get; set; } = string.Empty;
            public string name { get; set; } = string.Empty;
            public string email { get; set; } = string.Empty;
            public string emailConfirmed { get; set; } = string.Empty;
        }
    }
}
