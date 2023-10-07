import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _formKey = GlobalKey<FormState>();

  final _emailNode = FocusNode();
  final _phoneNode = FocusNode();
  final _addressNode = FocusNode();
  final _cityNode = FocusNode();
  final _provinceNode = FocusNode();
  final _postalNode = FocusNode();
  final _countryNode = FocusNode();

  final Map<String, dynamic> _contactBillingData = {
    'name': '',
    'email': '',
    'phone': 0,
    'address': '',
    'city': '',
    'state': '',
    'postal': '',
    'country': '',
  };

  @override
  void dispose() {
    _phoneNode.dispose();
    _addressNode.dispose();
    _cityNode.dispose();
    _provinceNode.dispose();
    _postalNode.dispose();
    _countryNode.dispose();
    super.dispose();
  }

  void proceedToPayment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_contactBillingData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    return Card(
        child: Container(
      padding: const EdgeInsets.all(10),
      height: 500,
      constraints: BoxConstraints(maxHeight: height - bottomInsets - 50),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Contact Information',
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailNode),
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: 'Full Name',
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Invalid Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contactBillingData['name'] = value!;
                },
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_phoneNode),
                focusNode: _emailNode,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: 'Email',
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Invalid Email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contactBillingData['email'] = value!;
                },
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_addressNode),
                focusNode: _phoneNode,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  icon: const Icon(Icons.phone),
                  labelText: 'Phone',
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Invalid Phone Number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contactBillingData['phone'] = value!;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Billing Address',
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_cityNode),
                focusNode: _addressNode,
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Invalid Address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contactBillingData['address'] = value!;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_provinceNode),
                        focusNode: _cityNode,
                        decoration: InputDecoration(
                          labelText: 'City',
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid City';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _contactBillingData['city'] = value!;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_postalNode),
                        focusNode: _provinceNode,
                        decoration: InputDecoration(
                          labelText: 'State / Province',
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid State / Province';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _contactBillingData['state'] = value!;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_countryNode),
                        focusNode: _postalNode,
                        decoration: InputDecoration(
                          labelText: 'Postal Code',
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Postal Code';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _contactBillingData['postal'] = value!;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        focusNode: _countryNode,
                        decoration: InputDecoration(
                          labelText: 'Country',
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid Country';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _contactBillingData['country'] = value!;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: proceedToPayment,
                    child: const Text('Proceed to Payment'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
