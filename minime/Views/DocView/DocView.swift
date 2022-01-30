//
//  DocView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI

struct DocView: View {
    let doc: DocViewModel
    
    var body: some View {
        ZoomableScrollView {
            Image(uiImage: doc.image)
                .renderingMode(.original)
                .resizable()
                .cornerRadius(10)
                .scaledToFit()
                .navigationTitle(doc.title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

struct DocTopBarView: View {
    let docTopBarTitle: String
    @State private var count = 1
    var body: some View {
        HStack(spacing: 20) {
            Text(docTopBarTitle)
                .font(Font.title.weight(.bold))
                
            Spacer()
            Button(action: {
                count += 1
            }) {
                Text("Edit")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.regularMaterial)
        
    }
}


//struct DocView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocView()
//    }
//}


struct ZoomableScrollView<Content: View>: UIViewRepresentable {
  private var content: Content

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  func makeUIView(context: Context) -> UIScrollView {
    // set up the UIScrollView
    let scrollView = UIScrollView()
    scrollView.delegate = context.coordinator  // for viewForZooming(in:)
    scrollView.maximumZoomScale = 20
    scrollView.minimumZoomScale = 1
    scrollView.bouncesZoom = true

    // create a UIHostingController to hold our SwiftUI content
    let hostedView = context.coordinator.hostingController.view!
    hostedView.translatesAutoresizingMaskIntoConstraints = true
    hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    hostedView.frame = scrollView.bounds
    scrollView.addSubview(hostedView)

    return scrollView
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator(hostingController: UIHostingController(rootView: self.content))
  }

  func updateUIView(_ uiView: UIScrollView, context: Context) {
    // update the hosting controller's SwiftUI content
    context.coordinator.hostingController.rootView = self.content
    assert(context.coordinator.hostingController.view.superview == uiView)
  }

  // MARK: - Coordinator

  class Coordinator: NSObject, UIScrollViewDelegate {
    var hostingController: UIHostingController<Content>

    init(hostingController: UIHostingController<Content>) {
      self.hostingController = hostingController
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return hostingController.view
    }
  }
}
