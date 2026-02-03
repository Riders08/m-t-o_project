import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meteo_app/enum/MenuPage.dart';


class Menu extends StatelessWidget{
  final MenuPage selectedPage;
  final Function(MenuPage) onItemSelected;
  const Menu({
    super.key,
    required this.selectedPage,
    required this.onItemSelected,
  });

  Widget _buildItem({
    required BuildContext context,
    required MenuPage page,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = selectedPage == page;
    return InkWell(
      onTap: () => onItemSelected(page),
      child: Container(
        width: double.infinity,
        color: isSelected ? Colors.blue : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child:
         Row(
          children: [
            const SizedBox(height: 40,),
            const SizedBox(width: 16,),
            FaIcon(icon, color: Colors.black),
            const SizedBox(width: 32),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }

  
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
                          const SizedBox(height: 24,),
                          Title(color:Colors.black ,child: Text(S.current.appTitle, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),)),
                          const SizedBox(height: 24,),
                          LayoutBuilder(builder: (context, contraints){
                            return Container(
                                width: contraints.maxWidth, 
                                height: 3, 
                                color: Colors.black,
                              );
                            }
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildItem(context: context, page: MenuPage.home, icon: FontAwesomeIcons.house, label: S.current.home),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 2, 
                                    color: Colors.black,
                                  );
                                }
                              ),      
                              _buildItem(context: context, page: MenuPage.language, icon: FontAwesomeIcons.language, label: S.current.language),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 2, 
                                    color: Colors.black,
                                  );
                                }
                              ),      
                              _buildItem(context: context, page: MenuPage.history, icon: FontAwesomeIcons.clockRotateLeft, label: S.current.history),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 2, 
                                    color: Colors.black,
                                  );
                                }
                              ), 
                              _buildItem(context: context, page: MenuPage.wallpaper, icon: FontAwesomeIcons.pen, label: S.current.wallpaper),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 2, 
                                    color: Colors.black,
                                  );
                                }
                              ), 
                              _buildItem(context: context, page: MenuPage.theme, icon: FontAwesomeIcons.palette, label: S.current.theme),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 2, 
                                    color: Colors.black,
                                  );
                                }
                              ), 
                              _buildItem(context: context, page: MenuPage.settings, icon: FontAwesomeIcons.gear, label: S.current.settings),
                              LayoutBuilder(builder: (context, contraints){
                                return Container(
                                    width: contraints.maxWidth, 
                                    height: 3, 
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