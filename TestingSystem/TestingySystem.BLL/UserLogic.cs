using BLLContracts;
using System.Linq;
using System.Security.Cryptography;

namespace TestingSystem.BLL
{
    public class UserLogic : IUserBll
    {
        public void Add(string login, string password)
        {
            SHA256 mySHA256 = SHA256Managed.Create();
            var tempPassword = password.ToCharArray().Select(n => (byte)n).ToArray();
            Common.UserDao.Add(login, mySHA256.ComputeHash(tempPassword));
        }

        public bool CanRegister(string login)
        {
            if (string.IsNullOrWhiteSpace(Common.UserDao.CanRegister(login)))
            {
                return true;
            }
            return false;
        }

        public bool CanLogin(string login, string password)
        {
            return Common.UserDao.CheckPassword(login, password);
        }
    }
}
