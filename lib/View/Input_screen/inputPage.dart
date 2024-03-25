import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobigic_mt/View/GridView/gridviewDetail.dart';
import 'package:mobigic_mt/View/Input_screen/InputBloc/input_bloc.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  var row = 0;
  var col = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final InputBlocRef = BlocProvider.of<InputBloc>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 175, 175),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: Color.fromARGB(255, 243, 230, 248),
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter the Grid Size:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[1-9]'))
                                  ],
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Length Required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      row = int.parse(value);
                                    });
                                  },
                                  controller: InputBlocRef.rowController,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Row Size',
                                      label: Text('Row')),
                                )),
                                const Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 12),
                                  child: Text('X'),
                                ),
                                Expanded(
                                    child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[1-9]'))
                                  ],
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Length Required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      col = int.parse(value);
                                    });
                                  },
                                  controller: InputBlocRef.colController,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Column Size',
                                      label: Text('Column')),
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Grid'), hintText: 'Enter Grid'),
                              controller: InputBlocRef.inputController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-z]'))
                              ],
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value.length < col * row) {
                                  return 'Minimum length required  : ${col * row}';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              maxLength: row * col == 0 ? 1 : row * col,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FilledButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    InputBlocRef.gridList = [];
                                    var index = 0;
                                    for (int i = 0; i < col; i++) {
                                      for (int j = 0; j < row; j++) {
                                        InputBlocRef.gridList.add(
                                            '${InputBlocRef.inputController.text[index]}');
                                        index++;
                                      }
                                    }

                                    Navigator.pushNamed(
                                      context,
                                      '/GridviewDetail',
                                      arguments:
                                          BlocProvider.of<InputBloc>(context),
                                    );
                                  }
                                },
                                child: Text('insert $row X $col'))
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
