Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F684F7D9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 13:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiDGLLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 07:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiDGLLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:11:41 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7584C79C;
        Thu,  7 Apr 2022 04:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649329780; i=@fujitsu.com;
        bh=HYwCKl4z98TADFdf0eWLoI2P43SeKLX0xz+CWJSnsIY=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=GDwpLOmkAdnLl0HmUWfWoOAqSoaSyys7G5q3RI+b1p2zSN4Upun3bcBpv51yIZj0C
         Xv2RCAVvfsOoQWTMZtZ10Smhy9xMwZiy6Lu0L/DCQ9CQpBIsz57wBbQXu+WAEwAsYh
         rT2Jm71WpVx9L9p/yPIuirI380cjwKnSoiorCsARxwb8cI6u67dRSiG/vhpH5uI1ky
         5bRJNawFaJ6jMFOlZcoj5UUu9JtXBL+hkTD+cst04FA5RJrA6AdXaFz7AQ6WygXVOK
         CZr0NfVgpwn0FnaTyiZ98w/zDIgvi+hDQLHLHj1dbO4H5Aay0zYEh4RdeEMyXbOoQL
         sDAyVmibR6IdA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRWlGSWpSXmKPExsViZ8MxSTfnmF+
  SwZc/uhavD39itNhy7B6jxeUnfBanW/ayW+zZe5LFgdXj1CIJj02rOtk8Pm+SC2COYs3MS8qv
  SGDN2LZtD3PBPrWKlgmd7A2MU+W7GLk4hAS2MErsO72WtYuRE8hZwCSxZ2YURGI3o8TK3bvZQ
  RJsApoSzzoXMIPYIgIuEt/2/2UDsZkFUiQazjcxgtjCAh4St9sPsoDYLAIqEremH2cCsXmB4o
  2zroHVSwgoSEx5+J4ZIi4ocXLmExaIORISB1+8YIaoUZS41PGNEcKukJg1q40JwlaTuHpuE/M
  ERv5ZSNpnIWlfwMi0itEqqSgzPaMkNzEzR9fQwEDX0NBU19hI19BEL7FKN1EvtVS3PLW4RNdI
  L7G8WC+1uFivuDI3OSdFLy+1ZBMjMJRTihX4djA2r/qpd4hRkoNJSZS3YadfkhBfUn5KZUZic
  UZ8UWlOavEhRhkODiUJ3sQjQDnBotT01Iq0zBxgXMGkJTh4lER4jx4GSvMWFyTmFmemQ6ROMS
  pKifPmHQVKCIAkMkrz4NpgsXyJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjCvBsgUnsy8Erj
  pr4AWMwEtrjvoC7K4JBEhJdXAZLPn7K51frErZzyYyG0aHVVgYVTF+o5r34py7cmz3xYnZRue
  M3x/Lygl/uu/Cb2zSrTrHr67p3D8ik+tVdfHuMjL6dsrhO2uiHvv3pt7LJ7z56q5BYl5dpNyH
  b9rXf3DOf8Jd1JCzrKDctsPHRCo7RdZGrI5t3np36yv8ssSWt8J6vUs8iiM5rJLDyvpc5DL5E
  7WeJ9Qb1D35p2QZeXhmKbuOBmnn/wGC7v2dFY+ttthyNZuf8FWSjh0UlHzd+sv6oIKD3lu2iZ
  lPA3MWKj38T3vdbZdRcnXrzNbebHunSI8KcZ92+RDKRuUZUQ7eOKDdrtv6TVeckWAu6bj+lS7
  W//m3WeIe5fg8lqpap0SS3FGoqEWc1FxIgA22TCYYAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-565.messagelabs.com!1649329772!1412!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28980 invoked from network); 7 Apr 2022 11:09:32 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-12.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2022 11:09:32 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 4B61C100464;
        Thu,  7 Apr 2022 12:09:32 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 3DE37100441;
        Thu,  7 Apr 2022 12:09:32 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 7 Apr 2022 12:09:09 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 1/6] idmapped-mount: split setgid test from test-core
