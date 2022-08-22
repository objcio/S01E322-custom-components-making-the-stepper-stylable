import SwiftUI

struct ContentView: View {
    @State var items = CartItem.sample
   
    var shipping: Decimal = 5
    
    var total: Decimal {
        items.map { $0.price * Decimal($0.quantity) }.reduce(0, +) + shipping
    }
    
    var body: some View {
        List($items) { $item in
            HStack {
                Image("coffee-bag")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .background(Color(white: 0.9))
                VStack {
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text(item.price.formatted(.currency(code: "EUR")))
                    }
                    MyStepper(value: $item.quantity, in: 0...99, label: { Text("Quantity") }, style: DefaultStepperStyle())
                        .controlSize(.mini)
                    

                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0, content: {
            VStack {
                HStack {
                    Text("Shipping")
                    Spacer()
                    Text(shipping.formatted(.currency(code: "EUR")))
                }
                HStack {
                    Text("Total")
                    Spacer()
                    Text(total.formatted(.currency(code: "EUR")))
                }
                Button("Checkout") { }
                    .buttonStyle(FullWidthButtonStyle())
            }
            .padding()
            .background(.regularMaterial)
        })
        .listStyle(.plain)
        .navigationTitle("Cart")
    }
}

struct FullWidthButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.tint)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
