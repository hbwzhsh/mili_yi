*********************************
**���þ�γ�ȼ������
*********************************;
option compress = yes validvarname = any;

libname lendRaw "D:\mili\Datamart\rawdata\applend";
libname dpRaw "D:\mili\Datamart\rawdata\appdp";
libname dwdata "D:\mili\Datamart\rawdata\dwdata";
libname submart "D:\mili\Datamart\data";

*************************************************************************************************************************��
**�������еľ�γ��֮��ľ�������;

**GPS��ַ;
data dis_GPS;
set dpRaw.apply_info(keep = apply_code user_code gps_address longitude latitude );
rename latitude=GPS_latitude longitude=GPS_longitude;
run;

**סַ�͹�˾סַ ;
data address_job;
set lendRaw.user_base_info(keep=user_code residence_address residence_latitude residence_longitude job_company_address job_company_latitude job_company_longitude);
run;

proc sort data = dis_GPS; by user_code; run;
proc sort data = address_job ; by user_code; run;
data distance;
merge address_job(in = a) dis_GPS(in = b);
by user_code;
if a;
run;

**�й���γ�ȵĴ��·�Χ;
/*data distance;*/
/*set ss;*/
/*if 0<= residence_latitude <50 and 75<residence_longitude<140 or*/
/*0<= job_company_latitude <50 and 75<job_company_longitude< 140 or*/
/*0<= GPS_latitude <50 and 75 < GPS_longitude< 140;*/
/*if GPS_latitude <90;*/
/*run;*/

proc sort data = distance nodupkey; by apply_code; run;

**��λ��ַ�;�ס��ַ����;
data job_address;
set distance;
lon1 = job_company_longitude *constant('pi')/180;
lat1 = job_company_latitude *constant('pi')/180;
lon2 = residence_longitude *constant('pi')/180;
lat2 = residence_latitude *constant('pi')/180;
 
dlon = lon2 - lon1;   
dlat = lat2 - lat1;   
a = sin(dlat/2)*sin(dlat/2) + cos(lat1) * cos(lat2) * sin(dlon/2)*sin(dlon/2);
c = 2 * arsin(sqrt(a)); 
ja_distance = c * 6371;

label ja_distance=��λ��ַ��סַ����(km);
keep apply_code residence_address job_company_address ja_distance;
run;

**סַ��GPS����;
data address_GPS;
set distance;
lon1 = GPS_longitude*constant('pi')/180;
lat1 = GPS_latitude*constant('pi')/180;
lon2 = residence_longitude*constant('pi')/180;
lat2 = residence_latitude*constant('pi')/180;
 
dlon = lon2 - lon1;   
dlat = lat2 - lat1;   
a = sin(dlat/2)*sin(dlat/2) + cos(lat1) * cos(lat2) * sin(dlon/2)*sin(dlon/2);
c = 2 * arsin(sqrt(a)); 
ag_distance = c * 6371;

label ag_distance=סַ��GPS����(km);
keep apply_code residence_address gps_address ag_distance;
run;

**��λ��GPS����;
data job_GPS;
set distance;

lon1 = job_company_longitude*constant('pi')/180;
lat1 = job_company_latitude*constant('pi')/180;
lon2 = GPS_longitude*constant('pi')/180;
lat2 = GPS_latitude*constant('pi')/180;
 
dlon = lon2 - lon1;   
dlat = lat2 - lat1;   
a = sin(dlat/2)*sin(dlat/2) + cos(lat1) * cos(lat2) * sin(dlon/2)*sin(dlon/2);
c = 2 * arsin(sqrt(a)); 
jg_distance = c * 6371;

label jg_distance=��λ��GPS����(km);
keep apply_code job_company_address gps_address jg_distance ;
run;

proc sort data = job_address nodupkey; by apply_code; run;
proc sort data = address_GPS nodupkey; by apply_code; run;
proc sort data = job_GPS nodupkey; by apply_code; run;

