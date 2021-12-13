//
//  ContentView.swift
//  Instafilter
//
//  Created by Dmitry Sharabin on 12.12.2021.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
//        image = Image("Example")
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
//        let currentFilter = CIFilter.sepiaTone()
//        let currentFilter = CIFilter.pixellate()
//        let currentFilter = CIFilter.crystallize()
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage
        
        let amount = 1.0
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        
//        currentFilter.intensity = 1 // sepiaTone()
//        currentFilter.scale = 100 // pixellate()
//        currentFilter.radius = 200 // crystallize()
//        currentFilter.radius = 1000 // twirlDistortion()
//        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2) // twirlDistortion()
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
