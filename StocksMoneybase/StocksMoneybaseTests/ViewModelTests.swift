import Testing
@testable import StocksMoneybase

@Suite("View Models")
struct ViewModelTests {

    @Test("List view model returns all items when search text is empty")
    @MainActor
    func listViewModelEmptySearch() {
        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
        let viewModel = MarketSummaryListViewModel(useCase: useCase)
        viewModel.marketSummaries = [makeItem(symbol: "AAPL", shortName: "Apple")]
        viewModel.searchText = "   "

        #expect(viewModel.filteredMarketSummaries.count == 1)
    }

    @Test("List view model filters by shortName case-insensitively")
    @MainActor
    func listViewModelFiltersByShortName() {
        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
        let viewModel = MarketSummaryListViewModel(useCase: useCase)
        viewModel.marketSummaries = [
            makeItem(symbol: "AAPL", shortName: "Apple Inc."),
            makeItem(symbol: "MSFT", shortName: "Microsoft")
        ]
        viewModel.searchText = "apple"

        #expect(viewModel.filteredMarketSummaries.count == 1)
        #expect(viewModel.filteredMarketSummaries.first?.symbol == "AAPL")
    }

    @Test("List view model filters by exchange name when shortName is nil")
    @MainActor
    func listViewModelFiltersByExchangeNameFallback() {
        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
        let viewModel = MarketSummaryListViewModel(useCase: useCase)
        viewModel.marketSummaries = [makeItem(symbol: "^DJI", shortName: nil, fullExchangeName: "Dow Jones")]
        viewModel.searchText = "dow"

        #expect(viewModel.filteredMarketSummaries.count == 1)
    }

    @Test("List view model loads summaries successfully")
    @MainActor
    func listViewModelLoadSuccess() async {
        let items = [makeItem(symbol: "NVDA", shortName: "NVIDIA")]
        let useCase = GetMarketSummaryUseCaseMock(result: .success(items))
        let viewModel = MarketSummaryListViewModel(useCase: useCase)

        await viewModel.loadMarketSummaries()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.marketSummaries.count == 1)
        #expect(viewModel.marketSummaries.first?.symbol == "NVDA")
        #expect(useCase.callCount == 1)
    }

    @Test("List view model keeps data empty when load fails")
    @MainActor
    func listViewModelLoadFailure() async {
        let useCase = GetMarketSummaryUseCaseMock(result: .failure(MockError.someFailure))
        let viewModel = MarketSummaryListViewModel(useCase: useCase)

        await viewModel.loadMarketSummaries()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.marketSummaries.isEmpty)
        #expect(useCase.callCount == 1)
    }

    @Test("Detail view model loads matching symbol")
    @MainActor
    func detailViewModelLoadSuccess() async {
        let items = [
            makeItem(symbol: "AAPL", shortName: "Apple"),
            makeItem(symbol: "MSFT", shortName: "Microsoft")
        ]
        let useCase = GetMarketSummaryUseCaseMock(result: .success(items))
        let viewModel = MarketSummaryDetailViewModel(symbol: "MSFT", initialName: "Microsoft", useCase: useCase)

        await viewModel.loadDetail()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.detail?.symbol == "MSFT")
        #expect(useCase.callCount == 1)
    }

    @Test("Detail view model sets not found message when symbol missing")
    @MainActor
    func detailViewModelSymbolNotFound() async {
        let useCase = GetMarketSummaryUseCaseMock(result: .success([makeItem(symbol: "TSLA", shortName: "Tesla")]))
        let viewModel = MarketSummaryDetailViewModel(symbol: "META", initialName: "Meta", useCase: useCase)

        await viewModel.loadDetail()

        #expect(viewModel.detail == nil)
        #expect(viewModel.errorMessage?.contains("META") == true)
    }

    @Test("Detail view model sets user-friendly error message on failure")
    @MainActor
    func detailViewModelLoadFailure() async {
        let useCase = GetMarketSummaryUseCaseMock(result: .failure(MockError.someFailure))
        let viewModel = MarketSummaryDetailViewModel(symbol: "AAPL", initialName: "Apple", useCase: useCase)

        await viewModel.loadDetail()

        #expect(viewModel.detail == nil)
        #expect(viewModel.errorMessage == "Unable to load stock details. Pull to retry.")
        #expect(viewModel.isLoading == false)
    }
}
