<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<%
	String id = request.getParameter("id");
	if (id == null) {
		id = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="../../inc.jsp"></jsp:include>
<script type="text/javascript">
	var uploader;//上传对象
	var submitNow = function($dialog, $grid, $pjq) {
		var url;
		if ($(':input[name="data.id"]').val().length > 0) {
			url = sy.contextPath + '/base/syuser!update.sy';
		} else {
			url = sy.contextPath + '/base/syuser!save.sy';
		}
		$.post(url, sy.serializeObject($('form')), function(result) {
			parent.sy.progressBar('close');//关闭上传进度条

			if (result.success) {
				$pjq.messager.alert('提示', result.msg, 'info');
				$grid.datagrid('load');
				$dialog.dialog('destroy');
			} else {
				$pjq.messager.alert('提示', result.msg, 'error');
			}
		}, 'json');
	};
	var submitForm = function($dialog, $grid, $pjq) {
		if ($('form').form('validate')) {
			/*if (uploader.files.length > 0) {
				uploader.start();
				uploader.bind('StateChanged', function(uploader) {// 在所有的文件上传完毕时，提交表单
					if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
						submitNow($dialog, $grid, $pjq);
					}
				});
			} else {*/
				submitNow($dialog, $grid, $pjq);
			//}
		}
	};
	$(function() {
		
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
						'data.loginname' : result.loginname,
						'data.name' : result.name,
						'data.duty' : result.duty,
						'data.company' : result.company,
						'data.phone' : result.phone,
						'data.email':result.email,
						'data.cellPhone' : result.cellPhone,
						'data.zipCode':result.zipCode,
						'data.company_address' : result.company_address
					});
					if (result.photo) {
						$('#photo').attr('src', sy.contextPath + result.photo);
					}
				}
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
</script>
</head>
<body>
	<form method="post" class="form">
		<fieldset>
			<legend>用户基本信息</legend>
			<table class="table" style="width: 100%;">
					<input type="hidden" name="data.id" value="<%=id%>" readonly="readonly" />
				<tr>
					<th>姓名</th>
					<td><input name="data.name" /></td>
					<th>登陆名</th>
					<td><input name="data.loginname" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>职务</th>
					<td><input name="data.duty" /></td>
					<th>模板</th>
					<td><select class="easyui-combobox" name="data.qrmoban" data-options="panelHeight:'auto',editable:false" style="width: 155px;">
							<option value="1">模板1</option>
							<option value="2">模板2</option>
							<option value="3">模板3</option>
							<option value="4">模板4</option>
					</select></td>
				</tr>
				<tr>
					<th>移动电话</th>
					<td><input name="data.cellPhone"/></td>
					<th>公司电话</th>
					<td><input name="data.phone" /></td>
				</tr>
				<tr>
					<th>电子邮件</th>
					<td><input name="data.email"/></td>
					<th>邮编</th>
					<td><input name="data.zipCode"/></td>
				</tr>
					<tr>
					<th>公司</th>
					<td><input name="data.company"/></td>
					<th>公司地址</th>
					<td><input name="data.company_address" /></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>