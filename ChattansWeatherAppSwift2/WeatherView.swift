import SwiftUI
struct WeatherView: View {
    let latitude: String
    let longitude: String

    @StateObject var weatherViewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            Color(red: 157/255, green: 205/255, blue: 241/255) // Background color for the entire view
                .ignoresSafeArea()

            VStack {
                Text(weatherViewModel.weatherData?.name ?? "City Loading...")
                    .font(.system(size: 32))
                    .fontWeight(.medium)
                    .padding()

                Image(systemName: weatherViewModel.weatherData?.weatherIconInfo.imageName ?? "sparkles")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(weatherViewModel.weatherData?.weatherIconInfo.color ?? .yellow)
                    .frame(width: 250, height: 250) // Set width and height to 250

                Text("\(Int(weatherViewModel.weatherData?.main.temp ?? 0)) °C")
                    .font(.system(size: 70))
                    .fontWeight(.medium)
                    .padding()

                Text(weatherViewModel.weatherData?.weather.first?.description.capitalized ?? "Loading...")
                    .font(.system(size: 20))
                    .padding()

                HStack(spacing: 20) {
                    VStack {
                        Text("Min")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                        Text("\(Int(weatherViewModel.weatherData?.main.tempMin ?? 0)) °C")
                            .font(.system(size: 20))
                    }

                    VStack {
                        Text("Max")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                        Text("\(Int(weatherViewModel.weatherData?.main.tempMax ?? 0)) °C")
                            .font(.system(size: 20))
                    }
                }
                .padding()
            }
        }
        .onAppear {
            weatherViewModel.fetchWeatherData(latitude: latitude, longitude: longitude)
        }
    }
}


