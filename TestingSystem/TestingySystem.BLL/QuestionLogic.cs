using BLLContracts;
using System.Linq;
using System.Security.Cryptography;

namespace TestingSystem.BLL
{
    public class QuestionLogic: IQuestionBll
    {
        public void Add(int idTest, string question, string answer)
        {
            SHA256 mySHA256 = SHA256Managed.Create();
            var tempAnswer = answer.ToCharArray().Select(n => (byte)n).ToArray();
            Common.QuestionDao.Add(idTest, question, mySHA256.ComputeHash(tempAnswer));
        }
    }
}
