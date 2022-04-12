Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9D4FDE84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348608AbiDLLuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 07:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355043AbiDLLtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:49:09 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270B965D3;
        Tue, 12 Apr 2022 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649759627; i=@fujitsu.com;
        bh=rsWNElBYKxD76xRqoti8fLFU5SgVLPmvtambBsME55w=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=BhY7NDGBveU1jolOKuM2jx1jPay2HjjKLUAK5D9g7XHiLlr+IHWX/m8d7dTNVcMvD
         tCgvgPHkXMjDNg8I883nQLusvblMh7zOkJ0hWs32ZTvP6K/uA1i0eGDkCCWPwHk3Y1
         D/EnIeAVpCBbkNuOjAVKEG7rhA7919nbYX0P/5QeS9fEfMCNXYNc8eluy9lwqFenX1
         VDEFrzhHcUf2vopIw89UHqjUzGBx6zA7Fh0DL0kKJLo+UNkZooGAUiVvkBJCU49Tr4
         uUDclhPut9tJk2gUP0DdM8GL0EihoJ/LwF0rDD+1TUKUfPqqoggOIFbpCZd6zY24Fr
         N4eJnlAJYSFvA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRWlGSWpSXmKPExsViZ8ORqNsdGpp
  kcLmDzeL14U+MFluO3WO0uPyEz+J0y152iz17T7I4sHqcWiThsWlVJ5vH501yAcxRrJl5SfkV
  CawZb68KFXx1qFi18ARTA+MK0y5GLg4hgS2MEksP/2ODcBYwSSy4uoERwtnDKNHTfpe1i5GTg
  01AU+JZ5wJmEFtEwEXi2/6/bCA2s0CKRMP5JkYQW1ggUmLN8+dg9SwCqhIrZ/4Fq+cV8JDY2t
  fABGJLCChITHn4HizOKeApMenIPhYQWwioZkbrajaIekGJkzOfsEDMl5A4+OIFM0SvosSljm+
  MEHaFxKxZbVAz1SSuntvEPIFRcBaS9llI2hcwMq1itEwqykzPKMlNzMzRNTQw0DU0NNU11DW1
  1Eus0k3USy3VLU8tLtE11EssL9ZLLS7WK67MTc5J0ctLLdnECAz8lGJG6x2MHX0/9Q4xSnIwK
  YnyGvCEJgnxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4JULBsoJFqWmp1akZeYAoxAmLcHBoyTCGx
  sIlOYtLkjMLc5Mh0idYlSUEudtDAFKCIAkMkrz4NpgkX+JUVZKmJeRgYFBiKcgtSg3swRV/hW
  jOAejkjAvP8gUnsy8Erjpr4AWMwEtDt0WCLK4JBEhJdXAxN0/6Y/e6wkctif5FzeZ3K9XPyxR
  ctb+jP+yiueM8y2PHWPl1DypvVRupdHchGOBV85scVr3SkI17ubtPfsr+LkzM++0sR2fcrVz+
  dpjPGdvntjO0mx16tU96ycvtjvZyLNoKDCqNp9qLPjpvFlumurBos4fm/9uzPYNK5FUe7h/AY
  +Fov33if2mKk9Dk0uYZTUzL6rwJiX6yS59FfqjNMetcPuz0jeHL7DlLXw0IW7hkerFv34fai6
  zvhk9c4KN5CluOZf+Ws7XW1s/yQVVXrCSWsrzwyRuz3JJL6ujzUEKG+3Dg3SjU2ft5/vzeOlt
  9YfKV/qldvF/YrDPeiv8w2nT8i7T92/EH5nrKTdtV2Ipzkg01GIuKk4EAJlAiqV3AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-585.messagelabs.com!1649759626!109095!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25695 invoked from network); 12 Apr 2022 10:33:47 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-14.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Apr 2022 10:33:47 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 504E3100197;
        Tue, 12 Apr 2022 11:33:46 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 0FA2B100184;
        Tue, 12 Apr 2022 11:33:46 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 12 Apr 2022 11:33:24 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 3/5] idmapped-mounts: Add open with O_TMPFILE operation in setgid test
Date:   Tue, 12 Apr 2022 19:33:44 +0800
Message-ID: <1649763226-2329-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Since we can create temp file by using O_TMPFILE flag and filesystem driver also
has this api, we should also check this operation whether strip S_ISGID.

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 148 ++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 617f56e0..02f91558 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -51,6 +51,7 @@
 #define FILE1_RENAME "file1_rename"
 #define FILE2 "file2"
 #define FILE2_RENAME "file2_rename"
+#define FILE3 "file3"
 #define DIR1 "dir1"
 #define DIR2 "dir2"
 #define DIR3 "dir3"
@@ -337,6 +338,24 @@ out:
 	return fret;
 }
 
+static bool openat_tmpfile_supported(int dirfd)
+{
+	int fd = -1;
+
+	fd = openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+	if (fd == -1) {
+		if (errno == ENOTSUP)
+			return false;
+		else
+			return log_errno(false, "failure: create");
+	}
+
+	if (close(fd))
+		log_stderr("failure: close");
+
+	return true;
+}
+
 /* __expected_uid_gid - check whether file is owned by the provided uid and gid */
 static bool __expected_uid_gid(int dfd, const char *path, int flags,
 			       uid_t expected_uid, gid_t expected_gid, bool log)
@@ -7841,7 +7860,10 @@ static int setgid_create(void)
 {
 	int fret = -1;
 	int file1_fd = -EBADF;
+	int tmpfile_fd = -EBADF;
 	pid_t pid;
+	bool supported = false;
+	char path[PATH_MAX];
 
 	if (!caps_supported())
 		return 0;
@@ -7866,6 +7888,8 @@ static int setgid_create(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(t_dir1_fd);
+
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -7929,6 +7953,25 @@ static int setgid_create(void)
 		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, t_dir1_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (!is_setgid(t_dir1_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(t_dir1_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(t_dir1_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8018,6 +8061,25 @@ static int setgid_create(void)
 		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, t_dir1_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(t_dir1_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(t_dir1_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(t_dir1_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8039,6 +8101,9 @@ static int setgid_create_idmapped(void)
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
+	char path[PATH_MAX];
 
 	if (!caps_supported())
 		return 0;
@@ -8086,6 +8151,8 @@ static int setgid_create_idmapped(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(open_tree_fd);
+
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -8168,6 +8235,25 @@ static int setgid_create_idmapped(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 10000, 10000))
+				die("failure: check ownership");
+			if  (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8191,6 +8277,9 @@ static int setgid_create_idmapped_in_userns(void)
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
+	char path[PATH_MAX];
 
 	if (!caps_supported())
 		return 0;
@@ -8238,6 +8327,8 @@ static int setgid_create_idmapped_in_userns(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(open_tree_fd);
+
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -8304,6 +8395,25 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (!is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8412,6 +8522,25 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 1000))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8508,6 +8637,25 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
-- 
2.27.0

