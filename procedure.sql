CREATE OR REPLACE PROCEDURE "SSIPMAS"."SP_CALC_BENEFITS"
(pexitdate varchar2,pps OUT number,pape OUT number, pnationalid varchar2,pclaimtype varchar2,pmonthlypension out number,
    pdlumpsum out number,pbentype out varchar2,ptotal out number,msg out varchar2,pinterest out number,preduction out number,pdoj varchar2,
    pdob varchar2, preceiveddate varchar, lumpsum out number, net_ps out number, pdeduct out number, vape out number, vps_before_com out number,
    vps_after_com out number,pdft varchar2, is_totalize varchar2,vredmon out number, payee number, pinclude number, v_reason number,isDeffered out varchar2,
    hasReduction out varchar2,reductionAmt out number, mem_age out number, resume_date out date, gov_exp_7 out number,psssf_exp_33 out number, crby number) IS
     
  vpf number(18,15);

v_c number;

vcf1 number;

vcf number;

vdoj date;

vdft date;

var_rv number;

vint number;

exitday number;

exitday2 number;

vage number;

fn_ape number;

vps number;

num date;

pcr1 number;

v_ed date;

vrf number;

vqp number;

contr_mon number;

vcr number;

lastday number;

vdob date;

vexitdate date;

real_vexitdate date;

vnra number;

vmra number;

vbeneficiary_dob date;

vsalary number;

v_m number;

vmonths number;

vreceiveddate date;

v_PF_OLD number;

v_CF_OLD number;

v_CR_OLD number;

v_COMMENCE_DATE date;

age_atcom number;

v_salmonth number;

v_salyear number;

v_fund number;

vpf1 number (18, 15);

vape1 number;

vape2 number;

vpf2 number;

pcr number;

pcr2 number;

pdlumpsum_2 number;

pdlumpsum_1 number;

pmonthlypension_1 number;

pmonthlypension_2 number;

vcf2 number;

bps number;

deduct number;

sumdeduct number;

vemployerid varchar2 (10);

vemp number;

vst number;

voluntary varchar2 (15);

vdep number;

v_half varchar2 (10);

mp number;

grat number;

depage number;

broken number;

sumbroken number;

pape1 number;

pape2 number;

amendApe number;

apeover12 number;

totalize date;

v_ape_ammend number;

aps number;

ppfcut date;

lapfcut date;

lapfstart date;

pspfcut date;

int1 number;

int2 number;

age_hire number;

vperiod number;

dateout date;

datein date;

vloan number;

pdate date;

intrate number;

loandays number;

totLoan number;

description varchar2 (50);

noScheme number;

descr varchar2 (50);

cont_no number;

hasBalance number;

commday number;

temp_period number;

d_temp date;

mon number;

interest number;

hasSpecial number;

memT varchar2 (100);

mindate date;

maxdate date;

dojday number;

V_VF_START_DATE date;

dojmonth number;

verify_tag number;

mem_status number;

advanceContr number;

stP number;

vddoj date;

exitMon number;

exitYear number;

stC number;

prev_cpg number;

curr_cpg number;

prev_mp number;

curr_mp number;

stPP number;

p_pdlumpsum_1 number;

p_pdlumpsum_2 number;

p_pmonthlypension_1 number;

mon_tempo number;

prev number;

p_vpf1 number;

p_pcr1 number;

p_vcf1 number;

p_pcr2 number;

v_ownerno number;

use_formula number;

p_pape1 number;

v_gaps number;

penalty number;

prev_scheme_ps number;

cur_scheme_ps number;

pscheme number;

v_tot_id number;

psssfps number;

v_ed2 date;

psumbroken number;

vemployer number;

psssf_scheme_ps number;

csumbroken number;

hasint number;

tot_contr number;

activeContr number;

vcurrent_fund varchar2 (100);

var_count number;

months_to_retire number;

V_RF number;

var_scheme number;

member_fund_start_date date;

gepfcut date;

v_NEW_CR number;

vodoj date;

v_cshrt number;

paid_une number;

une_exit_date date;

cat_id number;

hasLoan number;

hasDependant number;

lapf_provident date;

pspf_pension date;

transfer_to_nssf_date date;

cnt number;

nssfape number;

nssfps number;

psssfape number;

cscheme number;

cno varchar2 (40);

mat_benefit number;

v_tot VARCHAR2 (10);

psssfps number;

approve number;

apprvPenalty number;

num1 date;

end_date date;

v_PSSSF_START_DATE date;

v_contr_mon_psssf number;

loan_balance number;

v_haflcpg number;

m_cnt number;

v_NEW_CR_40 number;

v_NEW_CR_35 number;

one_month_check number;

count_trans number;

cursor c1 is
SELECT
    LOAN_AMOUNT,
    INT_RATE,
    PAID_DATE,
    DESCRIPTION
FROM LOAN
WHERE
    trim(national_id) = trim(pnationalid)
    AND RECOVERED = 0;

fin_rec c1 % rowtype;

cursor c2 is
SELECT COUNT(*) as PS, SCHEME
from CONTRIBUTION
where
    trim(national_id) = trim(pnationalid)
    and trim(status) = 'A'
group by
    scheme;

fin_rec1 c2 % rowtype;

BEGIN
cat_id:=0;prev:=0;use_formula:=0;
penalty:=0; p_pdlumpsum_2:=0;p_pmonthlypension_1:=0;
mem_status:=0;psumbroken:=0;csumbroken:=0;mat_benefit:=0;paid_une:=0;
stP:=0;prev_cpg:=0;curr_cpg:=0;prev_mp:=0;curr_mp:=0;
stC:=0;isDeffered:='N';hasReduction:='N';
stPP:=0;mat_benefit:=0;
dojmonth:=0;v_gaps:=0;
dojday:=0;
interest:=0;
vps:=0;
var_rv:=0;
preduction:=0;
pinterest:=0;
pmonthlypension:=0;
pdlumpsum:=0;
ptotal:=0;
sumdeduct:=0;
sumbroken:=0;
pdlumpsum_1:=0;
pdlumpsum_2:=0;
pmonthlypension_1:=0;
pmonthlypension_2:=0;
vps_before_com:=0;
vps_after_com:=0;
lumpsum:=0;
apeover12:=0;
aps:=0;
bps:=0;
v_fund := 0;
pinterest:=0;
vperiod:=0;
vloan:=0;
intrate:=0;
loandays:=0;
totLoan:=0;
vape:=0;
cont_no:=0;
hasBalance:=0;
temp_period:=0;
mon:=0;
mon_tempo:=0;
hasSpecial:=0;
vredmon:=0;
contr_mon:=0;
gov_exp_7:=0;psssf_exp_33:=0;
count_trans:=0;

totalize:= to_date('01/07/2014', 'dd/mm/rrrr');

pspfcut:=to_date('01/07/1999','dd/mm/rrrr');
lapfcut:=to_date('01/07/1991','dd/mm/rrrr');
lapfstart:=to_date('01/07/1986', 'dd/mm/rrrr');
ppfcut:=to_date('01/01/1994','dd/mm/rrrr');
gepfcut:=to_date('01/01/2001','dd/mm/rrrr');
lapf_provident:= to_date('01/07/2005','dd/mm/rrrr');
pspf_pension:= to_date('01/07/2004','dd/mm/rrrr');
transfer_to_nssf_date:=to_date('31/01/2019','dd/mm/rrrr');


