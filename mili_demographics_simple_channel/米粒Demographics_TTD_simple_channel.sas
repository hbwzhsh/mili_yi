*************************************************************************************************************************
***TTD;

data benzi.ml_Demograph1_chanel1;
set bjb.ml_Demograph_simple;
if 申请提交日<=&dt.;
if 复贷申请^=1;
if 渠道标签=1;
run;
**得到复贷和新客户的数据集;
data  benzi.ml_Demograph1_chanel2;
set bjb.ml_Demograph_simple;
if 申请提交日<=&dt.;
if 复贷申请^=1;
if 渠道标签=2;
run;
*得到冠军的数据集;
data  benzi.ml_Demograph1_chanel3; 
set bjb.ml_Demograph_simple;
if 申请提交日<=&dt.;
if 复贷申请^=1;
if 渠道标签=3;
run;
*得到挑战者的数据集;
data benzi.ml_Demograph1_chanel4;
set bjb.ml_Demograph_simple;
if 申请提交日<=&dt.;
if 复贷申请^=1;
if 渠道标签=4;
run;


%macro demo_0(use_database,class_g,i);
%do n=1 %to &i.;

data var;
set var_name;
where id=&n.;
format var_name $45.;
call symput("var_name ",var_name);
run;
%put &var_name.;

data use0;
set &use_database.;
format &var_name. $45.;
if strip(&var_name.)="" then &var_name.="z-Missing";
run;

proc tabulate data=use0 out=demo_res_&n.(drop=_TYPE_ _PAGE_ _TABLE_ );
class &class_g. &var_name. /missing;
var input_complete;
table &var_name.
all,&class_g.*input_complete*(N);
run;
proc sort data=demo_res_&n.;by &var_name. &class_g.;run;
proc transpose data=demo_res_&n. out=demo_&n. prefix=a_;
/*where &var_name.  ne "";*/
by &var_name. ;
id &class_g.;
var input_complete_N;
run;

data demo_&n.;
set demo_&n.;
format Group $45.;
format variable $45.;
variable="&var_name.";
if &var_name.="" then group="小计";
else group=&var_name.;
drop _NAME_ &var_name.;
run;

%if &n=1 %then %do;
	data demo_res;
	set demo_&n.;
	run;
	%end;
%else %do;
	data demo_res;
	set demo_res demo_&n.;
	format variable $45.;
	run;
%end;
%end;
%mend;

x "F:\米粒Demographics简版\Monthly_Demographics(渠道1)_simple.xlsx";

**生成demo_res_ttd_all_auto;
%demo_0(use_database=benzi.ml_Demograph1_chanel1,class_g=申请提交月份,i=21);
data demo_res_ttd_chanel1;set demo_res;run;
proc sql;
create table demo_res_ttd_all_chanel1 as
select a.*,b.a_201612,b.a_201701,b.a_201702,b.a_201703,b.a_201704,b.a_201705,b.a_201706,b.a_201707 from var_name_left as a
left join demo_res_ttd_chanel1 as b on a.group=b.group and a.variable=b.variable;
quit;
proc sort data=demo_res_ttd_chanel1_auto ;by id;run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道1)_simple.xlsx]TTD!r5c3:r400c3';
data _null_;
set Work.demo_res_ttd_chanel1_auto;
file DD;
put a_201612;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道1)_simple.xlsx]TTD!r5c5:r400c5';
data _null_;
set Work.demo_res_ttd_chanel1_auto;
file DD;
put a_201701;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道1)_simple.xlsx]TTD!r5c7:r400c7';
data _null_;
set Work.demo_res_ttd_chanel1_auto;
file DD;
put a_201702;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道1)_simple.xlsx]TTD!r5c9:r400c9';
data _null_;
set Work.demo_res_ttd_all_auto;
file DD;
put a_201703;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道1)_simple.xlsx]TTD!r5c11:r400c11';
data _null_;
set Work.demo_res_ttd_all_auto;
file DD;
put a_201704;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道1)_simple.xlsx]TTD!r5c13:r400c13';
data _null_;
set Work.demo_res_ttd_all_auto;
file DD;
put a_201705;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道1)_simple.xlsx]TTD!r5c15:r400c15';
data _null_;
set Work.demo_res_ttd_all_auto;
file DD;
put a_201706;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道1)_simple.xlsx]TTD!r5c17:r400c17';
data _null_;
set Work.demo_res_ttd_all_auto;
file DD;
put a_201707;
run;


x "F:\米粒Demographics简版\Monthly_Demographics(渠道2)_simple.xlsx";

