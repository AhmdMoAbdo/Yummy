//
//  IconAnimation.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import SwiftUI
import Lottie

struct IconAnimation: UIViewRepresentable {
    
    var lottieFile: String
    var animationView = LottieAnimationView()
    var animationLoop:LottieLoopMode = .playOnce
 
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        let tempAnimation = LottieAnimationView(name: lottieFile)
        animationView.animation = tempAnimation.animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = animationLoop
        animationView.play()
        animationView.backgroundColor = .clear
 
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: Context) {
 
    }
}

struct IconAnimation_Previews: PreviewProvider {
    static var previews: some View {
        IconAnimation(lottieFile: "home")
    }
}
