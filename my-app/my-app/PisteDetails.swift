//
//  PisteDetails.swift
//  my-app
//
//  Created by LUCAS Arthur on 21/11/2023.
//

import SwiftUI

struct PisteDetails: View {
    
    @ObservedObject var pisteDetails: PisteStructure
    
    @ObservedObject var pisteCollection: PisteCollection
    
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
            VStack(){
                AsyncImage(url: pisteDetails.url){ image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }.cornerRadius(15).frame(maxHeight: 300)
                Text(pisteDetails.dateCreation.formatted(.iso8601.day().month().year())).foregroundColor(.gray).font(.system(size: 16)).padding(.bottom)
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
                    Spacer()
                    Picker(selection: $pisteDetails.state, label: Text("Etat") ) {
                        Text("Ouverte").tag(1)
                        Text("En aménagement").tag(2)
                        Text("Fermée").tag(3)
                    }
                }
                
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding().navigationBarItems(trailing: btnDelete)
    }
}

struct PisteDetails_Previews: PreviewProvider {
    static var previews: some View {
        PisteDetails(pisteDetails: PisteStructure(name: "test", dateCreation: Date(), url: URL(string: "https://static8.depositphotos.com/1443681/907/i/450/depositphotos_9077647-stock-photo-pair-of-cross-skis.jpg") ?? URL(filePath: ""), state: 2), pisteCollection: PisteCollection(pistes: []))
    }
}
