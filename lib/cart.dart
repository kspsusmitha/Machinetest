import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const Cart({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int getDishCount() {
    if (widget.cartItems == null) return 0;
    int count = 0;
    for (var item in widget.cartItems) {
      count += (item['count'] ?? 0) as int;
    }
    return count;
  }

  int getItemCount() {
    if (widget.cartItems == null) return 0;
    int count = 0;
    for (var item in widget.cartItems) {
      count += (item['count'] ?? 0) as int;
    }
    return count;
  }

  double getTotalAmount() {
    double totalAmount = 0.0;
    for (var item in widget.cartItems) {
      totalAmount += (item['price'] ?? 0.0) * (item['count'] ?? 0);
    }
    return totalAmount;
  }

  void _incrementCount(int index) {
    setState(() {
      if (widget.cartItems != null) {
        widget.cartItems[index]['count']++;
      }
    });
  }

  void _decrementCount(int index) {
    setState(() {
      if (widget.cartItems != null && widget.cartItems[index]['count'] > 0) {
        widget.cartItems[index]['count']--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int dishCount = getDishCount();
    int itemCount = getItemCount();
    double totalAmount = getTotalAmount();

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Summary"),
          ],
        ),
      ),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 35,
              width: double.infinity,
              color: Colors.green,
              child: Center(
                child: Text(
                  "${dishCount} Dishes",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.6,
              child: ListView.builder(
                itemCount: widget.cartItems?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = widget.cartItems![index];
                  return ListTile(
                    leading: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj19llt0R324Qhh3Cuxfiyyk8M_EzumzGIA77mghmQCw&s"),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'] ?? ''),
                          ],
                        ),
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
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => _decrementCount(index),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              color: Colors.green,
                              child: Center(
                                child: Text(
                                  "${item['count']}",
                                  style: TextStyle(color: Colors.white),
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
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => _incrementCount(index),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price: ${item['price'] ?? ''}"),
                        Text("Calories: ${item['calories'] ?? ''}"),
                        // if (dish['customizations']!.isNotEmpty)
                        //   Text(
                        //     dish['customizations']!,
                        //     style: TextStyle(color: Colors.red),
                        //   ),
                      ],
                    ),
                    trailing: Text(
                        "Total: INR ${(item['price'] ?? 0.0) * (item['count'] ?? 0)}"),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Place Order"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            // Text(
            //   "Total Amount: INR ${totalAmount.toStringAsFixed(2)}",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }
}



