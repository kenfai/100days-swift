//
//  FilteredGenericList.swift
//  CoreDataProject
//
//  Created by Ginger on 22/09/2020.
//

import CoreData
import SwiftUI

struct FilteredGenericList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }
    
    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    init(sortDescriptors: [NSSortDescriptor], predicate: Predicates, filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        
        var predicates = ""
        
        switch predicate {
        case .equal:
            predicates = "=="
        case .inside:
            predicates = "in"
        case .beginsWith:
            predicates = "BEGINSWITH"
        }
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicates) %@", filterKey, filterValue))
            self.content = content
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
}

/*struct FilteredGenericList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredGenericList()
    }
}*/
