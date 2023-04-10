import 'package:driveaustralia/bloc/dkt_bloc.dart';
import 'package:driveaustralia/bloc/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuestionAnswerPage extends StatefulWidget {
  final String? id;
  final String? category;
  const QuestionAnswerPage({Key? key,this.id,this.category}) : super(key: key);

  @override
  State<QuestionAnswerPage> createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  // late DrivingState state;
  @override
  void initState() {
     // state=context.watch()<DktBloc>().state;
    context.read<DktBloc>().add(LoadCategoryEvent(widget.category??''));

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
final state=context.watch<DktBloc>().state;
    return Scaffold(appBar: AppBar(
      title: Text(widget.category??''),
      leading:  BackButton(onPressed: (){
        context.go('/navigation');
      },),
    ),
      body:ListView.builder(
        itemCount: state.categoryModelList?.length??0,
          itemBuilder: (context,index){
          DktModel model=state.categoryModelList![index];
        return Container(
          padding: const EdgeInsets.all(15),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
                Text((index+1).toString()),
                const  SizedBox(width: 10,),
                Expanded(child: Text(model.question,style: Theme.of(context).textTheme.bodyLarge,)),
              ],
            ),
           const SizedBox(height: 10,),
            if(model.image.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Image.asset(model.image,width: MediaQuery.of(context).size.height*0.05,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                   model.options.map((e) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.option),


                      ],),).toList()
                  ,
                ),
              ),

            ],)
            else
            ...model.options.map((e) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(e.option),


            ],),),

          ],),);
      }),
      // Container(
      //   child: Text(state.categoryModelList.toString(),),
      // ),
    );
  }
}
