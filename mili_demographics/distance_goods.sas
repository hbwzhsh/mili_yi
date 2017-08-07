option compress = yes validvarname = any;
libname submart "D:\mili\Datamart\data";

***��������**�ջ���ַ;
proc sort data=submart.apply_flag nodupkey;by apply_code;run;
proc sort data=submart.ml_Demograph nodupkey;by apply_code;run;

data ds_data_jbgz;
merge submart.Bqsrule_jbgz_submart(in = a) submart.Bqsrule_jbgz_b_submart(in = b);
by apply_code;
if a;
run;
proc sort data = ds_data_jbgz; by apply_code; run;

data ds_data;
set ds_data_jbgz(keep = apply_code rule_name_normal memo id main_info_id rule_name ���������·� ������������);
if rule_name_normal="JBAA018_סַ���ջ��ؾ���С��100M" or 
rule_name_normal="JBAA019_��λ���ջ��ؾ���С��100M" or 
rule_name_normal="JBAA022_סַ���ջ��ؾ���С��200M" or
rule_name_normal="JBAA023_סַ���ջ��ؾ���С��300M" or 
rule_name_normal="JBAA024_סַ���ջ��ؾ���С��400M" or 
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
