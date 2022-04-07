Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C094F7DA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 13:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiDGLNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 07:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiDGLNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:13:23 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ACD16592;
        Thu,  7 Apr 2022 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649329880; i=@fujitsu.com;
        bh=FJuR1EOUMji0eqnLNa4QcheQalD0sFicovpWA0I+gTs=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=dsAV8imnrLDfC/bm5GAmBJnxGCV4q42EoIqr9/IzoXmY2J50u1Z3xxuvFcUTLEJht
         wb6L2k9Ksp6SF+Fexr6jABMecSPcNgdq0PwqVO5cw+qQ9gAFNYcRnb6CJGoElWyYZW
         PheKSYaT6IUleRWMoUB4TcEl5yPduSZNzYF1y6gFGOJihrVyyWgnD27FsykIN7dd+j
         sXi3+Tss39sxm+hRamhyHQ0plVTYmH043w7FMYdCs/QtigAOEwQgQPYq2H+KEcGqol
         2j5EgKNE43PBbbi+0UTHZatY0bWVSk1z6OlQfq1/ev3inLcdj7x8HT1b7Z0LUfF2O1
         69Xy0B9BddrZw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRWlGSWpSXmKPExsViZ8ORqHv9mF+
  SwblJKhavD39itNhy7B6jxeUnfBanW/ayW+zZe5LFgdXj1CIJj02rOtk8Pm+SC2COYs3MS8qv
  SGDN+D91N2vBgYiKt49vsDcwnvHoYuTkEBLYwijR+S6ri5ELyF7AJDF7y3omCGc3o8SFx3PYQ
  arYBDQlnnUuYAaxRQRcJL7t/8sGYjMLpEg0nG9iBLGFBSIlls+7wgpiswioSCztPAYW5xXwkN
  h14ylYvYSAgsSUh+/B5nAKeErcffydDeIKD4nmGzOg6gUlTs58wgIxX0Li4IsXzBC9ihKXOr4
  xQtgVErNmtTFB2GoSV89tYp7AKDgLSfssJO0LGJlWMdomFWWmZ5TkJmbm6BoaGOgaGprqmpnp
  WprpJVbpJuqlluomp+aVFCUCZfUSy4v1UouL9Yorc5NzUvTyUks2MQIjIKXYKWEH46O+n3qHG
  CU5mJREeRt2+iUJ8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuBNPAKUEyxKTU+tSMvMAUYjTFqCg0
  dJhPfoYaA0b3FBYm5xZjpE6hSjopQ47/ujQAkBkERGaR5cGywBXGKUlRLmZWRgYBDiKUgtys0
  sQZV/xSjOwagkzCsOTCdCPJl5JXDTXwEtZgJaXHfQF2RxSSJCSqqBqdBi/5/kJWtMTutWNr94
  UP7+iFHJC35zTgkOleJzkoazbPd97ZzbqbSsaYGJav7TggXc77LtlFTv/t3oWrFg5ckdtZ2CA
  SZcViIiV9al3NrS1Mqj9MPP6kHLLEWNiCV1bor6XpJZPxr8nrGmqAlrpk9Y/uE9s4SJxHmdgp
  K/Z2tyj/d9Pu1edvide7CK3O2P51eu0A4Tvp+r+u3GjjneeuU16zW6FSZ+W1i3PU/Q6qCYqWH
  UgbcfZpXd/hjPNmFb9L5e6y7u81pPY3dlPmB9Udu869EZPpZFDO/W/38kKbXCvXKxzMZXDKFb
  Yp6/njVzg+NT3nmNKxTFv1xaUhH1juX3jPXMuyRi79Ys7H+rocRSnJFoqMVcVJwIAB1wATp7A
  wAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-25.tower-528.messagelabs.com!1649329879!1667!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9134 invoked from network); 7 Apr 2022 11:11:19 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-25.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2022 11:11:19 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 027EA100199;
        Thu,  7 Apr 2022 12:11:19 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id CFFA1100190;
        Thu,  7 Apr 2022 12:11:18 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 7 Apr 2022 12:11:12 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 6/6] idmapped-mounts: Add open with O_TMPFILE operation in setgid test
Date:   Thu, 7 Apr 2022 20:09:35 +0800
Message-ID: <1649333375-2599-6-git-send-email-xuyang2018.jy@fujitsu.com>
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

