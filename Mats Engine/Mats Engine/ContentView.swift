//
//  ContentView.swift
//  Mats Engine
//
//  Created by Mathias Dietrich on 31.12.23.
//

import SwiftUI
import cengine
import Metal
import MetalKit
import SwiftUI
import vger
import vgerSwift

// https://developer.apple.com/forums/thread/119112
// https://developer.apple.com/documentation/coreimage/generating_an_animation_with_a_core_image_render_destination
struct MyView: UIViewRepresentable {
    
   var adapter :RendererAdapter = RendererAdapter()
    typealias UIViewType = MTKView
   let mtkView = MTKView()

    
    func draw(){
        adapter.draw(mtkView.currentDrawable, device: mtkView.device)
    }

    func makeUIView(context: Context) -> MTKView {
      //  mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.backgroundColor = context.environment.colorScheme == .dark ? UIColor.white : UIColor.white
        mtkView.isOpaque = true
        mtkView.enableSetNeedsDisplay = true
        return mtkView
    }

    func updateUIView(_ uiView: MTKView, context: Context) {
    }
}

struct ContentView: View {
    @State var debug = "starting"
    @State var myView =  MyView()

    
   // let cyan = SIMD4<Float>(0,1,1,1)
    
    
    let cyan = SIMD4<Float>(229/255,103/255,23/255,1)
    
    let magenta = SIMD4<Float>(1,0,1,1)
    
    func textAt(_ vger: vgerContext, _ x: Float, _ y: Float, _ string: String) {
           vgerSave(vger)
           vgerTranslate(vger, .init(x: x, y: y))
           vgerText(vger, string, cyan, 0)
           vgerRestore(vger)
       }

       func draw(vger: vgerContext) {
           vgerSave(vger)

           let bezPaint = vgerLinearGradient(vger, .init(x: 50, y: 450), .init(x: 100, y: 450), cyan, magenta, 0.0)
           vgerStrokeBezier(vger, vgerBezierSegment(a: .init(x: 50, y: 450), b: .init(x: 100, y: 450), c: .init(x: 100, y: 500)), 1.0, bezPaint)
           vgerScale(vger, SIMD2<Float>(1.2, 1.2))
           textAt(vger, 50, 350, "Quadratic Bezier stroke")

           let rectPaint = vgerLinearGradient(vger, .init(x: 50, y: 350), .init(x: 100, y: 400), cyan, magenta, 0.0)
           vgerFillRect(vger, .init(x: 50, y: 350), .init(x: 100, y: 400), 10.0, rectPaint)
           textAt(vger, 150, 350, "Rounded rectangle")

           let circlePaint = vgerLinearGradient(vger, .init(x: 50, y: 250), .init(x: 100, y: 300), cyan, magenta, 0.0)
           vgerFillCircle(vger, .init(x: 75, y: 275), 25, circlePaint)
           textAt(vger, 150, 250, "Circle")

           let linePaint = vgerLinearGradient(vger, .init(x: 50, y: 150), .init(x: 100, y: 200), cyan, magenta, 0.0)
           vgerStrokeSegment(vger, .init(x: 50, y: 150), .init(x: 100, y: 200), 2.0, linePaint)
           textAt(vger, 150, 150, "Line segment")

           let theta: Float = 0.0 // orientation
           let aperture: Float = 0.5 * .pi

           let arcPaint = vgerLinearGradient(vger, .init(x: 50, y: 50), .init(x: 100, y: 100), cyan, magenta, 0.0)
           vgerStrokeArc(vger, .init(x: 75, y: 75), 25, 1.0, theta, aperture, arcPaint)
           textAt(vger, 150, 050, "Arc")


           vgerRestore(vger);
       }
    
    var body: some View {
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        ScrollView{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("\(debug)")
                VgerView(renderCallback: draw).frame(width:width, height:height)
                
                //myView.frame(width: 300, height:300).border(.red)
            }
            .padding()
            .onAppear(){
                debug = " engine says \(debug)"
                myView.draw()
            }
        }
    }
}

#Preview {
    ContentView()
}
