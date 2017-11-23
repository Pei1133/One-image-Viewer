//
//  ViewController.swift
//  One-image-Viewer
//
//  Created by 黃珮鈞 on 2017/11/23.
//  Copyright © 2017年 黃珮鈞. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    let picker = UIImagePickerController()
    
    @IBAction func tapButton(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "icon_photo"))
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = imageView.bounds.size
        scrollView.backgroundColor = UIColor.black
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        scrollView.contentOffset = CGPoint(x: 100, y: 200)
        scrollView.delegate = self
//        scrollView.maximumZoomScale = 4.0
//        scrollView.zoomScale = 1.0
        
        
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        
        let minScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minScale
        
        scrollView.zoomScale = minScale
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Delegates
    private func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageView.contentMode = .scaleAspectFit //3
        imageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
}


