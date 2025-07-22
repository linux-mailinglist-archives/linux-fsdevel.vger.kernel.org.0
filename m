Return-Path: <linux-fsdevel+bounces-55768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11353B0E71C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 01:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58C31CC1351
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264BF28C01D;
	Tue, 22 Jul 2025 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="pSsmAH0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127C28B7D3;
	Tue, 22 Jul 2025 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226390; cv=none; b=ZkvCta/drOzxilm5KdsA5SCTl+yqC7WHPWnM6nGwiNwmtwyScu9sV+IKJLPisJftOqcmGX/Jm2cLOGFR3hBrVTb21VWOEacnrICGXxeIzi1s8yX0HJ8ClU30ZNuXHcQyUzw863FDYsR42iSMp50GYaiy0Coxne6t1Shqb0i45QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226390; c=relaxed/simple;
	bh=iERN6Xzk9sHzsB4pLCPzg+cd0rkOPiJ6NJagUizg4D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbY6IudQxf9WN+Upb8aPap46HWU7UgkOXFiPLLE6F/owTRbSH5BQzyotGJa2OEILyhrlAkbx04f/AUEvDvZuVhi5fdOu2z428ZIrI74X7PXKjMQxviPBxHiIoeUXrnmDA42s+bn7B7zRc7+2qyJbNw1iv6R/ZrWEH7u13RfXX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=pSsmAH0b; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bmtWx40bRz9tKY;
	Wed, 23 Jul 2025 01:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753226381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ga146VfUnbYMyYkmA+aailWJBUlJlGizk/gmO5Hyyfg=;
	b=pSsmAH0b+jJYacyGxS8hatPE1X+DUMc0aN6RwPvJHabw0eaoUjNSBE0DgLeLaZLdlYhpZ9
	rL+lBDcBr3JmrukxwtCLTaQSavAVzi76K6IgN9LC1o3XiWRP9QW6w4wR92jI3o1LGin1k2
	V7RZz+VE7FZAJd+Rt0Zdc9L0mqVNE94Pg8tiZZyRm+wgG4fEfTP+AlXVq96BNIzkKDSZz7
	Xj8k/d+8aWFejT+KBgXOsvjmcv5rS87UbIqaLu0z+iSFoIv0K7pqxo2AlzSrdnbJkRcF70
	BIr1sSzA/8XSa6vyCO+W+Y6xynOifI4nIUZgF2iYJGeyAGZiF0waq+PNIhCP8A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 23 Jul 2025 09:18:54 +1000
Subject: [PATCH RFC v2 4/4] selftests/proc: add tests for new pidns APIs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-procfs-pidns-api-v2-4-621e7edd8e40@cyphar.com>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
In-Reply-To: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9962; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=iERN6Xzk9sHzsB4pLCPzg+cd0rkOPiJ6NJagUizg4D0=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWQ0yBTsauX+3WS7hd/t/3ljl529dbIJNY7NRn85D0oxM
 GssDfndUcrCIMbFICumyLLNzzN00/zFV5I/rWSDmcPKBDKEgYtTACbys43hf+IP/Qqbb129cgJM
 Z47zhQec6EjY/kQxqCbkcOwpTkebLwz/o39nrnshbDFr4wH+o7sdlmuw/o7PfHR5ocFst6d5h0+
 a8QAA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bmtWx40bRz9tKY

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/proc/.gitignore   |   1 +
 tools/testing/selftests/proc/Makefile     |   1 +
 tools/testing/selftests/proc/proc-pidns.c | 286 ++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+)

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 973968f45bba..2dced03e9e0e 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -17,6 +17,7 @@
 /proc-tid0
 /proc-uptime-001
 /proc-uptime-002
+/proc-pidns
 /read
 /self
 /setns-dcache
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index b12921b9794b..c6f7046b9860 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -27,5 +27,6 @@ TEST_GEN_PROGS += setns-sysvipc
 TEST_GEN_PROGS += thread-self
 TEST_GEN_PROGS += proc-multiple-procfs
 TEST_GEN_PROGS += proc-fsconfig-hidepid
+TEST_GEN_PROGS += proc-pidns
 
 include ../lib.mk
