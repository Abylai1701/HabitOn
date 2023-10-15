import Foundation

protocol GoalDetailViewModelLogic: AnyObject {
    func fetchGoalDetail(id: Int)

    var goalDetail: Observable<GoalDetailModel?> {get}
}

final class GoalDetailViewModel: GoalDetailViewModelLogic {
    
    //MARK: - Binding Values
    var goalDetail: Observable<GoalDetailModel?> = Observable(nil)
    
    //MARK: - Functions
    
    internal func fetchGoalDetail(id: Int) {
        Router.shared.showLoader()
        ParseManager.shared.getRequest(
            url: API.goalDetail(id: id),
            parameters: [:]) {
            (result: GoalDetailModel?, error) in
                Router.shared.hideLoader()
                if let result = result {
                    self.goalDetail.value = result
                }
        }
    }
}
