using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace TechnicalTest
{
    public class Startup
    {
        public IConfiguration Configuration { get; }
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }
  
        public void ConfigureServices(IServiceCollection services)
        {
            /* 
             * There are several ways to deserialise integers / doubles passed as string in JSON. 
             * This method is convenient however using a preview version of the Newtonsoft package is probably 
             * not recommended. Ideally the source JSON should be fixed, or a custom handler written.
             * Note: this is fixed in .NET 5 by default.;
            */

            services.AddControllers().AddNewtonsoftJson(); ; 
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            // Iniitiate our Low-effort logger. Ideally a 3rd party logger should be used.
            Log.Init(Configuration);

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
