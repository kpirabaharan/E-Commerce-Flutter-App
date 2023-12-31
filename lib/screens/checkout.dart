import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart' show Stripe;

import 'package:e_commerce/providers/active_store_provider.dart';
import 'package:e_commerce/providers/cart_provider.dart';

class Checkout extends ConsumerStatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  ConsumerState<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends ConsumerState<Checkout> {
  final _formKey = GlobalKey<FormState>();

  var _isLoading = false;

  final _emailNode = FocusNode();
  final _phoneNode = FocusNode();
  final _addressNode = FocusNode();
  final _cityNode = FocusNode();
  final _provinceNode = FocusNode();
  final _zipNode = FocusNode();
  final _countryNode = FocusNode();

  final Map<String, dynamic> _contactBillingData = {
    'name': '',
    'email': '',
    'phone': '',
    'address': '',
    'city': '',
    'state': '',
    'zip': '',
    'country': '',
  };

  @override
  void dispose() {
    _phoneNode.dispose();
    _addressNode.dispose();
    _cityNode.dispose();
    _provinceNode.dispose();
    _zipNode.dispose();
    _countryNode.dispose();
    super.dispose();
  }

  void proceedToPayment() async {
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await ref
          .read(cartProvider.notifier)
          .checkout(ref.read(activeStoreProvider)!.id, _contactBillingData);

      setState(() {
        _isLoading = false;
      });

      try {
        await Stripe.instance.presentPaymentSheet();
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment Successful'),
          ),
        );
        Navigator.of(context).pop();
        ref.read(cartProvider.notifier).clearCart();
        Navigator.of(context).pop();
      } catch (e) {
        print('Payment Error: $e');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    return Card(
        child: Container(
      padding: const EdgeInsets.all(10),
      height: 500,
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: height - bottomInsets - 50),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
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
                      initialValue: _contactBillingData['name'],
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
                      initialValue: _contactBillingData['email'],
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
                      initialValue: _contactBillingData['phone'],
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
                      keyboardType: TextInputType.streetAddress,
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
                      initialValue: _contactBillingData['address'],
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
                              keyboardType: TextInputType.streetAddress,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).requestFocus(_provinceNode),
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
                              initialValue: _contactBillingData['city'],
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
                              keyboardType: TextInputType.streetAddress,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).requestFocus(_zipNode),
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
                              initialValue: _contactBillingData['state'],
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
                              keyboardType: TextInputType.streetAddress,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).requestFocus(_countryNode),
                              focusNode: _zipNode,
                              decoration: InputDecoration(
                                labelText: 'Zip Code',
                                labelStyle: Theme.of(context).textTheme.labelMedium,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Zip Code';
                                }
                                return null;
                              },
                              initialValue: _contactBillingData['zip'],
                              onSaved: (value) {
                                _contactBillingData['zip'] = value!;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.streetAddress,
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
                              initialValue: _contactBillingData['country'],
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
