Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBAF4F7DA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 13:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiDGLMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 07:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbiDGLMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:12:41 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF32AC9;
        Thu,  7 Apr 2022 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649329839; i=@fujitsu.com;
        bh=ldhkgmh+x9ZpMfMk06uXxU34VsAmVCDbQY1Nmni+etc=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=P1yWJ2VP5MkWzkR3pmxIuQtm2awSGXdvgA1klDsZeVi5y9zcTIhr2q0BIXhGoFayC
         PAtye1qM22+ezPnV7MCvejXrXiShJnpKURFv4EUe1w1s6YwQqMtsEQdcLXsoKDyshV
         7ssfLhDN26oAOjP7l/xfx9H5CWBPLrKzcGtNg+y8nTvUHhJpUpDBRkc/MG3UvzGGDU
         DdS4neIqS7N6HlioL/LyR6aoqNY6QIq3jWTzR+3hkJdOKivSKpnRmV+l0dO/blIHXz
         hy32cQ5Gr0B3utIU264tgVh1t+WamoYvqr4ngIbTpL91cpMz99ZgwXaKMKCW9byLwS
         4FHaGA5SgEDNQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsViZ8MxSXfdMb8
  kgwtX1CxeH/7EaLHl2D1Gi8tP+CxOt+xlt9iz9ySLA6vHqUUSHptWdbJ5fN4kF8AcxZqZl5Rf
  kcCa0XxmI2NBl2zF6YkXmRoYt0p0MXJyCAlsYZSYfq+8i5ELyF7AJHF90h4mCGc3o8TujlvMI
  FVsApoSzzoXgNkiAi4S3/b/ZQOxmQVSJBrONzGC2MICcRIrf8wAs1kEVCTW/NwNZvMKeEgs27
  kbrF5CQEFiysP3YHM4BTwl7j7+zgZxhYdE840ZUPWCEidnPmGBmC8hcfDFC2aIXkWJSx3fGCH
  sColZs9qYIGw1iavnNjFPYBSchaR9FpL2BYxMqxitk4oy0zNKchMzc3QNDQx0DQ1NdY1NdQ1N
  LPUSq3QT9VJLdctTi0t0jfQSy4v1UouL9Yorc5NzUvTyUks2MQKDP6VYeeoOxtOrfuodYpTkY
  FIS5W3Y6ZckxJeUn1KZkVicEV9UmpNafIhRhoNDSYI38QhQTrAoNT21Ii0zBxiJMGkJDh4lEd
  6jh4HSvMUFibnFmekQqVOMilLivO+PAiUEQBIZpXlwbbDov8QoKyXMy8jAwCDEU5BalJtZgir
  /ilGcg1FJmFccmEqEeDLzSuCmvwJazAS0uO6gL8jikkSElFQDU2KxR1bN/tSiXddeP5zzoEXk
  +zK1c5+Pd7q8iNywYdGr6yd7SyRaff/rbHFJ2mOz7q3XnF97v5fdWvxJ/uq0+omh7xR49ngdF
  N1qsm+C3+UKIWvFiuD6dX6xG2zZfyQeXX/+8fkHnoGS7sZTTGcmnP/Qcd7Y71K0yyftmYdClr
  UVXsrxspq30zL3ifnBd3GNOyv31vt6qnu8fyDaa1x28P/fj4lfGv7e5at4I+4d11lb92DZx/o
  DP+e/uvzoycEK3+dWzzZK/t0y9Xh/4oqCIG9u7nCjCUlezzikNCdd837abvnux3nfENMNXn+e
  rn54co5H11Z3/iRe7S92N2YmyRXZl4rlxHe+XbjCVWjC914lluKMREMt5qLiRAALVClxeQMAA
  A==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-565.messagelabs.com!1649329838!1459!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3257 invoked from network); 7 Apr 2022 11:10:38 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-20.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2022 11:10:38 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 3F275100468;
        Thu,  7 Apr 2022 12:10:38 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 31C03100451;
        Thu,  7 Apr 2022 12:10:38 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 7 Apr 2022 12:10:17 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 5/6] idmapped-mounts: Add setfacl(S_IXGRP) wrapper for setgid_create* cases
Date:   Thu, 7 Apr 2022 20:09:34 +0800
Message-ID: <1649333375-2599-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since stipping S_SIGID should check S_IXGRP, so using sefacl to umask it to
check whether works well.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 75 +++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index d6769f08..8f292228 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -8052,6 +8052,30 @@ static int setgid_create_umask(void)
 		return 0;
 }
 
+static int setgid_create_acl(void)
+{
+	pid_t pid;
+
+	snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx %s/%s", t_mountpoint, T_DIR1);
+	if (system(t_buf))
+		die("failure: system");
+
+	pid = fork();
+	if (pid < 0)
+		die("failure: fork");
+
+	if (pid == 0) {
+		if (setgid_create())
+			die("failure: setgid");
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		return -1;
+	else
+		return 0;
+}
+
 static int setgid_create_idmapped(void)
 {
 	int fret = -1;
@@ -8199,6 +8223,30 @@ static int setgid_create_idmapped_umask(void)
 		return 0;
 }
 
+static int setgid_create_idmapped_acl(void)
+{
+	pid_t pid;
+
+	snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx %s/%s", t_mountpoint, T_DIR1);
+	if (system(t_buf))
+		die("failure: system");
+
+	pid = fork();
+	if (pid < 0)
+		die("failure: fork");
+
+	if (pid == 0) {
+		if (setgid_create_idmapped())
+			die("failure: setgid");
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		return -1;
+	else
+		return 0;
+}
+
 static int setgid_create_idmapped_in_userns(void)
 {
 	int fret = -1;
@@ -8555,6 +8603,30 @@ static int setgid_create_idmapped_in_userns_umask(void)
 		return 0;
 }
 
+static int setgid_create_idmapped_in_userns_acl(void)
+{
+	pid_t pid;
+
+	snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx %s/%s", t_mountpoint, T_DIR1);
+	if (system(t_buf))
+		die("failure: system");
+
+	pid = fork();
+	if (pid < 0)
+		die("failure: fork");
+
+	if (pid == 0) {
+		if (setgid_create_idmapped_in_userns())
+			die("failure: setgid_create");
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		return -1;
+	else
+		return 0;
+}
+
 #define PTR_TO_INT(p) ((int)((intptr_t)(p)))
 #define INT_TO_PTR(u) ((void *)((intptr_t)(u)))
 
@@ -14164,10 +14236,13 @@ struct t_idmapped_mounts t_setattr_fix_968219708108[] = {
 struct t_idmapped_mounts t_setgid[] = {
 	{ setgid_create,						false,	"create operations in directories with setgid bit set",						},
 	{ setgid_create_umask,						false,	"create operations in directories with setgid bit set by umask(S_IXGRP)",			},
+	{ setgid_create_acl,						false,	"create operations in directories with setgid bit set by setfacl(S_IXGRP)",			},
 	{ setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
 	{ setgid_create_idmapped_umask,					true,	"create operations in directories with setgid bit set on idmapped mounts by umask(S_IXGRP)",	},
+	{ setgid_create_idmapped_acl,					true,	"create operations in directories with setgid bit set on idmapped mounts by setfacl(S_IXGRP)",	},
 	{ setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
 	{ setgid_create_idmapped_in_userns_umask,			true,   "create operations in directories with setgid bit set on idmapped mounts in user namespace by umask(S_IXGRP)",	},
+	{ setgid_create_idmapped_in_userns_acl,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace by setfacl(S_IXGRP)",},
 };
 
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
-- 
2.27.0

