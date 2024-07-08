import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var selectedDessert: Dessert?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Colors.grayBackground)
                    .ignoresSafeArea()
                List(viewModel.desserts) { dessert in
                    NavigationLink(value: dessert) {
                        HStack {
                            AsyncImage(url: URL(string: dessert.strMealThumb)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack(alignment: .leading) {
                                Text(dessert.strMeal)
                                    .font(Fonts.subHeadline)
                                    .foregroundColor(Colors.label)
                            }
                            Spacer()
                        }
                    }
                }
                .listRowSpacing(8.0)
                .task {
                    await viewModel.fetchDesserts()
                }
                .navigationTitle("Desserts")
                .navigationDestination(for: Dessert.self) { dessert in
                    DetailView(dessert: dessert)
                }
                .alert(item: $viewModel.errorMessage) { errorMessage in
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
        .accentColor(Colors.label)
        .scrollContentBackground(.hidden)
    }
}

extension String: Identifiable {
    public var id: String { self }
}

#Preview {
    ContentView()
}
