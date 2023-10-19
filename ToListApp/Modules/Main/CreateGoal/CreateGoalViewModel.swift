import Foundation

protocol CreateGoalViewModelLogic: AnyObject {
    func createGoal(name: String, iteration_count: Int, days: [String])
    var goal: Observable<CreateHabbitModel?> {get}

}

final class CreateGoalViewModel: CreateGoalViewModelLogic {
    
    //MARK: - Functions
    var goal: Observable<CreateHabbitModel?> = Observable(nil)

    internal func createGoal(name: String, iteration_count: Int, days: [String]) {
        
        let parameters: Parameters = ["name": name,
                                      "iteration_count": iteration_count,
                                      "days": days]
        
        ParseManager.shared.postRequest(
            url: API.goals,
            parameters: parameters) {
                (result: CreateHabbitModel?, error) in
                Router.shared.hideLoader()
                if let result = result {
                    self.goal.value = result
                }
            }
    }
}
