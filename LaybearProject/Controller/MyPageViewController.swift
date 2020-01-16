//
//  MyPageViewController.swift
//  LaybearProject
//
//  Created by 城間海月 on 2019/12/20.
//  Copyright © 2019 Mizuki. All rights reserved.
//

import UIKit
import Firebase

class MyPageViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var iconImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 大きさ場所を設定
        self.iconImageView2.frame = CGRect(x: 9, y: 103, width: 80, height: 80)
        // 画像を設定
        self.iconImageView2.image = UIImage(named: "クマの後ろ姿")
        // 角を丸くする
        self.iconImageView2.layer.cornerRadius = 80 * 0.5
        self.iconImageView2.clipsToBounds = true
        // 画像を表示
        self.view.addSubview(self.iconImageView2)
    }
    
    @IBAction func didClickPostButton(_ sender: UIButton) {
        
        // FireSotreに接続
        let db = Firestore.firestore()
        
        db.collection("posts").addDocument(data: [
            "text": textView.text!,
            "uid": Auth.auth().currentUser?.uid
        ]) {error in
            
            if let error = error {
                // エラーが発生した場合
                // (変数errorがnilでない場合、エラー情報を変数errorに入れる))
                print("エラーが発生しました")
            } else {
                // エラーが発生しなかった場合
                print("正常に作動しています")
            }
        }
        
//        // HomeViewControllerを取得
//        let HomeVC = self.presentingViewController as! HomeViewController
//        // HomeViewControllerのラベルにtextViewで入力した値を代入
//        HomeVC.label1.text = textView.text
//
//        // 画面遷移で値を渡す
//        performSegue(withIdentifier: "toHome", sender: // document.text)
        
        // HomeVCに戻る
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickGoBackToHomeButton(_ sender: UIButton) {
        
        // HomeViewControllerを取得
        let HomeVC = self.presentingViewController as! HomeViewController
        
        // HomeVCに戻る
        dismiss(animated: true, completion: nil)
    }
    
}
