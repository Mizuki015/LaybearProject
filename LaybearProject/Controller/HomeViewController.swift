//
//  HomeViewController.swift
//  LaybearProject
//
//  Created by 城間海月 on 2019/12/20.
//  Copyright © 2019 Mizuki. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 投稿部屋を全件をもつ配列
    var posts: [Post] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Firestoreに接続
        let db = Firestore.firestore()
        
        db.collection("posts").addSnapshotListener { (querySnapshot, error) in
                
                // 最新のpostsコレクションの中身を取得
                guard let documents = querySnapshot?.documents else {
                    // postsコレクションの中身がnilの場合、処理を中断
                    // 中身がある場合は、変数documentsに中身を全て入れる
                    return
                }
                
                // 結果を入れる配列
                var results: [Post] = []
                
                // ドキュメントをfor文を使ってループする
                for document in documents {
                    let text = document.get("text") as! String
                    let posts = Post(text: text, userId: document.documentID)
                    results.append(posts)
                }
                print(results)
                // 表示する変数postsを全結果の入ったresultsで上書き
                self.posts = results
        }
        
    }

    @IBAction func didClickMyPageButton(_ sender: UIButton) {
        
        // MyPageに画面遷移する
        performSegue(withIdentifier: "toMyPage", sender: nil)
        
    }
    
    @IBAction func doAnonymousLogin(_ sender: UIButton) {
        
        //匿名ユーザーとしてログイン
        Auth.auth().signInAnonymously { (result, error) in
            if (result?.user) != nil{
                //次の画面へ遷移
                self.performSegue(withIdentifier: "toMyPage", sender: nil)
            }
        }
    }

    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを名前と行番号で取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // 配列から表示する部屋情報を1件取得
        let post = posts[indexPath.row]
        
        // cell内のアイコン画像を設定
        let image = cell.viewWithTag(1) as! UIImageView
        // 画像の大きさを設定
        image.frame = CGRect(x: 9, y: 103, width: 80, height: 80)
        // 画像を設定
//        image.image = UIImage.ini
        // 角を丸くする
        image.layer.cornerRadius = 80 * 0.5
        image.clipsToBounds = true
        
        // cell内のlabelを設定
        let label = cell.viewWithTag(2) as! UILabel
        label.text = post.text
        
        // cell内の「解」ボタンを設定
        let didClickUSButton = cell.viewWithTag(3) as! IndexButton
        didClickUSButton.addTarget(self, action: #selector(tapUSButton(_:)), for: .touchUpInside)
        didClickUSButton.index = indexPath.row
        
        // cell内の「幸」ボタンを設定
        let didClickHopeButton = cell.viewWithTag(4) as! IndexButton2
        didClickHopeButton.addTarget(self, action: #selector(tapHopeButton(_:)), for: .touchUpInside)
        didClickHopeButton.index2 = indexPath.row
        
        // セルを返す
        return cell
    }
    
    // 解ボタンの設定
    @objc func tapUSButton(_ sender: IndexButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.tintColor = UIColor.systemRed
            sender.backgroundColor = .systemRed
            sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else {
            sender.backgroundColor = .white
            sender.setTitleColor(UIColor.systemBlue, for: .normal)
        }
    }
    
    // 幸ボタンにの設定
    @objc func tapHopeButton(_ sender: IndexButton2) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.tintColor = UIColor.systemYellow
            sender.backgroundColor = .systemYellow
            sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else {
            sender.backgroundColor = .white
            sender.setTitleColor(UIColor.systemBlue, for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @objc private func pushButton(_ sender:UIButton)
    {
        
    }
}
