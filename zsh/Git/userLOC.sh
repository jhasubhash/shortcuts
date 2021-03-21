#!/bin/sh

SINCE=""
UNTIL=""
USER=""

if [ $1 ]
then
	USER=$1
else
	echo "Please provide user name"
	exit 1
fi

if [ $2 ]
then
	SINCE=$2
fi

if [ $3 ]
then
	UNTIL=$3
fi

if [ -z "$UNTIL" ]
then
	UNTIL=$(date '+%d-%h-%Y')
fi

if [ -z "$SINCE" ]
then
	SINCE="1-Jan-1980"
fi

CURRENT_BRANCH=`git branch --show-current`

RESULT=`git log --shortstat --author "$USER" --since "$SINCE" --until "$UNTIL" | awk '/commit/ {print $2}' | tail -r`
#echo "$RESULT"

FINAL_SCC_JS=""
FINAL_SCC_TS=""
FINAL_SCC_CHEADER=""
FINAL_SCC_CPP=""
FINAL_SCC_OBJECTIVEC=""
FINAL_SCC_C=""
FINAL_SCC_CPPHEADER=""
COLUMN_NAME=`scc --include-ext=js,ts,cpp,h,hpp,c,mm | awk -v OFS='\t' '/Language/ {print $1,$2,$3,$4,$5,$6,$7}'`

COUNT_LINE=`echo $RESULT | wc -w`
CURR_LINE=1
for line in $RESULT
do
	VAL=`echo "$CURR_LINE/$COUNT_LINE*100" | bc -l`
	printf "\r%.0f%%" $VAL
	CURR_LINE=$((CURR_LINE+1))

	git checkout "$line~1" 2>/dev/null
	BEFORE_SCC=$(scc --include-ext=js,ts,cpp,h,hpp,c,mm 2>/dev/null)
	git checkout "$line" 2>/dev/null
	AFTER_SCC=$(scc --include-ext=js,ts,cpp,h,hpp,c,mm 2>/dev/null)

	SCC_JS=`echo "$BEFORE_SCC\n$AFTER_SCC" | awk -v OFS='\t' '/^JavaScript/ {print $0}'`
	SCC_TS=`echo "$BEFORE_SCC\n$AFTER_SCC" | awk -v OFS='\t' '/^TypeScript/ {print $0}'`
	SCC_CHEADER=`echo "$BEFORE_SCC\n$AFTER_SCC" | awk -v OFS='\t' '/^C Header/ {print $1"_"$2,$3,$4,$5,$6,$7}'`
	SCC_CPP=`echo "$BEFORE_SCC\n$AFTER_SCC" | awk -v OFS='\t' '/^C\+\+  / {print $0}'`
	SCC_OBJECTIVEC=`echo "$BEFORE_SCC\n$AFTER_SCC" | awk -v OFS='\t' '/^Objective C\+\+/ {print $1"_"$2,$3,$4,$5,$6,$7}'`
	SCC_C=`echo "$BEFORE_SCC\n$AFTER_SCC" | awk -v OFS='\t' '/^C  / {print $0}'`
	SCC_CPPHEADER=`echo "$BEFORE_SCC\n$AFTER_SCC" | awk -v OFS='\t' '/^C\+\+ Header/ {print $1"_"$2,$3,$4,$5,$6,$7}'`

	DIFF_JS=`echo "$SCC_JS" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2-old2, $3-old3, $4-old4, $5-old5, $6-old6, $7-old7}'`
	DIFF_TS=`echo "$SCC_TS" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2-old2, $3-old3, $4-old4, $5-old5, $6-old6, $7-old7}'`
	DIFF_CHEADER=`echo "$SCC_CHEADER" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2-old2, $3-old3, $4-old4, $5-old5, $6-old6, $7-old7}'`
	DIFF_CPP=`echo "$SCC_CPP" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2-old2, $3-old3, $4-old4, $5-old5, $6-old6, $7-old7}'`
	DIFF_OBJECTIVEC=`echo "$SCC_OBJECTIVEC" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2-old2, $3-old3, $4-old4, $5-old5, $6-old6, $7-old7}'`
	DIFF_C=`echo "$SCC_C" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2-old2, $3-old3, $4-old4, $5-old5, $6-old6, $7-old7}'`
	DIFF_CPPHEADER=`echo "$SCC_CPPHEADER" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2-old2, $3-old3, $4-old4, $5-old5, $6-old6, $7-old7}'`

	FINAL_SCC_JS=`echo "$FINAL_SCC_JS\n$DIFF_JS" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2+old2, $3+old3, $4+old4, $5+old5, $6+old6, $7+old7}'`
	FINAL_SCC_TS=`echo "$FINAL_SCC_TS\n$DIFF_TS" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2+old2, $3+old3, $4+old4, $5+old5, $6+old6, $7+old7}'`
	FINAL_SCC_CHEADER=`echo "$FINAL_SCC_CHEADER\n$DIFF_CHEADER" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2+old2, $3+old3, $4+old4, $5+old5, $6+old6, $7+old7}'`
	FINAL_SCC_CPP=`echo "$FINAL_SCC_CPP\n$DIFF_CPP" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2+old2, $3+old3, $4+old4, $5+old5, $6+old6, $7+old7}'`
	FINAL_SCC_OBJECTIVEC=`echo "$FINAL_SCC_OBJECTIVEC\n$DIFF_OBJECTIVEC" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2+old2, $3+old3, $4+old4, $5+old5, $6+old6, $7+old7}'`
	FINAL_SCC_C=`echo "$FINAL_SCC_C\n$DIFF_C" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2+old2, $3+old3, $4+old4, $5+old5, $6+old6, $7+old7}'`
	FINAL_SCC_CPPHEADER=`echo "$FINAL_SCC_CPPHEADER\n$DIFF_CPPHEADER" | awk -v OFS='\t' 'NR==1{old2=$2; old3=$3; old4=$4; old5=$5; old6=$6; old7=$7; next;}{print $1, $2+old2, $3+old3, $4+old4, $5+old5, $6+old6, $7+old7}'`
done
printf "\n"
git checkout $CURRENT_BRANCH 2>/dev/null
FINAL_DATA=`echo "$COLUMN_NAME\n$FINAL_SCC_JS\n$FINAL_SCC_TS\n$FINAL_SCC_CHEADER\n$FINAL_SCC_CPP\n$FINAL_SCC_OBJECTIVEC\n$FINAL_SCC_C\n$FINAL_SCC_CPPHEADER"`
SEPERATOR="------ ------ ------ ------ ------ ------ ------"
TOTAL=`echo "$FINAL_DATA" | awk '{for (i=2;i<=NF;i++){ sums[i]+=$i;}} END{for(i=2;i<=NF;i++){ printf("%s\t", sums[i])}}'`
echo "$FINAL_DATA\n$SEPERATOR\nTotal $TOTAL" | column -t

