using Entities;
using System.Collections.Generic;

namespace DAOContracts
{
    public interface ITestDao
    {
        void Add(string name);
        IEnumerable<Test> GetAll();
        IEnumerable<Question> GetAllQuestions(int id);
        IDictionary<int, List<byte>> GetAllQuestionsAnswer(int id);
    }
}
