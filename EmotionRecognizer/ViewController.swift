//
//  ViewController.swift
//  EmotionRecognizer
//
//  Created by Dmytro Hrek on 11/30/16.
//  Copyright © 2016 Dmytro Hrek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let subscriptionKey = "40778dfbd2884ee4870526cf17cc15bd"
    
    
    let Emotions = [
        "Anger": "http://www.lindaclarke.co.za/wp-content/uploads/2012/11/Image-of-Anger.jpg",
        "Surprise": "http://psychology.iresearchnet.com/wp-content/uploads/2016/01/Surprise.jpg",
        "Happiness" : "https://s-media-cache-ak0.pinimg.com/736x/08/15/db/0815db06df850e27e74411a3232ffa3e.jpg",
        "Disgust": "https://ocdinformation.files.wordpress.com/2010/09/disgust.jpg"    ]
    
    
    func EmotionUrlNamed(imageN: String?) -> NSURL?{
        if let urlstring =  Emotions[imageN ?? ""]{
            return NSURL(string: urlstring)
        }else{
            return nil
        }
    }
    
    var imageUrl: NSURL? {
        didSet{
            image = nil
            fetchImage()
        }
    }
    
    private var image: UIImage? {
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            spinner?.stopAnimating()
        }
    }
    
    private func fetchImage() {
        if let url = imageUrl {
            spinner?.startAnimating()

            DispatchQueue.global().async {
                let contentsOf = NSData(contentsOf: url as URL)
                
                DispatchQueue.main.async {
                    if url == self.imageUrl{
                        if let imageData = contentsOf{
                            self.image = UIImage(data: imageData as Data)
                        } else{
                            self.spinner?.stopAnimating()
                        }
                    }else{
                        print("ignored data returned from url \(url)")
                    }
                }
            }
        }
    }
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    @IBAction func findEmotion(_ sender: UIButton) {

        imageUrl = EmotionUrlNamed(imageN: sender.currentTitle)
    }
    
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
    }
    
}

