//
//  ChatFirebaseViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/4/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChatFirebaseViewController: BaseViewController {
    
    @IBOutlet weak var tablViewChat: UITableView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var txtInput: UITextField!
    
    
    var ref: DatabaseReference!
    var item: [ChatResponse] = []
    var counts : Int = 0
    var acountId : String = String(describing: UserService.userInfo?.id as! Int)
    var db = Database.database().reference().child("accounts")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablViewChat.delegate = self
        tablViewChat.dataSource = self
        ref = Database.database().reference().child("messages").child((UserService.userInfo?.phone)!)
        
        readChat()
    }
    
    override func localization() {
        labTitle.text = "Livechat với nhân viên chăm sóc khách hàng."
    }
    
    private func readChat(){
        
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.item.removeAll()
                
                //iterating through all the values
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let artistObject = artists.value as? [String: AnyObject]
                    let notviewed  = artistObject?["notviewed"]
                    let text  = artistObject?["text"]
                    let timestamp = artistObject?["timestamp"]
                    let fullName = artistObject?["fullname"]
                    let type = artistObject?["type"]
                    //creating artist object with model and fetched values
                    let artist = ChatResponse(fullname: fullName as! String, type: type as! String, timestamp: timestamp as! Double, text: text as! String, notviewed: notviewed as! Bool)
                    
                    //appending it to list
                    self.item.append(artist)
                }
                //reloading the tableview
                self.tablViewChat.reloadData()
                self.getCountNotification()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushChat(_ sender: Any) {
        let timestamp = NSDate().timeIntervalSince1970
        
        let data = [
            "fullname": UserService.userInfo?.fullname ?? "",
            "notviewed": false,
            "text": txtInput.text ?? "",
            "timestamp": Int(timestamp),
            "type": UserService.userInfo?.phone ?? ""
            ] as [String : Any]
        ref.childByAutoId().setValue(data)

        self.counts += 1
        let childUpdates = ["count_notification": counts,
                            "last_send_time": -Int(timestamp)] as [String: Any]
        self.db.child(acountId).updateChildValues(childUpdates)
        txtInput.text = ""
    }
    
    func getCountNotification() {
        
        db.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                //iterating through all the values
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let artistObject = artists.value as? [String: AnyObject]
                    let countNotification  = artistObject?["count_notification"]
                    let respone = CountChatResponse(count: countNotification as? Int)
                    self.counts = respone.count_notification ?? 0
                    
                    
                }
            }
        })
        
    }
    
    @IBAction func onClickProfile(_ sender: Any) {
        if let vc = UIStoryboard.initViewController(storyboard: "Profile", viewController: "ProfileViewController") {
            self.present(vc, animated: true, completion: nil)
        }
    }
}

class CountChatResponse{
    var count_notification: Int?
    var last_send_time: Double?
    init(count: Int?) {
        self.count_notification = count
    }
}

extension ChatFirebaseViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablViewChat.dequeueReusableCell(withIdentifier: "Cell")
        if item[indexPath.row].type != UserService.userInfo?.phone {
            cell?.textLabel?.text = item[indexPath.row].text
            cell?.textLabel?.textAlignment = .left
        }else{
            cell?.textLabel?.text = item[indexPath.row].text
            cell?.textLabel?.textAlignment = .right
        }
        return cell!
    }
    
    
}