Since we can create temp file by using O_TMPFILE flag and filesystem driver also
has this api, we should also check this operation whether strip S_ISGID.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 155 +++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 8f292228..362b8820 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -337,6 +337,24 @@ out:
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
@@ -7841,7 +7859,10 @@ static int setgid_create(void)
 {
 	int fret = -1;
 	int file1_fd = -EBADF;
+	int tmpfile_fd = -EBADF;
 	pid_t pid;
+	bool supported = false;
+	char path[PATH_MAX];
 
 	if (!caps_supported())
 		return 0;
@@ -7866,6 +7887,8 @@ static int setgid_create(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(t_dir1_fd);
+
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -7883,9 +7906,24 @@ static int setgid_create(void)
 		if (!is_setgid(t_dir1_fd, FILE1, 0))
 			die("failure: is_setgid");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, t_dir1_fd, FILE2, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (!is_setgid(t_dir1_fd, FILE2, 0))
+				die("failure: is_setgid");
+		}
+
 		/* create directory */
 		if (mkdirat(t_dir1_fd, DIR1, 0000))
-			die("failure: create");
+			die("failure: mkdirat");
 
 		/* Directories always inherit the setgid bit. */
 		if (!is_setgid(t_dir1_fd, DIR1, 0))
@@ -7908,6 +7946,9 @@ static int setgid_create(void)
 		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (supported && !expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (!expected_uid_gid(t_dir1_fd, DIR1 "/" FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
@@ -7920,6 +7961,9 @@ static int setgid_create(void)
 		if (unlinkat(t_dir1_fd, FILE1, 0))
 			die("failure: delete");
 
+		if (supported && unlinkat(t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
 		if (unlinkat(t_dir1_fd, DIR1 "/" FILE1, 0))
 			die("failure: delete");
 
@@ -7957,6 +8001,21 @@ static int setgid_create(void)
 		if (is_setgid(t_dir1_fd, FILE1, 0))
 			die("failure: is_setgid");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, t_dir1_fd, FILE2, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(t_dir1_fd, FILE2, 0))
+				die("failure: is_setgid");
+		}
+
 		/* create directory */
 		if (mkdirat(t_dir1_fd, DIR1, 0000))
 			die("failure: create");
@@ -7992,6 +8051,9 @@ static int setgid_create(void)
 		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (supported && !expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
 		/*
 		 * In setgid directories newly created directories always
 		 * inherit the gid from the parent directory. Verify that the
@@ -8009,6 +8071,9 @@ static int setgid_create(void)
 		if (unlinkat(t_dir1_fd, FILE1, 0))
 			die("failure: delete");
 
+		if (supported && unlinkat(t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
 		if (unlinkat(t_dir1_fd, DIR1 "/" FILE1, 0))
 			die("failure: delete");
 
@@ -8083,7 +8148,10 @@ static int setgid_create_idmapped(void)
 	struct mount_attr attr = {
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
+	int tmpfile_fd = -EBADF;
 	pid_t pid;
+	bool supported = false;
+	char path[PATH_MAX];
 
 	if (!caps_supported())
 		return 0;
@@ -8131,6 +8199,7 @@ static int setgid_create_idmapped(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(open_tree_fd);
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -8151,6 +8220,21 @@ static int setgid_create_idmapped(void)
 		if (is_setgid(open_tree_fd, FILE1, 0))
 			die("failure: is_setgid");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE2, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE2, 0))
+				die("failure: is_setgid");
+		}
+
 		/* create directory */
 		if (mkdirat(open_tree_fd, DIR1, 0000))
 			die("failure: create");
@@ -8173,6 +8257,9 @@ static int setgid_create_idmapped(void)
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 10000, 10000))
 			die("failure: check ownership");
 
+		if (supported && !expected_uid_gid(open_tree_fd, FILE2, 0, 10000, 10000))
+			die("failure: check ownership");
+
 		/*
 		 * In setgid directories newly created directories always
 		 * inherit the gid from the parent directory. Verify that the
@@ -8254,7 +8341,10 @@ static int setgid_create_idmapped_in_userns(void)
 	struct mount_attr attr = {
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
+	int tmpfile_fd = -EBADF;
 	pid_t pid;
+	bool supported = false;
+	char path[PATH_MAX];
 
 	if (!caps_supported())
 		return 0;
@@ -8302,6 +8392,7 @@ static int setgid_create_idmapped_in_userns(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(open_tree_fd);
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -8322,6 +8413,21 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!is_setgid(open_tree_fd, FILE1, 0))
 			die("failure: is_setgid");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE2, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (!is_setgid(open_tree_fd, FILE2, 0))
+				die("failure: is_setgid");
+		}
+
 		/* create directory */
 		if (mkdirat(open_tree_fd, DIR1, 0000))
 			die("failure: create");
@@ -8346,6 +8452,9 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (supported && !expected_uid_gid(open_tree_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
@@ -8357,6 +8466,8 @@ static int setgid_create_idmapped_in_userns(void)
 
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
+		if (supported && unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
 		if (unlinkat(open_tree_fd, DIR1 "/" FILE1, 0))
 			die("failure: delete");
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
@@ -8410,6 +8521,21 @@ static int setgid_create_idmapped_in_userns(void)
 		if (is_setgid(open_tree_fd, FILE1, 0))
 			die("failure: is_setgid");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE2, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE2, 0))
+				die("failure: is_setgid");
+		}
+
 		/* create directory */
 		if (mkdirat(open_tree_fd, DIR1, 0000))
 			die("failure: create");
@@ -8446,6 +8572,9 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 1000))
 			die("failure: check ownership");
 
+		if (supported && !expected_uid_gid(open_tree_fd, FILE2, 0, 0, 1000))
+			die("failure: check ownership");
+
 		/*
 		 * In setgid directories newly created directories always
 		 * inherit the gid from the parent directory. Verify that the
@@ -8463,6 +8592,9 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
 
+		if (supported && unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
 		if (unlinkat(open_tree_fd, DIR1 "/" FILE1, 0))
 			die("failure: delete");
 
@@ -8515,6 +8647,21 @@ static int setgid_create_idmapped_in_userns(void)
 		if (is_setgid(open_tree_fd, FILE1, 0))
 			die("failure: is_setgid");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE2, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE2, 0))
+				die("failure: is_setgid");
+		}
+
 		/* create directory */
 		if (mkdirat(open_tree_fd, DIR1, 0000))
 			die("failure: create");
@@ -8546,6 +8693,9 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (supported && !expected_uid_gid(open_tree_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
@@ -8558,6 +8708,9 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
 
+		if (supported && unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
 		if (unlinkat(open_tree_fd, DIR1 "/" FILE1, 0))
 			die("failure: delete");
 
-- 
2.27.0

