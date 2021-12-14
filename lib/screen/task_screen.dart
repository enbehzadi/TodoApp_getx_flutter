// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter_app_todo/controller/database_controller.dart';
import 'package:flutter_app_todo/controller/task_controller.dart';
import 'package:flutter_app_todo/model/task_model.dart';
import 'package:get/get.dart';
import 'package:progress_indicator_button/progress_button.dart';
import '../constants.dart';
class TaskScreen extends StatelessWidget {
  final TaskController taskController=Get.put(TaskController());
  final DatabaseController database=Get.put(DatabaseController());
  TaskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Task Screen".tr),
        centerTitle: true,
        leading:PopupMenuButton<int>(
          onSelected: (item) => taskController.popupmenu_click(item),
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0,
              child:
                  Obx((){
                    return
                      SwitchListTile(
                      value:taskController.idDark.value,
                      title: const Text("Dark"),
                      onChanged: (bool value) {
                        database.storeStateDark(value);
                        taskController.changeTheme(database.restoreStateDark());
                      },
                    );


                  }),

            ),
            PopupMenuItem<int>(value: 1, child: ListTile(
              leading: const Icon(Icons.translate_outlined),
              title: Text('Language'.tr,style: const TextStyle(fontSize: 13)),
            ), ),

            PopupMenuItem<int>(value: 2, child: ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: Text('About'.tr,style: const TextStyle(fontSize: 13)),
            ), ),

            PopupMenuItem<int>(value: 3, child: ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: Text('Logout'.tr,style: const TextStyle(fontSize: 13)),
              onTap: (){
                taskController.logout();
              },
            ),
            ),
          ],
        ),



      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(AddTask(),

              backgroundColor:Get.isDarkMode ? Colors.black : Colors.white,

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10),)
              ));
        },
        child:Icon(Icons.add,color:Get.isDarkMode ? Colors.white : Colors.white ,),

      ),
    );
  }
  Widget _buildBody() {
    return Obx(() {

      if (taskController.loading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      else{return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (BuildContext context, int index) {
            task_model tsk=taskController.tasks[index];
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child:
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(

                            color: Colors.grey.withOpacity(0.2)
                        )
                    ),
                    child:ListTile(
                      title: Text(tsk.description.toString()),
                      subtitle: Text(tsk.createdAt.toString().split("T").first),
                      trailing: Container(
                          width: 100,
                          height: 50,
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                                taskController.deleteTask(tsk);
                              }
                                  , icon: const Icon(Icons.delete),color:Get.isDarkMode ? Colors.white : Colors.red),
                              Checkbox(value: tsk.completed,activeColor: Colors.green,onChanged: (value){
                                taskController.updateTask(tsk);
                              })
                            ],
                          )
                      ),
                    )
                ));
          }
      );
      }
    }
    );
  }

}


// ignore: must_be_immutable
class AddTask extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var description;

  AddTask({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(

      height: 260,
      padding: const EdgeInsets.symmetric(vertical:10,horizontal: 10 ),

      child: Column(
        children: [

          TextField(
            style: TextStyle(
              fontSize: 14,
              color:Get.isDarkMode ? Colors.white :mediumBlue,
            ),
            onChanged: (String value){
              description=value;
            },
            decoration: InputDecoration(

              labelText: "Description".tr,
              labelStyle: TextStyle(
                  color:Get.isDarkMode ? Colors.white :mediumBlue,),
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(

                    color:Get.isDarkMode ? Colors.white :mediumBlue,

              )
              ),

            ),
            maxLines: 6,

          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ProgressButton(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              strokeWidth: 2,

              color:Get.isDarkMode ? Colors.white10 :mediumBlue,



              child: Text(
                "Save".tr,
                style: const TextStyle(
                  color: Colors.white,


                  fontSize: 24,
                ),
              ),
              onPressed: (AnimationController controller) async {
                controller.forward();
                await Get.find<TaskController>().addTask(description);
                controller.reverse();
              },
            ),
          ),
          const SizedBox(
              height:30
          )
        ],
      ),
    );
  }

}
