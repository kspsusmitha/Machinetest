import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/cart.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> jsonList = [];
  Map<String, int> dishCounts = {};
  Map<String, dynamic> dishes = {};

  List<Map<String, dynamic>> selectedDishes = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await Dio()
          .get('https://run.mocky.io/v3/eed9349e-db58-470c-ae8c-a12f6f46c207');
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data;
          initializeDishCounts();
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void initializeDishCounts() {
    jsonList.forEach((category) {
      category['table_menu_list'].forEach((menuCategory) {
        menuCategory['category_dishes'].forEach((dish) {
          dishCounts[dish['dish_id']] = 0;
          dishes[dish['dish_id']] = dish;
        });
      });
    });
  }

  void _incrementCount(String dishId, int calories) {
    setState(() {
      dishCounts[dishId] = dishCounts[dishId]! + 1;
      updateSelectedDishes(dishId, calories);
    });
  }

  void _decrementCount(String dishId, int calories) {
    setState(() {
      if (dishCounts[dishId]! > 0) {
        dishCounts[dishId] = dishCounts[dishId]! - 1;
        updateSelectedDishes(dishId, calories);
      }
    });
  }

  void updateSelectedDishes(String dishId, int calories) {
    selectedDishes.clear();

    dishCounts.forEach((dishId, count) {
      if (count > 0) {
        var dish = dishes[dishId];
        selectedDishes.add({
          'name': dish['dish_name'],
          'count': count,
          'price': dish['dish_price'] * count,
          'calories': calories * count,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 165, 255, 137),
                    ),
                    Text(
                      "Muhammed Naseem",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "ID:410",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cart(cartItems: selectedDishes)),
                  );
                },
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Breakfast'),
              Tab(text: 'Lunch'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMenuCategory(jsonList, 'Breakfast'),
            _buildMenuCategory(jsonList, 'Lunch'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCategory(List<dynamic> jsonList, String category) {
    var categoryData = jsonList.firstWhere(
      (element) => element['restaurant_id'] == 'south_indian_restaurant',
      orElse: () => null,
    );

    if (categoryData != null) {
      var menuCategories = categoryData['table_menu_list'];
      var categoryIndex = menuCategories.indexWhere(
        (element) => element['menu_category'] == category,
      );

      if (categoryIndex != -1) {
        return ListView.builder(
          itemCount: menuCategories[categoryIndex]['category_dishes'].length,
          itemBuilder: (context, dishIndex) {
            var dish =
                menuCategories[categoryIndex]['category_dishes'][dishIndex];
            var dishId = dish['dish_id']; // Unique ID for each dish

            return ListTile(
              leading: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj19llt0R324Qhh3Cuxfiyyk8M_EzumzGIA77mghmQCw&s",
              ),
              title: Text(dish['dish_name']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dish['dish_price'].toString()!),
                      Text(dish['dish_calories'].toString()!),
                    ],
                  ),
                  Text(dish['dish_description']!),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Center(
                              child: Icon(
                                Icons.remove,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () =>
                                _decrementCount(dishId, dish['dish_calories']),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            dishCounts[dishId].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Center(
                              child: Icon(
                                Icons.add,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () =>
                                _incrementCount(dishId, dish['dish_calories']),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Image.network(dish["dish_image"].toString()),
            );
          },
        );
      }
    }

    return Center(
      child: Text('No data available'),
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}