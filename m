Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167A14FDE7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346822AbiDLLuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355050AbiDLLtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:49:09 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705DA9FEE;
        Tue, 12 Apr 2022 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649759628; i=@fujitsu.com;
        bh=mAumIPc8r56GCBPV0WVMEx+GRmeDp0lAwL4fXJ/7Bn0=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=PloExhdnHyNytenD12Ov9pTvwAg7IfWoZ0EqdcSsgfC0VaQS7Swew6HmSFh6DuS89
         DjoR9GKccSAmRw8AFSgMMDM320MSAWklBM2MCJ8bYI5QCYYEvRt3ITssiqzPXl+mXj
         YPngodUeTY8aNJNTqLap5I6pdryY0Lz5af0RQwKYMxEzBrJx2q1oLLZMMokXyvFbY2
         kVSJ+uiIZ4GdkYEXjqpqhzdBb78VivsBYkEVinvuye6CofJfNQGysTWPc/G7yd1LGg
         KX4hCzMfCaPokheb5l7YQceY9m0IsiYCvQ6OIo04sUmxgrVrFLwrXtr24ayLEHrbea
         qFCt3PFHOaO9Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRWlGSWpSXmKPExsViZ8MxRbcnNDT
  JYONEcYvXhz8xWmw5do/R4vITPovTLXvZLfbsPcniwOpxapGEx6ZVnWwenzfJBTBHsWbmJeVX
  JLBmzFj0kLHgQTdjxe91T9gbGG8WdDFycQgJvGaUuNm/gRnC2cMocXnqGdYuRk4ONgFNiWedC
  5hBbBEBF4lv+/+ygdjMAjkSDbt/MIHYwgKeEl1PToLVsAioStw5e5YRxOYV8JDo3ziJHcSWEF
  CQmPLwPVgNJ1D9pCP7WEBsIaCaGa2r2SDqBSVOznzCAjFfQuLgixfMEL2KEpc6vjFC2BUSs2a
  1MU1g5J+FpGUWkpYFjEyrGK2TijLTM0pyEzNzdA0NDHQNDU11jS10DU0M9BKrdBP1Ukt1y1OL
  S3SN9BLLi/VSi4v1iitzk3NS9PJSSzYxAsM5pVitZwfjiVU/9Q4xSnIwKYnyGvCEJgnxJeWnV
  GYkFmfEF5XmpBYfYpTh4FCS4JULBsoJFqWmp1akZeYAYwsmLcHBoyTCGxsIlOYtLkjMLc5Mh0
  idYtTl+Pvp715mIZa8/LxUKXFezhCgIgGQoozSPLgRsDi/xCgrJczLyMDAIMRTkFqUm1mCKv+
  KUZyDUUmYlx9kCk9mXgncpldARzABHRG6LRDkiJJEhJRUA1PeCf8mmZ3Hog9+y7opM58pdq2C
  7jTH54w1DvOmP74/3c1uYYdv+a2E+Ksu7/d++qea7TiniaHV0+f+knX2eke8Jtz8psxRxi8/c
  Z5vf7bwrgWTTX+5euh5fi7721fix/X4Xl0Z53Pjb8Yllqa677WW7NwqI7b1g94DrwTja24fb/
  9ue3ai4j7vZNnv7+sa5y1ozsycs/pO8JVL26JYbi9XSe0XlLRoO/z4miFj5H+/hb1rJ/PN/lb
  8Kmtmise0k82zl69o6v2l3HbS0Xt6XLr2tfdNnnd0V4WpLStuTvHhWOC/vvRAjXd9ykkxg4hp
  Xk80wl56le54xxPfyvdcdFlAws/tz+PP6c6ozU0szVNiKc5INNRiLipOBADbHMS6bgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-565.messagelabs.com!1649759628!58522!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31504 invoked from network); 12 Apr 2022 10:33:48 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-16.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Apr 2022 10:33:48 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23CAXmvN004638
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Apr 2022 11:33:48 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 12 Apr 2022 11:33:45 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 4/5] idmapped-mounts: Add new setgid_create_umask test
Date:   Tue, 12 Apr 2022 19:33:45 +0800
Message-ID: <1649763226-2329-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current_umask() is stripped from the mode directly in the vfs if the
filesystem either doesn't support acls or the filesystem has been
mounted without posic acl support.

If the filesystem does support acls then current_umask() stripping is
deferred to posix_acl_create(). So when the filesystem calls
posix_acl_create() and there are no acls set or not supported then
current_umask() will be stripped.

