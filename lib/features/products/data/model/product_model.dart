class ProductModel {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  int? weight;
  Dimensions? dimensions;
  String? returnPolicy;
  List<String>? images;
  String? thumbnail;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.weight,
    this.dimensions,
    this.returnPolicy,
    this.images,
    this.thumbnail,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'weight': weight,
      'dimensions': dimensions == null
          ? null
          : {
              'width': dimensions!.width,
              'height': dimensions!.height,
              'depth': dimensions!.depth,
            },
      'returnPolicy': returnPolicy,
      'images': images,
      'thumbnail': thumbnail,
    };
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = (json['price'] as num?)?.toDouble();
    discountPercentage = (json['discountPercentage'] as num?)?.toDouble();

    weight = json['weight'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(
            Map<String, dynamic>.from(json['dimensions'] as Map),
          )
        : null;

    returnPolicy = json['returnPolicy'];

    images = (json['images'] as List<dynamic>?)
        ?.map((item) => item.toString())
        .toList();
    thumbnail = json['thumbnail'];
  }
}

class Dimensions {
  double? width;
  double? height;
  double? depth;

  Dimensions({this.width, this.height, this.depth});

  Dimensions.fromJson(Map<String, dynamic> json) {
    width = (json['width'] as num?)?.toDouble();
    height = (json['height'] as num?)?.toDouble();
    depth = (json['depth'] as num?)?.toDouble();
  }
}
