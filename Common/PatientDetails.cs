using System;

namespace Common
{

    public class PatientDetails
    {
        public int PatientID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Gender { get; set; }
        public DateTime DOB { get; set; }
        public double HeightCms { get; set; }
        public double WeightKgs { get; set; }
        public int MedicationID { get; set; }
        public double CalcultateBmi()
        {
            // BMI = kg / m2 where kg is a person's weight in kilograms and m2 is their height in metres squared. 
            return WeightKgs / Math.Pow(HeightCms / 100, 2);
        }
    }
 
}
