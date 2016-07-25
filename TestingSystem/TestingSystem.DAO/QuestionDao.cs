using DAOContracts;
using System.Configuration;
using System.Data.SqlClient;

namespace TestingSystem.DAO
{
    public class QuestionDao : IQuestionDao
    {
        private static string conSqlr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;

        public void Add(int idTest, string question, byte[] answer)
        {
            using (var con = new SqlConnection(conSqlr))
            {
                var query = "add_question";
                
                var command = new SqlCommand(query, con)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@id_test", idTest);
                command.Parameters.AddWithValue("@question", question);
                command.Parameters.AddWithValue("@answer", answer);

                con.Open();

                command.ExecuteNonQuery();
            }
        }
    }
}
