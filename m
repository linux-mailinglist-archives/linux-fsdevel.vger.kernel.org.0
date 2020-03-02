Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E6D1753B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCBG0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:26:35 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59535 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgCBG0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:34 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200302062631epoutp0474d011c516ca524e02be45485dc301f1~4aLQeQWbA2114721147epoutp04R
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2020 06:26:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200302062631epoutp0474d011c516ca524e02be45485dc301f1~4aLQeQWbA2114721147epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583130391;
        bh=A7hoCWZILD9/XnFYmjNAsppFTlAIG/m51nOnZFyHrcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDaS/DP9inY7PhMguSKCACPWnZ5CEy4HJlpCr/FCtHbnENfNKz9pi1oaNr/jcCE+O
         99x4AmDDSf+hbLtKrgO9pSVB1KpC8kCiwTgPZHM7sfG+fiwNWpAQ7HGIVcH4sLF3nr
         D5ao6S1Fgk2v5qIrsD+IL8j8TRy9eZmc9mTEMXDQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200302062631epcas1p40efe12f9a5e0af679353164e0f97df59~4aLQDOQyz2317423174epcas1p4k;
        Mon,  2 Mar 2020 06:26:31 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48W9CB1BDhzMqYkq; Mon,  2 Mar
        2020 06:26:30 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.08.52419.617AC5E5; Mon,  2 Mar 2020 15:26:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200302062629epcas1p46967161019cd142c17a9ee7d33ae9265~4aLOnu5cr2317423174epcas1p4b;
        Mon,  2 Mar 2020 06:26:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302062629epsmtrp127e3c15a0661caef7838df2478a50fee~4aLOm_F4o1431214312epsmtrp1m;
        Mon,  2 Mar 2020 06:26:29 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-21-5e5ca7164cd5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.49.10238.517AC5E5; Mon,  2 Mar 2020 15:26:29 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062629epsmtip21e9bcc1b9908f5912f7e9fd707162b28~4aLOdIqq-1396013960epsmtip2d;
        Mon,  2 Mar 2020 06:26:29 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com
Subject: [PATCH v14 14/14] exfat: update file system parameter handling
Date:   Mon,  2 Mar 2020 15:21:45 +0900
Message-Id: <20200302062145.1719-15-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302062145.1719-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTV1dseUycQccnZou/k46xWzQvXs9m
        sXL1USaL63dvMVvs2XuSxeLyrjlsFhNP/2ay2PLvCKvFpfcfWCzO/z3O6sDl8fvXJEaPnbPu
        snvsn7uG3WP3zQY2j74tqxg9Pm+S8zi0/Q2bx6Ynb5kCOKJybDJSE1NSixRS85LzUzLz0m2V
        vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAjlRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
        5BeX2CqlFqTkFBgaFOgVJ+YWl+al6yXn51oZGhgYmQJVJuRkHFxynKXgskjFldaj7A2MPYJd
        jJwcEgImEhObVjJ2MXJxCAnsYJSY1PWQBcL5xCix+Ms3VgjnG6PE3dv72GBa1r7sZ4NI7GWU
        2LlxBhtcy6Nvd5i7GDk42AS0Jf5sEQVpEBGQljjTf4kJpIZZ4CajxMHFm5lBEsIC7hLTPm1n
        AbFZBFQldhxeCxbnFbCR6F/ZzgqxTV5i9YYDYHFOoPidXRcYIeJn2CReX1eHsF0k1hzthaoX
        lnh1fAs7hC0l8bK/jR3kHgmBaomP+5khwh2MEi++20LYxhI3129gBSlhFtCUWL9LHyKsKLHz
        91ywTcwCfBLvvvawQkzhlehoE4IoUZXou3SYCcKWluhq/wC11ENiw7fH0EDsZ5R4v62NbQKj
        3CyEDQsYGVcxiqUWFOempxYbFhgjR9gmRnAi1DLfwbjhnM8hRgEORiUe3h3Po+OEWBPLiitz
        DzFKcDArifD6cgKFeFMSK6tSi/Lji0pzUosPMZoCw3Eis5Rocj4wSeeVxBuaGhkbG1uYmJmb
        mRorifM+jNSMExJITyxJzU5NLUgtgulj4uCUamDkDpX4PVVE41P9tbAYpXobzTfughse3Z0i
        /cT6SvLqfbwpT6aa7dhjZcc194j9hG6x+Pcek2Y7To5W4vP7f+UK+0+lXW5KU5VuHL6m8eBF
        sqPH8R5+bg29fokj0+r2hwWfK3cK42Se++TEyQ0RXWcd33yb1aLwVvbyFwZ3zw8nTS1vTNVQ
        eVaqxFKckWioxVxUnAgA8nqlI5oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvK7o8pg4g1eP9Sz+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWUw8/ZvJYsu/I6wWl95/YLE4//c4qwOXx+9fkxg9ds66
        y+6xf+4ado/dNxvYPPq2rGL0+LxJzuPQ9jdsHpuevGUK4IjisklJzcksSy3St0vgyji45DhL
        wWWRiiutR9kbGHsEuxg5OSQETCTWvuxn62Lk4hAS2M0o0X/gGAtEQlri2IkzzF2MHEC2sMTh
        w8UQNR8YJSYs28cOEmcT0Jb4s0UUpFwEqPxM/yUmkBpmgceMEjN+fGEDSQgLuEtM+7QdbCaL
        gKrEjsNrmUFsXgEbif6V7awQu+QlVm84ABbnBIrf2XWBEcQWErCWePriLvMERr4FjAyrGCVT
        C4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCA1ZLcwfj5SXxhxgFOBiVeHh3Po+OE2JNLCuu
        zD3EKMHBrCTC68sJFOJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyW
        iYNTqoFRXK/huU9W6Ny44lgHx4Q53Cbip9KfTrz3UKwgwHt5w17zVRwlKTP/aL7gmeu11jr9
        dfYB1qfz+Wb2bn2csUfL9ETDJZ7CJawxUws23VAMnX9vTfyl0+f5vlxfduCpoUHSVf8nK5tf
        Ohqyi4tdX3Fgm39eZqr/9ast2sYvhY3knYLqd29vZ/uoxFKckWioxVxUnAgA/EaA4VQCAAA=
