import 'package:flutter/material.dart';

class GridUsedItems extends StatelessWidget {
  const GridUsedItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView.builder(
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 2 / 3),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(0, 3),
                    blurRadius: 3.0),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                      width: 200,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(9.0),
                          topRight: Radius.circular(9.0),
                        ),
                        child: Image.asset(
                          'assets/puppy.jpg',
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "제목",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "가격",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.apply(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
