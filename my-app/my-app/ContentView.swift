//
//  ContentView.swift
//  my-app
//
//  Created by LUCAS Arthur on 20/11/2023.
//

import SwiftUI
import Foundation


struct ContentView: View {
    
    @State var bAddNewPiste = false
    

    @StateObject var pisteCollection: PisteCollection
    
    
    var body: some View {
        
        
        
        
        ZStack (alignment: .bottomTrailing){
            VStack{
                NavigationView {
                    VStack{
                        HStack(alignment: .center){
                            Text("Liste des pistes")
                            Spacer()
                            Button {
                                bAddNewPiste = true
                            } label: {
                                Text("Ajouter")
                            }
                        }.padding()
                        if(pisteCollection.pistes.count > 0){
                            List(pisteCollection.pistes) {piste in
                                
                                NavigationLink(destination: PisteDetails(pisteDetails: piste, pisteCollection: pisteCollection), label: {
                                    PisteDetailCell(piste: piste)
                                })
                            }
                        } else {
                            List{
                                Text("Aucune Piste")
                            }
                            
                        }
                        
                    }
                }
            
                
            }
            

            

        }.frame(maxHeight: .infinity, alignment: .top)
            .sheet(isPresented: $bAddNewPiste, onDismiss: {bAddNewPiste = false}) {
                NewPiste(bAddNewPiste: $bAddNewPiste, pisteCollection: pisteCollection)
          }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(pisteCollection: PisteCollection(pistes: [
            PisteStructure(name: "Piste des moines", dateCreation: Date(), url: URL(string: "https://static8.depositphotos.com/1443681/907/i/450/depositphotos_9077647-stock-photo-pair-of-cross-skis.jpg") ?? URL(filePath: ""), state: 1, position: "45.811786363173866,6.723216738742208"),
            PisteStructure(name: "Piste des enfants disparus", dateCreation: Date(), url: URL(string: "https://images.unsplash.com/photo-1565992441121-4367c2967103?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2tpfGVufDB8fDB8fHww") ?? URL(filePath: ""), state: 2, position: "45.811786363173866,6.723216738742208")
        ]) )
    }
}



