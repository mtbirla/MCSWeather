using MicroSvcWeather.Controllers;

namespace MicroServiceTest
{
    [TestFixture]
    public sealed class WeatherForecastControllerTests
    {
        private WeatherForecastController _controller;

        [SetUp]
        public void SetUp()
        {
            _controller = new WeatherForecastController();
        }

        [Test]
        public void Get_ReturnsFiveWeatherForecasts()
        {
            // Act
            var result = _controller.Get();

            // Assert
            Assert.That(result != null);
            var forecasts = result.ToArray();
            Assert.That(5.Equals(forecasts.Length));
        }
    }
}