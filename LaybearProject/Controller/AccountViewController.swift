//
//  AccountViewController.swift
//  LaybearProject
//
//  Created by 城間海月 on 2020/01/07.
//  Copyright © 2020 Mizuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doAnonymousLogin(_ sender: UIButton) {
        //匿名ユーザーとしてログイン
        Auth.auth().signInAnonymously { (result, error) in
            if (result?.user) != nil{
                //次の画面へ遷移
                self.performSegue(withIdentifier: "nextViewController", sender: nil)
            }
        }
        
    }
    
}
