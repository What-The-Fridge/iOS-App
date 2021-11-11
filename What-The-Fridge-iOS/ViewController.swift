//
//  ViewController.swift
//  What-The-Fridge
//
//  Created by admin on 2021-11-02.
//

import UIKit

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Random Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBlue
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        getRandomPhoto()
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(didTapButton),
                         for: .touchUpInside)
    }
    
    @objc func didTapButton(){
        getRandomPhoto()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 20,
                              y: view.frame.size.height-50-view.safeAreaInsets.bottom,
                              width: view.frame.size.width-40,
                              height: 50)
        
    }
    
    func getRandomPhoto() {
        let urlString = URL(string: "https://dog.ceo/api/breeds/image/random")!
        var request = URLRequest(url: urlString)
        request.httpMethod = "GET"
        
        
        
        var data1 = Data()
        let _ = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            data1 = data
            print("Data is: \(data1)!")
        }
        imageView.image = UIImage(data: data1)
    }
}

