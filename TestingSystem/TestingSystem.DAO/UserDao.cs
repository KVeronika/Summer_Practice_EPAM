using DAOContracts;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Linq;
using System;

namespace TestingSystem.DAO
{
    public class UserDao : IUserDao
    {
        private static string conSqlr = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
        public void Add(string login, byte[] password)
        {
            using (var con = new SqlConnection(conSqlr))
            {
                try
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
                catch(Exception e)
                {
                    Log.For(this).Error(e);
                    throw e;
                }
            }
        }

        public string CanRegister(string login)
        {
            using (var con = new SqlConnection(conSqlr))
            {
                try
                {
                    string existingLogin = "";
                    var query = "existing_username";

                    var command = new SqlCommand(query, con)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@username", login);

                    con.Open();

                    var reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        existingLogin = (string)reader["c_login"];
                    }
                    return existingLogin;
                }
                catch (Exception e)
                {
                    Log.For(this).Error(e);
                    throw e;
                }
            }
        }

        public bool CheckPassword(string login, string password)
        {
            using (var con = new SqlConnection(conSqlr))
            {
                try
                {
                    var query = "get_password_for_user";

                    var command = new SqlCommand(query, con)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@login", login);

                    con.Open();

                    var reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        var passwordthis = (byte[])reader["c_password"];
                        SHA256 mySHA256 = SHA256Managed.Create();
                        var temppaswotrs = password.ToCharArray().Select(n => (byte)n).ToArray();
                        return UserDao.Compare(passwordthis, mySHA256.ComputeHash(temppaswotrs));
                    }
                    else
                    {
                        return false;
                    }
                }
                catch (Exception e)
                {
                    Log.For(this).Error(e);
                    throw e;
                }
            }
        }

        private static bool Compare(byte[] a, byte[] b)
        {
            if (a != null && b != null && a.Length != b.Length)
            {
                return false;
            }

            for (int i = 0; i < a.Length; i++)
            {
                if (a[i] != b[i])
                {
                    return false;
                }
            }

            return true;
        }
    }
}