--load basic paramaters
select PF,CF,QP,GR_INT,rf,cr,NRA,MRA,PF_OLD,CF_OLD,CR_OLD,COMMENCE_DATE,PSSSF_START_DATE,NEW_CR,RF, VF_START_DATE,NEW_CR_40,NEW_CR_35 into 
vpf,vcf,vqp,VINT,vrf,vcr,vnra,vmra,v_PF_OLD,v_CF_OLD,v_CR_OLD,v_COMMENCE_DATE,v_PSSSF_START_DATE, v_NEW_CR,V_RF, V_VF_START_DATE,v_NEW_CR_40,V_NEW_CR_35 from BENEFIT_PARAMETER where BP_ID=1;
        
        --use of owner number
        select OWNER_NO,nvl(SCHEME_TYPE,1), SCHEME, STATUS_ID,nvl(category_id,0),checkno,CURRENT_FUND, NVL(VR_TAG,0) into v_ownerno,var_scheme, v_fund, mem_status,cat_id,cno,vcurrent_fund, verify_tag from member where trim(national_id) =trim(pnationalid);   
         
        if verify_tag = 1 then
           msg:='This Claim need member scheme verification from Compliance before being processed :nsuccess';
           return;
        end if;
                
        --convert date format
        select to_date(pdoj,'dd/mm/rrrr') into vdoj from dual;
        select to_date(pdft, 'dd/mm/rrrr') into vdft from dual;
        select to_date(preceiveddate,'dd/mm/rrrr') into vreceiveddate from dual;
        select to_date(pdob,'dd/mm/rrrr') into vdob from dual;
        select to_date(pexitdate, 'dd/mm/rrrr') into vexitdate from dual;
        real_vexitdate:=vexitdate;
        
        if vexitdate < V_VF_START_DATE AND  pclaimtype = 'VFR'  then
           msg:='Benefit type selected is applicable before October 2022:nsuccess';
           return;
        end if;
       
        if pclaimtype not in ('DAS','RET','INV','SL','DTH', 'DFRT','VFR') then
           msg:='Benefit type selected is not applicable after July 2022:nsuccess';
           return;
        end if;
        
        if is_totalize = 'YES' and pclaimtype not in ('RET','INV','DTH','DFRT') then
           msg:='Benefit type selected is not eligible for Totalization:nsuccess';
           return;
        end if;
        
        select count(*) into m_cnt from claim_register where  trim(national_id)=trim(pnationalid) and is_reg = 0;
        
        if m_cnt = 0 then
           msg:='This Claim has not registered,Please register to proceed with payment!:nsuccess';
           return;
        end if;
        
        select count(*) into m_cnt from claim_register where  trim(national_id)=trim(pnationalid) and is_reg = 0 and is_manual <> 0;
        
        if m_cnt > 0 then
           msg:='Claim registered as Manual, you can not process as normal claim. Please check!:nsuccess';
           return;
        end if;
        
      --transfered to nssf and psssf only for DFRT, add walioletwa psssf: Massawe flag
        if pclaimtype= 'DFRT' and vcurrent_fund not in ('TRANSFERED_TO_NSSF','NSSF','PSSSF') and  is_totalize = 'YES' then
           msg:='Deffered Benefit is eligible for Transfered Members Only(PSSSF and NSSF):nsuccess';
           return;
        end if;
        
      --get member fund start_date
      case
        when v_fund = 1 then
             member_fund_start_date:= gepfcut;
        when v_fund = 2 then
             member_fund_start_date:= lapfcut;
        when v_fund = 3 then
             member_fund_start_date:= ppfcut;
        when v_fund = 4 then
             member_fund_start_date:= pspfcut;
        when v_fund = 5 then
             member_fund_start_date:= v_PSSSF_START_DATE;
        when v_fund = 7 then
             member_fund_start_date:= v_PSSSF_START_DATE;
      end case;
      
      if vdoj > member_fund_start_date then
          member_fund_start_date:=vdoj;
      end if;

      if var_scheme <> 2 and  pclaimtype = 'DAS' then
         msg:='The Member number is not eligible for DAS Benefit:nsuccess';
         return;
      end if;
                   
      if var_scheme = 2 and  pclaimtype <> 'DAS' then
         msg:='The Member number is eligible for DAS Only:nsuccess';
         return;
      end if;
              
   --convert date format
   select to_date(pdoj,'dd/mm/rrrr') into vdoj from dual;
   select to_date(pdft, 'dd/mm/rrrr') into vdft from dual;
   select to_date(preceiveddate,'dd/mm/rrrr') into vreceiveddate from dual;
   select to_date(pdob,'dd/mm/rrrr') into vdob from dual;
   select to_date(pexitdate, 'dd/mm/rrrr') into vexitdate from dual;
   
   real_vexitdate:=vexitdate;
        
   if mem_status in (2,3) then
      msg:='This Member is either Dormant or Exited, Check Member Status!:nsuccess';
      return;
   end if;
          
   select count(*) into deduct from SHORTTERM_CLAIM where trim(national_id)=trim(pnationalid) and trim(status)='A';
          
   if deduct > 0 then
      msg:='Member has Unpaid Short Term Benefit, Please Check!:nsuccess';
      return;
   end if;
          
   if cat_id in (1,2,5) and pclaimtype <> 'VFR' then
      msg:='This Member has suspended due to invalid Certificate,should be paid VF Refunds!:nsuccess';
      return;
   end if;
        
   if cat_id in (6) then
      msg:='This Member has suspended due to Court Order!:nsuccess';
      return;
   end if;
          
   if vreceiveddate > sysdate then
      msg:='Received Date can not be greater than Today:nsuccess';
      return;
   end if;
           
   if vdoj > sysdate Then
      msg:='Hire Date can not be greater than Today:nsuccess';
      return;
   end if; 
       
   if payee = '' or payee is null then
      msg:='Please select payee:nsuccess';
      return;
   end if;
   
   if payee = 2 then
      SELECT COUNT(*) INTO hasDependant FROM CLAIM_ADMIN_EMPLOYER WHERE NATIONAL_ID=trim(pnationalid);
       
      if hasDependant = 0 then
         msg:='Please add Employer Bank Details for payment:nsuccess';
         return;
      end if;
      
      select count(*) into noScheme from (SELECT COUNT(*)  from CONTRIBUTION where OWNER_NO=v_ownerno 
      and trim(status)='A' group by scheme);
      
      if noScheme > 1 and  is_totalize = 'NO' then
         msg:='Please confirm members scheme OR member should be paid Totalization, contribution should have same scheme:nsuccess';
         return;
      end if;        
      
      --handle % based on status id
      select count(*) into stP from CLAIM_ADMIN_EMPLOYER where trim(national_id)=trim(pnationalid);
      
      if stP > 1 then
          msg:='There is duplicate Employer Bank Details assigned to this Member, Please remove duplicate:nsuccess';
          return;
      end if;
   end if;
   
 --payee is survivor must add Dependants for Underpayment
   if payee = 4 then
          
      SELECT COUNT(*) INTO hasDependant FROM DEPENDANT WHERE NATIONAL_ID=trim(pnationalid) AND IS_UNDERPAYMENT=0;
          
      if hasDependant = 0 then
         msg:='Please add Dependant for Death payment:nsuccess';
         return;
      end if; 
      
      SELECT COUNT(*) INTO hasDependant FROM CLAIM_ADMIN_MEMBER WHERE NATIONAL_ID=trim(pnationalid);
      
      if hasDependant > 0 then
         msg:='Please remove added Administrator to proceed, You select as Payee Survivor';
         return;
      end if;
      
        --handle % based on status id
       select sum(AWARDED_PERCENT) into stP from dependant where trim(national_id)=trim(pnationalid);
        
       if stP < 100 or stP > 100 then
          msg:='The Percentage of Gratuity must be 100%:nsuccess';
          return;
       end if;
       
   end if;
        
   if payee = 3 then
      SELECT COUNT(*) INTO hasDependant FROM DEPENDANT WHERE NATIONAL_ID=trim(pnationalid) and IS_UNDERPAYMENT = 0;
         
      if hasDependant > 0 then
         msg:='Please remove added dependant to proceed, You select Payee as Administrator';
         return;
      end if;
      
      SELECT COUNT(*) INTO hasDependant FROM CLAIM_ADMIN_MEMBER WHERE NATIONAL_ID=trim(pnationalid);
       
      if hasDependant = 0 then
         msg:='Please add Administrator for Death payment:nsuccess';
         return;
      end if;
      
      --handle % based on status id
      select count(*) into stP from CLAIM_ADMIN_MEMBER where trim(national_id)=trim(pnationalid);
      
      if stP > 1 then
         msg:='There is duplicate Administrator assigned to theis Member, Please remove duplicate:nsuccess';
         return;
      end if; 
   end if;
    
   lastday:=to_number(to_char(last_day(vexitdate),'dd'));
   exitday:=to_char(vexitdate,'dd'); 
   exitday2:=to_char(vexitdate,'dd');  
   dojday:=to_char(vdoj,'dd');
   dojmonth:=to_char(vdoj,'mm');
   
   v_ed:=to_date(lastday||'/'||to_char(vexitdate,'mm')||'/'||to_char(vexitdate,'rrrr'),'dd/mm/rrrr');--exit date formatted
   vage:=months_between(vexitdate,vdob)/12;--age at retirement
   age_atcom :=floor(months_between(v_COMMENCE_DATE,vdob)/12);--age at commencement
   age_hire:=floor(months_between(vdoj,vdob)/12); --age at hiredate
   mon:=floor(months_between(vdoj,vdob)); --months at hiredate
   
   one_month_check:= months_between(vexitdate,sysdate);
   
   if one_month_check > 1 then
      msg:='System allows processing of claim one month before member retirement date:nsuccess';
      return;
   end if;
   
   if is_totalize ='YES' then
   
      SELECT COUNT(*) into cnt FROM CLAIM_TOTALIZATION WHERE trim(NATIONAL_ID)=trim(pnationalid) and STATUS='A';
        
      if cnt > 0 then 
         --ps and ape for computation
         SELECT TOT_ID,PREVIOUS_SCHEME_PS,CURRENT_SCHEME_PS,PREVIOUS_SCHEME,CURRENT_SCHEME,APE_NSSF
         INTO v_tot_id,prev_scheme_ps,cur_scheme_ps,pscheme,cscheme,nssfape FROM CLAIM_TOTALIZATION WHERE trim(NATIONAL_ID)=trim(pnationalid) AND STATUS='A';
      else
         IF NOT c2%ISOPEN THEN
             OPEN c2;
         END IF;
                                         
         FETCH c2 INTO fin_rec1;
                    
         WHILE c2%FOUND LOOP
               count_trans:=count_trans + 1;
               
               if count_trans = 1 then         
                  INSERT INTO CLAIM_TOTALIZATION(NATIONAL_ID,PREVIOUS_SCHEME,APE_NSSF,PREVIOUS_SCHEME_PS,CRBY,IS_UNDERPAYMENT) VALUES(pnationalid,fin_rec1.SCHEME,0,fin_rec1.PS,crby,0);
                  commit;
               else
                  UPDATE CLAIM_TOTALIZATION SET CURRENT_SCHEME_PS=fin_rec1.PS,CURRENT_SCHEME=fin_rec1.SCHEME
                  WHERE trim(NATIONAL_ID)=trim(pnationalid) AND STATUS='A' and processed_status = 'A';
                   
               commit;
               end if;
               
               v_fund:=fin_rec1.SCHEME;
                
              FETCH c2 INTO fin_rec1;
         END LOOP;

         CLOSE c2;    
      end if;
   end if;
       
   --HANDLE LAPF OPEN BALANCE PERIOD: LAPF Less than 91
   if v_fund = 2 and vdoj < lapfcut then
     
       --check if has ps balance
       SELECT COUNT(*) into hasBalance FROM LAPF_OPEN_BALANCE WHERE trim(NATIONAL_ID)=trim(pnationalid);
        
       if hasBalance > 0 then
          --check if hired before 86
          if vdoj < lapfstart then
             --lapfstart:86
                  
             --check waveout: special case (Approved from hazina to be paid before 86)
             SELECT count(*) INTO apprvPenalty FROM CLAIM_120_PENSIONABLE WHERE NATIONAL_ID=pnationalid and HAZINA_FLAG=1;
                        
             if apprvPenalty > 0 then
                vdoj:= vdoj;
             else
                vdoj:= lapfstart;
             end if;
   
          else
             vdoj:=vdoj;
          end if;
       else
          --lapfcut:91
          vdoj:=lapfcut;
       end if;
   end if;
       
     --handle child service period
     if age_hire < 18 and v_fund in (1,2,4) then
         --add broken service (dateout, datein, period, remark)
          vperiod:= 216 - mon; --Child period       
          dateout:=vdoj;
          datein:=add_months(vdoj, vperiod);
            
        INSERT INTO BROKEN_SERVICE(NATIONAL_ID,DATE_OUT,DATE_IN, BPERIOD, REASON, TYPE) VALUES (trim(pnationalid),dateout,datein,vperiod,'Under Age', 2);
     end if;
        
       --handle TEMPORARY SERVICE
       if vdoj < vdft then
          select count(*) into mon_tempo from BROKEN_SERVICE where NATIONAL_ID = pnationalid and type = 2 and reason = 'Under Age';
            
          vodoj:=vdoj;
             
          if mon_tempo > 0 then
        
             select DATE_IN into vodoj from BROKEN_SERVICE where NATIONAL_ID = pnationalid and type = 2 and reason = 'Under Age'; 
                  
             if vodoj <= vdft then
                vodoj:=vodoj;
             else
                vodoj:=vdoj;
             end if; 
          end if;
               
          mon_tempo:=floor(months_between(vdft,vodoj)/2); --months to fin tempo /2
             
          vperiod:=mon_tempo;
                
          dateout:=vodoj;
          datein:=vdft;
            
          if is_totalize = 'YES' then
             v_tot:='Y';
          else
             v_tot:='N';
          end if;
                
          INSERT INTO BROKEN_SERVICE(NATIONAL_ID,DATE_OUT,DATE_IN, BPERIOD, REASON, TYPE, IS_TOT) VALUES (trim(pnationalid),dateout,datein,vperiod,'Temporary Service', 2,v_tot);
       end if;
                   
       --handle HOUSE LOAN from pspf, lapf, gepf
       SELECT COUNT(*) INTO vloan FROM LOAN WHERE trim(national_id)=trim(pnationalid) AND DESCRIPTION <> 'MATERNITY';
        
       if vloan > 0 and pclaimtype not in ('VFR') then
          v_half:='N';
            
          IF NOT c1%ISOPEN THEN
             OPEN c1;
          END IF;
                             
          FETCH c1 INTO fin_rec;
                    
          WHILE c1%FOUND LOOP
            interest:=0;
            totLoan:=0;
            vloan:=0;
            loandays:=0;
            hasLoan:=0;
            
            pdate:=fin_rec.PAID_DATE;
            intrate:=fin_rec.INT_RATE;
            vloan:=fin_rec.LOAN_AMOUNT;
            description:=fin_rec.DESCRIPTION;
            
           if description = 'HOUSE LOAN' then
             
              hasLoan:= 1;
              select to_date(pdate, 'dd/mm/rrrr') into pdate from dual; 
                 --interext
              select trunc(to_date(vexitdate, 'dd-mm-yyyy')) - to_date(pdate, 'dd-mm-yyyy') into loandays from dual; 
                  
              loandays:=loandays + 1; 
                
              if v_fund = 2 then 
                 interest:= ((((intrate/100)*vloan)/365.25)*loandays);
              else  
                 interest:= ((((intrate/100)*vloan)/365)*loandays);
              end if;
                  
              totLoan:= vloan + interest;
                
              v_half:='Y';
                            
            end if;
            
            if description='PLOT AND HOUSE RENT' then 
               hasLoan:= 1;
               totLoan:= vloan; 
            end if;
            
           -- if v_fund = 1 then 
              -- hasLoan:= 1;
               --totLoan:=vloan; 
           -- end if;
            
            if hasLoan = 0  then
               totLoan:=vloan;
            end if;
            
            INSERT INTO DEDUCTION(NATIONAL_ID,DEBTOR,DESCRIPTION,AMOUNT,TYPE,PAID_LOAN,INTEREST_AMT,LOAN_DAYS, DEDUCTION_CATEGORY,IS_HALF) 
            VALUES (trim(pnationalid),'DG PSSSF',description,totLoan,2,vloan,interest,loandays,1,v_half);   
                
            COMMIT;
         
            FETCH c1 INTO fin_rec;
            END LOOP;
            
            CLOSE c1;  
        end if;
        
        SELECT COUNT(*) INTO v_cshrt from shortterm_claim where national_id = pnationalid and BENEFITID in ('UNE','MAT');-- AND STATUS IN('V','P');
        
        --paid unemployement
        if v_cshrt > 0 then
         
           --has contribution after exit
           SELECT COUNT(*) INTO v_cshrt from shortterm_claim where national_id = pnationalid and BENEFITID in ('UNE');
           if v_cshrt > 0 then
              select STARTDATE into une_exit_date from shortterm_claim where national_id=pnationalid and BENEFITID='UNE';-- AND STATUS IN('V','P');
               
              select count(*) into v_cshrt from contribution where OWNER_NO=v_ownerno and status='A' and
              to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy')>= une_exit_date;
           else
              v_cshrt:=1; --no une
           end if;
           
            if v_cshrt = 0 and vage < vnra and pclaimtype <> 'DFRT' then
             
               msg:='Member has no Contribution after payment of Unemployment, not eligible for Long term Benefit:nsuccess';
               return;
              
            end if;
           
            --inPayroll and short-term: Establish deduction   
            SELECT COUNT(*) INTO v_cshrt FROM UNEMPLOYMENTAPPROVAL WHERE NATIONAL_ID = pnationalid and nvl(AMOUNT,0) > 0; 
              
            --Payroll amount
            if v_cshrt > 0 then
               SELECT nvl(sum(AMOUNT),0) INTO paid_une FROM UNEMPLOYMENTPAYROLL WHERE trim(national_id) =trim(pnationalid) AND nvl(AMOUNT,0) > 0;-- AND ISPAID='Y' AND UNCLAIMED IS NULL ;
               descr:='Unemployment Paid';
            else
               SELECT nvl(sum(AMT),0) INTO paid_une FROM shortterm_claim WHERE trim(national_id) =trim(pnationalid) AND  BENEFITID in ('UNE','MAT');-- and STATUS IN('V','P');
               descr:='Maternity Paid';
            end if; 
          
            if pclaimtype not in ('RET','DTH', 'INV', 'VFR') then
               
               INSERT INTO DEDUCTION(NATIONAL_ID,DEBTOR,DESCRIPTION,AMOUNT,TYPE,PAID_LOAN,INTEREST_AMT,LOAN_DAYS,DEDUCTION_CATEGORY) 
               VALUES (trim(pnationalid),'DG PSSSF',descr,paid_une,2,paid_une,0,0,1);       
               COMMIT;
            end if;
         
        end if; 
          
        select count(*) into broken from broken_service where trim(national_id)=trim(pnationalid) and ispaid=0;
        
        --sum broken ps
        if broken > 0 then
         
            if is_totalize ='YES' then
              select nvl(sum(bperiod),0) into psumbroken from broken_service where trim(national_id)=trim(pnationalid) and ispaid=0 and is_previous_scheme='Y';
              select nvl(sum(bperiod),0) into csumbroken from broken_service where trim(national_id)=trim(pnationalid) and ispaid=0 and is_previous_scheme='N';
            else
              select nvl(sum(bperiod),0) into sumbroken from broken_service where trim(national_id)=trim(pnationalid) and ispaid=0;
            end if;
           
        end if;
        
        select count(*) into deduct from deduction where trim(national_id) = trim(pnationalid) and ispaid = 0;
        
        --sum deduction 
        if deduct > 0 then
        
           select NVL(sum(amount),0) into totLoan from deduction where trim(national_id) = trim(pnationalid) and IS_HALF='Y';
           select NVL(sum(amount),0) into sumdeduct from deduction where trim(national_id) = trim(pnationalid) and ispaid = 0 and IS_HALF='N';
        
        end if;
        
      pdeduct:= sumdeduct + totLoan;
        
      --handle penalty
      if v_fund in (3, 5, 7)  then
         select count(*) into penalty from contribution where OWNER_NO=v_ownerno and HASPENALTY=1
         and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy') <= vexitdate and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy') >= vdoj; 
      else
         select count(*) into penalty from contribution where OWNER_NO=v_ownerno and HASPENALTY=1
         and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy') <= vexitdate and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy') >= v_PSSSF_START_DATE; 
      end if;
       
     -- pdeduct:=sumdeduct;
       
     --handle special case: POLICE, PRISON, JUDGE, PROF AND SPECIALIST     
     SELECT COUNT(*) INTO vemp FROM MEMBER where OWNER_NO=v_ownerno and TITLE IS NOT NULL;
      
      --member has title
      if vemp > 0 then 
         SELECT trim(TITLE) INTO memT FROM MEMBER where OWNER_NO=v_ownerno;
         SELECT COUNT(*) INTO hasSpecial FROM CLAIM_TITLE WHERE TITLE=memT;
            
         if hasSpecial > 0 then 
            if hasSpecial > 1 then
               msg:='There is More than one Title, Contact System Administrator:nsuccess';
               return;
            end if;
            SELECT COMP, VOL INTO vmra, vnra FROM CLAIM_TITLE WHERE  TITLE=memT;
               
         end if;       
     end if;
      
    if vage > 59.993 and vage < 60 and vmra = 60 then
       vage:= 60;
    elsif vage > 64.993 and vage < 65 and vmra = 65 then
       vage:= 65;
    elsif vage > 54.993 and vage < 55 and vmra = 55 then
       vage:= 55;
    elsif vage > 49.5 and vage < 50 and vmra = 50 then
       vage:= 50;
    else
       vage:= floor(months_between(vexitdate,vdob)/12);--age at retirement
    end if;
    
     mem_age:=vage;
     
    if pclaimtype not in ('VFR','SL') then
       select date_of_birth + numtoyminterval(vnra,'year') into resume_date from member where OWNER_NO=v_ownerno;
    end if;
      
     --handle special case: POLICE, PRISON, JUDGE, PROF AND SPECIALIST     
     --handle nssf transfered members
    if vcurrent_fund='TRANSFERED_TO_NSSF' and vexitdate > transfer_to_nssf_date  then
       vexitdate:=transfer_to_nssf_date;
    end if;
     
    select count(*) into activeContr from contribution where OWNER_NO=v_ownerno and trim(status) = 'A' and transact is null and open_flag is null
    and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy')<= vexitdate and to_date('27/'||SALmonth||'/'||SALyear,'dd/mm/yyyy')>= member_fund_start_date;
    
    select count(*) into v_gaps from contribution where OWNER_NO=v_ownerno and trim(status) = 'S' and transact is null and open_flag is null
    and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy')<= vexitdate and to_date('27/'||SALmonth||'/'||SALyear,'dd/mm/yyyy')>= member_fund_start_date;
     
    if activeContr < 1 then
       msg:='No Contribution Found for this Member until his Exit:nsuccess';
       return;
    end if;  
    
    -- CONTR_STATUS, SALMONTH, SALYEAR
    select count(*) into advanceContr from ADVANCE_CREDITS where OWNER_NO=v_ownerno and trim(CONTR_STATUS) = 'A'
    and to_date('15/'||SALMONTH||'/'||SALYEAR,'dd/mm/yyyy')<= vexitdate;
    
    --flag used advanced contribution
    if advanceContr > 0 then
       update ADVANCE_CREDITS set BENEFIT_STATUS = 1, BENEFIT_DATE=SYSDATE where OWNER_NO=v_ownerno and to_date('15/'||SALMONTH||'/'||SALYEAR,'dd/mm/yyyy') <= vexitdate;
       commit;
    end if;
       
    if vdoj < member_fund_start_date then
       vps:= FN_PS(member_fund_start_date,vdoj,pinclude);
    end if;
    
    if vps < 0 then
       vps:= 0;
    end if;
    
    if vdoj < member_fund_start_date and v_fund in (5,7) and vps > 180 and is_totalize = 'NO' then
       msg:='Member must be paid Totalization:nsuccess';
       return;
    end if;
     
    if is_totalize = 'NO' then   
       pps:= vps + activeContr + v_gaps + advanceContr; 
       vps:= vps + activeContr + advanceContr - penalty - sumbroken;
      
    else
       vps:= FN_PS(real_vexitdate,vdoj,pinclude);
       pps:=vps;
    end if;
    
    net_ps:=vps;
    
    --handle transferd to NSSF    vcurrent_fund='TRANSFERED_TO_NSSF' and 
    if is_totalize = 'YES' then
       if vage < vnra AND pclaimtype= 'RET' then
          msg:='This Member age must be attain Retirement Age for Totalization:nsuccess';
          return;
       end if;
    end if;
       
    --handle received from NSSF
    --handle scheme 7 this is for totalization
    if is_totalize = 'NO' and v_fund = 7 and pclaimtype <> 'WTD' then
       if activeContr < 13 then
          msg:='Member will be Paid with NSSF, Contribution should be transfered for Payment:nsuccess';
          return;
       end if;
    end if;
    
    --changes start here   
    vpf1:= 1/vpf; --1/580
    vcf1:= vcf; 
   
    if v_fund in (2,4) or vemployer in(1004068,1011813) then
    --LAPF AND PSPF
        pcr1:= v_NEW_CR_40; 
        pcr2:= 1 - v_NEW_CR_40;
    else
    --OTHERS FUNDS
        pcr1:= v_NEW_CR_35; 
        pcr2:= 1 - v_NEW_CR_35;
    end if;
    
    --changes ends here
    
    if is_totalize = 'NO' then
       if advanceContr > 0 then
          delete from APE_CONTRIBUTION_TOTOALIZATION where OWNER_NO = v_ownerno;
          COMMIT;
                            
          INSERT INTO APE_CONTRIBUTION_TOTOALIZATION (NATIONAL_ID,OWNER_NO,SALMONH,SALYEAR,APESALARY,ARREARS,STATUS)
          (select * from  (select NATIONAL_ID,OWNER_NO,SALMONTH,SALYEAR,nvl(APESALARY,0),nvl(ARREARS,0),STATUS
          from  VW_CONTR_ADVANCED_CREDIT where OWNER_NO = v_ownerno  order by salyear desc,salmonth desc) 
          where rownum <= 120);
          COMMIT;
                      
          vape1:=FN_CALC_APE_TOTALIZE(pnationalid,vexitdate);
      else      
          vape1:=fn_ky(v_ownerno,vexitdate);
      end if;
    end if;
                    
    --vape1:=fn_ky(v_ownerno,vexitdate);
    vape:=vape1;
    pape1:=vape1;
    pape:=vape1;
    pape2:=pape1;
    
     SELECT count(*) INTO approve FROM CLAIM_120_PENSIONABLE WHERE NATIONAL_ID=pnationalid and ISAPPROVE=1;
          
          if approve > 0 then
             vqp:=120;
          end if;
       
       --handle less than 180 after deduction of penalty and broken service  
        if net_ps < 180 then
           if  net_ps  < 121 and approve > 0 then
               if pps >= 120 then
                   use_formula:= 1;
               end if;
           else
               if pps >= 180 then
                   use_formula:= 1;
               end if;
           end if;
       end if;
     
   --controll totalization:LATER BE HANDLED    
   if is_totalize = 'YES' then
    
          net_ps:=net_ps - psumbroken - csumbroken - penalty;
           
          psssf_scheme_ps:=vps - prev_scheme_ps - csumbroken;
           
          prev_scheme_ps:=prev_scheme_ps - psumbroken;
           
         --not taken to fn_ben_controll  
          if pps < 180 then
             msg:='Member with less than 180 Credits, Does not Qualify for Totalization:nsuccess';
             return;
          end if;
          
         cont_no:=cnt + activeContr + advanceContr;
        
         select count(*) into v_ape_ammend from CLAIM_CONTRIBUTION_NSSF_TRAIL where OWNER_NO = v_ownerno;
                  
         if v_ape_ammend = 0 then
                     
              delete from APE_CONTRIBUTION_TOTOALIZATION where OWNER_NO = v_ownerno;
              COMMIT;
                     
              INSERT INTO APE_CONTRIBUTION_TOTOALIZATION (NATIONAL_ID,OWNER_NO,SALMONH,SALYEAR,APESALARY,ARREARS,STATUS)
              (select * from  (select NATIONAL_ID,OWNER_NO,SALMONTH,SALYEAR,nvl(APESALARY,0),nvl(ARREARS,0),STATUS
              from  VW_CONTR_TOTOALIZATION where OWNER_NO = v_ownerno  order by salyear desc,salmonth desc) 
              where rownum <= 120);
                     
              COMMIT;
                        
           end if;

           if cscheme = 7 then
              
            if v_ape_ammend = 0 then
               vape1:=nssfape;
            else
              select SUM(APESALARY) INTO vape1 from APE_CONTRIBUTION_TOTOALIZATION where OWNER_NO = v_ownerno and FROM_NSSF='Y';
               
              vape1:=(vape1*12)/36;
            end if;
             
              pape1:=vape1;
              pape2:=pape1;
              pape:=pape1;
           else
                   
                 --APE: Prev PSSSF (APE from PSSSF)
               if is_totalize = 'YES' and  vexitdate < v_PSSSF_START_DATE then
                  vape1:=fn_60_ape(pnationalid,vexitdate);
               else
                 
                  vape1:=FN_CALC_APE_TOTALIZE(pnationalid,vexitdate);
               end if;
                        
               pape1:=vape1;
               pape:=vape1;
               pape2:=p_pape1;
               
           end if;
           
           --previous fund formula factors: ppf, nsssf, psssf
           if pscheme in (1,2,3,4,5,7) or cscheme in (7) then
               prev:= 1;
              
               p_vpf1:= 1/vpf;
               p_vcf1:= vcf; 
               
               if pscheme in (2,4) then
                  p_pcr1:= v_NEW_CR_40;
                  p_pcr2:= 1 - v_NEW_CR_40; 
               else
                  p_pcr1:= v_NEW_CR_35;
                  p_pcr2:= 1 - v_NEW_CR_35; 
               end if;
               
           else
               prev:=1;
               p_vpf1:=1/v_PF_OLD;
               p_pcr1:=0.5;
               p_vcf1:= v_CF_OLD;--15.5 
           end if;
       end if;
       
          
   --Retirement age as per sector 
   if  pclaimtype = 'RET' Then

      if vage > vmra then
         msg:='Member age exceeded Compulsory Retirement age:nsuccess';
         return;
      end if;
             
      if hasSpecial > 0 and  vemployer in(1004068,1011813) then
         
         contr_mon:= floor(months_between(vexitdate,vdoj)/12); --period in service   
         
         if contr_mon >= 25 and vage < vnra then
            vage:=vnra;
         end if;
       
      end if;
                      
      --controll retirement age: below nra
      if vage < vnra then
          msg:='Member age is not eligible for Retirement Benefit!:nsuccess';
          return;  
      end if;
         
      if net_ps >= vqp or use_formula = 1 then
                     
         if vage < vmra  then
             voluntary:='Voluntary';
         else
             voluntary:='Compulsory';
         end if;  
                           
            pdlumpsum_1:=(vpf1)*net_ps*pape1;
                        
            pdlumpsum_2:=(pdlumpsum_1*pcr1)*vcf1;
                        
            pmonthlypension_1:= pdlumpsum_1 * pcr2/12;
                      
            if is_totalize = 'YES' and prev=1 then
                            
               p_pdlumpsum_1:=(p_vpf1)*net_ps*pape1;
                        
               p_pdlumpsum_2:=(p_pdlumpsum_1*p_pcr1)*p_vcf1;
                              
               p_pmonthlypension_1:= p_pdlumpsum_1 * p_pcr2/12;
                           
            end if;
                   
                        --total lumpsum
            lumpsum:= pdlumpsum_2 + p_pdlumpsum_2;
                        --net lumpsum and total monthly pension
            pdlumpsum:=lumpsum - sumdeduct;
                        
            pmonthlypension:= pmonthlypension_1 + p_pmonthlypension_1;

             if vage < vmra  then
                         
               hasReduction:='Y';
               months_to_retire:= (vmra - vage)*12;
                        
               reductionAmt:= pmonthlypension - (pmonthlypension * V_RF * months_to_retire);
             end if;
          
            pbentype:=voluntary || ' Retirement';
                    
            msg:='Old Age Benefit Processed Successfull:success';
      else 
               
            pmonthlypension:=0;
                    
            if vage < vmra then
               voluntary:='Voluntary';
            else
               voluntary:='Compulsory';
            end if;                                    
                   
            v_fund:=5;
            
            pdlumpsum:=FN_WITHDRWAL_LAPF_GEPF(v_ownerno,v_fund,vexitdate,vdoj);
            
            SELECT nvl(sum(interest),0) into pinterest FROM CLAIM_TABLE_TEMP where owner_no =v_ownerno;        
                   
            lumpsum:=pdlumpsum;
            pdlumpsum:= lumpsum - sumdeduct;
                 
            pbentype:=voluntary || ' Retirement';                   
            msg:='Old Age Benefit Processed Successfull:success';  
      end if;
   end if; 
     
   if  pclaimtype = 'SL' then
      
       if v_reason is null or v_reason ='' then
          msg:='Please select Reason for Benefit Type:nsuccess';
          return;
       end if;
     
         --foreigner and imigration
       if v_reason not in (5,7,23) and net_ps > vqp then
          msg:='Member is qualifying for Deffered Benefit with reason PS is Above 180 :nsuccess';
          return;
       end if;
         
         --above 45 and age is below
       if v_reason = 4 and age_hire < 45 then
          msg:='Member is not Qualifying for this Category :nsuccess';
          return;
       end if;
      
       --reason should be as described
       v_fund:= 5; pmonthlypension:= 0;
                
            
       if v_reason = 23 then
            --pay total contribution
           select nvl(sum(total_contribution),0) into pdlumpsum from contribution where owner_no =v_ownerno and trim(status)='A'  and transact is null and open_flag is null
           and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/rrrr')<= vexitdate and transact is null and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy') >= member_fund_start_date;
           
       else
           pdlumpsum:=FN_WITHDRWAL_LAPF_GEPF(v_ownerno,v_fund,vexitdate,vdoj);
          
        
           SELECT nvl(sum(interest),0) into pinterest FROM CLAIM_TABLE_TEMP where owner_no =v_ownerno;
          -- pinterest:= pdlumpsum - lumpsum; 
               
       end if;
           
       lumpsum:= pdlumpsum;
       pdlumpsum:= lumpsum - sumdeduct - mat_benefit;
         
       pbentype:='Special Lumpsum';   
           
       msg:='Special Lump Sum Processed Successfull:success';  
   end if;
    
   if pclaimtype = 'DFRT' then
   
      if v_reason is null or v_reason ='' then
          msg:='Please select Reason for Benefit Type:nsuccess';
          return;
       end if;
    
      if vage > vnra then
         msg:='Member age is not eligible for Deffered Benefit:nsuccess';
         return;
      end if;
      
      if v_reason not in(14,9,10,11,12,13) then
         msg:='Member is not eligible for Deffered Benefit:nsuccess';
         return;
      end if;
              if net_ps < vqp then
         msg:='Member with less than 180 are eligible for Special Lumpsum:nsuccess';
         return;
      end if;
        
      isDeffered:='Y';
      hasReduction:='Y';
        
      --formula
      pdlumpsum_1:=(vpf1)*net_ps*pape1;
                        
      --after commerce
      pdlumpsum_2:=(pdlumpsum_1*pcr1)*vcf1;
                        
      pmonthlypension_1:= pdlumpsum_1*pcr2/12;
        --total lumpsum
      lumpsum:= pdlumpsum_2 + p_pdlumpsum_2;
        --net lumpsum and total monthly pension
      pdlumpsum :=lumpsum - sumdeduct;
                        
      pmonthlypension:= pmonthlypension_1 + p_pmonthlypension_1;
          
      months_to_retire:= (vmra - vage)*12;
                        
      reductionAmt:= pmonthlypension - (pmonthlypension * V_RF * months_to_retire);
          
      pbentype:='Deffered Retirement';   
           
      msg:='Deffered Retirement Processed Successfull:success';  
       
   end if;
    
     
   if pclaimtype = 'INV' then
      if vage > vmra then
         msg:='Member age exceeded Compulsory Retirement age:nsuccess';
         return;
      end if;
         
      if vage >= vnra then
         msg:='Member is eligible for Retirement Benefit:nsuccess';
         return;
      end if;
       
      select to_date(vexitdate,'dd/mm/rrrr')-365 into num from dual;
       
      select count(*) into v_contr_mon_psssf from contribution where OWNER_NO = v_ownerno  and transact is null and open_flag is null
      and trim(status)='A' and to_date('27/'||SALmonth||'/'||SALyear,'dd/mm/rrrr') >= num and
      to_date('01/'||SALmonth||'/'||SALyear,'dd/mm/rrrr') <= vexitdate;
      
      if v_contr_mon_psssf < 12  then
         msg:='Member must be Contributing for 12 months consecutively prior exit date for Invalidity Benefit:nsuccess';
         return;
      end if;  
         
      if net_ps >= 36 or use_formula=1 then
                             
          pdlumpsum_1:=(vpf1)*net_ps*pape1;
                        
          pdlumpsum_2:=(pdlumpsum_1*pcr1)*vcf1;
                       
          pmonthlypension_1:= pdlumpsum_1*pcr2/12;
          
          if is_totalize = 'YES' and prev=1 then
                            
             p_pdlumpsum_1:=(p_vpf1)*net_ps*pape1;
                        
             p_pdlumpsum_2:=(p_pdlumpsum_1*p_pcr1)*p_vcf1;
                        
             p_pmonthlypension_1:= p_pdlumpsum_1 * p_pcr2/12;
                        
          end if;
                        
          --total lumpsum
          lumpsum:= pdlumpsum_2 + p_pdlumpsum_2;
                        --net lumpsum and total monthly pension
          pdlumpsum :=lumpsum - sumdeduct;
                        
          pmonthlypension:= pmonthlypension_1+p_pmonthlypension_1;
                      
          if (pape1 * 0.3)/12 > pmonthlypension then
              pmonthlypension:=(pape1 * 0.3)/12;
          end if;
            
          pbentype:='Invalidity Retirement';
            
          msg:='Invalidity Benefit Processed Successfull:success';
       else 
               
           pmonthlypension:=0;
            
           v_fund:= 5;
                 
           pdlumpsum:=FN_WITHDRWAL_LAPF_GEPF(v_ownerno,v_fund,vexitdate,vdoj);
                     
           select nvl(sum(total_contribution),0) into lumpsum from contribution where owner_no =v_ownerno and trim(status)='A' and open_flag is null
           and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/rrrr')<= vexitdate and transact is null and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy') >= member_fund_start_date;
           
            SELECT nvl(sum(interest),0) into pinterest FROM CLAIM_TABLE_TEMP where owner_no =v_ownerno;        
           
           lumpsum:= pdlumpsum;
           pdlumpsum:= lumpsum - sumdeduct;
                  
            pbentype:='Invalidity Retirement';                   
            msg:='Invalidity Benefit Processed Successfull:success'; 
       end if;
            
   end if;
     
     --Calculate Death Benefits
          
   if  pclaimtype = 'DTH' Then
       
       if vage > vmra then
          msg:='Member age exceeded Compulsory Retirement age:nsuccess';
          return;
       end if;  
          
       if vexitdate > vreceiveddate then
          msg:='Death Benefit exit date should be before received date:nsuccess';
          return;
       end if;
        
       if payee=1 then
          msg:='Payee can not be Individual:nsuccess';
          return;
       end if;
            
       if  net_ps >= vqp or use_formula=1  then
  
           pdlumpsum_1:=(vpf1)*net_ps*pape1;
                        
           pmonthlypension_1:= pdlumpsum_1*pcr2/12;
                     
           --after commerce
           pdlumpsum_2:=(pdlumpsum_1*pcr1)*vcf1;
                     
           if is_totalize = 'YES' and prev=1 then
                            
              p_pdlumpsum_1:=(p_vpf1)*net_ps*pape1;
                        
              p_pdlumpsum_2:=(p_pdlumpsum_1*p_pcr1)*p_vcf1;
                             
              p_pmonthlypension_1:= p_pdlumpsum_1 * p_pcr2/12;
                          
           end if;
                     
           --total lumpsum
           lumpsum:= pdlumpsum_2+p_pdlumpsum_2;
           --net lumpsum and total monthly pension
           pdlumpsum :=lumpsum - sumdeduct;
                       
           pdlumpsum := pdlumpsum;
                        
           pmonthlypension:= pmonthlypension_1+p_pmonthlypension_1;
                       
           pbentype:='Death'; 
           msg:='Death Benefit Processed Successfull:success';
                
       else
           pmonthlypension:=0;
                    
           v_fund:= 5;
                         
           pdlumpsum:=FN_WITHDRWAL_LAPF_GEPF(v_ownerno,v_fund,vexitdate,vdoj);
                             
           select nvl(sum(total_contribution),0) into lumpsum from contribution where owner_no =v_ownerno and trim(status)='A' and open_flag is null
           and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/rrrr')<= vexitdate and transact is null and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy') >= member_fund_start_date;
                   
           if pape1 > pdlumpsum then
              pdlumpsum:=pape1;        
           end if;
                  
           pinterest:= pdlumpsum - lumpsum;         
                   
           lumpsum:= pdlumpsum;
           pdlumpsum:= lumpsum - sumdeduct;
                           
           pbentype:='Death'; 
           msg:='Death Benefit Processed Successfull:success'; 
       end if;
   
   end if; 

    --DA CALCULATION
   if  pclaimtype = 'DAS' and  var_scheme = 2 then
  
        ----Call DA calculation procedure
        pbentype:='DAS Benefits';
   
        DELETE  FROM DADETAILS WHERE OWNER_NO=v_ownerno;    
        commit; 
        SSIPMAS.CALC_DA_INT(v_ownerno, trunc(vreceiveddate), trunc(v_ed));
     
       if pinclude=1 then
          select nvl(sum(total_contribution),0) into pdlumpsum from contribution where owner_no=v_ownerno  and trim(status)='A' and open_flag is null and  
          to_date('01'||'/'||SALmonth||'/'||SALyear,'dd/mm/rrrr')<= vexitdate and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy') >= member_fund_start_date;
             
       else
          select nvl(sum(total_contribution),0) into pdlumpsum from contribution where owner_no=v_ownerno  and trim(status)='A' and open_flag is null and  
          to_date('01'||'/'||SALmonth||'/'||SALyear,'dd/mm/rrrr')<= vexitdate and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy') >= member_fund_start_date;
             
       end if;

       select nvl(sum(interestamt),0) into pinterest from dadetails where owner_no=v_ownerno; 
        
             --lumpsum
       lumpsum:=pdlumpsum + pinterest;
             --net
              
       pdlumpsum:= nvl(lumpsum,0) - nvl(sumdeduct,0);
              
       pmonthlypension:=0;
       pape2:=0;
              
       msg:='Deposit Administration benefits Processed Successfull:success';  
  	  
   end if;
   
   if pclaimtype = 'VFR' then
      pbentype:='VF Refunds';
      pmonthlypension:=0;
      pape2:=0;
      
      if v_fund = 2 then
         
         SELECT COUNT(*) into hasBalance FROM LAPF_OPEN_BALANCE WHERE owner_no =v_ownerno;
         
         if hasBalance > 0 then
          
            SELECT sum(nvl(AMOUNT,0)) into hasBalance FROM LAPF_OPEN_BALANCE WHERE owner_no =v_ownerno;
          
            hasBalance:=hasBalance/4;
         end if;
         
      end if;
      
      select nvl(sum(member_contr),0) into lumpsum from contribution where owner_no =v_ownerno and trim(status)='A' and open_flag is null
      and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/rrrr')<= vexitdate and transact is null;
      --and to_date('15/'||SALmonth||'/'||SALyear,'dd/mm/yyyy') >= member_fund_start_date;
      
      if v_fund = 2 then
         lumpsum:= hasBalance + lumpsum;
      end if;
      
      pdlumpsum:= nvl(lumpsum,0) - nvl(sumdeduct,0);
              
      msg:='VF Refunds benefits Processed Successfull:success';  
   
   end if;
   
      --handle ps above 180 but net less than 180
    
    if use_formula = 1 then
        pmonthlypension:=0;
    end if;

      --prolata
       if is_totalize ='YES' then
       
       --within[psssf funds] the fund: pay within[sum prev and curr]
            if pscheme in (1,2,3,4,5) and cscheme in (1,2,3,4,5) then
            
               psssf_scheme_ps:=psssf_scheme_ps - penalty;
               
               prev_cpg:=p_pdlumpsum_2 * (psssf_scheme_ps/net_ps);
               curr_cpg:=pdlumpsum_2 * (psssf_scheme_ps/net_ps);
                 
               prev_mp:=p_pmonthlypension_1 * (psssf_scheme_ps/net_ps);
               curr_mp:=pmonthlypension_1 * (psssf_scheme_ps/net_ps);
              
               pmonthlypension:=curr_mp + prev_mp;
               lumpsum:=curr_cpg + prev_cpg;
               pdlumpsum:=lumpsum - sumdeduct;
               
             else
             
             --out[nssf] with in[psssf merged funds]: pay in only[curr]
             if cscheme = 7 then
                prev_scheme_ps:=prev_scheme_ps - penalty;
                prev_cpg:=pdlumpsum_2 * (prev_scheme_ps/net_ps);
                prev_mp:=pmonthlypension_1 * (prev_scheme_ps/net_ps);
                
                pmonthlypension:=prev_mp;
                lumpsum:=pdlumpsum_2;
                pdlumpsum:=prev_cpg - sumdeduct;
              else
              
                psssf_scheme_ps:=psssf_scheme_ps - penalty;
                   
                curr_cpg:=pdlumpsum_2 * (psssf_scheme_ps/net_ps);
                curr_mp:=pmonthlypension_1 * (psssf_scheme_ps/net_ps);
                 
                pmonthlypension:=curr_mp;
                lumpsum:=pdlumpsum_2;
                pdlumpsum:=curr_cpg - sumdeduct;
              end if;
              
            end if;
           
         update CLAIM_TOTALIZATION set APE_NSSF=pape1,PREVIOUS_SCHEME_PS=prev_scheme_ps,CURRENT_SCHEME_PS=psssf_scheme_ps, APE_PSSSF=pape1,PREVIOUS_SCHEME_CPG=prev_cpg,PREVIOUS_SCHEME_MP=prev_mp,
         CURRENT_SCHEME_CPG=curr_cpg,CURRENT_SCHEME_MP=curr_mp where tot_id=v_tot_id and national_id=trim(pnationalid);
               
         commit;
       end if;
     
       --HANDLE HOUSE LOAN (HALF OF CPG)
       if totLoan > 0 then
         
          v_haflcpg:=pdlumpsum/2;
          loan_balance:=v_haflcpg - totLoan;
          
          if loan_balance > 0 then
             pdlumpsum:=v_haflcpg + loan_balance;
             loan_balance:=0;
          else
             pdlumpsum:=v_haflcpg;
             totLoan:=v_haflcpg;
             loan_balance:=loan_balance * (-1);
          end if;
          
          --update current loan
          update deduction set AMOUNT = totLoan, UNRECOVERED_AMOUNT = loan_balance WHERE trim(national_id) = trim(pnationalid) and IS_HALF = 'Y';
          commit;
          
       end if;
       
       if pmonthlypension > 0 and (v_fund in (2,4) or vemployer in (1004068,1011813))  then
          gov_exp_7:= 7/40 * lumpsum;
          psssf_exp_33:= 33/40 * lumpsum; 
       end if;
    
      vps_before_com:=vps;
      pdlumpsum:=round(nvl(pdlumpsum,0),2);
      pmonthlypension:=round(nvl(pmonthlypension,0),2);

      pinterest:=round(nvl(pinterest,0),2);
      vexitdate:=real_vexitdate;
         
END;