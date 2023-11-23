//
//  PisteDetails.swift
//  my-app
//
//  Created by LUCAS Arthur on 21/11/2023.
//

import SwiftUI


struct PisteDetails: View {
    
    @State private var responseData: String = ""
    
    @ObservedObject var pisteDetails: PisteStructure
    
    @ObservedObject var pisteCollection: PisteCollection
    @State var weatherResponse: WeatherResponse = WeatherResponse()
    
    var btnDelete : some View {
        Button {
            pisteCollection.remove(id: pisteDetails.id)
        } label: {
            Image(systemName: "trash.fill")
        }
    }

    @State var bEditing = false
    
    var body: some View {
        ZStack (){
            VStack(alignment: .center){
                AsyncImage(url: pisteDetails.url){ image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
//                    ProgressView()
                    Rectangle().foregroundColor(.gray)
                }.cornerRadius(15).frame(maxHeight: 300)
                HStack(alignment: .center) {
                    HStack{
                        if(!bEditing){
                            Text(pisteDetails.name)
                            Button {
                                bEditing = true
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                            
                        } else {
                            TextField("Nom de la piste", text: $pisteDetails.name, onEditingChanged: { onEditing in
                                if(!onEditing){
                                    bEditing = false
                                }
                            }).textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }.padding(.leading, 10)
                    Spacer()
                    Text(pisteDetails.dateCreation.formatted(.iso8601.day().month().year())).foregroundColor(.gray).font(.system(size: 16))
                    
                    
                }
                HStack(){
                    Picker(selection: $pisteDetails.state, label: Text("Etat") ) {
                                        Text("Ouverte").tag(1)
                                        Text("En aménagement").tag(2)
                                        Text("Fermée").tag(3)
                                    }
                    Spacer()
                }
                
                
                
                
                    
                VStack{
                    
                    
                    if(weatherResponse.data.values.snowIntensity > 0 && weatherResponse.data.values.rainIntensity < weatherResponse.data.values.snowIntensity){
                        Image("snow").resizable().aspectRatio(contentMode: .fit).frame(maxHeight: 100)
                    }
                    else if(weatherResponse.data.values.rainIntensity > 0 && weatherResponse.data.values.rainIntensity > weatherResponse.data.values.snowIntensity){
                        Image("rain").resizable().aspectRatio(contentMode: .fit).frame(maxHeight: 100)
                    } else if(weatherResponse.data.values.cloudCover > 80){
                        Image("cloud").resizable().aspectRatio(contentMode: .fit).frame(maxHeight: 100)
                    }
                    else if(weatherResponse.data.values.cloudCover > 50){
                        Image("cloudSun").resizable().aspectRatio(contentMode: .fit).frame(maxHeight: 100)
                    }
                    else{
                        Image("sun").resizable().aspectRatio(contentMode: .fit).frame(maxHeight: 100)
                    }
                    VStack{
                        HStack{
                            HStack{
                                Image(systemName: "wind").foregroundColor(weatherResponse.data.values.windSpeed > 20 ? weatherResponse.data.values.windSpeed > 45 ? .red : .orange : .blue)
                                Text(weatherResponse.data.values.windSpeed, format : .number.precision(.fractionLength(2)))
                            }
                            Spacer()
                            HStack{
                                Image(systemName: "humidity.fill").foregroundColor(.blue)
                                Text(weatherResponse.data.values.humidity, format : .number.precision(.fractionLength(2)))
                            }
                            Spacer()
                            HStack{
                                Image(systemName: "eye.fill").foregroundColor(.blue)
                                Text(weatherResponse.data.values.visibility, format : .number.precision(.fractionLength(2)))
                            }
                        }.padding(.bottom)
                        
                        HStack{
                            HStack{
                                Image(systemName: "cloud.fill").foregroundColor(.blue)
                                Text(weatherResponse.data.values.cloudCover, format : .number.precision(.fractionLength(2)))
                            }
                            Spacer()
                            HStack{
                                Image(systemName: "thermometer.transmission").foregroundColor(weatherResponse.data.values.temperature > 20 ? .red : .blue)
                                Text(weatherResponse.data.values.temperature, format : .number.precision(.fractionLength(2)))
                            }
                            Spacer()
                            HStack{
                                Image(systemName: "sun.max.fill").foregroundColor(.blue)
                                Text(weatherResponse.data.values.uvIndex, format : .number.precision(.fractionLength(2)))
                            }
                        }.padding(.bottom)
                    }.padding()
                }
                
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding().navigationBarItems(trailing: btnDelete).onAppear{
            fetchData()
        }
    }
    
    
    
    func fetchData() {
//             Remplacez l'URL par l'URL de votre API 7da60ddd82890b9ff3d8fec758b2ba32
        let urlString: String = "https://api.tomorrow.io/v4/weather/realtime?location=\(pisteDetails.position)&apikey=TP6t12SNStqHXMZ7Uc2aiv4INWhqFVFI"
        let apiUrl = URL(string: urlString)!
        
            // Créez une session URLSession
            let session = URLSession.shared

            // Créez une tâche de données pour effectuer la requête
            let task = session.dataTask(with: apiUrl) { (data, response, error) in
                // Vérifiez s'il y a une erreur
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    
//                    print("Error Code: \(error)")
                    
                } else if let data = data {
                    weatherResponse = try! JSONDecoder().decode(WeatherResponse.self, from: data)
//                    print("weatherResponse")weatherResponse.data.values.humidity
                }
            }
            // Démarrez la tâche
            task.resume()
        }

}

struct PisteDetails_Previews: PreviewProvider {
    static var previews: some View {
        PisteDetails( pisteDetails: PisteStructure(name: "test", dateCreation: Date(), url: URL(string: "https://images.unsplash.com/photo-1565992441121-4367c2967103?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2tpfGVufDB8fDB8fHww") ?? URL(filePath: ""), state: 2, position: "45.811786363173866,6.723216738742208"), pisteCollection: PisteCollection(pistes: []))
    }
}

struct WeatherResponse: Codable {
    struct WeatherData: Codable {
        struct Values: Codable {
            var humidity: Double = 0
            var temperature: Double = 0
            var windSpeed: Double = 0
            var visibility: Double = 0
            var snowIntensity: Double = 0
            var rainIntensity: Double = 0
            var uvIndex: Double = 0
            var precipitationProbability: Double = 0
            var cloudCover: Double = 0
        }
        var values: Values = Values()
    }
    var data: WeatherData = WeatherData()
}
