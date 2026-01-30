import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Menu extends StatelessWidget{
  const Menu(
    {super.key}
  );
  
  @override
  Widget build(BuildContext context) {
    return ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(0),
                child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16,),
                          Title(color:Colors.black ,child: Text(S.current.appTitle, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),)),
                          const SizedBox(height: 16,),
                          LayoutBuilder(builder: (context, contraints){
                            return Container(
                                width: contraints.maxWidth, 
                                height: 2, 
                                color: Colors.black,
                              );
                            }
                          ),
                          const SizedBox(height: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start, 
                                children: [
                                  const SizedBox(width: 4,),
                                  const FaIcon(FontAwesomeIcons.language),
                                  const SizedBox(width: 6,),
                                  Text(S.current.language),
                                ]
                              ),
                              const SizedBox(height: 10,),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 1, 
                                    color: Colors.black,
                                  );
                                }
                              ),      
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 4,),
                                  const FaIcon(FontAwesomeIcons.clockRotateLeft),
                                  const SizedBox(width: 6,),
                                  Text(S.current.history),
                                ]
                              ),
                              const SizedBox(height: 10,),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 1, 
                                    color: Colors.black,
                                  );
                                }
                              ), 
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 4,),
                                  const FaIcon(FontAwesomeIcons.pen),
                                  const SizedBox(width: 6,),
                                  Text(S.current.wallpaper),
                                ]
                              ),
                              const SizedBox(height: 10,),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 1, 
                                    color: Colors.black,
                                  );
                                }
                              ), 
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 4,),
                                  const FaIcon(FontAwesomeIcons.palette),
                                  const SizedBox(width: 6,),
                                  Text(S.current.theme),
                                ]
                              ),
                              const SizedBox(height: 10,),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 1, 
                                    color: Colors.black,
                                  );
                                }
                              ), 
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 4,),
                                  const FaIcon(FontAwesomeIcons.gear),
                                  const SizedBox(width: 6,),
                                  Text(S.current.settings),
                                ]
                              ),
                              const SizedBox(height: 10,),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 1, 
                                    color: Colors.black,
                                  );
                                }
                              ), 
                            ],
                          ),
                        ],
                      )      
              )
            ],
          );
  }

}