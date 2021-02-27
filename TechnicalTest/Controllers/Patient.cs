using Common;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace TechnicalTest.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class Patient : ControllerBase
    {
        // TODO Discuss business logic regarding authorisation... In it's current state this is a security risk

        private readonly IPatientManager _patientManager;

        [ActivatorUtilitiesConstructor]
        public Patient(IConfiguration configuration)
        {
            _patientManager = new PatientManager(configuration);
        }

        public Patient(IPatientManager manager)
        {
            _patientManager = manager;
        }


        [HttpPost]
        public IActionResult Post([FromBody] PatientDetails value)
        { 
            var result = _patientManager.AddUpdatePatient(value);

            // TODO - We should discuss Business Logic around return result / content;
            if (result) {
                return Ok($"Patient updated");
            } 
            
            return BadRequest($"An error occureed. Check the error log for more information.");
        }
    }
}