**demo_res_ttd_xz_auto;
%demo_0(use_database=benzi.ml_Demograph1_xz,class_g=申请提交月份,i=21);
data demo_res_ttd_xz;set demo_res;run;
proc sql;
create table demo_res_ttd_xz_auto as
select a.*,b.a_201612,b.a_201701,b.a_201702,b.a_201703,b.a_201704,b.a_201705,b.a_201706,b.a_201707 from var_name_left as a
left join demo_res_ttd_xz as b on a.group=b.group and a.variable=b.variable;
quit;
proc sort data=demo_res_ttd_xz_auto ;by id;run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道2)_simple.xlsx]TTD!r5c3:r400c3';
data _null_;
set Work.demo_res_ttd_xz_auto;
file DD;
put a_201612;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道2)_simple.xlsx]TTD!r5c5:r400c5';
data _null_;
set Work.demo_res_ttd_xz_auto;
file DD;
put a_201701;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道2)_simple.xlsx]TTD!r5c7:r400c7';
data _null_;
set Work.demo_res_ttd_xz_auto;
file DD;
put a_201702;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(米粒_新客户)_simple.xlsx]TTD!r5c9:r400c9';
data _null_;
set Work.demo_res_ttd_xz_auto;
file DD;
put a_201703;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道2)_simple.xlsx]TTD!r5c11:r400c11';
data _null_;
set Work.demo_res_ttd_xz_auto;
file DD;
put a_201704;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道2)_simple.xlsx]TTD!r5c13:r400c13';
data _null_;
set Work.demo_res_ttd_xz_auto;
file DD;
put a_201705;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道2)_simple.xlsx]TTD!r5c15:r400c15';
data _null_;
set Work.demo_res_ttd_xz_auto;
file DD;
put a_201706;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道2)_simple.xlsx]TTD!r5c17:r400c17';
data _null_;
set Work.demo_res_ttd_xz_auto;
file DD;
put a_201707;
run;

x "F:\米粒Demographics简版\Monthly_Demographics(渠道3)_simple.xlsx";

**demo_res_ttd_fd_auto;
%demo_0(use_database=benzi.ml_Demograph1_fd,class_g=申请提交月份,i=21);
data demo_res_ttd_fd;set demo_res;run;
proc sql;
create table demo_res_ttd_fd_auto as
select a.*,b.a_201612,b.a_201701,b.a_201702,b.a_201703,b.a_201704,b.a_201705,b.a_201706,b.a_201707 from var_name_left as a
left join demo_res_ttd_fd as b on a.group=b.group and a.variable=b.variable;
quit;
proc sort data=demo_res_ttd_fd_auto ;by id;run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道3)_simple.xlsx]TTD!r5c3:r400c3';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201612;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道3)_simple.xlsx]TTD!r5c5:r400c5';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201701;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道3)_simple.xlsx]TTD!r5c7:r400c7';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201702;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道3)_simple.xlsx]TTD!r5c9:r400c9';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201703;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道3)_simple.xlsx]TTD!r5c11:r400c11';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201704;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道3)_simple.xlsx]TTD!r5c13:r400c13';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201705;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道3)_simple.xlsx]TTD!r5c15:r400c15';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201706;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道3)_simple.xlsx]TTD!r5c17:r400c17';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201707;
run;

x "F:\米粒Demographics简版\Monthly_Demographics(渠道4)_simple.xlsx";

**demo_res_ttd_A_auto;
%demo_0(use_database=benzi.ml_Demograph1_A,class_g=申请提交月份,i=21);
data demo_res_ttd_A;set demo_res;run;
proc sql;
create table demo_res_ttd_A_auto as
select a.*,b.a_201706,b.a_201707 from var_name_left as a
left join demo_res_ttd_A as b on a.group=b.group and a.variable=b.variable;
quit;
proc sort data=demo_res_ttd_A_auto ;by id;run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道4)_simple.xlsx]TTD!r5c3:r400c3';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201612;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道4)_simple.xlsx]TTD!r5c5:r400c5';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201701;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道4)_simple.xlsx]TTD!r5c7:r400c7';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201702;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道4)_simple.xlsx]TTD!r5c9:r400c9';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201703;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道4)_simple.xlsx]TTD!r5c11:r400c11';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201704;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道4)_simple.xlsx]TTD!r5c13:r400c13';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201705;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道4)_simple.xlsx]TTD!r5c15:r400c15';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201706;
run;

filename DD DDE 'EXCEL|[Monthly_Demographics(渠道4)_simple.xlsx]TTD!r5c17:r400c17';
data _null_;
set Work.demo_res_ttd_fd_auto;
file DD;
put a_201707;
run;