**�й��ϱ��Ͷ��������벻����6000km������6000km��ֵ��Ҫȥ��;
data dis_tance;
merge job_address(in=a) address_GPS(in=b) job_GPS(in=c);
by apply_code;
if a;
if jg_distance>6000 then jg_distance = .; 
if ag_distance>6000 then ag_distance = .; 
if ja_distance>6000 then ja_distance = .;
run;

**********************************************************************************************************;
**�����������������ջ���ַ����;

***��������**�ջ���ַ;
proc sort data=submart.apply_flag nodupkey;by apply_code;run;

data ds_data_jbgz;
set submart.Bqsrule_jbgz_submart submart.Bqsrule_jbgz_b_submart;
run;
proc sort data = ds_data_jbgz; by apply_code; run;

data ds_data;
set ds_data_jbgz(keep = apply_code rule_name_normal memo id main_info_id rule_name ���������·� ������������);
if rule_name_normal="JBAA018_סַ���ջ��ؾ���С��100M" or 
rule_name_normal="JBAA019_��λ���ջ��ؾ���С��100M" or 
rule_name_normal="JBAA022_סַ���ջ��ؾ���С��200M" or
rule_name_normal="JBAA023_סַ���ջ��ؾ���С��300M" or 
rule_name_normal="JBAA024_סַ���ջ��ؾ���С��400M" or 
rule_name_normal="JBAA025_סַ���ջ��ؾ���С��500M" or
rule_name_normal="JBAA026_��λ���ջ��ؾ���С��200M" or
rule_name_normal="JBAA027_��λ���ջ��ؾ���С��300M" or 
rule_name_normal="JBAA028_��λ���ջ��ؾ���С��400M" or 
rule_name_normal="JBAA029_��λ���ջ��ؾ���С��500M" or
rule_name_normal="JBAA030_��λ���ջ��ؾ������500M" or 
rule_name_normal="JBAA031_סַ���ջ��ؾ������500M" or 
rule_name_normal="JBAA032_סַ��GPS����С��500M" or 
rule_name_normal="JBAA033_��λ��GPS����С��500M" or 
rule_name_normal="JBAA034_��λ��GPS����С��400M" or
rule_name_normal="JBAA035_��λ��GPS����С��300M" or
rule_name_normal="JBAA036_��λ��GPS����С��200M" or
rule_name_normal="JBAA037_��λ��GPS����С��100M" or
rule_name_normal="JBAA038_סַ��GPS����С��400M" or
rule_name_normal="JBAA039_סַ��GPS����С��300M" or
rule_name_normal="JBAA040_סַ��GPS����С��200M" or
rule_name_normal="JBAA041_סַ��GPS����С��100M" or
rule_name_normal="JBAA042_סַ��GPS�������500M" or
rule_name_normal="JBAA043_��λ��GPS�������500M";
run;

**���memo;
data t;set ds_data;
max=length(compress(memo,'#','k'))+1;
run;

data b;
set t;
do idd=1 to max;
memo1=scan(memo,idd,'#');output;
end;
run;

**��ȡ������:;
data rr; 
set b;
memo2=tranwrd(memo1,'���룺','');
run;

**ǿ������ת��;
data ss;
set rr;
format memo3 best12.;
memo3=strip(memo2);
run;

proc sql;
create table ds_goods as select apply_code,rule_name_normal,id ,main_info_id ,rule_name,���������·�, ������������,memo,min(memo3) as min_memo from 
ss group by apply_code,rule_name_normal,id ,main_info_id ,rule_name,���������·�, ������������,memo;
quit;

