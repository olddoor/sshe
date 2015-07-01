<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sy.model.base.SessionInfo"%>
<%
	String contextPath = request.getContextPath();
	String id=null;
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
	if (sessionInfo != null) {
		id=sessionInfo.getUser().getId();
	}
	if (id == null) {
		id = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="../../inc.jsp"></jsp:include>
<style type="text/css">
.table th {
    background: #f8f8f8;
    text-align: left;
}
.table thead th {
    text-align: left;
}
.table tbody th {
    text-align: left;
}
.table tr:hover {
    background-color: #f8f8f8;
}
.table td:hover {
    background-color: #f9feff;
}
.form th {
    text-align: left;
}
.form th, .form td {
    border: solid 0px #ccc;
    padding: 0.1em 0.3em;
}
.form th {
    border:none;
    border-bottom: none;
}
.form input, .form select, .form textarea {
    width: 525px;
}
.form input[type="checkbox"], .form input[type="radio"] {
    width: 20px;
}
fieldset {
    border: 1px dotted #d1d7dc;
}
legend {
    border: 1px dotted #d1d7dc;
    font-size: small;
}

.td01 {
    border-bottom: none;
}
.table {
	border-collapse: collapse;
	border-spacing: 0;
  float: left;
  border: solid 1px #ccc;
  width: 440px;
  background: #f8f8f8;
  padding: 10px;
  margin: 5px 0 5px 5px;
  border-radius: 8px;
}
</style>
<script type="text/javascript">
	var uploader;//上传对象
	var submitNow = function() {
		var url;
		if ($(':input[name="data.id"]').val().length > 0) {
			url = sy.contextPath + '/base/syuser!update.sy';
		} 
		$.post(url, sy.serializeObject($('form')), function(result) {
			parent.sy.progressBar('close');//关闭上传进度条
			if (result.success) {
				$.messager.alert('提示', result.msg, 'info');
				window.location.reload();//刷新当前页面. 
			} else {
				$.messager.alert('提示', result.msg, 'error');
				window.location.reload();//刷新当前页面. 
			}
		}, 'json');
	};
	//保存
	var submitForm = function() {
		if ($('form').form('validate')) {
			if (uploader.files.length > 0) {
				uploader.start();
				uploader.bind('StateChanged', function(uploader) {// 在所有的文件上传完毕时，提交表单
					if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
						submitNow();
					}
				});
			} else {
				submitNow();
			}
		}
		 var loginname=$(':input[name="data.loginname"]').val();
		 parent.changeRealQR(loginname);
	};
	
     //修改模板类型
	$(function() {
		$('#checkMOBAN').combobox({  
	        onChange:function(newValue,oldValue){  
	        	var loginname=$(':input[name="data.loginname"]').val()
	           // if(newValue==1){
				//	$('#moban1').attr('src', '<%=contextPath%>/static/moban1.jpg');
				//}else if(newValue==2){
				//	$('#moban1').attr('src', '<%=contextPath%>/static/moban2.jpg');
				//}
	        	 parent.changefun(newValue,loginname);
	        }  
	    }); 

		if ($(':input[name="data.id"]').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(sy.contextPath + '/base/syuser!getById.sy', {
				id : $(':input[name="data.id"]').val()
			}, function(result) {
				if (result.id != undefined) {
					$('form').form('load', {
						'data.id' : result.id,
						'data.name' : result.name,
						'data.loginname' : result.loginname,
						'data.sex' : result.sex,
						'data.age' : result.age,
						'data.photo' : result.photo,
						'data.email' : result.email,
						'data.fax' : result.fax,
						'data.company' : result.company,
						'data.cellPhone' : result.cellPhone,
						'data.company_address' : result.company_address,
						'data.duty' : result.duty,
						'data.qrPhoto':result.qrPhoto,
						'data.qrmoban':result.qrmoban,
						'data.pwd':result.pwd
					});
					if (result.photo) {
						$('#photo').attr('src', sy.contextPath + result.photo);
					}
					if (result.qrPhoto) {
						$('#qrPhoto').attr('src', sy.contextPath + result.qrPhoto);
					}
					
					//if(result.qrmoban==1){
					//	$('#moban1').attr('src', '<%=contextPath%>/static/moban1.jpg');
				//	}else if(result.qrmoban==2){
					//	$('#moban1').attr('src', '<%=contextPath%>/static/moban2.jpg');
					//}
				}
				parent.$.messager.progress('close');
			}, 'json');
		}

		uploader = new plupload.Uploader({//上传插件定义
			browse_button : 'pickfiles',//选择文件的按钮
			container : 'container',//文件上传容器
			runtimes : 'html5,flash',//设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html4
			//flash_swf_url : sy.contextPath + '/jslib/plupload_1_5_7/plupload/js/plupload.flash.swf',// Flash环境路径设置
			url : sy.contextPath + '/plupload?fileFolder=/userPhoto',//上传文件路径
			max_file_size : '5mb',//100b, 10kb, 10mb, 1gb
			chunk_size : '10mb',//分块大小，小于这个大小的不分块
			unique_names : true,//生成唯一文件名
			// 如果可能的话，压缩图片大小
			/*resize : {
				width : 320,
				height : 240,
				quality : 90
			},*/
			// 指定要浏览的文件类型
			filters : [ {
				title : '图片文件',
				extensions : 'jpg,gif,png'
			} ]
		});
		uploader.bind('Init', function(up, params) {//初始化时
			//$('#filelist').html("<div>当前运行环境: " + params.runtime + "</div>");
			$('#filelist').html("");
		});
		uploader.bind('BeforeUpload', function(uploader, file) {//上传之前
			if (uploader.files.length > 1) {
				parent.$.messager.alert('提示', '只允许选择一张照片！', 'error');
				uploader.stop();
				return;
			}
			$('.ext-icon-cross').hide();
		});
		uploader.bind('FilesAdded', function(up, files) {//选择文件后
			$.each(files, function(i, file) {
				$('#filelist').append('<div id="' + file.id + '">' + file.name + '(' + plupload.formatSize(file.size) + ')<strong></strong>' + '<span onclick="uploader.removeFile(uploader.getFile($(this).parent().attr(\'id\')));$(this).parent().remove();" style="cursor:pointer;" class="ext-icon-cross" title="删除">&nbsp;&nbsp;&nbsp;&nbsp;</span></div>');
			});
			up.refresh();
		});
		uploader.bind('UploadProgress', function(up, file) {//上传进度改变
			var msg;
			if (file.percent == 100) {
				msg = '99';//因为某些大文件上传到服务器需要合并的过程，所以强制客户看到99%，等后台合并完成...
			} else {
				msg = file.percent;
			}
			$('#' + file.id + '>strong').html(msg + '%');

			parent.sy.progressBar({//显示文件上传滚动条
				title : '文件上传中...',
				value : msg
			});
		});
		uploader.bind('Error', function(up, err) {//出现错误
			$('#filelist').append("<div>错误代码: " + err.code + ", 描述信息: " + err.message + (err.file ? ", 文件名称: " + err.file.name : "") + "</div>");
			up.refresh();
		});
		uploader.bind('FileUploaded', function(up, file, info) {//上传完毕
			var response = $.parseJSON(info.response);
			if (response.status) {
				$('#' + file.id + '>strong').html("100%");
				//console.info(response.fileUrl);
				//console.info(file.name);
				//$('#f1').append('<input type="hidden" name="fileUrl" value="'+response.fileUrl+'"/>');
				//$('#f1').append('<input type="hidden" name="fileName" value="'+file.name+'"/><br/>');
				$(':input[name="data.photo"]').val(response.fileUrl);
			}
		});
		uploader.init();

	});
