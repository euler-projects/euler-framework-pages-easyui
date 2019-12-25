<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <%@ include file="/WEB-INF/jsp/admin/themes/default/common/css-global.jsp"%>
    <%@ include file="/WEB-INF/jsp/admin/themes/default/common/css-dash.jsp"%>

    <title></title>

    <style>
        .add-btn {
            color: #444!important;
        }
    </style>
</head>

<body class="easyui-layout">
    <div data-options="region:'west',collapsible:false,border:false" style="width:48%;">
        <ul id="dl-authority-available" class="authority-list" title="${e:i18n('_ADMIN_DASHBOARD_USER_AUTH_AVAILABLE')}">
        </ul>
    </div>
    <div data-options="region:'center',border:true" style="width: 4%; height: 100%; border-top-width: 0; border-bottom-width: 0">
        <div style="position: relative; height:180px; top:50%; margin-top:-90px; text-align: center;  line-height: 40px;">
            <div style="position: relative; height: 80px; top: 0">
                <a id="rm-selected" title="${e:i18n('_ADMIN_DASHBOARD_USER_AUTH_RM_SELECTED')}" href="#" class="easyui-linkbutton add-btn">&lt;</a>
                <a id="rm-all" title="${e:i18n('_ADMIN_DASHBOARD_USER_AUTH_RM_ALL')}" href="#" class="easyui-linkbutton add-btn">&lt;&lt;</a>
            </div>
            <div style="position: relative; height: 80px; top: 20px">
                <a id="add-selected" title="${e:i18n('_ADMIN_DASHBOARD_USER_AUTH_ADD_SELECTED')}" href="#" class="easyui-linkbutton add-btn">&gt;</a>
                <a id="add-all" title="${e:i18n('_ADMIN_DASHBOARD_USER_AUTH_ADD_ALL')}" href="#" class="easyui-linkbutton add-btn">&gt;&gt;</a>
            </div>
        </div>
    </div>
    <div data-options="region:'east',collapsible:false,border:false" style="width:48%;">
        <ul id= "dl-authority-active" class="authority-list" title="${e:i18n('_ADMIN_DASHBOARD_USER_AUTH_ACTIVE')}">
        </ul>
    </div>

<%@ include file="/WEB-INF/jsp/admin/themes/default/common/js-global.jsp"%>
<%@ include file="/WEB-INF/jsp/admin/themes/default/common/js-dash.jsp"%>
<script>
    $(function(){
        $('.add-btn').linkbutton({
            height: '25px',
            width: '25px'
        });

        $('.authority-list').datalist({
            height: '100%',
            width: '100%',
            border: false,
            checkbox: true,
            singleSelect: false,
            valueField: 'code',
            textField: 'name'
        });

        $('#dl-authority-available').datalist({
            url: '${__ADMIN_PATH}/ajax/authentication/group/findGroupByPage?pageSize=9999999&pageIndex=0'
        });

        $('#dl-authority-active').datalist({
            url: '${__ADMIN_PATH}/ajax/authentication/group/findUserGroupByPage?pageSize=9999999&pageIndex=0&query.userId=' + euler.getUrlParam('userId')
        });

        $('#rm-selected').linkbutton({
            onClick: function() {
                const checked = $('#dl-authority-active').datalist('getChecked');
                console.log(checked);
                for(const checkedItem of checked) {
                    const rowIndex = $('#dl-authority-active').datalist('getRowIndex', checkedItem);
                    console.log(rowIndex);
                    $('#dl-authority-active').datalist('deleteRow', rowIndex);
                }
            }
        });

        $('#rm-all').linkbutton({
            onClick: function() {
                $('#dl-authority-active').datalist('loadData', {rows:[]});
            }
        });

        $('#add-selected').linkbutton({
            onClick: function() {
                const checked = $('#dl-authority-available').datalist('getChecked');
                console.log(checked);
                for(const checkedItem of checked) {
                    const rowIndex = $('#dl-authority-active').datalist('getRowIndex', checkedItem);
                    if(rowIndex < 0) {
                        $('#dl-authority-active').datalist('insertRow', {row: checkedItem});
                    }
                }
            }
        });

        $('#add-all').linkbutton({
            onClick: function() {
                const data = $('#dl-authority-available').datalist('getData');
                $('#dl-authority-active').datalist('loadData', data);
            }
        });
    });

    function onEulerIframeDlgConfirm(callback) {
        var result = {};
        result.userId = euler.getUrlParam('userId');
        var selectedGroupCodes = [];
        var data = $('#dl-authority-active').datalist('getData');
        if(data != null && data.rows != null) {
            for(var i = 0; i < data.rows.length; i++) {
                selectedGroupCodes[i] = data.rows[i].code;
            }
        }
        result.selectedGroupCodes = selectedGroupCodes;
        callback(result);
    }
</script>
</body>

</html>