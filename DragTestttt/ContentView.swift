//
//  ContentView.swift
//  DragTestttt
//
//  Created by Sraavan Chevireddy on 8/30/22.
//

import SwiftUI

struct ContentView: View {
    @State var isDragging = false
    @GestureState var magnifyBy = 1.0
    @State var angle = Angle(degrees: 0.0)
    @State var viewState = CGSize.zero
    
    @State var initialSize = CGSize(width: 100, height: 50)
    
    var body: some View {
        Text("Hello, world!")
            .frame(width: initialSize.width, height: initialSize.height, alignment: .center)
            .padding(25)
            .background(Color.red)
            .cornerRadius(4)
            .rotationEffect(self.angle)
            .offset(x: viewState.width, y: viewState.height)
            .scaleEffect(magnifyBy)
            .gesture(gesture)
            .simultaneousGesture(rotation)
            .simultaneousGesture(magnification)
    }
    
    var gesture : some Gesture{
        DragGesture(minimumDistance: 3, coordinateSpace: .local)
                    .onChanged { value in
                        self.isDragging = true
                        viewState = value.translation
                        print(" == \(viewState.width)")
                    }
                    .onEnded { _ in
                        print("Ended")
                        print(viewState.width)
                    }
    }

        var magnification: some Gesture {
            MagnificationGesture()
                .updating($magnifyBy) { currentState, gestureState, transaction in
                    gestureState = currentState
//                    print(currentState)
                }.onEnded { value in
                    print(value)
                    initialSize = CGSize(width: initialSize.width*value, height: initialSize.height*value)
                }
        }
    
    var rotation: some Gesture {
           RotationGesture()
               .onChanged { angle in
                   self.angle = angle
               }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
