Return-Path: <linux-fsdevel+bounces-6037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28185812863
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 07:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E552828F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 06:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5231ED51C;
	Thu, 14 Dec 2023 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fpi9gaNf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E452710F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 22:44:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcd8f64549so1307301276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 22:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702536287; x=1703141087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi0n1hV1ncb/RNwMZFnyh9hgwMGCToBH7DtU0L8OSxs=;
        b=Fpi9gaNfboAVvku+rZdlb6aNhnJC1QklaxRwMgYroM8zyOeRa4oVbquxJ9+D9Jd75Y
         5zkH9BQSc1Pa7nJvouWG15HZZ0bPzIfYvNQLlgppVgDr1wNqpk8JhFjN7NwD3oD7qrjq
         JTTqXpR1LYvTXl3HzychB1GMrxm7g5FosJtfWM1Y8v68G/u5a6VcMqVQ9tV3CHNm/R0/
         /SNgBosZt/tKLbF7T9Jg+ACMiP1gUM0vVttUzkvyY2WjuzBcY5Rj/SgVbgPOVG1nySli
         Z85whCyXr3Spp+eASR8pzL97psnN2ssvEv7iOnnjOrN8lGTzJzoidKHJOHd2ndAQUGCi
         46zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536287; x=1703141087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi0n1hV1ncb/RNwMZFnyh9hgwMGCToBH7DtU0L8OSxs=;
        b=v+DRs6EItL/xr3T2rQRcU0mhRjWOOHSXXkAX7zZiu6BR1Xq9+4aI7ubtQLjZamiwP3
         bB7B3QmXVw71yLMXhGy6lWuEioV/rlHYi/M1Rro3FChAJQyM1zH3AntvVHCY/dfFc6r8
         Gg+2AhUNDzthR5d0BSwJ4Z7zXeAKr3hCnHJ90X0v4gRJztBD5ySNt4D4hN8gDjDX6bsD
         t8aYHOb+BFY7X0NAvrXNeFf5+bpVffKZIkNGt+LI5GVQyXrjiIQuMKbbAHBYK8mK2093
         k1Mb2WN95xBzO93+aCSUTIfmF/Jy2nD7V80wiiPnD5WhWVOsOg40Tt91Ssv26+U019Xc
         qdbw==
X-Gm-Message-State: AOJu0YygxHaCXsDMhvgARd/0/o0Wjlhz5iduW+mP0yuxFs6OemyH40Fh
	VnN6sRIZP1V/seaLXhjYujH2fZ/Il2s=
X-Google-Smtp-Source: AGHT+IFIcGL80lHU9a3QBXcN8ajJPDrjxhCqjsogxxgpG76jxiYcwGLHlmLh1XM+txh5BQ5FFFg6RJjTlQM=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:e986:a7c7:2814:c9a8])
 (user=avagin job=sendgmr) by 2002:a05:6902:343:b0:db5:f536:17d4 with SMTP id
 e3-20020a056902034300b00db5f53617d4mr76906ybs.11.1702536287106; Wed, 13 Dec
 2023 22:44:47 -0800 (PST)
Date: Wed, 13 Dec 2023 22:44:39 -0800
In-Reply-To: <20231214064439.1023011-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214064439.1023011-1-avagin@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214064439.1023011-2-avagin@google.com>
Subject: [PATCH 2/2] selftests/overlayfs: verify device and inode numbers in /proc/pid/maps
From: Andrei Vagin <avagin@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

When mapping a file on overlayfs, the file stored in ->vm_file is a
backing file whose f_inode is on the underlying filesystem. We need to
verify that /proc/pid/maps contains numbers of the overlayfs file, but
not its backing file.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../filesystems/overlayfs/.gitignore          |   2 +
 .../selftests/filesystems/overlayfs/Makefile  |   7 +
 .../filesystems/overlayfs/dev_in_maps.c       | 182 ++++++++++++++++++
 .../selftests/filesystems/overlayfs/log.h     |  26 +++
 5 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/Makefile
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/log.h

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b2061d1c1a5..0939a40abb28 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -26,6 +26,7 @@ TARGETS += filesystems
 TARGETS += filesystems/binderfs
 TARGETS += filesystems/epoll
 TARGETS += filesystems/fat
