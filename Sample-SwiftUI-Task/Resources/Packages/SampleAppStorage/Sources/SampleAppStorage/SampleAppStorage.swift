//
//  SampleAppStorage.swift
//
//
//  Created by Patryk Grabowski on 14/10/2022.
//

import CoreData

class SampleAppStorage: CoreDataStoring {

    private let container: NSPersistentContainer

    static var `default`: CoreDataStoring = {
        return SampleAppStorage(name: "SampleAppStorage", in: .persistent)
    }()

    var viewContext: NSManagedObjectContext {
        return self.container.viewContext
    }

    init(name: String, in storageType: StorageType) {
        self.container = NSPersistentContainer(name: name)
        self.setupIfMemoryStorage(storageType)
        self.container.loadPersistentStores { _, _ in }
    }

    private func setupIfMemoryStorage(_ storageType: StorageType) {
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.container.persistentStoreDescriptions = [description]
        }
    }
}
