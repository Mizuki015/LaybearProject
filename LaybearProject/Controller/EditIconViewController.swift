//
//  EditIconViewController.swift
//  LaybearProject
//
//  Created by 城間海月 on 2020/01/16.
//  Copyright © 2020 Mizuki. All rights reserved.
//

import UIKit


class EditIconViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func runAlbum(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // アルバムの使用が許可されている場合
            
            // アルバムの画面を作成
            let albumView = UIImagePickerController()
            albumView.sourceType = .photoLibrary
            albumView.delegate = self
            
            // アルバムの画面を表示
            present(albumView, animated: true, completion: nil)
//            self.view.addSubview(albumView)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
                //写真が存在する場合、変数pickedImageにその写真が渡される
                // その写真を画面に表示する
                imageView.image = pickedImage
            }
        
            // picker：カメラorアルバム画面
            // dismiss：画面を閉じる
            picker.dismiss(animated: true, completion: nil)
    }
    
}
