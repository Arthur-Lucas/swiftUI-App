//
//  NewPiste.swift
//  my-app
//
//  Created by LUCAS Arthur on 20/11/2023.
//

import SwiftUI

struct NewPiste: View {
    
    @State var pisteName = ""
    @State var pisteDate = Date()
    @State var imageUrl = ""
    @State var pisteState = 1
    
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
                                Button("Ajouter") {
                                    pisteCollection.add(name: pisteName, imageString: imageUrl, date: pisteDate, state: pisteState)
                                }
                Spacer()
            }
        }.padding()
    }
}

struct NewPiste_Previews: PreviewProvider {
    
    
    static var previews: some View {
        NewPiste(pisteCollection: PisteCollection(pistes: []))
    }
}
