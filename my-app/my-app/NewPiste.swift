//
//  NewPiste.swift
//  my-app
//
//  Created by LUCAS Arthur on 20/11/2023.
//

import SwiftUI
import MapKit

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct NewPiste: View {
    
    struct IdentifiableCoordinate: Identifiable {
            var id: UUID 
            var coordinate: CLLocationCoordinate2D
    }
    struct SaveDetails: Identifiable {
        let name: String
        let error: String
        let id = UUID()
    }

    @Binding var bAddNewPiste: Bool

    @State var selectedLocation: IdentifiableCoordinate?
    
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 45.811786363173866,longitude: 6.723216738742208),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    @State private var annotations: [MKPointAnnotation] = []
    
    @State private var didError = false
    @State private var details: SaveDetails?
    
    @State var pisteName = ""
    @State var pisteDate = Date()
    @State var imageUrl = ""
    @State var pisteState = 1
    @State var position = ""
    
    @ObservedObject var pisteCollection : PisteCollection
    
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                TextField("Nom de la piste", text: $pisteName).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Image Url", text: $imageUrl).textFieldStyle(RoundedBorderTextFieldStyle())
                HStack{
                    Text("Etat de la piste")
                    Spacer()
                    Picker(selection: $pisteState, label: Text("Etat") ) {
                        Text("Ouverte").tag(1)
                        Text("En aménagement").tag(2)
                        Text("Fermée").tag(3)
                    }
                }
                DatePicker(selection: $pisteDate, displayedComponents: [.date], label: { Text("Jour") })
                        
                HStack(alignment: .firstTextBaseline){
                    if(position != ""){
                        Text("Coordonnées : \(position)").font(.system(size: 12))
                    } else {
                        Text("Sélectionnez une position : \(position)").font(.system(size: 16))
                    }
                    Spacer()
                }.padding(.top)
                
                                
                Map(coordinateRegion: $region, annotationItems: [selectedLocation].compactMap { $0 }) { location in
                    MapMarker(coordinate: location.coordinate, tint: .blue)
                        }
                        .onTapGesture(coordinateSpace: .local, perform: handleTap)
                        .edgesIgnoringSafeArea(.all).padding(.bottom)
                
                Button("Ajouter") {
                    if(!pisteName.isEmpty  && !imageUrl.isEmpty && pisteState != 0 && !position.isEmpty){
                        pisteCollection.add(name: pisteName, imageString: imageUrl, date: pisteDate, state: pisteState, position: position)
                        bAddNewPiste = false
                    } else {
                        didError = true
                        details = SaveDetails(name: "Champs vide", error: "Veuillez remplir tout les champs")
                    }
                }.buttonStyle(GrowingButton()).alert(
                    "Ajout impossible",
                    isPresented: $didError,
                    presenting: details
                ) { details in
                } message: { details in
                    Text(details.error)
                }
                Spacer()
            }
        }.padding()
    }
    
        func handleTap(location: CGPoint) {
            let coordinate = region.center
            selectedLocation = IdentifiableCoordinate(id: UUID(), coordinate: coordinate)
            position = "\(coordinate.latitude),\(coordinate.longitude)"
        }
    
    
}

struct NewPiste_Previews: PreviewProvider {
    
    
    static var previews: some View {
        NewPiste(bAddNewPiste: .constant(true), pisteCollection: PisteCollection(pistes: []))
    }
}
