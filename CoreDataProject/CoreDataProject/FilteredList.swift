//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Ginger on 22/09/2020.
//

import SwiftUI

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    
    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
    
    var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
    
    var body: some View {
        List(singers, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}

/*struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList()
    }
}
*/
