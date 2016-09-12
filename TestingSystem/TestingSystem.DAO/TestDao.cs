using DAOContracts;
using System.Configuration;
using System.Data.SqlClient;
using Entities;
using System.Collections.Generic;
using System.Linq;
using System;

namespace TestingSystem.DAO
{
    public class TestDao : ITestDao
    {
        private static string conSqlr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;

        public void Add(string name)
        {
            using (var con = new SqlConnection(conSqlr))
            {
                try
                {
                    var query = "add_test";

                    var command = new SqlCommand(query, con)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@name", name);

                    con.Open();

                    command.ExecuteNonQuery();
                }
                catch(Exception e)
                {
                    Log.For(this).Error(e);
                    throw e;
                }
            }
        }

        public void Delete(int idTest)
        {
            using (var con = new SqlConnection(conSqlr))
            {
                try
                {
                    var query = "delete_test";

                    var command = new SqlCommand(query, con)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@id_test", idTest);

                    con.Open();

                    command.ExecuteNonQuery();
                }
                catch (Exception e)
                {
                    Log.For(this).Error(e);
                    throw e;
                }
            }
        }

        public IEnumerable<Test> GetAll()
        {
            var temp = new List<Test>();

            using (var con = new SqlConnection(conSqlr))
            {
                try
                {
                    var query = "get_all_tests";

                    var command = new SqlCommand(query, con)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };

                    con.Open();

                    var reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        int idTest = (int)reader["id_test"];
                        string nameTest = (string)reader["name"];
                        var tempTest = new Test(idTest, nameTest);
                        temp.Add(tempTest);
                    }

                    return temp;
                }
                catch (Exception e)
                {
                    Log.For(this).Error(e);
                    throw e;
                }
            }
        }

        public IEnumerable<Question> GetAllQuestions(int id)
        {
            
            var temp = new List<Question>();

            using (var con = new SqlConnection(conSqlr))
            {
                try
                {
                    var query = "get_all_questions_in_test";

                    var command = new SqlCommand(query, con)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@id_test", id);

                    con.Open();

                    var reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        int idQuestion = (int)reader["id"];
                        string textQuestion = (string)reader["question"];
                        var tempQuestion = new Question(idQuestion, textQuestion);
                        temp.Add(tempQuestion);
                    }

                    return temp;
                }
                catch (Exception e)
                {
                    Log.For(this).Error(e);
                    throw e;
                }
            }
        }

        public IDictionary<int, List<byte>> GetAllQuestionsAnswer(int id)
        {
            var temp = new Dictionary<int, List<byte>>();

            using (var con = new SqlConnection(conSqlr))
            {
                try
                {
                    var query = "get_all_questions_in_test";

                    var command = new SqlCommand(query, con)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@id_test", id);

                    con.Open();

                    var reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        int idTest = (int)reader["id"];
                        List<byte> answers = ((byte[])reader["answer"]).ToList<byte>();
                        temp.Add(idTest, answers);
                    }
                    return temp;
                }
                catch (Exception e)
                {
                    Log.For(this).Error(e);
                    throw e;
                }
            }
        }
    }
}
