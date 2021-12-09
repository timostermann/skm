import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:skm_services/src/config/styles.dart';
import 'package:skm_services/src/core/helpers.dart';
import 'package:skm_services/src/data/models/customer.dart';
import 'package:skm_services/src/presentation/blocs/customer/customer_bloc.dart';
import 'package:skm_services/src/presentation/screens/scenario_screen.dart';
import 'package:skm_services/src/presentation/widgets/sk_button.dart';
import 'package:skm_services/src/presentation/widgets/sk_text_field.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final _customerFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: SkColors.main700,
          centerTitle: true,
          title: SvgPicture.asset(
            'assets/icons/logo_white_small.svg',
            height: 35,
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                SkColors.main700,
                SkColors.main600,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.6, 1],
            ),
          ),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 32,
                          left: 12,
                        ),
                        child: Text(
                          "Kundendaten",
                          style: TextStyle(
                            color: SkColors.main300,
                            fontSize: isTablet(context) ? 36 : 40,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.7,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 40,
                          left: 12,
                        ),
                        child: Text(
                          "Bitte geben Sie zunächst die Kundendaten ein.",
                          style: TextStyle(
                            color: SkColors.main300,
                            fontSize: isTablet(context) ? 16 : 20,
                          ),
                        ),
                      ),
                      FormBuilder(
                        key: _customerFormKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: SkTextField(
                                        name: "firstName",
                                        label: "Vorname",
                                        keyboardType: TextInputType.name,
                                        initialValue: (state is CustomerLoaded)
                                            ? state.customer.firstName
                                            : "",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                    ),
                                    Flexible(
                                      child: SkTextField(
                                        name: "lastName",
                                        label: "Nachname",
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "street",
                                label: "Straße & Hausnummer",
                                keyboardType: TextInputType.streetAddress,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: SkTextField(
                                        name: "postcode",
                                        label: "PLZ",
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                signed: true),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: SkTextField(
                                        name: "place",
                                        label: "Wohnort",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "phone",
                                label: "Telefonnummer",
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "email",
                                label: "E-Mail-Adresse",
                                keyboardType: TextInputType.emailAddress,
                                optional: true,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SkTextField(
                                name: "id",
                                label: "Kundennummer",
                                last: true,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SkButton(
                                    onTap: () {
                                      if (_customerFormKey.currentState !=
                                              null &&
                                          _customerFormKey.currentState!
                                              .validate()) {
                                        _customerFormKey.currentState!.save();
                                        final customerValues = _customerFormKey
                                            .currentState!.value;
                                        context
                                            .read<CustomerBloc>()
                                            .add(CustomerUpdateFields(Customer(
                                              id: customerValues["id"],
                                              firstName:
                                                  customerValues["firstName"],
                                              lastName:
                                                  customerValues["lastName"],
                                              street: customerValues["street"],
                                              postcode:
                                                  customerValues["postcode"],
                                              place: customerValues["place"],
                                              phone: customerValues["phone"],
                                              email: customerValues["email"],
                                            )));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return ScenarioScreen();
                                          }),
                                        );
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: SvgPicture.asset(
                                            "assets/icons/tick.svg",
                                            width: 40,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 40,
                                            ),
                                            child: Text(
                                              "Weiter",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 28,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
