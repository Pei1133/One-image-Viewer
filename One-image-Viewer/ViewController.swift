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
    var fullSize = UIScreen.main.bounds.size
    
    @IBAction func tapButton(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
//        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
//        present(picker, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        imageView = UIImageView(image: UIImage(named: "icon_photo"))
        imageView.bounds = CGRect(x:0, y:0 ,width: fullSize.width, height: fullSize.height - 50 )
        scrollView = UIScrollView(frame: imageView.bounds)
        scrollView.contentSize = imageView.bounds.size
        scrollView.backgroundColor = UIColor.black
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.contentOffset = CGPoint(x: 100, y: 250)
        scrollView.delegate = self
//        scrollView.minimumZoomScale = 0.1
//        scrollView.maximumZoomScale = 2.0
//        scrollView.zoomScale = 1.0
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
//    func setZoomScale() {
//        let imageViewSize = imageView.bounds.size
//        let scrollViewSize = scrollView.bounds.size
//        let widthScale = scrollViewSize.width / imageViewSize.width
//        let heightScale = scrollViewSize.height / imageViewSize.height
//        
//        scrollView.minimumZoomScale = min(widthScale, heightScale)
//        scrollView.zoomScale = 1.0
//    }
//    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateMinZoomScaleForSize(view.bounds.size)
//        setZoomScale()
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size

        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0

        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    MARK: - UIImagePickerControllerDelegate
    private func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage
        }
        dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


