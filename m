Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8D44FDE94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349712AbiDLLu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 07:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355363AbiDLLtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:49:19 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1746C19284;
        Tue, 12 Apr 2022 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649759685; i=@fujitsu.com;
        bh=WE0H8u6NMFZxVA6KQdMCLJqSSWftjC4J+9Oi8D1rfa8=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=qAUZxsIFrtumSqXZnvRkOf4/NOgMB83ef1tFriBzxcJ/SzwnJ1uK8VTYf+xALqOEw
         cUy9SlK0ZN74+3goiXLj92+JlIzeq/L9OWMNNQMMCqWWOvQb7x2qxU0Fo/tcvTYrvF
         nbFe5ZetPEh+jogeDtaPShsJB/mDrMlq+GlTORLqlC9rVxlEJUDAThfDZ3HUaQJzpg
         XeCZPw36QaDig+JskXpyqhUC/mK/sY3la9gLR6HQHDGnJh7kGN1j5LdQY1GZIhbVZ0
         vUSJdGX7J2IdPTIr+CHN8lswyDNbHq5TdX9ipmVe5EzpBZZgI26Ue7AHtjqED3rtvJ
         Mg3RWxvWuqY9g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRWlGSWpSXmKPExsViZ8MxRfdIaGi
  SwdXvGhavD39itNhy7B6jxeUnfBanW/ayW+zZe5LFgdXj1CIJj02rOtk8Pm+SC2COYs3MS8qv
  SGDNeHnoAUtB313Giqb/q9kbGKdsZuxi5OIQEnjNKLF+5wXmLkZOIGcPo8TD/RUgNpuApsSzz
  gVgcREBF4lv+/+ygdjMAjkSDbt/MIHYwgLuEutezACrYRFQlZh19QlYnFfAQ2LjmaUsILaEgI
  LElIfvwWo4BTwlJh3ZxwKxy0NiRutqNoh6QYmTM5+wQMyXkDj44gUzRK+ixKWOb4wQdoXErFl
  tTBMY+WchaZmFpGUBI9MqRqukosz0jJLcxMwcXUMDA11DQ1NdYyNdQxO9xCrdRL3UUt3y1OIS
  XSO9xPJivdTiYr3iytzknBS9vNSSTYzAYE4pVuDbwdi86qfeIUZJDiYlUV4DntAkIb6k/JTKj
  MTijPii0pzU4kOMMhwcShK8csFAOcGi1PTUirTMHGBkwaQlOHiURHhjA4HSvMUFibnFmekQqV
  OMuhx/P/3dyyzEkpeflyolztsYAlQkAFKUUZoHNwIW5ZcYZaWEeRkZGBiEeApSi3IzS1DlXzG
  KczAqCfPyg0zhycwrgdv0CugIJqAjQrcFghxRkoiQkmpgklF6tSXUcvabZ+Eri05OVZwxM3Li
  VwF2M+WlNu/tg/v0TxSuZFTKyam9mHNUf8cqg3pTkSbn/x9d+Bam9hT1aEg/fiBacLrsxIN+0
  xc7QoUYnR1EOCqzHrlf/32q8dkCobzb29bsjH4bXbcy8f//+r7pl7/raoac23CkqtnWovFrXt
  fm6RPr73N2Hw26Lc3IyZeqdDLlylfT09pTyjMYvc9P2TU3cbr9v9SaH5Ltlkdsk9YsZgjZL/p
  G+xnHlu7qiYo6mgdnSD+InF/uwsrxnE1EuTxuwu4GNd3WC/qHS57K/+xxrLgg6aE9IUE1ntOX
  /1Dw9T0fNW99X7Z6vuonD8nWuisRnFtzWXrrdn1QYinOSDTUYi4qTgQAtH13MW0DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-548.messagelabs.com!1649759684!54629!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14189 invoked from network); 12 Apr 2022 10:34:44 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-10.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Apr 2022 10:34:44 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23CAYiKg004938
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Apr 2022 11:34:44 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 12 Apr 2022 11:34:41 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 5/5] idmapped-mounts: Add new setgid_create_acl test
Date:   Tue, 12 Apr 2022 19:33:46 +0800
Message-ID: <1649763226-2329-5-git-send-email-xuyang2018.jy@fujitsu.com>
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

If the parent directory has a default acl then permissions are based off
of that and current_umask() is ignored. Specifically, if the ACL has an
ACL_MASK entry, the group permissions correspond to the permissions of
the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
group permissions correspond to the permissions of the ACL_GROUP_OBJ
entry.

