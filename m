Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86451E6CB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446327AbiEGMKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446324AbiEGMKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 08:10:19 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A24165B6;
        Sat,  7 May 2022 05:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1651925190; i=@fujitsu.com;
        bh=sjN00rHRyEGXhsQgec4Y8T/bP21jIUW3AePbJpOM/1s=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=vHIwaJ+5BnBWt5e4wbqwjPYQ9YZdeVNGCYhljulTNvwvIrBztZIyKLpJSJ4iuoYq9
         zUS0/sOtqlv1Qp4ylf1Z9uTmwQq/MRgaMGohnnmDqZwb5Ia4PQYR+r5tdnQb/6c3WC
         rRaa8ULrbC1x+SW3qTRz9BSM+3xnZtA+he7a3IihfeK7PtxUjWO0rLLmfdhVKPYESk
         DIHZ2nhNOlj3jvcua0JUwtUaD9PHTe7Is+jqE1LEZLTXhVfAKP8Q3cI8GY+EgWD++1
         kBZqzcicvuadHVVI1A2VC//UmcqtoD3TfX22eLwGo1njQobKsGqtCCtgTWGQnRhN6Q
         4M2ZvLOwShXug==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRWlGSWpSXmKPExsViZ8MxSfdoQlm
  Swd+dWhavD39itNhy7B6jxeUnfBanW/ayW+zZe5LFgdXj1CIJj02rOtk8Pm+SC2COYs3MS8qv
  SGDNuP0lpqAzruLO6rWsDYxffbsYuTiEBLYwSlxZcpgFwlnAJNF3rZ8ZwtnNKLF1yzmgDCcHm
  4CmxLPOBcwgtoiAi8S3/X/ZQGxmgRSJhvNNjCC2sICvxKquv0wgNouAisSHLVvBenkFPCTu7H
  wFViMhoCAx5eF7sDmcAp4SbYvbWUFsIaCaFf9ms0PUC0qcnPmEBWK+hMTBFy+YIXoVJS51fIO
  aUyExa1YbE4StJnH13CbmCYyCs5C0z0LSvoCRaRWjVVJRZnpGSW5iZo6uoYGBrqGhqa6hrpGB
  sV5ilW6iXmqpbnlqcYmuoV5iebFeanGxXnFlbnJOil5easkmRmDopxQznt7BuKnvp94hRkkOJ
  iVR3hab0iQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErwfY8uShASLUtNTK9Iyc4BxCJOW4OBREu
  FljgZK8xYXJOYWZ6ZDpE4x6nL8/fR3L7MQS15+XqqUOK9RPFCRAEhRRmke3AhYSrjEKCslzMv
  IwMAgxFOQWpSbWYIq/4pRnINRSZhXFWQKT2ZeCdymV0BHMAEd8TGgFOSIkkSElFQD0xI/Z3v+
  efX8C8Mjjb9KdX5cMHtrIVP6X921vJfK2TbwGd/3W3OgJmZS3fwtv/kvu3hZnKhUbHrFL/Fg8
  gr/GO8O/hlvK25OLVhutmq3x/FjhevdezXOBm4S8t0Z8k/7+3fN/TlXqu6yud7dajXb724Wk6
  nMMqXe2skfTsq4u/31Ko/edfhf3KadL154rzcX/slxYlvhEYedkR6LH5wTOZ039aXlt+2/P07
  hiVn/32Pa2pDGtaE3/COyitk99C2NlpWahJcs/bYjvvp+8K8XUbHLI52bRY8+m+J+h/vR8iOe
  CXd+aBvebkzb2aHFdO/C3o/9p658jgjJUzX8uvnHK8bvy+b57fkhxjMrmCHptZ0SS3FGoqEWc
  1FxIgBesjVlhAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-587.messagelabs.com!1651925189!68821!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20558 invoked from network); 7 May 2022 12:06:29 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-9.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 May 2022 12:06:29 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 267FA100353;
        Sat,  7 May 2022 13:06:29 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 17D381000FF;
        Sat,  7 May 2022 13:06:29 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sat, 7 May 2022 13:06:13 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v4 2/3] idmapped-mounts: Add mknodat operation in setgid test
