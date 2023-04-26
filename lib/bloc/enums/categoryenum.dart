enum EnumCategory {
  alcohol,
  car,
  driving,
  vulnerable,
  seat,
  intersections,
}

String convertEnum(EnumCategory enumCategory) {
  switch (enumCategory) {
    case EnumCategory.alcohol:
      return '';
    case EnumCategory.car:
      return '';
    case EnumCategory.driving:
      return '';
    case EnumCategory.intersections:
      return '';
    case EnumCategory.seat:
      return '';
    case EnumCategory.vulnerable:
      return '';
    default:
      return '';
  }
}

EnumCategory convertStringToEnum(String values) {
  switch (values) {
    case 'Alcohol and Drugs':
      return EnumCategory.alcohol;
    case 'Car General':
      return EnumCategory.car;
    case 'Driving General':
      return EnumCategory.driving;
    case 'Intersections':
      return EnumCategory.intersections;
    case 'Seat Belts':
      return EnumCategory.seat;
    case 'Vulnerable Road Users':
      return EnumCategory.vulnerable;
    default:
      return EnumCategory.vulnerable;
  }
}
