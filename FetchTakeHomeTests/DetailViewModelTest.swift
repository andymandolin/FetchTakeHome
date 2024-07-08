import XCTest
import Combine
@testable import FetchTakeHome

class DetailViewModelTests: XCTestCase {
    
    var detailViewModel: DetailViewModel!
    var mockNetworking: MockNetworking!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworking = MockNetworking()
        detailViewModel = DetailViewModel(networking: mockNetworking)
        cancellables = []
    }
    
    override func tearDown() {
        detailViewModel = nil
        mockNetworking = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchDetailedDessertsSuccess() async {
        // Given
        let mockMealsResponse = createMockMealsResponse()
        mockNetworking.mockDetailedDessertsResponse = mockMealsResponse
        
        // When
        let expectation = XCTestExpectation(description: "Fetch detailed desserts")
        
        detailViewModel.$dessertRecipe
            .dropFirst()
            .sink { dessert in
                XCTAssertEqual(dessert?.idMeal, "1")
                XCTAssertEqual(dessert?.strMeal, "Test Meal")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await detailViewModel.fetchDessertDetails(by: "1")
        
        // Then
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertNil(detailViewModel.errorMessage)
    }
 
    func testFetchDetailedDessertsFailure() async {
        // Given
        mockNetworking.shouldThrowError = true
        
        // When
        let expectation = XCTestExpectation(description: "Fetch detailed desserts failure")
        
        detailViewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await detailViewModel.fetchDessertDetails(by: "1")
        
        // Then
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertNil(detailViewModel.dessertRecipe)
    }
    
    private func createMockMealsResponse() -> DessertRecipes {
        return DessertRecipes(meals: [
            DessertRecipe(idMeal: "1",
                          strMeal: "Test Meal",
                          strDrinkAlternate: nil,
                          strCategory: "Dessert",
                          strArea: "American",
                          strInstructions: "Test Instructions",
                          strMealThumb: "test.jpg",
                          strTags: nil,
                          strYoutube: nil,
                          strIngredient1: nil,
                          strIngredient2: nil,
                          strIngredient3: nil,
                          strIngredient4: nil,
                          strIngredient5: nil,
                          strIngredient6: nil,
                          strIngredient7: nil,
                          strIngredient8: nil,
                          strIngredient9: nil,
                          strIngredient10: nil,
                          strMeasure1: nil,
                          strMeasure2: nil,
                          strMeasure3: nil,
                          strMeasure4: nil,
                          strMeasure5: nil,
                          strMeasure6: nil,
                          strMeasure7: nil,
                          strMeasure8: nil,
                          strMeasure9: nil,
                          strMeasure10: nil)
        ])
    }
}
