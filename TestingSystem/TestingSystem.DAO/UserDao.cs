using DAOContracts;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Linq;

namespace TestingSystem.DAO
{
    public class UserDao : IUserDao
    {
        private static string conSqlr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
        public void Add(string login, string password)
        {
            using (var con = new SqlConnection(conSqlr))
            {
                var query = "add_user";

                SHA256 mySHA256 = SHA256Managed.Create();
                var tempPassword = password.ToCharArray().Select(n => (byte)n).ToArray();

                var command = new SqlCommand(query, con)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@login", login);
                command.Parameters.AddWithValue("@password", mySHA256.ComputeHash(tempPassword));

                con.Open();

                command.ExecuteNonQuery();
            }
        }
    }
}
