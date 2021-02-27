using Common;
using Newtonsoft.Json;
using System;
using System.IO;
using Xunit;

namespace Tests
{
    public class PatientTest
    {

        [Fact]
        public void TestDeserialization()
        {
            // TODO - shouldn't hardcode this path
            var json = File.ReadAllText("C:\\Users\\benag\\source\\repos\\Medi-Map-TechnicalTest\\TechnicalTest\\data\\Patientsdata.json");
            var patients = JsonConvert.DeserializeObject<PatientDetails[]>(json);

            Assert.Equal(6, patients.Length);

            Assert.Equal(1, patients[0].PatientID);
            Assert.Equal("Barbara", patients[0].FirstName);
            Assert.Equal("Smith", patients[0].LastName);
            Assert.Equal("Female", patients[0].Gender);
            Assert.Equal(new DateTime(1944, 8, 28), patients[0].DOB);
            Assert.Equal(165, patients[0].HeightCms);
            Assert.Equal(75.6, patients[0].WeightKgs);
            Assert.Equal(5, patients[0].MedicationID);
        }

        [Fact]
        public void TestBmi()
        {
            var patient = new PatientDetails();
            patient.HeightCms = 100.0;
            patient.WeightKgs = 50.0;
            Assert.Equal(50, patient.CalcultateBmi());
        }
    }
}
