import XCTest
import Combine
@testable import FetchTakeHome

class ContentViewModelTests: XCTestCase {
    
    var contentViewModel: ContentViewModel!
    var mockNetworking: MockNetworking!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworking = MockNetworking()
        contentViewModel = ContentViewModel(networking: mockNetworking)
        cancellables = []
    }
    
    override func tearDown() {
        contentViewModel = nil
        mockNetworking = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchDessertsSuccess_sortedAlphabeticallyAndEmptyAreFiltered() async {
        // Given
        let mockMealsResponse: Desserts = createMockDessertResponse()
        mockNetworking.mockMealsResponse = mockMealsResponse
        
        // When
        let expectation = XCTestExpectation(description: "Fetch desserts")
        
        contentViewModel.$desserts
            .dropFirst()
            .sink { desserts in
                XCTAssertEqual(desserts.count, 2)
                XCTAssertEqual(desserts.first?.strMeal, "Apple Pie")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await contentViewModel.fetchDesserts()
        
        // Then
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertNil(contentViewModel.errorMessage)
    }
    
    func testFetchDessertsFailure() async {
        // Given
        mockNetworking.shouldThrowError = true
        
        // When
        let expectation = XCTestExpectation(description: "Fetch desserts failure")
        
        contentViewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await contentViewModel.fetchDesserts()
        
        // Then
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertTrue(contentViewModel.desserts.isEmpty)
    }
    
    private func createMockDessertResponse() -> Desserts {
        let dessertThatStartsWithTheLetterA: Dessert = Dessert(id: "1",
                                                               strMeal: "Apple Pie",
                                                               strMealThumb: "thumbnail_address",
                                                               idMeal: "1")
        let dessertThatStartsWithTheLetterZ: Dessert = Dessert(id: "1",
                                                               strMeal: "Zebra Cake",
                                                               strMealThumb: "thumbnail_address",
                                                               idMeal: "1")
        let dessertWithEmptyValue: Dessert = Dessert(id: "1",
                                                     strMeal: "",
                                                     strMealThumb: "thumbnail_address",
                                                     idMeal: "1")
        
        return Desserts(meals:[dessertThatStartsWithTheLetterZ, 
                               dessertThatStartsWithTheLetterA,
                               dessertWithEmptyValue])
    }
}
