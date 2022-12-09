import 'package:flutter/material.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/components/custom_button.dart';
import 'package:project/main.dart';
import 'package:project/providers/booking_provider.dart';
import 'package:project/screens/home/booking_list/postpone.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingListPage extends StatefulWidget {
  const BookingListPage({Key? key}) : super(key: key);

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  @override
  void initState() {
    super.initState();
    // final BookingProvider provider =
    //     Provider.of<BookingProvider>(context, listen: false);
    // provider.updateBookingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        title: Text('ความรู้เกี่ยวกับยาทั่วไป'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Consumer<BookingProvider>(builder: (context, booking, child) {
          return ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70.w,
                    child: Image.network(
                        'https://my.thaibuffer.com/rq/1200/630/45/imagescontent/fb_img/489/s_101186_7060.jpg'),
                  )
                ],
              ),
              Container(
                height: 30,
              ),
              Row(
                children: [Expanded(child: Text('พาราเซตามอล (Paracetamol)'))],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                          '    เป็นยาที่ใช้เพื่อบรรเทาอาการปวดและช่วยลดไข้โดยนิยมใช้เพื่อรักษาอาการปวดทั่วไป อาการปวดศีรษะ หรือไข้หวัดใหญ่ ทั้งนี้ ยาพาราเซตามอลยังสามารถใช้เพื่อบรรเทาอาการปวดของโรคข้ออักเสบได้อีกด้วย โดยยาชนิดนี้จัดเป็นยาสามัญประจำบ้านเพราะสามารถใช้ได้โดยไม่ต้องมีใบสั่งยาของแพทย์ แต่ต้องใช้ในปริมาณที่เหมาะสม'))
                ],
              ),
              Container(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70.w,
                    child: Image.network(
                        'https://bangpleestationery.com/wp-content/uploads/2019/11/4088015.png.webp'),
                  )
                ],
              ),
              Container(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text('ยาธาตุน้ำขาว  (Salol et Menthol Mixture) '))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                          '   แก้ปวดท้อง แก้ท้องเสีย (อาการท้องเสียจากการติดเชื้อแบบไม่รุนแรง) แก้อาการท้องอืดท้องเฟ้อ จุกเสียดแน่นท้อง ช่วยขับลม ช่วยเคลือบกระเพาะอาหารเพื่อการทำลายเชื้อโรคในลำไส้หรือควบคุมเชื้อแบคทีเรียในกระเพาะอาหาร'))
                ],
              ),
              Container(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70.w,
                    child: Image.network(
                        'https://cf.shopee.co.th/file/809e3a1bba2397da994224423ba0bc04'),
                  )
                ],
              ),
              Container(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text('ยาลดกรด (Aluminium-Magnesium Antacid) '))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                          '   ยาน้ำรักษาโรคกระเพาะอาหาร เป็นยาลดกรดที่มีส่วนผสมของเกลืออลูมิเนียมAluminum Hydroxide และแมกนีเซียม Magnesium Hydroxide มีฤทธิ์ในการรักษาและป้องกันแผลในกระเพาะอาหารและลำไส้เล็กส่วนต้น อาการจุกเสียดหน้าอกเนื่องจากโรคกระเพาะ กรดในกระเพาะมาก แผลในกระเพาะอาหาร กระเพาะอาหารอักเสบ แผลในกระเพาะอาหาร หลอดอาหารอักเสบ ยาน้ำนี้จะจับกับกรดในกระเพาะอาหาร'))
                ],
              ),
              Container(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70.w,
                    child: Image.network(
                        'https://cz.lnwfile.com/_/cz/_raw/w4/q1/n9.jpg'),
                  )
                ],
              ),
              Container(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child:
                          Text('ผงน้ำตาลเกลือแร่ (Electrolyte Powder Packet) '))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                          '   สารที่ช่วยทดแทนการสูญเสียเกลือแร่ มีคุณสมบัติในการช่วยเพิ่มพลังงาน เกลือแร่ และน้ำในร่างกาย รวมทั้งป้องกันความรุนแรงที่อาจเกิดขึ้นจากการสูญเสียน้ำ และเกลือแร่จากอาการท้องเสียและอาเจียนได้ ORS หาซื้อได้ตามร้านขายยาทั่วไป ใช้ได้โดยไม่ต้องให้แพทย์สั่ง เว้นแต่เป็นผู้ที่มีประวัติแพ้ ORS หรือมีระดับโพแทสเซียมในเลือดสูง'))
                ],
              ),
              Container(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70.w,
                    child: Image.network(
                        'https://cdn1.productnation.co/stg/sites/6/620f397a3a84b.jpeg'),
                  )
                ],
              ),
              Container(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                          'ยาแก้ไอที่ออกฤทธิ์ระงับหรือลดอาการไอ (Antitussive)'))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                          '   ยาแก้ไอที่นิยมใช้กันจะเป็นกลุ่มยาเดกซ์โทรเมทอร์แฟน (Dextromethorphan), โคเดอีน (Codeine) หรือ ไฮโดรโคโดน (Hydrocodone) ซึ่งเป็นยาที่ออกฤทธิ์กดศูนย์ควบคุมการไอที่สมอง ทำให้อาการไอลดลงได้ มีทั้งแบบยาเม็ด ยาน้ำเชื่อม ยาน้ำแขวนตะกอน   โดยยาตัวนี้จะเหมาะกับผู้ที่มีอาการไอแห้ง ๆ ไม่มีเสมหะ ในกรณีที่มีอาการไอหนัก ๆ ไอบ่อย ไอแห้งเรื้อรัง ไอจนเจ็บหน้าอก หรือไอจนอาเจียน แต่ไม่สามารถใช้รักษาอาการไอจากการสูบบุหรี่ ไอจากโรคหืด ไอจากถุงลมโป่งพอง หรือผลข้างเคียงจากยารักษาความดันได้   '))
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
