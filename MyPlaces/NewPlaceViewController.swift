
import UIKit

class NewPlaceViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView() //заменяем низ TVC на VC. Избавляемся от линий снизу 

    }

    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { //реализовываем меню выбора картинки
            
        } else {
            view.endEditing(true) //метод скрывает клавиатуру если была выбрана ячейка не 0
        }
    }
   
}

//чтобы можно было поработать с клавиатурой, подписываемся под протоколо

//MARK: - Text field delegate

extension NewPlaceViewController: UITextFieldDelegate {
    
    //скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
