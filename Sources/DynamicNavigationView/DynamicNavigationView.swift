import SwiftUI


/// Defines and controls the Navigation stack
public class DNViewModel: ObservableObject {
   
    private var stack = [DNDefination]()
    
    /// The current defination to present
    @Published private(set) var current: DNDefination
    
    public func push(_ shape: DNDefination) {
        stack.append(shape)
        self.current = shape
    }
    
    public func pop() {
        if stack.count > 1 {
            stack.removeLast()
            if let last = stack.last {
                self.current = last
            }
        }
    }
    
    public func popToRoot() {
        if let first = stack.first {
            current = first
            stack = [first]
        }
    }
    
    public init(root: DNDefination = DNDefination(width: 130, height: 38)) {
        self.stack = [DNDefination]()
        self.current = root
        stack.append(root)
    }
}

/// Defines the view width-height, content, and any accessory that should be displayed
public struct DNDefination {
    
    public init(width: CGFloat, height: CGFloat, mainAccessory: AnyView? = nil, rightAccessory: AnyView? = nil) {
        self.width = width
        self.height = height
        self.mainAccessory = mainAccessory
        self.rightAccessory = rightAccessory
    }
    
    let width: CGFloat
    let height: CGFloat
    var mainAccessory: AnyView? = nil
    var rightAccessory: AnyView? = nil
}

public struct DNNavigationView: View {
    
    @StateObject public var vm: DNViewModel
    
    public init(vm: DNViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    public var body: some View {
        HStack {
            
            // TODO: Left Accessory
            ZStack {
                Color.clear
                    .frame(height: vm.current.height)
                    .frame(maxWidth: 50)
            }
            
            // Main Content
            ZStack {
                Color.black
                HStack(alignment: .center) {
                    if let main = vm.current.mainAccessory {
                        main
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal)
                    }
                }
                .padding(10)
            }
            .frame(width: vm.current.width, height: vm.current.height)
            .cornerRadius(min(vm.current.height/2, 50))
         
            // Right Accessory
            ZStack {
                Color.clear
                    .frame(height: vm.current.height)
                    .frame(maxWidth: 50)
                if let right = vm.current.rightAccessory {
                    right
                        .transition(.scale.combined(with: .opacity).combined(with: .asymmetric(insertion: .slide, removal: .opacity)))
                }
            }
        }
        .animation(.easeInOut, value: vm.current.width)
       
    }
}
