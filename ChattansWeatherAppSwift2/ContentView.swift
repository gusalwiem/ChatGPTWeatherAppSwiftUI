import SwiftUI

struct InputView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.yellow)
                    .frame(width: 250, height: 250) //modified size
                    .padding()
                
                Spacer()
                    .frame(height: 40) // Add space between the image and the textfields
                
                VStack {
                    Text("Latitude")
                        .font(.body)
                    TextField("XX.XXXX", text: $latitude) //modified preview text
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .keyboardType(.decimalPad)
                }
                
                VStack {
                    Text("Longitude")
                        .font(.body)
                    TextField("XX.XXXX", text: $longitude) //modified preview text
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .keyboardType(.decimalPad)
                }
                
                NavigationLink(destination: WeatherView(latitude: latitude, longitude: longitude)) {
                    Text("Update")
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Set input")
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}

