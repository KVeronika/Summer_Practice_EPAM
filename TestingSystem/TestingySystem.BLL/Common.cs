using DAOContracts;
using TestingSystem.DAO;

namespace TestingSystem.BLL
{
    public static class Common
    {
        private static IQuestionDao questionDao = new QuestionDao();

        private static ITestDao testDao = new TestDao();

        private static IUserDao userDao = new UserDao();

        public static IQuestionDao QuestionDao
        {
            get
            {
                return questionDao;
            }
        }

        public static ITestDao TestDao
        {
            get
            {
                return testDao;
            }
        }

        public static IUserDao UserDao
        {
            get
            {
                return userDao;
            }
        }
    }
}
