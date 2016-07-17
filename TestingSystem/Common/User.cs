using System;

namespace Entites
{
    public class User
    {
        public User(string login, string password)
        {
            if(string.IsNullOrWhiteSpace(login)|| string.IsNullOrWhiteSpace(password))
            {
                throw new ArgumentOutOfRangeException();
            }
            this.Login = Login;
            this.Password = password;
        }

        public string Login { get; }
        public string Password { get; }
    }
}
