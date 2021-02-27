using Common;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Text;
using TechnicalTest.Controllers;
using Xunit;

namespace Tests
{
    public class TestPatientManager : IPatientManager
    {
        public bool AddUpdatePatient(PatientDetails patient)
        {
            return patient.PatientID == 1 ? true : false;
        }
    }

    public class PatientControllerTest
    {
        [Fact]
        public void TestPost()
        {
            var controller = new Patient(new TestPatientManager());
            
            var successResult = controller.Post(new PatientDetails { PatientID = 1 });
            Assert.IsAssignableFrom<OkObjectResult>(successResult);

            var failResult = controller.Post(new PatientDetails { PatientID = 2 });
            Assert.IsAssignableFrom<BadRequestObjectResult>(failResult);
        }
    }
}
