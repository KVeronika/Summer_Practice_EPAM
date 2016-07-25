namespace DAOContracts
{
    public interface IUserDao
    {
        void Add(string login, byte[] password);
    }
}
