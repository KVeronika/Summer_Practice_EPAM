using BLLContracts;
using TestingSystem.BLL;

namespace TestingSystem.Models
{
    public static  class Common
    {
        private static IQuestionBll questionBll = new QuestionLogic();

        private static ITestBll testBll = new TestLogic();

        private static IUserBll userBll = new UserLogic();

        public static IQuestionBll QuestionBll
        {
            get
            {
                return questionBll;
            }
        }

        public static ITestBll TestBll
        {
            get
            {
                return testBll;
            }
        }

        public static IUserBll UserBll
        {
            get
            {
                return userBll;
            }
        }
    }
}