diff --git a/tools/testing/selftests/proc/proc-pidns.c b/tools/testing/selftests/proc/proc-pidns.c
new file mode 100644
index 000000000000..e7e34c78d383
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-pidns.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2025 SUSE LLC.
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/prctl.h>
+
+#include "../kselftest_harness.h"
+
+#define bail(fmt, ...)							\
+	do {								\
+		fprintf(stderr, fmt ": %m", __VA_ARGS__);		\
+		exit(1);						\
+	} while (0)
+
+#define ASSERT_SUCCESS	ASSERT_FALSE
+#define ASSERT_FAIL	ASSERT_TRUE
+
+int touch(char *path)
+{
+	int fd = open(path, O_WRONLY|O_CREAT|O_CLOEXEC, 0644);
+	if (fd < 0 || close(fd) < 0)
+		return -errno;
+	return 0;
+}
+
+FIXTURE(ns)
+{
+	int host_mntns, host_pidns;
+	int dummy_pidns;
+};
+
+FIXTURE_SETUP(ns)
+{
+	/* Stash the old mntns. */
+	self->host_mntns = open("/proc/self/ns/mnt", O_RDONLY|O_CLOEXEC);
+	ASSERT_GE(self->host_mntns, 0);
+
+	/* Create a new mount namespace and make it private. */
+	ASSERT_SUCCESS(unshare(CLONE_NEWNS));
+	ASSERT_SUCCESS(mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL));
+
+	/*
+	 * Create a proper tmpfs that we can use and will disappear once we
+	 * leave this mntns.
+	 */
+	ASSERT_SUCCESS(mount("tmpfs", "/tmp", "tmpfs", 0, NULL));
+
+	/*
+	 * Create a pidns we can use for later tests. We need to fork off a
+	 * child so that we get a usable nsfd that we can bind-mount and open.
+	 */
+	ASSERT_SUCCESS(touch("/tmp/dummy-pidns"));
+
+	self->host_pidns = open("/proc/self/ns/pid", O_RDONLY|O_CLOEXEC);
+	ASSERT_GE(self->host_pidns, 0);
+	ASSERT_SUCCESS(unshare(CLONE_NEWPID));
+
+	pid_t pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		prctl(PR_SET_PDEATHSIG, SIGKILL);
+		ASSERT_SUCCESS(mount("/proc/self/ns/pid", "/tmp/dummy-pidns", NULL, MS_BIND, 0));
+		exit(0);
+	}
+
+	int wstatus;
+	ASSERT_EQ(waitpid(pid, &wstatus, 0), pid);
+	ASSERT_TRUE(WIFEXITED(wstatus));
+	ASSERT_EQ(WEXITSTATUS(wstatus), 0);
+
+	ASSERT_SUCCESS(setns(self->host_pidns, CLONE_NEWPID));
+
+	self->dummy_pidns = open("/tmp/dummy-pidns", O_RDONLY|O_CLOEXEC);
+	ASSERT_GE(self->dummy_pidns, 0);
+}
+
+FIXTURE_TEARDOWN(ns)
+{
+	ASSERT_SUCCESS(setns(self->host_mntns, CLONE_NEWNS));
+	ASSERT_SUCCESS(close(self->host_mntns));
+
+	ASSERT_SUCCESS(close(self->host_pidns));
+	ASSERT_SUCCESS(close(self->dummy_pidns));
+}
+
+TEST_F(ns, pidns_mount_string_path)
+{
+	ASSERT_SUCCESS(mkdir("/tmp/proc-host", 0755));
+	ASSERT_SUCCESS(mount("proc", "/tmp/proc-host", "proc", 0, "pidns=/proc/self/ns/pid"));
+	ASSERT_SUCCESS(access("/tmp/proc-host/self/", X_OK));
+
+	ASSERT_SUCCESS(mkdir("/tmp/proc-dummy", 0755));
+	ASSERT_SUCCESS(mount("proc", "/tmp/proc-dummy", "proc", 0, "pidns=/tmp/dummy-pidns"));
+	ASSERT_FAIL(access("/tmp/proc-dummy/1/", X_OK));
+	ASSERT_FAIL(access("/tmp/proc-dummy/self/", X_OK));
+}
+
+TEST_F(ns, pidns_fsconfig_string_path)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_GE(fsfd, 0);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_STRING, "pidns", "/tmp/dummy-pidns", 0));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_GE(mountfd, 0);
+
+	ASSERT_FAIL(faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_FAIL(faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(mountfd));
+}
+
+TEST_F(ns, pidns_fsconfig_fd)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_GE(fsfd, 0);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, self->dummy_pidns));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_GE(mountfd, 0);
+
+	ASSERT_FAIL(faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_FAIL(faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(mountfd));
+}
+
+TEST_F(ns, pidns_reconfigure_remount)
+{
+	ASSERT_SUCCESS(mkdir("/tmp/proc", 0755));
+	ASSERT_SUCCESS(mount("proc", "/tmp/proc", "proc", 0, ""));
+	ASSERT_SUCCESS(access("/tmp/proc/self/", X_OK));
+
+	ASSERT_SUCCESS(mount(NULL, "/tmp/proc", NULL, MS_REMOUNT, "pidns=/tmp/dummy-pidns"));
+	ASSERT_FAIL(access("/tmp/proc/self/", X_OK));
+}
+
+TEST_F(ns, pidns_reconfigure_fsconfig_string_path)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_GE(fsfd, 0);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_GE(mountfd, 0);
+
+	ASSERT_SUCCESS(faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_SUCCESS(faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_STRING, "pidns", "/tmp/dummy-pidns", 0));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0));
+
+	ASSERT_FAIL(faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_FAIL(faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(mountfd));
+}
+
+TEST_F(ns, pidns_reconfigure_fsconfig_fd)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_GE(fsfd, 0);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_GE(mountfd, 0);
+
+	ASSERT_SUCCESS(faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_SUCCESS(faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, self->dummy_pidns));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0));
+
+	ASSERT_FAIL(faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_FAIL(faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(mountfd));
+}
+
+int is_same_inode(int fd1, int fd2)
+{
+	struct stat stat1, stat2;
+
+	assert(fstat(fd1, &stat1) == 0);
+	assert(fstat(fd2, &stat2) == 0);
+
+	return stat1.st_ino == stat2.st_ino && stat1.st_dev == stat2.st_dev;
+}
+
+#define PROCFS_IOCTL_MAGIC 'f'
+#define PROCFS_GET_PID_NAMESPACE	_IO(PROCFS_IOCTL_MAGIC, 1)
+
+TEST_F(ns, get_pidns_ioctl)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_GE(fsfd, 0);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, self->dummy_pidns));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_GE(mountfd, 0);
+
+	/* fsmount returns an O_PATH, which ioctl(2) doesn't accept. */
+	int new_mountfd = openat(mountfd, ".", O_RDONLY|O_DIRECTORY|O_CLOEXEC);
+	ASSERT_GE(new_mountfd, 0);
+
+	ASSERT_SUCCESS(close(mountfd));
+	mountfd = -EBADF;
+
+	int procfs_pidns = ioctl(new_mountfd, PROCFS_GET_PID_NAMESPACE);
+	ASSERT_GE(procfs_pidns, 0);
+
+	ASSERT_NE(self->dummy_pidns, procfs_pidns);
+	ASSERT_FALSE(is_same_inode(self->host_pidns, procfs_pidns));
+	ASSERT_TRUE(is_same_inode(self->dummy_pidns, procfs_pidns));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(new_mountfd));
+	ASSERT_SUCCESS(close(procfs_pidns));
+}
+
+TEST_F(ns, reconfigure_get_pidns_ioctl)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_GE(fsfd, 0);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_GE(mountfd, 0);
+
+	/* fsmount returns an O_PATH, which ioctl(2) doesn't accept. */
+	int new_mountfd = openat(mountfd, ".", O_RDONLY|O_DIRECTORY|O_CLOEXEC);
+	ASSERT_GE(new_mountfd, 0);
+
+	ASSERT_SUCCESS(close(mountfd));
+	mountfd = -EBADF;
+
+	int procfs_pidns1 = ioctl(new_mountfd, PROCFS_GET_PID_NAMESPACE);
+	ASSERT_GE(procfs_pidns1, 0);
+
+	ASSERT_NE(self->dummy_pidns, procfs_pidns1);
+	ASSERT_TRUE(is_same_inode(self->host_pidns, procfs_pidns1));
+	ASSERT_FALSE(is_same_inode(self->dummy_pidns, procfs_pidns1));
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_STRING, "pidns", "/tmp/dummy-pidns", 0));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0));
+
+	int procfs_pidns2 = ioctl(new_mountfd, PROCFS_GET_PID_NAMESPACE);
+	ASSERT_GE(procfs_pidns2, 0);
+
+	ASSERT_NE(self->dummy_pidns, procfs_pidns2);
+	ASSERT_FALSE(is_same_inode(self->host_pidns, procfs_pidns2));
+	ASSERT_TRUE(is_same_inode(self->dummy_pidns, procfs_pidns2));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(new_mountfd));
+	ASSERT_SUCCESS(close(procfs_pidns1));
+	ASSERT_SUCCESS(close(procfs_pidns2));
+}
+
+TEST_HARNESS_MAIN

-- 
2.50.0


