import Foundation

protocol MainViewModelLogic: AnyObject {
    func fetchGoals()

    var goals: Observable<[GoalModel]> {get}
}

final class MainViewModel: MainViewModelLogic {

    //MARK: - Binding Values
    var goals: Observable<[GoalModel]>  = Observable([])

    //MARK: - Functions
    internal func fetchGoals() {
        Router.shared.showLoader()
        ParseManager.shared.getRequest(
            url: API.goals,
            parameters: [:]) {
            (result: [GoalModel]?, error) in
                Router.shared.hideLoader()
                if let result = result {
                    self.goals.value = result
                }
        }
    }
}