Date:   Thu, 7 Apr 2022 20:09:30 +0800
Message-ID: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
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

Since we plan to increase setgid test covertage, it will find new bug
, so add a new test group test-setgid is better.

Also add a new test case to test test-setgid instead of miss it.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 19 +++++++++++++++----
 tests/generic/999                     | 26 ++++++++++++++++++++++++++
 tests/generic/999.out                 |  2 ++
 3 files changed, 43 insertions(+), 4 deletions(-)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 4cf6c3bb..dff6820f 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -13809,6 +13809,7 @@ static void usage(void)
 	fprintf(stderr, "--test-nested-userns                Run nested userns idmapped mount testsuite\n");
 	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
 	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
+	fprintf(stderr, "--test-setgid                       Run setgid create tests\n");
 
 	_exit(EXIT_SUCCESS);
 }
@@ -13826,6 +13827,7 @@ static const struct option longopts[] = {
 	{"test-nested-userns",			no_argument,		0,	'n'},
 	{"test-btrfs",				no_argument,		0,	'b'},
 	{"test-setattr-fix-968219708108",	no_argument,		0,	'i'},
+	{"test-setgid",				no_argument,		0,	'j'},
 	{NULL,					0,			0,	  0},
 };
 
@@ -13866,9 +13868,6 @@ struct t_idmapped_mounts {
 	{ setattr_truncate,						false,	"setattr truncate",										},
 	{ setattr_truncate_idmapped,					true,	"setattr truncate on idmapped mounts",								},
 	{ setattr_truncate_idmapped_in_userns,				true,	"setattr truncate on idmapped mounts in user namespace",					},
-	{ setgid_create,						false,	"create operations in directories with setgid bit set",						},
-	{ setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
-	{ setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
 	{ setid_binaries,						false,	"setid binaries on regular mounts",								},
 	{ setid_binaries_idmapped_mounts,				true,	"setid binaries on idmapped mounts",								},
 	{ setid_binaries_idmapped_mounts_in_userns,			true,	"setid binaries on idmapped mounts in user namespace",						},
@@ -13923,6 +13922,12 @@ struct t_idmapped_mounts t_setattr_fix_968219708108[] = {
 	{ setattr_fix_968219708108,					true,	"test that setattr works correctly",								},
 };
 
+struct t_idmapped_mounts t_setgid[] = {
+	{ setgid_create,						false,	"create operations in directories with setgid bit set",						},
+	{ setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
+	{ setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
+};
+
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 {
 	int i;
@@ -14000,7 +14005,7 @@ int main(int argc, char *argv[])
 	int index = 0;
 	bool supported = false, test_btrfs = false, test_core = false,
 	     test_fscaps_regression = false, test_nested_userns = false,
-	     test_setattr_fix_968219708108 = false;
+	     test_setattr_fix_968219708108 = false, test_setgid = false;
 
 	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
 		switch (ret) {
@@ -14037,6 +14042,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			test_setattr_fix_968219708108 = true;
 			break;
+		case 'j':
+			test_setgid = true;
+			break;
 		case 'h':
 			/* fallthrough */
 		default:
@@ -14106,6 +14114,9 @@ int main(int argc, char *argv[])
 		      ARRAY_SIZE(t_setattr_fix_968219708108)))
 		goto out;
 
+	if (test_setgid && !run_test(t_setgid, ARRAY_SIZE(t_setgid)))
+		goto out;
+
 	fret = EXIT_SUCCESS;
 
 out:
diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..46a34804
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved
+#
+# FS QA Test 999
+#
+# Test that setgid bit behave correctly.
+#
+. ./common/preamble
+_begin_fstest auto quick cap idmapped mount perms rw
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs generic
+_require_test
+
+echo "Silence is golden"
+
+$here/src/idmapped-mounts/idmapped-mounts --test-setgid --device "$TEST_DEV" \
+	--mount "$TEST_DIR" --fstype "$FSTYP"
+
+status=$?
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..3b276ca8
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Silence is golden
-- 
2.27.0

