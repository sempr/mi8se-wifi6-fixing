[ -x `which magisk` ] && {
if magisk --denylist ls &>/dev/null; then
CMDPREFIX="magisk --denylist exec"
elif magisk magiskhide ls &>/dev/null; then
CMDPREFIX="magisk magiskhide exec"
fi
} || unset CMDPREFIX
CHECK_DIRS="/system /vendor /product /system_ext"
EXISTING_DIRS=""
for dir in $CHECK_DIRS; do
[[ -d "$dir" ]] && EXISTING_DIRS="$EXISTING_DIRS $dir"
done
CFGS=$($CMDPREFIX find $EXISTING_DIRS -type f -name WCNSS_qcom_cfg.ini)
for CFG in $CFGS
do
[[ -f $CFG ]] && {
mkdir -p `dirname $MODPATH$CFG`
ui_print "- Migrating $CFG"
$CMDPREFIX cp -af $CFG $MODPATH$CFG
ui_print "- Starting modifiy"
sed -i '/gEnableDFSChnlScan=/d;/gAllowDFSChannelRoam=/d;s/^END$/gEnableDFSChnlScan=0\ngAllowDFSChannelRoam=0\nEND/g' $MODPATH$CFG
}
done
[[ -z $CFG ]] && abort "- Installation FAILED. Your device didn't support WCNSS_qcom_cfg.ini." || { mkdir -p $MODPATH/system; mv -f $MODPATH/vendor $MODPATH/system/vendor; mv -f $MODPATH/product $MODPATH/system/product; mv -f $MODPATH/system_ext $MODPATH/system/system_ext;}
