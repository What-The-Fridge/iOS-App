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
    
    
    struct Response: Codable{
        let message: String!
        let status: String
    }
    
    func getRandomPhoto() {
        let urlString = URL(string: "https://dog.ceo/api/breeds/image/random")!
        var request = URLRequest(url: urlString)
        request.httpMethod = "GET"
        
        var jsonResponse : Response?
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            // have data
            var result: Response?
            
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("failed to convert \(error.localizedDescription)")
            }
            
            // have json
            guard let json = result else {
                return
            }
            
            jsonResponse = json
            print(jsonResponse?.message! ?? "nothing here")
            
            // this is the default image
            var url = URL(string: "https://images.dog.ceo/breeds/coonhound/n02089078_3821.jpg")
            
            // as long as the return message is not null or empty, assign the new image url to url variable
            print(!(jsonResponse?.message ?? "").isEmpty)
            if(!(jsonResponse?.message ?? "").isEmpty) {
                print("here")
                url = URL(string: (jsonResponse?.message)!)
            }

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                }
            }
        }.resume()
    }
}

