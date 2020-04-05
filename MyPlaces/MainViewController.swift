
import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var places: Results<Place>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //отображаем наши заведения из базы. Инициализируем обект places с помощью метода objects(Place.self)
        places = realm.objects(Place.self)

    }

    // MARK: - Table view data source

 

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return places.isEmpty ? 0 : places.count //проверяем нашу базу данных на наличие записей. Если пустая, то присваиваем ноль
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let place = places[indexPath.row]
        // Благодаря let place = places[indexPath.row]  cell.typeLabel.text = places[indexPath.row].type меняем на cell.typeLabel.text = place.type

        cell.nameLabel.text = place.name //таким образом выбираем конкретное свойство с массива places
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)

        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2 //заркугляем imageView
        cell.imageOfPlace.clipsToBounds = true //обрезаем изображение

        return cell
    }
    
    //MARK: - Table view delegate
    
    //этот метод разрешает вызывать различные пункты меню через swipe
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let place = places[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            
            StorageManager.deletedObject(place) //удаляем запись с базы
            tableView.deleteRows(at: [indexPath], with: .automatic) //удаляем запись с экрана
        }
        
        return [deleteAction]
    }
    
    //MARK: - Navigation
    
    //этот метод используется при нажатии на определенную ячейку
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard  let indexPath = tableView.indexPathForSelectedRow else { return } //извлекаем конкретный индекс нажатой ячейки
            let place = places[indexPath.row] //присваиваем place конкретные данные с DataBase
            let newPlaceVC = segue.destination as! NewPlaceViewController //Привеодим newPlaceVC к типу NewPlaceViewController
            newPlaceVC.currentPlace = place // подключаемся к currentPlace и передаем ему значение place (с DataBase)
            
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) { //метод для выхода при нажати кнопки cancel
    
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        newPlaceVC.savePlace()
        tableView.reloadData()//обновляем интерфейс

    }
}
