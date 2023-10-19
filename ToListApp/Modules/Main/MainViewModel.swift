import Foundation

protocol MainViewModelLogic: AnyObject {
    func fetchGoals()
    func doneGoal(id: Int)
    func removeGoal(id: Int)

    var goals: Observable<[GoalModel]> {get}
    var goal: Observable<GoalModel?> {get}
}

final class MainViewModel: MainViewModelLogic {

    //MARK: - Binding Values
    var goals: Observable<[GoalModel]>  = Observable([])
    var goal: Observable<GoalModel?> = Observable(nil)

    //MARK: - Functions
    internal func fetchGoals() {
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
    internal func doneGoal(id: Int) {
        ParseManager.shared.postRequest(
            url: API.goalDone,
            parameters: ["habit_id": id]) {
                (result: GoalModel?, error) in
                Router.shared.hideLoader()
                if let result = result {
                    self.goal.value = result
                }
            }
    }
    internal func removeGoal(id: Int) {
        ParseManager.shared.deleteRequest(
            url: API.removeGoal(id: id),
            parameters: [:]) {
                (result: MessageModel? , error) in
                Router.shared.hideLoader()
                print("message: ", result?.message ?? "")
            }
    }
}
