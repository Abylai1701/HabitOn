import Foundation

protocol HabbitDetailViewModelLogic: AnyObject {
    func fetchHabbitDetail(id: Int)
    func removeHabbit(id: Int)
    
    var habbitDetail: Observable<HabbitDetailModel?> {get}
}

final class HabbitDetailViewModel: HabbitDetailViewModelLogic {
    
    //MARK: - Binding Values
    var habbitDetail: Observable<HabbitDetailModel?> = Observable(nil)
    
    //MARK: - Functions
    
    internal func fetchHabbitDetail(id: Int) {
        Router.shared.showLoader()
        ParseManager.shared.getRequest(
            url: API.habbitDetail(id: id),
            parameters: [:]) {
                (result: HabbitDetailModel?, error) in
                Router.shared.hideLoader()
                if let result = result {
                    self.habbitDetail.value = result
                }
            }
    }
    internal func removeHabbit(id: Int) {
        Router.shared.showLoader()
        ParseManager.shared.deleteRequest(
            url: API.removeHabbit(id: id),
            parameters: [:]) {
                (result: MessageModel? , error) in
                Router.shared.hideLoader()
                print("message: ", result?.message ?? "")
            }
    }
}
