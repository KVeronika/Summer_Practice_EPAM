namespace DAOContracts
{
    public interface IQuestionDao
    {
        void Add(int idTest, string question, byte[] answer);
    }
}