Date:   Sat, 7 May 2022 21:05:25 +0800
Message-ID: <1651928726-2263-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651928726-2263-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1651928726-2263-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since mknodat can create file, we should also check whether strip S_ISGID.
Also add new helper caps_down_fsetid to drop CAP_FSETID because strip S_ISGID
depend on this cap and keep other cap(ie CAP_MKNOD) because create character
device needs it when using mknod.

Only test mknodat with character device in setgid_create function and the another
two functions test mknodat with whiteout device.

Since kernel commit a3c751a50 ("vfs: allow unprivileged whiteout creation") in
v5.8-rc1, we can create whiteout device in userns test. Since kernel 5.12, mount_setattr
and MOUNT_ATTR_IDMAP was supported, we don't need to detect kernel whether allow
unprivileged whiteout creation. Using fs_allow_idmap as a proxy is safe.

Tested-by: Christian Brauner (Microsoft)<brauner@kernel.org>
Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v3->v4: add comment for cap_down_fsetid helper
 src/idmapped-mounts/idmapped-mounts.c | 222 +++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 7 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 2e94bf71..a1c22da2 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -243,6 +243,35 @@ static inline bool caps_supported(void)
 	return ret;
 }
 
+/* caps_down_fsetid - lower CAP_FSETID effective cap */
+static int caps_down_fsetid(void)
+{
+	bool fret = false;
+#ifdef HAVE_SYS_CAPABILITY_H
+	cap_t caps = NULL;
+	cap_value_t cap = CAP_FSETID;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	ret = cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, 0);
+	if (ret)
+		goto out;
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+
+out:
+	cap_free(caps);
+#endif
+	return fret;
+}
+
 /* caps_down - lower all effective caps */
 static int caps_down(void)
 {
@@ -7807,9 +7836,9 @@ out_unmap:
 #endif /* HAVE_LIBURING_H */
 
 /* The following tests are concerned with setgid inheritance. These can be
- * filesystem type specific. For xfs, if a new file or directory is created
- * within a setgid directory and irix_sgid_inhiert is set then inherit the
- * setgid bit if the caller is in the group of the directory.
+ * filesystem type specific. For xfs, if a new file or directory or node is
+ * created within a setgid directory and irix_sgid_inhiert is set then inherit
+ * the setgid bit if the caller is in the group of the directory.
  */
 static int setgid_create(void)
 {
@@ -7865,18 +7894,44 @@ static int setgid_create(void)
 		if (!is_setgid(t_dir1_fd, DIR1, 0))
 			die("failure: is_setgid");
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(t_dir1_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (!is_setgid(t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (unlinkat(t_dir1_fd, FILE1, 0))
 			die("failure: delete");
 
 		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
+		if (unlinkat(t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -7891,8 +7946,8 @@ static int setgid_create(void)
 		if (!switch_ids(0, 10000))
 			die("failure: switch_ids");
 
-		if (!caps_down())
-			die("failure: caps_down");
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
 
 		/* create regular file via open() */
 		file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
@@ -7919,6 +7974,19 @@ static int setgid_create(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(t_dir1_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (is_setgid(t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -7935,6 +8003,24 @@ static int setgid_create(void)
 		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(t_dir1_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8037,6 +8123,20 @@ static int setgid_create_idmapped(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -8053,6 +8153,24 @@ static int setgid_create_idmapped(void)
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8151,18 +8269,44 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!is_setgid(open_tree_fd, DIR1, 0))
 			die("failure: is_setgid");
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
 
 		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8192,9 +8336,12 @@ static int setgid_create_idmapped_in_userns(void)
 			exit(EXIT_SUCCESS);
 		}
 
-		if (!switch_userns(attr.userns_fd, 0, 0, true))
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -8220,6 +8367,20 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -8236,12 +8397,24 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 1000))
+			die("failure: check ownership");
+
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
 
 		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8268,9 +8441,12 @@ static int setgid_create_idmapped_in_userns(void)
 			exit(EXIT_SUCCESS);
 		}
 
-		if (!switch_userns(attr.userns_fd, 0, 1000, true))
+		if (!switch_userns(attr.userns_fd, 0, 1000, false))
 			die("failure: switch_userns");
 
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -8297,12 +8473,44 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
-- 
2.31.1

