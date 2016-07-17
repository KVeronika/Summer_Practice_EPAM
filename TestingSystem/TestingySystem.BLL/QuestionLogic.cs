using BLLContracts;

namespace TestingSystem.BLL
{
    public class QuestionLogic: IQuestionBll
    {
        public void Add(int idTest, string question, string answer)
        {
            Common.QuestionDao.Add(idTest, question, answer);
        }
    }
}
