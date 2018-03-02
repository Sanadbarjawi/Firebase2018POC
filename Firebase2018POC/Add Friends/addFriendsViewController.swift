//
//  addFriendsViewController.swift
//  Firebase2018POC
//
//  Created by Sanad  on 2/27/18.
//  Copyright © 2018 Sanad . All rights reserved.
//

import UIKit
import Firebase
class addFriendsViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var db = Firestore.firestore()
    var email = ""
    var location = ""
    var UsersNamesArray = [user]()
    @IBOutlet weak var addFriendsLbl: UILabel!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var friendsTableHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        location = "Amman"//Change this later to be dynamic
        db.collection("users").whereField("location", isEqualTo: location).getDocuments{(snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else{
                for document in snapshot!.documents {
                    self.activityIndicator.startAnimating()
                    if let displayName = document.data()["displayName"] as? String {
                                self.UsersNamesArray.append(user(displayName: displayName))
                        }
                    }
                self.UsersNamesArray.remove(at: 0)
                self.friendsTableView.reloadData()
                self.activityIndicator.stopAnimating()
                }
            }
        let nib = UINib(nibName: "FriendCell", bundle: nil)
        friendsTableView.register(nib, forCellReuseIdentifier: "FriendCell")
        addFriendsLbl.text = "Suggested Friends"
        email=UserDefaults.standard.string(forKey: "userEmail")!
        db.collection("users").whereField("email", isEqualTo: email).getDocuments{(snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    if let Displayname = document.data()["displayName"] as? String {
                        self.displayName.text = Displayname
                    }
                }
            }
        }
    }
    @IBAction func logOutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let vc = Authentication(nibName: "Authentication", bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        } catch  {
            print("Invalid Selection.")
        }
    }
    
}

extension addFriendsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //for removing extra seperators while row is empty
        return UsersNamesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FriendCell = self.friendsTableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        cell.selectionStyle = .none
       cell.displayNameLbl.text = UsersNamesArray[indexPath.row].displayName

        friendsTableView.tableFooterView = UIView()
        friendsTableHeightConstraint.constant = friendsTableView.contentSize.height
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
struct user {
    var displayName:String?
}
