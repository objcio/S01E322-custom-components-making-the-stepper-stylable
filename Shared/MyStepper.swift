//
//  MyStepper.swift
//  Stepper
//
//  Created by Chris Eidhof on 17.08.22.
//

import Foundation
import SwiftUI

struct MyStepperStyleConfiguration {
    var value: Binding<Int>
    var label: Label
    var range: ClosedRange<Int>
    
    struct Label: View {
        var underlyingLabel: AnyView
        
        var body: some View {
            underlyingLabel
        }
    }
}

protocol MyStepperStyle {
    associatedtype Body: View
    func makeBody(_ configuration: MyStepperStyleConfiguration) -> Body
}

struct DefaultStepperStyle: MyStepperStyle {
    func makeBody(_ configuration: MyStepperStyleConfiguration) -> some View {
        Stepper(value: configuration.value, in: configuration.range) {
            configuration.label
        }
    }
}

extension MyStepperStyle where Self == DefaultStepperStyle {
    static var `default`: DefaultStepperStyle { return .init() }
}

struct CapsuleStepperStyle: MyStepperStyle {
    func makeBody(_ configuration: MyStepperStyleConfiguration) -> some View {
        CapsuleStepper(configuration: configuration)
    }
}

struct CapsuleStepper: View {
    var configuration: MyStepperStyleConfiguration
    
    @Environment(\.controlSize)
    var controlSize
    
    var padding: Double {
        switch controlSize {
        case .mini: return 4
        case .small: return 6
        default: return 8
        }
    }
    
    var body: some View {
        HStack {
            configuration.label
            Spacer()
            HStack {
                Button("-") { configuration.value.wrappedValue -= 1 }
                Text(configuration.value.wrappedValue.formatted())
                Button("+") { configuration.value.wrappedValue += 1 }
            }
            .transformEnvironment(\.font, transform: { font in
                if font != nil { return }
                switch controlSize {
                case .mini: font = .footnote
                case .small: font = .callout
                default: font = .body
                }

            })
            .padding(.vertical, padding)
            .padding(.horizontal, padding * 2)
            .foregroundColor(.white)
            .background {
                Capsule()
                    .fill(.tint)
            }
        }
        .buttonStyle(.plain)
    }
}

struct MyStepper<Label: View, Style: MyStepperStyle>: View {
    @Binding var value: Int
    var `in`: ClosedRange<Int> // todo
    @ViewBuilder var label: Label
    var style: Style
    
    var body: some View {
        style.makeBody(.init(value: $value, label: .init(underlyingLabel: AnyView(label)), range: `in`))
    }
}

struct MyStepper_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MyStepper(value: .constant(10), in: 0...100, label: { Text("Value") })
            MyStepper(value: .constant(10), in: 0...100, label: { Text("Value") }, style: .default)
                .controlSize(.mini)
            MyStepper(value: .constant(10), in: 0...100, label: { Text("Value") }, style: CapsuleStepperStyle())
                .controlSize(.large)
                .font(.largeTitle)
        }.padding()
    }
}