X-CMS-MailID: 20200302062629epcas1p46967161019cd142c17a9ee7d33ae9265
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200302062629epcas1p46967161019cd142c17a9ee7d33ae9265
References: <20200302062145.1719-1-namjae.jeon@samsung.com>
        <CGME20200302062629epcas1p46967161019cd142c17a9ee7d33ae9265@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Al Viro recently reworked the way file system parameters are handled
Update super.c to work with it in linux-next 20200203.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Namjae Jeon <namjae.jeon@samsung.com>
---
 fs/exfat/super.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index f06e0b53e393..16ed202ef527 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -214,7 +214,14 @@ enum {
 	Opt_time_offset,
 };
 
-static const struct fs_parameter_spec exfat_param_specs[] = {
+static const struct constant_table exfat_param_enums[] = {
+	{ "continue",		EXFAT_ERRORS_CONT },
+	{ "panic",		EXFAT_ERRORS_PANIC },
+	{ "remount-ro",		EXFAT_ERRORS_RO },
+	{}
+};
+
+static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_u32("uid",			Opt_uid),
 	fsparam_u32("gid",			Opt_gid),
 	fsparam_u32oct("umask",			Opt_umask),
@@ -222,25 +229,12 @@ static const struct fs_parameter_spec exfat_param_specs[] = {
 	fsparam_u32oct("fmask",			Opt_fmask),
 	fsparam_u32oct("allow_utime",		Opt_allow_utime),
 	fsparam_string("iocharset",		Opt_charset),
-	fsparam_enum("errors",			Opt_errors),
+	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
 	fsparam_s32("time_offset",		Opt_time_offset),
 	{}
 };
 
-static const struct fs_parameter_enum exfat_param_enums[] = {
-	{ Opt_errors,	"continue",		EXFAT_ERRORS_CONT },
-	{ Opt_errors,	"panic",		EXFAT_ERRORS_PANIC },
-	{ Opt_errors,	"remount-ro",		EXFAT_ERRORS_RO },
-	{}
-};
-
-static const struct fs_parameter_description exfat_parameters = {
-	.name		= "exfat",
-	.specs		= exfat_param_specs,
-	.enums		= exfat_param_enums,
-};
-
 static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct exfat_sb_info *sbi = fc->s_fs_info;
@@ -248,7 +242,7 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	int opt;
 
-	opt = fs_parse(fc, &exfat_parameters, param, &result);
+	opt = fs_parse(fc, exfat_parameters, param, &result);
 	if (opt < 0)
 		return opt;
 
@@ -665,7 +659,7 @@ static struct file_system_type exfat_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "exfat",
 	.init_fs_context	= exfat_init_fs_context,
-	.parameters		= &exfat_parameters,
+	.parameters		= exfat_parameters,
 	.kill_sb		= kill_block_super,
 	.fs_flags		= FS_REQUIRES_DEV,
 };
-- 
2.17.1

