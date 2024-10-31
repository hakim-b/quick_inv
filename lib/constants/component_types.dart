
class ComponentTypes {
  static const types = [
    'Resistor',
    'Capacitor',
    'Diode',
    'Other',
    //more cna be added
  ];

  static const specifications = {
    'Resistor': ['Resistance', 'Tolerance', 'Power Rating'],
    'Capacitor': ['Capacitance', 'Voltage Rating', 'Type'],
    'Diode': ['Forward Voltage', 'Reverse Voltage', 'Type'],
    'Other': ['Specification 1', 'Specification 2'],
  };
}
