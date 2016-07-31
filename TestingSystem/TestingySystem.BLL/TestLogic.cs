using Entities;
using System.Collections.Generic;
using System.Linq;
using BLLContracts;
using System;
using System.Security.Cryptography;
using System.Globalization;

namespace TestingSystem.BLL
{
    public class TestLogic: ITestBll
    {
        public void Add(string name)
        {
            Common.TestDao.Add(name);
        }

        public void Delete(int id)
        {
            Common.TestDao.Delete(id);
        }

        public List<Test> GetAll()
        {
            return Common.TestDao.GetAll().ToList();
        }

        public List<Question> GetAllQuestions(int id)
        {
            return Common.TestDao.GetAllQuestions(id).ToList();
        }

        public Dictionary<int, bool> CheckTest(Dictionary<int, string> solution, int idTest)
        {
            var answer = Common.TestDao.GetAllQuestionsAnswer(idTest);

            var result = new Dictionary<int, bool>();

            SHA256 mySHA256 = SHA256Managed.Create();
            
            foreach (var item in solution)
            {
                var tempAnswer = item.Value.ToCharArray().Select(n => (byte)n).ToArray();
                
                result.Add(item.Key, this.CheckAnswer(mySHA256.ComputeHash(tempAnswer).ToList(), answer.FirstOrDefault(n =>n.Key == item.Key).Value));
            }

            return result;
        }

        private bool CheckAnswer(List<byte> answerFirst, List<byte> answerSecond)
        {
            if (answerFirst.Count != answerSecond.Count)
            {
                throw new ArgumentException();
            }

            for (int i = 0; i < answerSecond.Count; i++)
            {
                if (answerFirst[i] != answerSecond[i])
                {
                    return false;
                }
            }

            return true;
        }

        public IEnumerable<Test> Search(string name)
        {
            return Common.TestDao.GetAll().Where(n => n.Name.StartsWith(name, false, CultureInfo.CurrentCulture)).ToList();
        }
    }
}
