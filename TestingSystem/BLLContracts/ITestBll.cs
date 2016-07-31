using System.Collections.Generic;
using Entities;
namespace BLLContracts
{
    public interface ITestBll
    {
        void Add(string name);
        void Delete(int id);
        List<Test> GetAll();
        List<Question> GetAllQuestions(int id);
        Dictionary<int, bool> CheckTest(Dictionary<int, string> solution, int idTest);
        IEnumerable<Test> Search(string name);
    }
}