+TARGETS += filesystems/overlayfs
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/overlayfs/.gitignore b/tools/testing/selftests/filesystems/overlayfs/.gitignore
new file mode 100644
index 000000000000..52ae618fdd98
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+dev_in_maps
diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
new file mode 100644
index 000000000000..56b2b48a765b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS := dev_in_maps
+
+CFLAGS := -Wall -Werror
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
new file mode 100644
index 000000000000..e19ab0e85709
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <inttypes.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <linux/unistd.h>
+#include <linux/types.h>
+#include <linux/mount.h>
+#include <sys/syscall.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <sys/mman.h>
+#include <sched.h>
+#include <fcntl.h>
+
+#include "../../kselftest.h"
+#include "log.h"
+
+static int sys_fsopen(const char *fsname, unsigned int flags)
+{
+	return syscall(__NR_fsopen, fsname, flags);
+}
+
+static int sys_fsconfig(int fd, unsigned int cmd, const char *key, const char *value, int aux)
+{
+	return syscall(__NR_fsconfig, fd, cmd, key, value, aux);
+}
+
+static int sys_fsmount(int fd, unsigned int flags, unsigned int attr_flags)
+{
+	return syscall(__NR_fsmount, fd, flags, attr_flags);
+}
+
+static int sys_move_mount(int from_dfd, const char *from_pathname,
+			  int to_dfd, const char *to_pathname,
+			  unsigned int flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
+}
+
+static long get_file_dev_and_inode(void *addr, struct statx *stx)
+{
+	char buf[4096];
+	FILE *mapf;
+
+	mapf = fopen("/proc/self/maps", "r");
+	if (mapf == NULL)
+		return pr_perror("fopen(/proc/self/maps)");
+
+	while (fgets(buf, sizeof(buf), mapf)) {
+		unsigned long start, end;
+		uint32_t maj, min;
+		__u64 ino;
+
+		if (sscanf(buf, "%lx-%lx %*s %*s %x:%x %llu",
+				&start, &end, &maj, &min, &ino) != 5)
+			return pr_perror("unable to parse: %s", buf);
+		if (start == (unsigned long)addr) {
+			stx->stx_dev_major = maj;
+			stx->stx_dev_minor = min;
+			stx->stx_ino = ino;
+			return 0;
+		}
+	}
+
+	return pr_err("unable to find the mapping");
+}
+
+static int ovl_mount(void)
+{
+	int tmpfs, fsfd, ovl;
+
+	fsfd = sys_fsopen("tmpfs", 0);
+	if (fsfd == -1)
+		return pr_perror("fsopen(tmpfs)");
+
+	if (sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) == -1)
+		return pr_perror("FSCONFIG_CMD_CREATE");
+
+	tmpfs = sys_fsmount(fsfd, 0, 0);
+	if (tmpfs == -1)
+		return pr_perror("fsmount");
+
+	close(fsfd);
+
+	/* overlayfs can't be constructed on top of a detached mount. */
+	if (sys_move_mount(tmpfs, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH))
+		return pr_perror("move_mount");
+	close(tmpfs);
+
+	if (mkdir("/tmp/w", 0755) == -1 ||
+	    mkdir("/tmp/u", 0755) == -1 ||
+	    mkdir("/tmp/l", 0755) == -1)
+		return pr_perror("mkdir");
+
+	fsfd = sys_fsopen("overlay", 0);
+	if (fsfd == -1)
+		return pr_perror("fsopen(overlay)");
+	if (sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0) == -1 ||
+	    sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "lowerdir", "/tmp/l", 0) == -1 ||
+	    sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "upperdir", "/tmp/u", 0) == -1 ||
+	    sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "workdir", "/tmp/w", 0) == -1)
+		return pr_perror("fsconfig");
+	if (sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) == -1)
+		return pr_perror("fsconfig");
+	ovl = sys_fsmount(fsfd, 0, 0);
+	if (ovl == -1)
+		return pr_perror("fsmount");
+
+	return ovl;
+}
+
+/*
+ * Check that the file device and inode shown in /proc/pid/maps match values
+ * returned by stat(2).
+ */
+static int test(void)
+{
+	struct statx stx, mstx;
+	int ovl, fd;
+	void *addr;
+
+	ovl = ovl_mount();
+	if (ovl == -1)
+		return -1;
+
+	fd = openat(ovl, "test", O_RDWR | O_CREAT, 0644);
+	if (fd == -1)
+		return pr_perror("openat");
+
+	addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED)
+		return pr_perror("mmap");
+
+	if (get_file_dev_and_inode(addr, &mstx))
+		return -1;
+	if (statx(fd, "", AT_EMPTY_PATH | AT_STATX_SYNC_AS_STAT, STATX_INO, &stx))
+		return pr_perror("statx");
+
+	if (stx.stx_dev_major != mstx.stx_dev_major ||
+	    stx.stx_dev_minor != mstx.stx_dev_minor ||
+	    stx.stx_ino != mstx.stx_ino)
+		return pr_fail("unmatched dev:ino %x:%x:%llx (expected %x:%x:%llx)\n",
+			mstx.stx_dev_major, mstx.stx_dev_minor, mstx.stx_ino,
+			stx.stx_dev_major, stx.stx_dev_minor, stx.stx_ino);
+
+	ksft_test_result_pass("devices are matched\n");
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int fsfd;
+
+	fsfd = sys_fsopen("overlay", 0);
+	if (fsfd == -1) {
+		ksft_test_result_skip("unable to create overlay mount\n");
+		return 1;
+	}
+	close(fsfd);
+
+	/* Create a new mount namespace to not care about cleaning test mounts. */
+	if (unshare(CLONE_NEWNS) == -1) {
+		ksft_test_result_skip("unable to create a new mount namespace\n");
+		return 1;
+	}
+
+	if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) == -1) {
+		pr_perror("mount");
+		return 1;
+	}
+
+	ksft_set_plan(1);
+
+	if (test())
+		return 1;
+
+	ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/filesystems/overlayfs/log.h b/tools/testing/selftests/filesystems/overlayfs/log.h
new file mode 100644
index 000000000000..db64df2a8483
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/log.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SELFTEST_TIMENS_LOG_H__
+#define __SELFTEST_TIMENS_LOG_H__
+
+#define pr_msg(fmt, lvl, ...)						\
+	ksft_print_msg("[%s] (%s:%d)\t" fmt "\n",			\
+			lvl, __FILE__, __LINE__, ##__VA_ARGS__)
+
+#define pr_p(func, fmt, ...)	func(fmt ": %m", ##__VA_ARGS__)
+
+#define pr_err(fmt, ...)						\
+	({								\
+		ksft_test_result_error(fmt "\n", ##__VA_ARGS__);		\
+		-1;							\
+	})
+
+#define pr_fail(fmt, ...)					\
+	({							\
+		ksft_test_result_fail(fmt, ##__VA_ARGS__);	\
+		-1;						\
+	})
+
+#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
+
+#endif
-- 
2.43.0.472.g3155946c3a-goog


