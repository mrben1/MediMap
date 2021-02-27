using System;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Extensions.Configuration;

namespace TechnicalTest
{
    // Low effort logger to fit test parameters. Discuss business requirements for fully fledged logger - recommend 3rd party.
    public class Log
    {
        private static IConfiguration _configuration;

        public static void Init(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public static void Error(Exception e)
        {
            try
            {
                using (var con = new SqlConnection(_configuration.GetConnectionString(Constants.TechTestDbSettingName)))
                using (var cmd = new SqlCommand("[dbo].[uspLogError]", con) { CommandType = CommandType.StoredProcedure })
                {
                    cmd.Parameters.AddWithValue("@ErrorMessage", e.Message);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception)
            {
                // TODO We couldn't talk to the database for some reason. Implement offline Log here
            }
        }

    }
}
