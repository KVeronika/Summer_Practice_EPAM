using DAOContracts;
using System.Data.SqlClient;
using System.Configuration;

namespace TestingSystem.DAO
{
    public class UserDao : IUserDao
    {
        private static string conSqlr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
        public void Add(string login, byte[] password)
        {
            using (var con = new SqlConnection(conSqlr))
            {
                var query = "add_user";

                var command = new SqlCommand(query, con)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@login", login);
                command.Parameters.AddWithValue("@password", password);

                con.Open();

                command.ExecuteNonQuery();
            }
        }
    }
}
