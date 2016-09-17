function checkdata() {
	
		var ssn=form.username.value.toLowerCase();
		if (!checkUserName(ssn)) return false;  //�û�����
		if( strlen(form.pwd.value)<6 || strlen(form.pwd.value)>16 ) {
			alert("正确地登录密码长度为6-16位，仅可用英文、数字、特殊字符！");
			form.pwd.focus();
			return false;
		}
		if( strlen2(form.pwd.value) ) {
			alert("您的密特殊字符！码中包含了非法字符，仅可用英文、数字、特殊字符！");
			form.pwd.focus();
			return false;
		}
		if( form.pwd.value == form.username.value ) {
			alert("用户名和密码不能相同！");
			form.pwd.focus();
			return false;
		}
		if( form.pwd2.value =="" ) {
			alert("请输入密码确认！");
			form.pwd2.focus();
			return false;
		}
		if( form.pwd2.value != form.pwd.value ) {
			alert("两次密码输入不一致！");
			form.pwd.focus();
			return false;
		}
		
		if(form.phone.value == "") {
			alert("请选择性别!");
			form.phone.focus();
			return false;
		}
		
		if( form.addr.value == "") {
			alert("地址不能为空");
			form.addr.focus();
			return false;
		}
	
		return true;
	
}

function checkUserName(ssn){
	//if( ssn.length<3 || ssn.length>18 ) {
		//alert("\��������ȷ���û���,�û����Ϊ3-18λ��");
		//form.username.focus();
		//return false;
	//}
	if (isWhiteWpace(ssn)){
		alert("请输入正确的用户名,用户名长度为3-18位！");
		form.username.focus();
		return false;
	}
	//if (!isSsnString(ssn)){
		//alert("\�Բ�����ѡ����û�����ȷ���ѱ�ռ�ã��û���\n��a��z��Ӣ����ĸ(����ִ�Сд)��0��9�����֡��㡢��\n�Ż��»�����ɣ�����Ϊ3��18���ַ�ֻ�������ֻ���ĸ\n��ͷ�ͽ�β,����:kyzy_001��");
	//	form.username.focus();
		//return false;
	//}
	return true;
}

function strlen(str){
	var len;
	var i;
	len = 0;
	for (i=0;i<str.length;i++){
		if (str.charCodeAt(i)>255) len+=2; else len++;
	}
	return len;
}

function strlen2(str){
	var len;
	var i;
	len = 0;
	for (i=0;i<str.length;i++){
		if (str.charCodeAt(i)>255) return true;
	}
	return false;
}

function isWhiteWpace (s)
{
	var whitespace = " \t\n\r";
	var i;
	for (i = 0; i < s.length; i++){   
		var c = s.charAt(i);
		if (whitespace.indexOf(c) >= 0) {
		  	return true;
		}
	}
	return false;
}

function isSsnString (ssn)
{
	var re=/^[0-9a-z][\w-.]*[0-9a-z]$/i;
	if(re.test(ssn))
		return true;
	else
		return false;
}

function checkssn(gotoURL) {
   var ssn=form.username.value.toLowerCase();
   if (checkUserName(ssn)){
	   var open_url = gotoURL + "?username=" + ssn;
	   window.open(open_url,'','status=0,directories=0,resizable=0,toolbar=0,location=0,scrollbars=0,width=322,height=200');
	}
}