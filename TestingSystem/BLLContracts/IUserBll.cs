namespace BLLContracts
{
    public interface IUserBll
    {
        void Add(string login, string password);
        bool CanRegister(string login);
        bool CanLogin(string login, string password);
    }
}
