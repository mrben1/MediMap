using System;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Extensions.Configuration;
using Common;

namespace TechnicalTest
{

    public class PatientManager : IPatientManager
    {
        private readonly IConfiguration _configuration;

        public PatientManager(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public bool AddUpdatePatient(PatientDetails patient)
        {


            try
            {
                using (var con = new SqlConnection(_configuration.GetConnectionString(Constants.TechTestDbSettingName)))
                {
                    // TODO - Transaction here? Discuss business logic
                    con.Open();

                    // Insert / Update Patient
                    using (var cmd = new SqlCommand("[dbo].[uspPatientManage]", con) { CommandType = CommandType.StoredProcedure })
                    {
                        cmd.Parameters.AddWithValue("@PatientID", patient.PatientID);
                        cmd.Parameters.AddWithValue("@FirstName", patient.FirstName);
                        cmd.Parameters.AddWithValue("@LastName", patient.LastName);
                        cmd.Parameters.AddWithValue("@Gender", patient.Gender);
                        cmd.Parameters.AddWithValue("@DOB", patient.DOB);
                        cmd.Parameters.AddWithValue("@HeightCms", patient.HeightCms);
                        cmd.Parameters.AddWithValue("@WeightKgs", patient.WeightKgs);
                        cmd.ExecuteNonQuery();
                    }

                    // Insert the Medication Record
                    using (var cmd = new SqlCommand("[dbo].[uspMedicationAdministration]", con) { CommandType = CommandType.StoredProcedure })
                    {
                        cmd.Parameters.AddWithValue("@PatientID", patient.PatientID);
                        cmd.Parameters.AddWithValue("@MedicationID", patient.MedicationID);
                        cmd.Parameters.AddWithValue("@BMI", patient.CalcultateBmi());
                        cmd.ExecuteNonQuery();
                    }

                    return true;
                }
            }
            catch (Exception e)
            {
                Log.Error(e);
                return false;
            }
        }

    }
}
