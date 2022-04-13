//
//  ViewController.swift
//  RealmSwiftSample
//
//  Created by Ryan on 2022/04/13.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Open the local-only default realm
        print("Realm 파일 생성 및 열기 ==============>")
        let localRealm = try! Realm()
        
        // File location
        print("- Realm 파일 생성 위치: ", localRealm.configuration.fileURL!)
        
        // Retrieve
        let tasks = localRealm.objects(LocalOnlyQsTask.self)
        print("저장된 데이터 가져오기==============>")
        print(tasks)
        
        // Retain notificationToken as long as you want to observe
        let notificationToken = tasks.observe { (changes) in
            switch changes {
            case .initial: break
                // Results are now populated and can be accessed without blocking the UI
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed.
                print("Deleted indices: ", deletions)
                print("Inserted indices: ", insertions)
                print("Modified modifications: ", modifications)
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
        
        // All Delete
        try! localRealm.write {
            localRealm.deleteAll()
        }
        
        // Add
        let task = LocalOnlyQsTask(name: "Do launrdy")
        try! localRealm.write {
            localRealm.add(task)
        }

        // Querying
        print("쿼리 조건으로 데이터 가져오기==============>")
        let tasksThatBeginWithA = tasks.where {
            $0.name.starts(with: "Do launrdy")
        }
        print("A list of all tasks that begin with A: \(tasksThatBeginWithA)")
            
        // Update
        let taskToUpdate = tasks[0]
        try! localRealm.write {
            taskToUpdate.status = "InProgress"
        }
        var datas = localRealm.objects(LocalOnlyQsTask.self)
        print("저장된 데이터 가져오기==============>")
        print(datas)
        
        // Delete
        let taskToDelete = datas[0]
        try! localRealm.write {
            localRealm.delete(taskToDelete)
        }
        datas = localRealm.objects(LocalOnlyQsTask.self)
        print("저장된 데이터 가져오기==============>")
        print(datas)
        
        // Invalidate notification tokens when done observing
        notificationToken.invalidate()
        
    }


}

extension ViewController {
    
    
}