Here we only use setfacl to set default acl or add ACL_MASK to check
whether inode strip  S_ISGID works correctly.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 793 +++++++++++++++++++++++++-
 tests/generic/681                     |  28 +
 tests/generic/681.out                 |   2 +
 3 files changed, 822 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/681
 create mode 100644 tests/generic/681.out

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index e6c14586..0dbbc64c 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -14634,6 +14634,781 @@ out:
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
+ * If the parent directory has a default acl then permissions are based off
+ * of that and current_umask() is ignored. Specifically, if the ACL has an
+ * ACL_MASK entry, the group permissions correspond to the permissions of
+ * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+ * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+ * entry.
+ *
+ * Use setfacl to check whether inode strip S_ISGID works correctly.
+ */
+static int setgid_create_acl(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF;
+	int tmpfile_fd = -EBADF;
+	pid_t pid;
+	bool supported = false;
+	char path[PATH_MAX];
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
+	/* Verify that the setgid bit got raised. */
+	if (!is_setgid(t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
+
+	supported = openat_tmpfile_supported(t_dir1_fd);
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx,m:rw %s/%s", t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
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
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+		 * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+		 * entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx, %s/%s", t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
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
+static int setgid_create_acl_idmapped(void)
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
+	/* Verify that the setgid bit got raised. */
+	if (!is_setgid(t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
+
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
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx,m:rw %s/%s", t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
+		if (!switch_ids(10000, 11000))
+			die("failure: switch_ids");
+
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
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+		 * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+		 * entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx, %s/%s", t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
+		if (!switch_ids(10000, 11000))
+			die("failure: switch_ids");
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
+		/* create a character device via mknodat() vfs_mknod */
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
+static int setgid_create_acl_idmapped_in_userns(void)
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
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx,m:rw %s/%s", t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
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
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+		 * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+		 * entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx %s/%s", t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
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
@@ -14653,6 +15428,7 @@ static void usage(void)
 	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
 	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
 	fprintf(stderr, "--test-setgid-umask                 Run setgid create umask test\n");
+	fprintf(stderr, "--test-setgid-acl                   Run setgid create acl tests\n");
 
 	_exit(EXIT_SUCCESS);
 }
@@ -14671,6 +15447,7 @@ static const struct option longopts[] = {
 	{"test-btrfs",				no_argument,		0,	'b'},
 	{"test-setattr-fix-968219708108",	no_argument,		0,	'i'},
 	{"test-setgid-umask",			no_argument,		0,	'u'},
+	{"test-setgid-acl",			no_argument,		0,	'l'},
 	{NULL,					0,			0,	  0},
 };
 
@@ -14774,6 +15551,12 @@ struct t_idmapped_mounts t_setgid_umask[] = {
 	{ setgid_create_umask_idmapped_in_userns,			true,	"create operations by using umask in directories with setgid bit set on idmapped mounts inside userns",	},
 };
 
+struct t_idmapped_mounts t_setgid_acl[] = {
+	{ setgid_create_acl,						false,	"create operations by using acl in directories with setgid bit set",					},
+	{ setgid_create_acl_idmapped,					false,	"create operations by using acl in directories with setgid bit set on idmapped mount",			},
+	{ setgid_create_acl_idmapped_in_userns,				false,	"create operations by using acl in directories with setgid bit set on idmapped mount inside userns",	},
+};
+
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 {
 	int i;
@@ -14851,7 +15634,8 @@ int main(int argc, char *argv[])
 	int index = 0;
 	bool supported = false, test_btrfs = false, test_core = false,
 	     test_fscaps_regression = false, test_nested_userns = false,
-	     test_setattr_fix_968219708108 = false, test_setgid_umask = false;
+	     test_setattr_fix_968219708108 = false, test_setgid_umask = false,
+	     test_setgid_acl = false;
 
 	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
 		switch (ret) {
@@ -14891,6 +15675,9 @@ int main(int argc, char *argv[])
 		case 'u':
 			test_setgid_umask = true;
 			break;
+		case 'l':
+			test_setgid_acl = true;
+			break;
 		case 'h':
 			/* fallthrough */
 		default:
@@ -14966,6 +15753,10 @@ int main(int argc, char *argv[])
 	    !run_test(t_setgid_umask, ARRAY_SIZE(t_setgid_umask)))
 		goto out;
 
+	if (test_setgid_acl &&
+	    !run_test(t_setgid_acl, ARRAY_SIZE(t_setgid_acl)))
+		goto out;
+
 	fret = EXIT_SUCCESS;
 
 out:
diff --git a/tests/generic/681 b/tests/generic/681
new file mode 100755
index 00000000..a78ca2d1
--- /dev/null
+++ b/tests/generic/681
@@ -0,0 +1,28 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Fujitsu Limited. All Rights Reserved.
+#
+# FS QA Test 681
+#
+# Test that idmapped mounts setgid's behave correctly when using acl.
+#
+. ./common/preamble
+_begin_fstest auto quick acl cap idmapped mount perms rw unlink
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+
+_supported_fs generic
+_require_test
+_require_acls
+
+echo "Silence is golden"
+
+$here/src/idmapped-mounts/idmapped-mounts --test-setgid-acl --device "$TEST_DEV" \
+	--mount "$TEST_DIR" --fstype "$FSTYP"
+
+status=$?
+exit
diff --git a/tests/generic/681.out b/tests/generic/681.out
new file mode 100644
index 00000000..15274cbc
--- /dev/null
+++ b/tests/generic/681.out
@@ -0,0 +1,2 @@
+QA output created by 681
+Silence is golden
-- 
2.27.0

