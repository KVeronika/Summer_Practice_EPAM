using DAOContracts;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;

namespace TestingSystem.DAO
{
    public class QuestionDao : IQuestionDao
    {
        private static string conSqlr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;

        public void Add(int idTest, string question, string answer)
        {
            using (var con = new SqlConnection(conSqlr))
            {
                var query = "add_question";

                SHA256 mySHA256 = SHA256Managed.Create();
                var tempAnswer = answer.ToCharArray().Select(n => (byte)n).ToArray();

                var command = new SqlCommand(query, con)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@id_test", idTest);
                command.Parameters.AddWithValue("@question", question);
                command.Parameters.AddWithValue("@answer", mySHA256.ComputeHash(tempAnswer));

                con.Open();

                command.ExecuteNonQuery();
            }
        }
    }
}