</script>
</head>
<body>
	<td><form method="post" class="form" id="forbox1">
		<fieldset>
			<legend>用户基本信息</legend>
			<table class="table" style="width: 70%;">
					<input name="data.qrPhoto" type="hidden"/>
					<input name="data.sex" type="hidden"/>
					<input name="data.pwd" type="hidden"/>
				<tr class="td01">
					<th class="td01"  colspan="2">编号</th>
				</tr>
				<tr>
					<td colspan="2"><input name="data.id" value="<%=id%>" readonly="readonly" /></td>
				</tr>
				<tr>	
					<th class="td01"  colspan="2">登陆名称</th>
				</tr>
					<td colspan="2"><input name="data.loginname" readonly="readonly" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<th class="td01"  colspan="2">姓名</th>
				</tr>
				<tr>
					<td colspan="2"><input name="data.name" /></td>
				</tr>
				<tr>
					<th class="td01"  colspan="2">模板</th>
				</tr>
				<tr>
					<td colspan="2"><select class="easyui-combobox" id="checkMOBAN" name="data.qrmoban" data-options="panelHeight:'auto',editable:false" style="width: 155px;" >
							<option value="1">模板1</option>
							<option value="2">模板2</option>
					</select>
					</td>
				</tr>
				<tr>
					<th class="td01"  colspan="2">电话号码</th>
				</tr>
				<tr>
					<td colspan="2"><input name="data.cellPhone"/></td>
				</tr>
				<tr>
					<th class="td01"  colspan="2">传真号码</th>
				</tr>
				<tr>
					<td colspan="2"><input name="data.fax" /></td>
				</tr>
				<tr>
					<th class="td01"  colspan="2">电子邮件</th>
				</tr>
				<tr>
					<td colspan="2"><input name="data.email"/></td>
				</tr>
				<tr>
					<th class="td01"  colspan="2">职务</th>
				</tr>
				<tr>
					<td colspan="2"><input name="data.duty" /></td>
				</tr>
				<tr>
					<th class="td01"  colspan="2">公司</th>
				</tr>
				<tr>
					<td colspan="2"><input name="data.company"/></td>
			    </tr>
			    <tr>
					<th class="td01"  colspan="2">公司地址</th>
				</tr>
				<tr>
					<td colspan="2"><input name="data.company_address" /></td>
				</tr>
				<tr >
					<th class="td01"  colspan="1">照片上传<div id="container">
							<a id="pickfiles" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom'">选择文件</a>
							<div id="filelist">您的浏览器没有安装Flash插件，或不支持HTML5！</div>
					</div></th>
					<td colspan="1"><input name="data.photo" readonly="readonly" style="display: none;" /> <img id="photo" src="" style="width: 200px; height: 200px;"></td>
				</tr>
				<tr>
					<th class="td01"  colspan="1">二维码</th>
					<td colspan="1"><input name="data.qrPhoto" readonly="readonly" style="display: none;" /> <img id="qrPhoto" src="" style="width: 200px; height: 200px;"></td>
				</tr>
				<tr>
				<td colspan="2"><input type="button" value="保存并预览" onclick="submitForm()"></td>
				</tr>
			</table>
		</fieldset>
	</form></td>
	<td><form>
	    <fieldset>
		</fieldset>
	</form></td>
</body>
</html>