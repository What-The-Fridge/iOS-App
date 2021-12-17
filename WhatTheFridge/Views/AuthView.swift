//
//  AuthView.swift
//  WhatTheFridge
//
//  Created by Hachi on 2021-12-14.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct AuthView: View {
    @State var isLoginMode = false
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @State var statusMessage = ""
    @State var imagePickerShowed = false
    @State var image: UIImage?
    @State var imageSize = 64
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: isLoginMode) { _ in
                        firstName = ""
                        lastName = ""
                        email = ""
                        password = ""
                        statusMessage = ""
                    }
                    
                    if !isLoginMode {
                        Button {
                            imagePickerShowed.toggle()
                        } label: {
                            
                            VStack{
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: CGFloat(imageSize)*2, height: CGFloat(imageSize)*2)
                                        .scaledToFill()
                                        .cornerRadius(CGFloat(imageSize))
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: CGFloat(imageSize)))
                                        .padding()
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: CGFloat(imageSize))
                                        .stroke(Color.black, lineWidth: 3))
                        }
                    }
                    
                    if(isLoginMode){
                        Group {
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            SecureField("Password", text: $password)
                        }
                        .padding(12)
                        .background(Color.white)
                    } else {
                        Group {
                            TextField("Firstname", text: $firstName)
                                .autocapitalization(.words)
                            TextField("Lastname", text: $lastName)
                                .autocapitalization(.words)
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            SecureField("Password", text: $password)
                        }
                        .padding(12)
                        .background(Color.white)
                    }
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Login" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                        
                    }
                    Text(statusMessage)
                }
                .padding()
                
            }
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        }
        .fullScreenCover(isPresented: $imagePickerShowed, onDismiss: nil) {
            ImagePicker(image: $image)
        }
    }
    
    private func handleAction() {
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                let errorMessage = err.localizedDescription.components(separatedBy: "\"")[0]
                self.statusMessage = "Failed to login user: \(errorMessage)"
                return
            }
            
            self.statusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
        }
    }
    
    private func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                let errorMessage = err.localizedDescription.components(separatedBy: "\"")[0]
                self.statusMessage = "Failed to create user: \(errorMessage)"
                return
            }
            
            self.storeUserData()
            
            self.statusMessage = "Successfully created user: \(result?.user.uid ?? "")"
        }
    }
    
    private func storeUserData() {
        guard let userUid = Auth.auth().currentUser?.uid
        else{return}

        let ref = Storage.storage().reference(withPath: userUid)
        guard let image = self.image?.jpegData(compressionQuality: 0.5) else {return}

        ref.putData(image, metadata: nil) {
            metadata, err in
            if let err = err {
                self.statusMessage = "Failed to put image to firebase storage \(err)"
            } else {
                ref.downloadURL { url, err in
                    if let err = err {
                        self.statusMessage = "Failed to get image url from firebase \(err)"
                    } else {
                        self.statusMessage = "successfully store the image with url \(url?.absoluteString ?? "")"
                        
                        let currentUser : User! = Auth.auth().currentUser
                        currentUser?.getIDTokenForcingRefresh(true) { idToken, err in
                            if let err = err {
                                self.statusMessage = "Failed to authenticate with firebase: \(err)"
                                return;
                            }
                            //authenticate with fb & create a new user in pg
                            CustomInterceptor.token = idToken!
                            createNewUserPostgres(uid: userUid, firstName: firstName, lastName: lastName, email: email, imgUrl: url?.absoluteString ?? "")
                        }
                    }
                }
            }
        }
    }
    
    private func createNewUserPostgres(uid: String, firstName: String, lastName: String, email: String, imgUrl: String?) {
        let input = UserInput(firebaseUserUid: uid, firstName: firstName, lastName: lastName, email: email, imgUrl: imgUrl)
        Network.shared.apollo.perform(mutation: CreateUserMutation(input: input)) { result in
            switch result{
            case .success(let graphQLResult):
                if let result = graphQLResult.data?.createUser.user?.firebaseUserUid {
                    print(result)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
