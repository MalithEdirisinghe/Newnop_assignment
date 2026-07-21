import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../models/product.dart';
import '../models/rating.dart';

class ProductRepository {
  final http.Client client;

  ProductRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<Product>> fetchProducts() async {
    try {
      final uri = Uri.parse('${AppConstants.baseUrl}${AppConstants.productsEndpoint}');
      final response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
        return jsonList.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback offline mock dataset if network is unavailable or times out
      return getFallbackProducts();
    }
  }

  List<Product> getFallbackProducts() {
    return const [
      Product(
        id: 1,
        title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        price: 109.95,
        description: "Your everyday pack for items. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday wear.",
        category: "men's clothing",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        rating: Rating(rate: 3.9, count: 120),
      ),
      Product(
        id: 2,
        title: "Mens Casual Premium Slim Fit T-Shirts",
        price: 22.3,
        description: "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric.",
        category: "men's clothing",
        image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
        rating: Rating(rate: 4.1, count: 259),
      ),
      Product(
        id: 3,
        title: "Mens Cotton Jacket",
        price: 55.99,
        description: "Great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping.",
        category: "men's clothing",
        image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
        rating: Rating(rate: 4.7, count: 500),
      ),
      Product(
        id: 4,
        title: "Mens Casual Slim Fit",
        price: 15.99,
        description: "The color could be slightly different between on the screen and in practice. Please check size chart.",
        category: "men's clothing",
        image: "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
        rating: Rating(rate: 2.1, count: 430),
      ),
      Product(
        id: 5,
        title: "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
        price: 695.0,
        description: "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl.",
        category: "jewelery",
        image: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
        rating: Rating(rate: 4.6, count: 400),
      ),
      Product(
        id: 6,
        title: "Solid Gold Petite Micropave",
        price: 168.0,
        description: "Satisfaction Guaranteed. Return or exchange any order within 30 days. Designed and manufactured by Hafeez Center.",
        category: "jewelery",
        image: "https://fakestoreapi.com/img/61sbMiAs0GL._AC_UL640_QL65_ML3_.jpg",
        rating: Rating(rate: 3.9, count: 70),
      ),
      Product(
        id: 7,
        title: "White Gold Plated Princess",
        price: 9.99,
        description: "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love.",
        category: "jewelery",
        image: "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
        rating: Rating(rate: 3.0, count: 400),
      ),
      Product(
        id: 8,
        title: "Pierced Owl Rose Gold Plated Stainless Steel Double",
        price: 10.99,
        description: "Rose Gold Plated Stainless Steel Double Flared Tunnel Plug Earring. Made of 316L Stainless Steel.",
        category: "jewelery",
        image: "https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
        rating: Rating(rate: 1.9, count: 100),
      ),
      Product(
        id: 9,
        title: "WD 2TB Elements Portable External Hard Drive - USB 3.0",
        price: 64.0,
        description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity.",
        category: "electronics",
        image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
        rating: Rating(rate: 3.3, count: 203),
      ),
      Product(
        id: 10,
        title: "SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s",
        price: 109.0,
        description: "Easy upgrade for faster boot up, shutdown, application load and response. Boost burst write performance.",
        category: "electronics",
        image: "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg",
        rating: Rating(rate: 2.9, count: 470),
      ),
      Product(
        id: 11,
        title: "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance",
        price: 109.0,
        description: "3D NAND flash are applied to deliver high transfer speeds. Remarkable transfer speeds that enable faster bootup.",
        category: "electronics",
        image: "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg",
        rating: Rating(rate: 4.8, count: 319),
      ),
      Product(
        id: 12,
        title: "WD 4TB Gaming Drive Portable External Hard Drive",
        price: 114.0,
        description: "Expand your PS4 gaming experience, Play anywhere Fast and easy, setup Sleek design with high capacity.",
        category: "electronics",
        image: "https://fakestoreapi.com/img/61mtL6hhWL._AC_SX679_.jpg",
        rating: Rating(rate: 4.8, count: 400),
      ),
      Product(
        id: 13,
        title: "Acer SB220Q bi 21.5 inches Full HD Ultra-Thin",
        price: 599.0,
        description: "21.5 inches Full HD (1920 x 1080) widescreen IPS display. Radeon FreeSync technology. 75Hz refresh rate.",
        category: "electronics",
        image: "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg",
        rating: Rating(rate: 2.9, count: 250),
      ),
      Product(
        id: 14,
        title: "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor",
        price: 999.99,
        description: "49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27 inch side by side panels.",
        category: "electronics",
        image: "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg",
        rating: Rating(rate: 2.2, count: 140),
      ),
      Product(
        id: 15,
        title: "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats",
        price: 56.99,
        description: "Note: The Jackets is US standard size. Stand collar liner jacket, keep you warm in cold weather.",
        category: "women's clothing",
        image: "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg",
        rating: Rating(rate: 2.6, count: 235),
      ),
      Product(
        id: 16,
        title: "Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket",
        price: 29.95,
        description: "100% POLYURETHANE (shell) 100% POLYESTER (lining). Hand wash cold / Hang to dry / Do not bleach.",
        category: "women's clothing",
        image: "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg",
        rating: Rating(rate: 2.9, count: 340),
      ),
      Product(
        id: 17,
        title: "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
        price: 39.99,
        description: "Lightweight raincoat jacket featuring adjustable drawstring hood, button and zipper front closure.",
        category: "women's clothing",
        image: "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg",
        rating: Rating(rate: 3.8, count: 679),
      ),
      Product(
        id: 18,
        title: "MBJ Women's Solid Short Sleeve Boat Neck V",
        price: 9.85,
        description: "95% RAYON 5% SPANDEX, Made in USA or Imported, Pull On closure, Hand Wash Only.",
        category: "women's clothing",
        image: "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg",
        rating: Rating(rate: 4.7, count: 130),
      ),
      Product(
        id: 19,
        title: "Opna Women's Short Sleeve Moisture",
        price: 7.95,
        description: "100% Polyester, Machine Wash, Lightweight, roomy and highly breathable with moisture wicking fabric.",
        category: "women's clothing",
        image: "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg",
        rating: Rating(rate: 4.5, count: 146),
      ),
      Product(
        id: 20,
        title: "DANVOUY Womens T Shirt Casual Cotton Short",
        price: 12.99,
        description: "95% Cotton, 5% Spandex. Features: Casual, Short Sleeve, Letter Print, V-Neck, Fashion Tees.",
        category: "women's clothing",
        image: "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
        rating: Rating(rate: 3.6, count: 145),
      ),
    ];
  }
}
