//
//  DatabaseManager.swift
//  Compler
//
//  Created by Lukáš Matuška on 08.11.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManager {
    
    static let shared = DatabaseManager()
    private init() { }
    
    private let db = Firestore.firestore()
    
    func getNotebooks(completion: @escaping ([Notebook]?, Error?) -> Void) {
        
        let collection = db.collection("notebooks")
        
        Task.init {
            do {
                var notebooks = [Notebook]()
                let snapshot = try await collection.getDocuments()
                for doc in snapshot.documents {
                    notebooks.append(try doc.data(as: Notebook.self))
                }
                completion(notebooks, nil)
            }
            catch {
                completion(nil, error)
            }
        }
        
    }
    
    func getNotebookModels(completion: @escaping (Set<String>?, Error?) -> Void) {
        
        let collection = db.collection("notebooks")
        
        Task.init {
            do {
                var notebookModels = Set<String>()
                let snapshot = try await collection.getDocuments()
                for doc in snapshot.documents {
                    notebookModels.update(with: try doc.data(as: Notebook.self).model)
                }
                completion(notebookModels, nil)
            }
            catch {
                completion(nil, error)
            }
        }
        
    }
    
    func getConfigurationsFor(model: String, completion: @escaping ([Notebook]?, Error?) -> Void) {
        
        let collection = db.collection("notebooks")
        
        // TODO: Use query
        Task.init {
            do {
                var notebooks = [Notebook]()
                let snapshot = try await collection.getDocuments()
                for doc in snapshot.documents {
                    let notebook = try doc.data(as: Notebook.self)
                    if notebook.model == model {
                        notebooks.append(notebook)
                    }
                }
                completion(notebooks, nil)
            }
            catch {
                completion(nil, error)
            }
        }
    }
}
