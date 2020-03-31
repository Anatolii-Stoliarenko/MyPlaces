
import UIKit

class MainViewController: UITableViewController {
    
    //let places = [Place(name: "1998 — Крошка моя", location: "Москва", type: "Руки вверх", image: "1998 — Крошка моя")]
    //заменяем переменную выше на следующее
    var places = Place.getPlaces() // благодаря тому, что метод static мы можем обращаться к нему сразу через саму структуру

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return places.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let place = places[indexPath.row]
        // Благодаря let place = places[indexPath.row]  cell.typeLabel.text = places[indexPath.row].type меняем на cell.typeLabel.text = place.type

        cell.nameLabel.text = place.name //таким образом выбираем конкретное свойство с массива places
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        
        if place.image == nil {
            cell.imageOfPlace.image = UIImage(named: place.restaurantImage!)
        } else {
            cell.imageOfPlace.image = place.image
        }
        
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2 //заркугляем imageView
        cell.imageOfPlace.clipsToBounds = true //обрезаем изображение

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) { //метод для выхода при нажати кнопки cancel
    
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        newPlaceVC.saveNewPlace()
        places.append(newPlaceVC.newPlace!)
        tableView.reloadData()//обновляем интерфейс

    }
}
