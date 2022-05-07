Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA551E6CC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 14:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446330AbiEGMKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 08:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352692AbiEGMKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 08:10:18 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0484E167D3;
        Sat,  7 May 2022 05:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1651925190; i=@fujitsu.com;
        bh=0JRoWl3GcAuQWOkluKc6JM/Ym+olUerUbxVko1Fe4e4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=QA6zcl+n5MTX3hZwMaSpaMp9kyQstV90bTKvkXfd+JZ0ckA2uxIW/il2zED717cvN
         fJWrjJ/vne/kyq8Yk4D+slI2ti4T0Qdk2/Nl5L48hFUJc2CLP7l6WKuJHqYZIxSlYi
         3b+7RdDsN1Zoyoc5d1ZjUVW6ctewi+PZewIm9g0Rde6b11gMf2Rz9NXnRXyJsYuG7s
         BjRYSzpoKeIDt7qa2wjBDF7jY7kn8AN6IXRJWP3RLhSFDcaJVSJ9Xfcm5/z0OdFgUX
         M4RFLkrGKIIroGBfv+w7ZIoO8h0f7A+VSZ4cEjCYOPcQx1Ohqr1tko2KKi07Zj/IRi
         AEnCqt0BR0ZfQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRWlGSWpSXmKPExsViZ8MxSfdoQlm
  SwZ9bmhavD39itNhy7B6jxeUnfBanW/ayW+zZe5LFgdXj1CIJj02rOtk8Pm+SC2COYs3MS8qv
  SGDNuNN9h62g365i4Z0m9gbGl0ZdjFwcQgJbGCXuT9vDBOEsYJL4vmEdK4Szm1Fi56tdzF2Mn
  BxsApoSzzoXgNkiAi4S3/b/ZQOxmQVSJBrONzGC2MICkRI7l80Di7MIqEis2L+RFcTmFfCQmD
  z5IJgtIaAgMeXhe7A5nAKeEm2L28HiQkA1K/7NZoeoF5Q4OfMJC8R8CYmDL14wQ/QqSlzq+MY
  IYVdIzJrVxgRhq0lcPbeJeQKj4Cwk7bOQtC9gZFrFaJdUlJmeUZKbmJmja2hgoGtoaKprZqZr
  aGqql1ilm6iXWqqbnJpXUpQIlNZLLC/WSy0u1iuuzE3OSdHLSy3ZxAiMgpRip9k7GHf0/dQ7x
  CjJwaQkyttiU5okxJeUn1KZkVicEV9UmpNafIhRhoNDSYL3Y2xZkpBgUWp6akVaZg4wImHSEh
  w8SiK8zNFAad7igsTc4sx0iNQpRkUpcV6jeKCEAEgiozQPrg2WBC4xykoJ8zIyMDAI8RSkFuV
  mlqDKv2IU52BUEuZVBZnCk5lXAjf9FdBiJqDFHwNKQRaXJCKkpBqYyp1fTPr18nxqcpHfoUMv
  rsXNnrTrW1ffk7YE2RLBJfYTNwVwdyy+WrDkB+eRvRfkO8oicqOeLO3zFp37zm1hQg7zveqtu
  /PPP07Zk/Ww41V63+2fetcfyxbmntFpFVxylTOw3Vl4xro1rA/C2JtM7iRPFpr9Y4LnLp7bG/
  doXk08d2n2qcRNBjYs2xbvCotbsrvzW8a7yS8Ek5V4z5zSdK7SFYkL5fLM2cPP+rWg30hW46/
  +qY6FMZYe+0NvPOtnifbTsPOZGX/H/NMHN/2ijR5hm++KGO77XXb3tKOXS8zGvvcKgoJ759fw
  Rl8osTipcGotzxfmsFfx89tXftmQMHP17wzNWU+efNpWn/o9WYmlOCPRUIu5qDgRAH23me19A
  wAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-545.messagelabs.com!1651925189!161158!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10162 invoked from network); 7 May 2022 12:06:29 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-4.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 May 2022 12:06:29 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 2E157100441;
        Sat,  7 May 2022 13:06:29 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 2042F10034F;
        Sat,  7 May 2022 13:06:29 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sat, 7 May 2022 13:06:18 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v4 3/3] idmapped-mounts: Add open with O_TMPFILE operation in setgid test
Date:   Sat, 7 May 2022 21:05:26 +0800
Message-ID: <1651928726-2263-3-git-send-email-xuyang2018.jy@fujitsu.com>
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

Since we can create temp file by using O_TMPFILE flag and filesystem driver also
has this api, we should also check this operation whether strip S_ISGID.

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v3->v4: use linkat with AT_EMPTY_PATH to make the temporary file permanent
instead of snprint and link with AT_SYMLINK_FOLLOW
 src/idmapped-mounts/idmapped-mounts.c | 139 ++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index a1c22da2..8fe06408 100644
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
@@ -340,6 +341,24 @@ out:
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
@@ -7844,7 +7863,9 @@ static int setgid_create(void)
 {
 	int fret = -1;
 	int file1_fd = -EBADF;
+	int tmpfile_fd = -EBADF;
 	pid_t pid;
+	bool supported = false;
 
 	if (!caps_supported())
 		return 0;
@@ -7869,6 +7890,8 @@ static int setgid_create(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(t_dir1_fd);
+
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -7932,6 +7955,24 @@ static int setgid_create(void)
 		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", t_dir1_fd, FILE3, AT_EMPTY_PATH))
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
@@ -8021,6 +8062,24 @@ static int setgid_create(void)
 		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", t_dir1_fd, FILE3, AT_EMPTY_PATH))
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
@@ -8042,6 +8101,8 @@ static int setgid_create_idmapped(void)
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
 
 	if (!caps_supported())
 		return 0;
@@ -8089,6 +8150,8 @@ static int setgid_create_idmapped(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(open_tree_fd);
+
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -8171,6 +8234,24 @@ static int setgid_create_idmapped(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", t_dir1_fd, FILE3, AT_EMPTY_PATH))
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
@@ -8194,6 +8275,8 @@ static int setgid_create_idmapped_in_userns(void)
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
 
 	if (!caps_supported())
 		return 0;
@@ -8241,6 +8324,8 @@ static int setgid_create_idmapped_in_userns(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(open_tree_fd);
+
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -8307,6 +8392,24 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", t_dir1_fd, FILE3, AT_EMPTY_PATH))
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
@@ -8415,6 +8518,24 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", t_dir1_fd, FILE3, AT_EMPTY_PATH))
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
@@ -8511,6 +8632,24 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", t_dir1_fd, FILE3, AT_EMPTY_PATH))
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
2.31.1

