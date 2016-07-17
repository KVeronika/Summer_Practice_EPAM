using BLLContracts;

namespace TestingSystem.BLL
{
    public class UserLogic : IUserBll
    {
        public void Add(string login, string password)
        {
            Common.UserDao.Add(login, password);
        }
    }
}