**סַ���ջ���ַ֮�����;
data address_goods;
set ds_goods;
if rule_name_normal="JBAA018_סַ���ջ��ؾ���С��100M" or 
rule_name_normal="JBAA022_סַ���ջ��ؾ���С��200M" or
rule_name_normal="JBAA023_סַ���ջ��ؾ���С��300M" or 
rule_name_normal="JBAA024_סַ���ջ��ؾ���С��400M" or 
rule_name_normal="JBAA025_סַ���ջ��ؾ���С��500M" or
rule_name_normal="JBAA031_סַ���ջ��ؾ������500M";
rule_name_normal = "סַ���ջ��ؾ���";
drop rule_name memo;
min_memo =min_memo *0.001;
rename min_memo=סַ���ջ��ؾ���;
run;

**��λ���ջ���ַ֮��ľ���;
data company_goods;
set ds_goods;
if rule_name_normal="JBAA019_��λ���ջ��ؾ���С��100M" or 
rule_name_normal="JBAA026_��λ���ջ��ؾ���С��200M" or
rule_name_normal="JBAA027_��λ���ջ��ؾ���С��300M" or 
rule_name_normal="JBAA028_��λ���ջ��ؾ���С��400M" or 
rule_name_normal="JBAA029_��λ���ջ��ؾ���С��500M" or
rule_name_normal="JBAA030_��λ���ջ��ؾ������500M";
rule_name_normal = "��λ���ջ��ؾ���";
min_memo =min_memo *0.001;
rename min_memo=��λ���ջ��ؾ���;
drop rule_name memo;
run;

**סַ��GPS֮��ľ���;
data address_gps;
set ds_goods;
if rule_name_normal="JBAA038_סַ��GPS����С��400M" or
rule_name_normal="JBAA039_סַ��GPS����С��300M" or
rule_name_normal="JBAA040_סַ��GPS����С��200M" or
rule_name_normal="JBAA041_סַ��GPS����С��100M" or
rule_name_normal="JBAA042_סַ��GPS�������500M" or
rule_name_normal="JBAA032_סַ��GPS����С��500M";
rule_name_normal = "סַ��GPS����";
min_memo =min_memo *0.001;
rename min_memo=סַ��GPS����;
drop rule_name memo;
run;

**��λ��GPS֮��ľ���;
data company_gps;
set ds_goods;
if rule_name_normal="JBAA033_��λ��GPS����С��500M" or 
rule_name_normal="JBAA034_��λ��GPS����С��400M" or
rule_name_normal="JBAA035_��λ��GPS����С��300M" or
rule_name_normal="JBAA036_��λ��GPS����С��200M" or
rule_name_normal="JBAA037_��λ��GPS����С��100M" or
rule_name_normal="JBAA043_��λ��GPS�������500M";
rule_name_normal = "��λ��GPS����";
min_memo =min_memo *0.001;
rename min_memo=��λ��GPS����;
drop rule_name memo;
run;

proc sort data=address_goods ;by apply_code;run;
proc sort data=company_goods ;by apply_code;run;
proc sort data=address_gps ;by apply_code;run;
proc sort data=company_gps ;by apply_code;run;

data distance_goods;
merge address_goods(in=a) company_goods(in=b) address_gps(in=c) company_gps(in=d);
by apply_code;
if a;
run;

proc sort data=distance_goods nodupkey ;by apply_code;run;


proc sort data = dis_tance nodupkey; by apply_code; run;

**ƴ�����������ݣ��������ߵĲ���������䵽ǰ������;
data submart.every_distance;
merge dis_tance(in=a) distance_goods(in=b);
by apply_code;
if a;
if ag_distance="." then ag_distance=סַ��GPS����;
if jg_distance="." then jg_distance=��λ��GPS����;
drop rule_name_normal id main_info_id ���������·� ������������ סַ��GPS���� ��λ��GPS����;
run;

proc sort data = submart.every_distance nodupkey; by apply_code; run;


filename export "F:\����Demographics\csv\distance.csv" encoding='utf-8';
PROC EXPORT DATA= submart.every_distance
			 outfile = export
			 dbms = csv replace;
RUN;
