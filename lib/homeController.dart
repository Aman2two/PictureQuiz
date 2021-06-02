


class HomeController {
  String category="flower";
  String mainImage="";
  String image1="";
  String image2="";
  int categoryImageIndex=0;

  Map<String, String> data = {
    "flower1": "lib/assets/flower1.jpg",
    "flower2": "lib/assets/flower2.jpg",
    "flower3": "lib/assets/flower3.jpg",
    "food1": "lib/assets/food1.jpg",
    "food2": "lib/assets/food2.jpg",
    "food3": "lib/assets/food3.jpg",
    "vehicle1": "lib/assets/vehicle1.jpg",
    "vehicle2": "lib/assets/vehicle2.jpg",
    "vehicle3": "lib/assets/vehicle3.jpg",
  };

  Map<String,List<String>> categoryMap={
    "flower":["flower1","flower2","flower3"],
    "food":["food1","food2","food3"],
    "vehicle":["vehicle1","vehicle2","vehicle3"],
  };

  setMainImage({String? localCategory}){
    category=localCategory==null?category:localCategory;
    categoryImageIndex=DateTime.now().millisecond%categoryMap[category]!.length;
    mainImage=categoryMap[category]![categoryImageIndex];
    setSelectionImages();
  }

  setSelectionImages(){
    image1=categoryMap[category]!.firstWhere((element) => element!=mainImage);
    image2=categoryMap.entries.firstWhere((element) => element.key!=category).value[DateTime.now().millisecond%categoryMap[category]!.length];
  }


  bool isPresentInMap(String imageName)
     =>categoryMap[category]!.contains(imageName);

  onNewPicturesSelect(){
    categoryImageIndex=(categoryImageIndex+1)%categoryMap[category]!.length;
    mainImage=categoryMap[category]![categoryImageIndex];
    setSelectionImages();
  }


}