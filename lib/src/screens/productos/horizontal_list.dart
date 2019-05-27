import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Categoria(
            image_location: 'img/im1.jpg',
            image_caption: 'Frutas',
          ),Categoria(
            image_location: 'img/im2.jpg',
            image_caption: 'Bebidas',
          ),
          Categoria(
            image_location: 'img/im3.jpg',
            image_caption: 'Conservas',
          ),
          Categoria(
            image_location: 'img/im4.jpg',
            image_caption: 'comida',
          ),
          Categoria(
            image_location: 'img/im5.jpg',
            image_caption: 'Harinas',
          ),
          Categoria(
            image_location: 'img/im6.jpg',
            image_caption: 'Verduras',
          )

          
        ],
      ),
    );
  }
}

class Categoria extends StatelessWidget {
  final String image_location;
  final String image_caption;
  Categoria({this.image_location, this.image_caption});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 110,
          child: ListTile(
              title: ClipRRect(
                  borderRadius: new BorderRadius.circular(50.0),
                  child: Image.asset(
                    image_location,
                    width: 80,
                    height: 80,fit: BoxFit.cover,
                  )),
              subtitle: Container(
                  alignment: Alignment.topCenter, child: Text(image_caption))),
        ),
      ),
    );
  }
}
