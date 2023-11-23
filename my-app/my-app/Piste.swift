//
//  Piste.swift
//  my-app
//
//  Created by LUCAS Arthur on 20/11/2023.
//

import Foundation

class PisteStructure: Identifiable, ObservableObject {
    
    let id: UUID = UUID()
    @Published var name: String
    @Published var dateCreation: Date
    @Published var url: URL
    @Published var state: Int
    @Published var position: String
    
    init(name: String, dateCreation: Date, url: URL, state: Int, position: String) {
        self.name = name
        self.dateCreation = dateCreation
        self.url = url
        self.state = state
        self.position = position
    }
}

class PisteCollection: ObservableObject {
    
    
//    @Published
    @Published var pistes: [PisteStructure]
    
    init(pistes: [PisteStructure]) {
        self.pistes = pistes
    }
    
    func add(name: String, imageString: String, date: Date, state: Int, position: String){
        print(imageString)
        let url: URL = URL(string: imageString)!
        
        let newPiste = PisteStructure(name: name, dateCreation: date, url: url, state: state, position: position)
        pistes.append(newPiste)
        
        
    }
    
     func remove(id: UUID){
        
        pistes.removeAll { PisteStructure in
            PisteStructure.id == id
        }
         
    }
}
