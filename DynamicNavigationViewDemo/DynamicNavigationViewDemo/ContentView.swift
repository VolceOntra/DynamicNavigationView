//
//  ContentView.swift
//  DynamicNavigationViewDemo
//
//  Created by Manar Alhamdy on 9/12/22.
//

import SwiftUI
import DynamicNavigationView



struct ContentView: View {
    let vm = DNViewModel()
    
    let examples = [
        
        // Lock only view
        DNDefination(width: 75, height: 50, mainAccessory: AnyView(HStack {
            Image(systemName: "lock.fill")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            Spacer()
        })),
        // Music Widget with controls
        DNDefination(width: 350, height: 200, mainAccessory: AnyView(VStack {
            
            HStack {
                Image("cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .cornerRadius(20)
                
                VStack(alignment: .leading) {
                    Text("Entropy").bold().foregroundColor(.white)
                    Text("Beach Baby").bold().foregroundColor(.gray)
                }
                Spacer()
            }
            .foregroundColor(.white)
            
            HStack {
                Text("1:50")
                    .foregroundColor(.gray)
                ZStack(alignment: .leading) {
                    Color.gray
                    Color.white.scaleEffect(x: 0.5, anchor: .leading)
                }
                .frame(height: 10)
                .cornerRadius(5)
                Text("1:51")
                    .foregroundColor(.gray)
            }
            
            HStack {
                Image(systemName: "forward.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .frame(maxWidth: .infinity)
                    .opacity(0)
                Image(systemName: "backward.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .frame(maxWidth: .infinity)
                Image(systemName: "pause.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 25)
                    .frame(maxWidth: .infinity)
                Image(systemName: "forward.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .frame(maxWidth: .infinity)
                Image(systemName: "airplayaudio")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .frame(maxWidth: .infinity)
            }
            .foregroundColor(.white)
            Spacer()
            
        }.padding(.vertical))),
        // Mini Music Widget
        DNDefination(width: 220, height: 70, mainAccessory: AnyView(HStack {
            Image("cover")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .cornerRadius(8)
                .offset(x: -5)
            VStack(alignment: .leading) {
                Text("Entropy").bold().foregroundColor(.white)
                Text("Beach Baby").bold().foregroundColor(.gray)
            }
            .offset(x: -5)
            Spacer()
            
        }), rightAccessory: AnyView(Circle().overlay(Image(systemName: "timer").resizable().padding(12).foregroundColor(.orange)).frame(width: 55, height: 55))),
        // Flight information
        DNDefination(width: 200, height: 60, mainAccessory: AnyView(HStack {
            Image(systemName: "arrow.down.right.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .cornerRadius(5)
                .offset(x: -10)
                .foregroundColor(.green)
            Text("JFK").bold().foregroundColor(.green)
                .offset(x: -10)
            Spacer()
            Text("in 55m").bold().foregroundColor(.green)
            
        }), rightAccessory: nil),
        // Phone ring status
        DNDefination(width: 150, height: 50, mainAccessory: AnyView(HStack {
            Image(systemName: "bell")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            Spacer()
            Text("Ring").bold().foregroundColor(.white)
        })),
        // Face ID
        DNDefination(width: 200, height: 200, mainAccessory: AnyView(Image(systemName: "faceid")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding().foregroundColor(.white))),
        // Charging Status
        DNDefination(width: 320, height: 50, mainAccessory: AnyView(
            HStack() {
                Text("Charging").bold().foregroundColor(.white)
                Spacer()
                Text("75%").bold().foregroundColor(.green)
                Image(systemName: "battery.100.bolt").scaleEffect(1.1, anchor: .trailing).foregroundColor(.green)
                
            }
        )
        ),
        // AirPod Pro charging status
        DNDefination(width: 370, height: 100, mainAccessory: AnyView(
            HStack() {
                Image(systemName: "airpodspro")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                VStack(alignment: .leading) {
                    Text("Connected").bold().foregroundColor(.gray)
                    Text("Wheeler's AirPods Pro")
                        .bold().foregroundColor(.white)
                        .fixedSize(horizontal: true, vertical: false)
                }
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 5)
                        .foregroundColor(.green)
                        .opacity(0.5)
                    Circle()
                        .trim(from: 0.0, to: 0.75)
                        .stroke(lineWidth: 5)
                        .foregroundColor(.green)
                        .rotationEffect(.degrees(-90))
                    
                    Text("75")
                        .bold()
                        .foregroundColor(.green)
                }
                .padding(.leading)
                
                
            }
        )
        )
        
    ]
    @State var idx = 0
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.red, .blue], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                DNNavigationView(vm: vm)
                    
                Spacer()
                
                HStack {
                    
                    Button("Back") {
                        guard idx >= 1 else { return }
                        vm.pop()
                        idx -= 1
                      
                    }
                    .padding()
                    .background(Rectangle().opacity(0.05))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    
                    Button("Next") {
                        guard examples.count > idx else { return }
                        vm.push(
                            examples[idx]
                        )
                        idx += 1
                     
                    }
                    .padding()
                    .background(Rectangle().opacity(0.05))
                    .cornerRadius(10)
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    
                }
                Button("Pop to root") {
                    vm.popToRoot()
                    idx = 0
                }
                .padding()
                .background(Rectangle().opacity(0.05))
                .cornerRadius(10)
                .buttonStyle(.plain)
                .padding(.bottom)
                .foregroundColor(.white)
                
            }
            
    #if os(macOS)
    .frame(width: 500, height: 400)
    #endif
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
