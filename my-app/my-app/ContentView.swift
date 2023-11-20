//
//  ContentView.swift
//  my-app
//
//  Created by LUCAS Arthur on 20/11/2023.
//

import SwiftUI



struct ContentView: View {
    
    @State var bAddNewPiste = false
    

    @State var pistes: PisteCollection
    
    
    var body: some View {
        ZStack (alignment: .bottomTrailing){
            VStack{
            
                    Text("Liste des pistes")
                    List {
                        
                    }
                        
                    

                    
                
                
                Button {
                    bAddNewPiste = true
                } label: {
                    Image(systemName: "plus.circle.fill").resizable()
                        .frame(width: 40, height: 40)
                }.padding()
            }
            

            

        }.frame(maxHeight: .infinity, alignment: .top)
            .sheet(isPresented: $bAddNewPiste, onDismiss: {bAddNewPiste = false}) {
                NewPiste(pistes: $pistes)
          }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(pistes: PisteCollection(pistes: []) )
    }
}



