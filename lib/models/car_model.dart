class CarModel {
  final int id;
  final String name;
  final String brand;
  final String type;
  final String imageUrl;
  final double pricePerDay;

  CarModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.type,
    required this.imageUrl,
    required this.pricePerDay,
  });

  static List<CarModel> getDummyCars() {
    return [
      CarModel(
        id: 1,
        name: 'Toyota Avanza',
        brand: 'Toyota',
        type: 'MPV',
        imageUrl: 'https://images.unsplash.com/photo-1619767886558-efdc259cde1a?w=400',
        pricePerDay: 350000,
      ),
      CarModel(
        id: 2,
        name: 'Toyota Fortuner',
        brand: 'Toyota',
        type: 'SUV',
        imageUrl: 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400',
        pricePerDay: 750000,
      ),
      CarModel(
        id: 3,
        name: 'Honda CR-V',
        brand: 'Honda',
        type: 'SUV',
        imageUrl: 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400',
        pricePerDay: 650000,
      ),
      CarModel(
        id: 4,
        name: 'Honda Civic',
        brand: 'Honda',
        type: 'Sedan',
        imageUrl: 'https://images.unsplash.com/photo-1590362891991-f776e747a588?w=400',
        pricePerDay: 550000,
      ),
      CarModel(
        id: 5,
        name: 'Mitsubishi Pajero',
        brand: 'Mitsubishi',
        type: 'SUV',
        imageUrl: 'https://images.unsplash.com/photo-1581540222194-0def2dda95b8?w=400',
        pricePerDay: 800000,
      ),
      CarModel(
        id: 6,
        name: 'Mitsubishi Xpander',
        brand: 'Mitsubishi',
        type: 'MPV',
        imageUrl: 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400',
        pricePerDay: 400000,
      ),
      CarModel(
        id: 7,
        name: 'Suzuki Ertiga',
        brand: 'Suzuki',
        type: 'MPV',
        imageUrl: 'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=400',
        pricePerDay: 300000,
      ),
      CarModel(
        id: 8,
        name: 'Daihatsu Xenia',
        brand: 'Daihatsu',
        type: 'MPV',
        imageUrl: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=400',
        pricePerDay: 320000,
      ),
      CarModel(
        id: 9,
        name: 'BMW X5',
        brand: 'BMW',
        type: 'SUV',
        imageUrl: 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400',
        pricePerDay: 1500000,
      ),
      CarModel(
        id: 10,
        name: 'Mercedes-Benz GLE',
        brand: 'Mercedes',
        type: 'SUV',
        imageUrl: 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=400',
        pricePerDay: 1800000,
      ),
    ];
  }
}
