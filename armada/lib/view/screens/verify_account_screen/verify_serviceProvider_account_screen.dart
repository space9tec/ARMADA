import 'package:flutter/material.dart';
import 'package:armada/utils/helper_widget.dart';

import '../../widgets/widgets.dart';

class VerifyServiceProvider extends StatefulWidget {
  static const String routeName = '/VerifyServiceProvider';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const VerifyServiceProvider();
      },
    );
  }

  const VerifyServiceProvider({super.key});

  @override
  State<VerifyServiceProvider> createState() => _VerifyServiceProviderState();
}

class _VerifyServiceProviderState extends State<VerifyServiceProvider> {
  String _currentCarType = '';
  String _currentTractorAttachmentsType = '';

  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              addVerticalSpace(55.0),
              Center(
                child: Text(
                  "Verify Account",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(25.0),
                  Text('Select a machinery type:'),
                  addVerticalSpace(15.0),
                  Row(
                    children: [
                      Radio(
                        value: 'Tractor',
                        groupValue: _currentCarType,
                        onChanged: (value) {
                          setState(() {
                            _currentCarType = value!;
                          });
                        },
                      ),
                      Text('Tractor'),
                      Radio(
                        value: 'Combineharvester',
                        groupValue: _currentCarType,
                        onChanged: (value) {
                          setState(() {
                            _currentCarType = value!;
                          });
                        },
                      ),
                      Text('Combine harvester'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'Thresher',
                        groupValue: _currentCarType,
                        onChanged: (value) {
                          setState(() {
                            _currentCarType = value!;
                          });
                        },
                      ),
                      Text('Thresher'),
                      Radio(
                        value: 'TractorAttachments',
                        groupValue: _currentCarType,
                        onChanged: (value) {
                          setState(() {
                            _currentCarType = value!;
                          });
                        },
                      ),
                      Text('Tractor Attachments'),
                      Radio(
                        value: 'Other',
                        groupValue: _currentCarType,
                        onChanged: (value) {
                          setState(() {
                            _currentCarType = value!;
                          });
                        },
                      ),
                      Text('Other'),
                    ],
                  ),
                ],
              ),
              if (_currentCarType == 'Tractor') _buildSedanInputs(),
              if (_currentCarType == 'Combineharvester') _buildSUVInputs(),
              if (_currentCarType == 'Thresher') _buildHatchbackInputs(),
              if (_currentCarType == 'TractorAttachments')
                _buildPickupTruckInputs(),
              if (_currentCarType == 'Other') _buildHatchbackInputsO(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'DiscPlough')
                  _buildSedanInputss(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'DiscHarrow')
                  _buildSedanInputsu(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'Planter')
                  _buildSedanInputsv(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'Sprayer')
                  _buildSedanInputsw(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'Baler')
                  _buildSedanInputsx(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'Trailer')
                  _buildSedanInputsy(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'Other')
                  _buildSedanInputsz(),
              addVerticalSpace(50),
              if (_currentCarType != '' &&
                  _currentCarType != 'TractorAttachments')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(context, "Verify", '/',
                        Theme.of(context).primaryColor, 200, 50),
                    addHorizontalSpace(25),
                    Button(context, "cancel", '/', Colors.grey, 325, 40),
                  ],
                ),
              if (_currentCarType == 'TractorAttachments' &&
                  _currentTractorAttachmentsType != '')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(context, "Verify", '/',
                        Theme.of(context).primaryColor, 200, 50),
                    addHorizontalSpace(25),
                    Button(context, "cancel", '/', Colors.grey, 325, 40),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSedanInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Year'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Horsepower '),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Hour meter'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Region'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildSUVInputs() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Year'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Grain Tank Capacity'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Grain Types'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Region'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildHatchbackInputs() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Required power (hp)'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Working Capacity (kg/hr)'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Region'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildHatchbackInputsO() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Additional Information'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Region'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildPickupTruckInputs() {
    return Column(
      children: [
        Row(
          children: [
            Radio(
              value: 'DiscPlough',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Disc Plough'),
            Radio(
              value: 'DiscHarrow',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Disc Harrow '),
            Radio(
              value: 'Planter',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Planter'),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 'Sprayer',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Sprayer'),
            Radio(
              value: 'Baler',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Baler'),
            Radio(
              value: 'Trailer',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Trailer'),
            Radio(
              value: 'Other',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Other '),
          ],
        ),
      ],
    );
  }

  Widget _buildSedanInputss() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Discs'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildSedanInputst() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Discs'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildSedanInputsu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Discs'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildSedanInputsv() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Rows'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildSedanInputsw() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Tank Capacity'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildSedanInputsx() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Required power (hp)'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildSedanInputsy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Loading Capacity (ton)'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Platform dimension(m)'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Sideboard Height (m)'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of tires'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }

  Widget _buildSedanInputsz() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Additional Information'),
          validator: (value) {
            if (value == null || value.length < 4) {
              return "More than 4 character needed";
            }
            return null;
          },
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
      ],
    );
  }
}