Here we only use umask(S_IXGRP) to check whether inode strip
S_ISGID works correctly.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 505 +++++++++++++++++++++++++-
 tests/generic/680                     |  26 ++
 tests/generic/680.out                 |   2 +
 3 files changed, 532 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/680
 create mode 100644 tests/generic/680.out

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 02f91558..e6c14586 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -14146,6 +14146,494 @@ out:
 	return fret;
 }
 
+/* The following tests are concerned with setgid inheritance. These can be
+ * filesystem type specific. For xfs, if a new file or directory or node is
+ * created within a setgid directory and irix_sgid_inhiert is set then inheritthe
+ * setgid bit if the caller is in the group of the directory.
+ *
+ * The current_umask() is stripped from the mode directly in the vfs if the
+ * filesystem either doesn't support acls or the filesystem has been
+ * mounted without posic acl support.
+ *
+ * If the filesystem does support acls then current_umask() stripping is
+ * deferred to posix_acl_create(). So when the filesystem calls
+ * posix_acl_create() and there are no acls set or not supported then
+ * current_umask() will be stripped.
+ *
+ * Use umask(S_IXGRP) to check whether inode strip S_ISGID works correctly.
+ */
+static int setgid_create_umask(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF;
+	int tmpfile_fd = -EBADF;
+	pid_t pid;
+	bool supported = false;
+	char path[PATH_MAX];
+	mode_t mode;
+
+	if (!caps_supported())
+		return 0;
+
+	if (fchmod(t_dir1_fd, S_IRUSR |
+			      S_IWUSR |
+			      S_IRGRP |
+			      S_IWGRP |
+			      S_IROTH |
+			      S_IWOTH |
+			      S_IXUSR |
+			      S_IXGRP |
+			      S_IXOTH |
+			      S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	   /* Verify that the setgid bit got raised. */
+	if (!is_setgid(t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
+
+	supported = openat_tmpfile_supported(t_dir1_fd);
+
+	/* Only umask with S_IXGRP because inode strip S_ISGID will check mode
+	 * whether has group execute or search permission.
+	 */
+	umask(S_IXGRP);
+	mode = umask(S_IXGRP);
+	if (!(mode & S_IXGRP))
+		die("failure: umask");
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(0, 10000))
+			die("failure: switch_ids");
+
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
+		/* create regular file via open() */
+		file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(t_dir1_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		/* create directory */
+		if (mkdirat(t_dir1_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled()) {
+			/* We're not in_group_p(). */
+			if (is_setgid(t_dir1_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(t_dir1_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
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
+			if (unlinkat(t_dir1_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(file1_fd);
+	return fret;
+}
+
+static int setgid_create_umask_idmapped(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
+	char path[PATH_MAX];
+	mode_t mode;
+
+	if (!caps_supported())
+		return 0;
+
+	if (fchmod(t_dir1_fd, S_IRUSR |
+			      S_IWUSR |
+			      S_IRGRP |
+			      S_IWGRP |
+			      S_IROTH |
+			      S_IWOTH |
+			      S_IXUSR |
+			      S_IXGRP |
+			      S_IXOTH |
+			      S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setgid(t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd  = get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	supported = openat_tmpfile_supported(open_tree_fd);
+
+	/* Only umask with S_IXGRP because inode strip S_ISGID will check mode
+	 * whether has group execute or search permission.
+	 */
+	umask(S_IXGRP);
+	mode = umask(S_IXGRP);
+	if (!(mode & S_IXGRP))
+		die("failure: umask");
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_ids(10000, 11000))
+			die("failure: switch fsids");
+
+		/* create regular file via open() */
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(open_tree_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		/* create directory */
+		if (mkdirat(open_tree_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled()) {
+			/* We're not in_group_p(). */
+			if (is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
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
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static int setgid_create_umask_idmapped_in_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
+	char path[PATH_MAX];
+	mode_t mode;
+
+	if (!caps_supported())
+		return 0;
+
+	if (fchmod(t_dir1_fd, S_IRUSR |
+			      S_IWUSR |
+			      S_IRGRP |
+			      S_IWGRP |
+			      S_IROTH |
+			      S_IWOTH |
+			      S_IXUSR |
+			      S_IXGRP |
+			      S_IXOTH |
+			      S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setgid(t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd  = get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	supported = openat_tmpfile_supported(open_tree_fd);
+
+	/* Only umask with S_IXGRP because inode strip S_ISGID will check mode
+	 * whether has group execute or search permission.
+	 */
+	umask(S_IXGRP);
+	mode = umask(S_IXGRP);
+	if (!(mode & S_IXGRP))
+		die("failure: umask");
+
+	/* Below we verify that setgid inheritance for a newly created file or
+	 * directory works correctly. As part of this we need to verify that
+	 * newly created files or directories inherit their gid from their
+	 * parent directory. So we change the parent directorie's gid to 1000
+	 * and create a file with fs{g,u}id 0 and verify that the newly created
+	 * file and directory inherit gid 1000, not 0.
+	 */
+	if (fchownat(t_dir1_fd, "", -1, 1000, AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
+		/* create regular file via open() */
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(open_tree_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		/* create directory */
+		if (mkdirat(open_tree_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled()) {
+			/* We're not in_group_p(). */
+			if (is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
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
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
 static void usage(void)
 {
 	fprintf(stderr, "Description:\n");
@@ -14164,6 +14652,7 @@ static void usage(void)
 	fprintf(stderr, "--test-nested-userns                Run nested userns idmapped mount testsuite\n");
 	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
 	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
+	fprintf(stderr, "--test-setgid-umask                 Run setgid create umask test\n");
 
 	_exit(EXIT_SUCCESS);
 }
@@ -14181,6 +14670,7 @@ static const struct option longopts[] = {
 	{"test-nested-userns",			no_argument,		0,	'n'},
 	{"test-btrfs",				no_argument,		0,	'b'},
 	{"test-setattr-fix-968219708108",	no_argument,		0,	'i'},
+	{"test-setgid-umask",			no_argument,		0,	'u'},
 	{NULL,					0,			0,	  0},
 };
 
@@ -14278,6 +14768,12 @@ struct t_idmapped_mounts t_setattr_fix_968219708108[] = {
 	{ setattr_fix_968219708108,					true,	"test that setattr works correctly",								},
 };
 
+struct t_idmapped_mounts t_setgid_umask[] = {
+	{ setgid_create_umask,						false,	"create operations by using umask in directories with setgid bit set",					},
+	{ setgid_create_umask_idmapped,					true,	"create operations by using umask in directories with setgid bit set on idmapped mount",		},
+	{ setgid_create_umask_idmapped_in_userns,			true,	"create operations by using umask in directories with setgid bit set on idmapped mounts inside userns",	},
+};
+
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 {
 	int i;
@@ -14355,7 +14851,7 @@ int main(int argc, char *argv[])
 	int index = 0;
 	bool supported = false, test_btrfs = false, test_core = false,
 	     test_fscaps_regression = false, test_nested_userns = false,
-	     test_setattr_fix_968219708108 = false;
+	     test_setattr_fix_968219708108 = false, test_setgid_umask = false;
 
 	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
 		switch (ret) {
@@ -14392,6 +14888,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			test_setattr_fix_968219708108 = true;
 			break;
+		case 'u':
+			test_setgid_umask = true;
+			break;
 		case 'h':
 			/* fallthrough */
 		default:
@@ -14463,6 +14962,10 @@ int main(int argc, char *argv[])
 		      ARRAY_SIZE(t_setattr_fix_968219708108)))
 		goto out;
 
+	if (test_setgid_umask &&
+	    !run_test(t_setgid_umask, ARRAY_SIZE(t_setgid_umask)))
+		goto out;
+
 	fret = EXIT_SUCCESS;
 
 out:
diff --git a/tests/generic/680 b/tests/generic/680
new file mode 100755
index 00000000..aa9c7375
--- /dev/null
+++ b/tests/generic/680
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Fujitsu Limited. All Rights Reserved.
+#
+# FS QA Test 680
+#
+# Test that idmapped mounts setgid's behave correctly when using umask.
+#
+. ./common/preamble
+_begin_fstest auto quick cap idmapped mount perms rw unlink
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
+$here/src/idmapped-mounts/idmapped-mounts --test-setgid-umask --device "$TEST_DEV" \
+	--mount "$TEST_DIR" --fstype "$FSTYP"
+
+status=$?
+exit
diff --git a/tests/generic/680.out b/tests/generic/680.out
new file mode 100644
index 00000000..f4950cda
--- /dev/null
+++ b/tests/generic/680.out
@@ -0,0 +1,2 @@
+QA output created by 680
+Silence is golden
-- 
2.27.0

