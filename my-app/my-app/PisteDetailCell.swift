//
//  PisteDetailCell.swift
//  my-app
//
//  Created by LUCAS Arthur on 21/11/2023.
//

import SwiftUI

struct PisteDetailCell: View {
    
    @ObservedObject var piste: PisteStructure
    
    var body: some View {
        HStack{
            Circle().frame(width: 15).foregroundColor(
                piste.state == 1 ? Color.green : piste.state == 2 ? Color.orange : Color.red)
            VStack(alignment: .leading){
                
                Text(piste.name)
                Text(piste.dateCreation.formatted(.iso8601.year().month().day())).foregroundColor(.gray).font(.system(size: 12))
            }
        }
    }
}

struct PisteDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        PisteDetailCell(piste: PisteStructure(name: "test", dateCreation: Date(), url: URL(string: "https://static8.depositphotos.com/1443681/907/i/450/depositphotos_9077647-stock-photo-pair-of-cross-skis.jpg") ?? URL(filePath: ""), state: 2, position: "45.811786363173866,6.723216738742208"))
    }
}
