namespace DAOContracts
{
    public interface IUserDao
    {
        void Add(string login, byte[] password);
        string CanRegister(string login);
        bool CheckPassword(string login, string password);
    }
}
