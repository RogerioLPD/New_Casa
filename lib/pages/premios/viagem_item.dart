class ProductItem {
  final String? image_1, title, description;
  final int? amount, uid;
  ProductItem({
    this.uid,
    this.image_1,
    this.title,
    this.description,
    this.amount,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
        uid: json['id'],
        image_1: json['imagem_1'],
        title: json['titulo'],
        description: json['descricao'],
        amount: json['pontos']);
  }
}

List<ProductItem> products = [
  ProductItem(
    uid: 1,
    title: "Argentina- Bariloche",
    amount: 4000,
    image_1: "assets/images/argentina.png",
    description: "400.000,00 de negócio gerado entre empresas do Núcleo",
  ),
  ProductItem(
    uid: 2,
    title: "Casa Decor- São Paulo",
    amount: 4000,
    image_1: "assets/images/casadecor.png",
    description: "400.000,00 de negócio gerado entre empresas do Núcleo",
  ),
  ProductItem(
    uid: 3,
    title: "Uruguai",
    amount: 4000,
    image_1: "assets/images/uruguai.png",
    description: "400.000,00 de negócio gerado entre empresas do Núcleo",
  ),
  ProductItem(
    uid: 4,
    title: "Paris",
    amount: 4000,
    image_1: "assets/images/Paris.png",
    description: "400.000,00 de negócio gerado entre empresas do Núcleo",
  ),
  ProductItem(
    uid: 5,
    title: "Egito",
    amount: 4000,
    image_1: "assets/images/egito.png",
    description: "400.000,00 de negócio gerado entre empresas do Núcleo",
  ),
  ProductItem(
    uid: 6,
    title: "Porto",
    amount: 4000,
    image_1: "assets/images/porto.png",
    description: "400.000,00 de negócio gerado entre empresas do Núcleo",
  ),
];
