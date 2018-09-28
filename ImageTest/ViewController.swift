//
//  ViewController.swift
//  ImageTest
//
//  Created by 石倉一平 on 2018/08/03.
//  Copyright © 2018年 Swift-Biginners. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var imageView: UIImageView!
  
  let ipAddress = "35.200.123.188:123"
//    let ipAddress = "192.168.0.11:3000"
  var imageUrl:NSURL = NSURL(string: "")!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  @IBAction func tappedUpLoad(_ sender: Any) {
    let imageName = "./search.png"
      let str = "image=\(imageUrl)"
      let url = URL(string: "http://\(ipAddress)/api/v1/image/upload")
      var request = URLRequest(url: url!)
      // POSTを指定
      request.httpMethod = "POST"
      // POSTするデータをBodyとして設定
      request.httpBody = str.data(using: .utf8)
      let session = URLSession.shared
      session.dataTask(with: request) { (data, response, error) in
        if error == nil, let data = data, let response = response as? HTTPURLResponse {
          // HTTPヘッダの取得
          print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
          // HTTPステータスコード
          print("statusCode: \(response.statusCode)")
          print(String(data: data, encoding: .utf8) ?? "")
         
          }
        }.resume()

  }
  
  @IBAction func tappedImageSelect(_ sender: Any) {
    // カメラロールが利用可能か？
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      // 写真を選ぶビュー
      let pickerView = UIImagePickerController()
      // 写真の選択元をカメラロールにする
      // 「.camera」にすればカメラを起動できる
      pickerView.sourceType = .photoLibrary
      // デリゲート
      pickerView.delegate = self
      // ビューに表示
      self.present(pickerView, animated: true)
    }
  }
  // 写真を選んだ後に呼ばれる処理
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    // 選択した写真を取得する
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    imageUrl = (info[UIImagePickerControllerReferenceURL] as? NSURL)!
    print("imageUrl:",imageUrl)
    
    // ビューに表示する
    self.imageView.image = image
    // 写真を選ぶビューを引っ込める
    self.dismiss(animated: true)
  }
  
}


