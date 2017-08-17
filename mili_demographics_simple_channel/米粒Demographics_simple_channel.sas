option compress = yes validvarname = any;
libname dpRaw "D:\mili\Datamart\rawdata\appdp";
libname dwdata "D:\mili\Datamart\rawdata\dwdata";
libname submart "D:\mili\Datamart\data";
libname bjb "F:\����Demographics\data";
libname benzi "F:\����demographics_simple_channel\data";
libname repayFin "F:\���������ձ���\data";

proc import datafile="F:\����Demographics���\����demo���ñ�_simple.xls"
out=var_name dbms=excel replace;
sheet="ά�ȱ���";
getnames=yes;
run;
proc import datafile="F:\����Demographics���\����demo���ñ�_simple.xls"
out=var_name_left dbms=excel replace;
sheet="ճ��ģ��";
getnames=yes;
run;

data _null_;
format dt yymmdd10.;
if year(today()) = 2004 then dt = intnx("year", today() - 6, 13, "same"); else dt = today() - 6;
call symput("dt", dt);
nt=intnx("day",dt,1);
call symput("nt", nt);
run;

data bjb.ml_Demograph_simple;
set bjb.ml_Demograph(keep=
apply_code
������
����ܾ�
�����ύ��
�����ύ��_g
�����ύ��
�����ύ����
�����ύʱ��
�����ύ�·�
����ͨ��
��˴�����
��˴�������
��˴����·�
��������
refuse_name
DEGREE_NAME
DEGREE_NAME_g
ID_CARD
JOB_COMPANY_CITY_NAME
JOB_COMPANY_PROVINCE_NAME
JOB_g
MARRIAGE_NAME_g
MONTH_SALARY_NAME
RESIDENCE_CITY_NAME
RESIDENCE_CONDITION_NAME
RESIDENCE_PROVINCE_NAME
SEX_NAME
SEX_NAME_group
app_total_cnt
app_type_cnt
apply_cnt_in1m
apply_cnt_in3m
apply_cnt_in7d
app��������
app��������
check_final
company_g
company_province_g
date_created
grp_cx_score
input_complete
last1m_callcnt_rate_in
last1m_callcnt_with_emergency
last1m_callplc_mostFreq
last3m_callcnt_with_emergency
last3m_callplc_mostFreq
last_record_time
loc_1mcnt_silent
loc_1mmaxcnt_silent
loc_3mcnt_silent
loc_3mmaxcnt_silent
loc_addresscnt
loc_addresscnt1
loc_appsl
loc_appsl_g
loc_ava_exp
loc_callcount
loc_calledcount
loc_inpast1st_calledtime
loc_inpast1st_calltime
loc_inpast2nd_calledtime
loc_inpast2nd_calltime
loc_inpast3rd_calledtime
loc_inpast3rd_calltime
loc_register_date
loc_tel_fm_rank
loc_tel_jm_rank
loc_tel_po_rank
loc_tel_py_rank
loc_tel_qs_rank
loc_tel_qt_rank
loc_tel_ts_rank
loc_tel_tx_rank
loc_tel_xd_rank
loc_tel_zn_rank
loc_tqscore
loc_txlsl
loc_txlsl_g
loc_zmscore
salary_g
user_code
��ĸ����
��Դ����
��ż����
��������
��������
��������
����ʱ��
����������
����ʱ��
�����·�
����ʱ��
�¾����ѽ��
�¾����ѽ������
֥�������
�����Ĭ����
������Ĭ����
��һ�Ĭ����
��һ��Ĭ����
loc_abmoduleflag
);
run;

**����������ǩ;
data bjb.ml_Demograph_simple_channel;
set bjb.ml_Demograph_simple;
if ��Դ���� in ("appstore","xiaomi") then ������ǩ=1;
else if ��Դ���� in ("oppo","yingyongbao","vivo","qihu360") then ������ǩ=2;
else if ��Դ���� in ("51kabao","taoqianbao","kuaiqiandai","mijisu","meizu","rongyijie") then ������ǩ=3;
else ������ǩ=4;
run;

