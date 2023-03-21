Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5716C3B7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 21:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCUUQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 16:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCUUQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:16:00 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845F158B45
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 13:15:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c8-20020a170902d48800b001a1e0fd4085so2022401plg.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679429746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUxn3KVcBxbFXkgOhZJm8jHzCo14A+URwIfQXLEPszQ=;
        b=gOamuZL09TvaiKBWLNigfj5XfPQ9ZV+G8B5xxWIHP7ReVAgFwkb2mMOqoMmAQj4JA5
         a71uvwvqvuhm9Mla+M6MKfVBfAeZv8j+Ais4qiGHYQbdzN04WOFDIvW+KHiX6/6UcG3g
         krfkQwX/3y0i/lIiZnvQ0cDeDcI7B671x+yj/K+Slq7czkPMQa4ZsYo4hXCLHwgEBbR6
         wcEzyW5vDv1w52aGipOfZRkfsbrmcbzAncEZk/uv+Uo6h534K0mNscTMHh24KGiLks3G
         i+rXSGXGfinc7T1/3sxRE9aQe0lPV9r2mPkO1dm8fdQ094x0CRIh1SLftIFzpGONkFQy
         Gw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUxn3KVcBxbFXkgOhZJm8jHzCo14A+URwIfQXLEPszQ=;
        b=r6BLEczVS2IsASlkCTEsnbM6Py86JAnL9hPsviMacBvDos0YCgdqCGOUmU4tWUVEdn
         uc6kZx3GOW9pwtCke8IAwmxhy5LP2s9jJniJfu+I5yYDDTB46ra0y+fcGXRoq1XwlxEE
         kjCSIWhIq4eupBvyheYtufHsggfF85Xy+7DUgavrNb293uKIlQKhgfblTIiMCkyShb3T
         wth7hKUGqLcDhs6y10axb8rkJDvSgLPjZoRPuTrLVTT+3jmN4FdZFgqS+b7ZkIC/KD/9
         tHQf1wTRk/tqNSxkUsoMtrjTAOn4Us9BcHs5TNjaGcE/j9R99YTp7DmPT/28bQ+8N/9W
         EYpg==
X-Gm-Message-State: AO0yUKVBiGMkf8qFRL9DbfcT+hXaZSJFRudgNT3WAE9zeHBpqwozcAsW
        A2cic5LR7uQ6j+7+yzD47yEUEm7PEHjReg3luw==
X-Google-Smtp-Source: AK7set+dSS5L5IQsR2QM90zFjxvQz3FiYFZP+Sm9POtIwngHMs0+tu5Z0jbahBkmyz+8xgu0gtCE94fpBCegZt4AyQ==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:99d:b0:628:fc:9049 with SMTP
 id u29-20020a056a00099d00b0062800fc9049mr654427pfg.4.1679429746071; Tue, 21
 Mar 2023 13:15:46 -0700 (PDT)
Date:   Tue, 21 Mar 2023 20:15:33 +0000
In-Reply-To: <cover.1679428901.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1679428901.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <4db33a8976193f3eff80dbd4515335c36aeeb416.1679428901.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 2/2] selftests: restrictedmem: Check hugepage-ness of
 shmem file backing restrictedmem fd
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For memfd_restricted() calls without a userspace mount, the backing
file should be the shmem mount in the kernel, and the size of backing
pages should be as defined by system-wide shmem configuration.

If a userspace mount is provided, the size of backing pages should be
as defined in the mount.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/restrictedmem/.gitignore        |   3 +
 .../testing/selftests/restrictedmem/Makefile  |  15 +
 .../testing/selftests/restrictedmem/common.c  |   9 +
 .../testing/selftests/restrictedmem/common.h  |   8 +
 .../restrictedmem_hugepage_test.c             | 459 ++++++++++++++++++
 6 files changed, 495 insertions(+)
 create mode 100644 tools/testing/selftests/restrictedmem/.gitignore
 create mode 100644 tools/testing/selftests/restrictedmem/Makefile
 create mode 100644 tools/testing/selftests/restrictedmem/common.c
 create mode 100644 tools/testing/selftests/restrictedmem/common.h
 create mode 100644 tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f07aef7c592c..44078eeefb79 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -60,6 +60,7 @@ TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
 TARGETS += resctrl
+TARGETS += restrictedmem
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
diff --git a/tools/testing/selftests/restrictedmem/.gitignore b/tools/testing/selftests/restrictedmem/.gitignore
new file mode 100644
index 000000000000..2581bcc8ff29
--- /dev/null
+++ b/tools/testing/selftests/restrictedmem/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+restrictedmem_hugepage_test
diff --git a/tools/testing/selftests/restrictedmem/Makefile b/tools/testing/selftests/restrictedmem/Makefile
new file mode 100644
index 000000000000..8e5378d20226
--- /dev/null
+++ b/tools/testing/selftests/restrictedmem/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS = $(KHDR_INCLUDES)
+CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -std=gnu99
+
+TEST_GEN_PROGS += restrictedmem_hugepage_test
+
+include ../lib.mk
+
+EXTRA_CLEAN = $(OUTPUT)/common.o
+
+$(OUTPUT)/common.o: common.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
+
+$(TEST_GEN_PROGS): $(OUTPUT)/common.o
diff --git a/tools/testing/selftests/restrictedmem/common.c b/tools/testing/selftests/restrictedmem/common.c
new file mode 100644
index 000000000000..03dac843404f
--- /dev/null
+++ b/tools/testing/selftests/restrictedmem/common.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <sys/syscall.h>
+#include <unistd.h>
+
+int memfd_restricted(unsigned int flags, int mount_fd)
+{
+	return syscall(__NR_memfd_restricted, flags, mount_fd);
+}
diff --git a/tools/testing/selftests/restrictedmem/common.h b/tools/testing/selftests/restrictedmem/common.h
new file mode 100644
index 000000000000..06284ed86baf
--- /dev/null
+++ b/tools/testing/selftests/restrictedmem/common.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef SELFTESTS_RESTRICTEDMEM_COMMON_H
+#define SELFTESTS_RESTRICTEDMEM_COMMON_H
+
+int memfd_restricted(unsigned int flags, int mount_fd);
+
+#endif  // SELFTESTS_RESTRICTEDMEM_COMMON_H
diff --git a/tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c b/tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c
new file mode 100644
index 000000000000..ae37148342fe
--- /dev/null
+++ b/tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define _GNU_SOURCE /* for O_PATH */
+#define _POSIX_C_SOURCE /* for PATH_MAX */
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "linux/restrictedmem.h"
+
+#include "common.h"
+#include "../kselftest_harness.h"
+
+/*
+ * Expect policy to be one of always, within_size, advise, never,
+ * deny, force
+ */
+#define POLICY_BUF_SIZE 12
+
+static int get_hpage_pmd_size(void)
+{
+	FILE *fp;
+	char buf[100];
+	char *ret;
+	int size;
+
+	fp = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
+	if (!fp)
+		return -1;
+
+	ret = fgets(buf, 100, fp);
+	if (ret != buf) {
+		size = -1;
+		goto out;
+	}
+
+	if (sscanf(buf, "%d\n", &size) != 1)
+		size = -1;
+
+out:
+	fclose(fp);
+
+	return size;
+}
+
+static bool is_valid_shmem_thp_policy(char *policy)
+{
+	if (strcmp(policy, "always") == 0)
+		return true;
+	if (strcmp(policy, "within_size") == 0)
+		return true;
+	if (strcmp(policy, "advise") == 0)
+		return true;
+	if (strcmp(policy, "never") == 0)
+		return true;
+	if (strcmp(policy, "deny") == 0)
+		return true;
+	if (strcmp(policy, "force") == 0)
+		return true;
+
+	return false;
+}
+
+static int get_shmem_thp_policy(char *policy)
+{
+	FILE *fp;
+	char buf[100];
+	char *left = NULL;
+	char *right = NULL;
+	int ret = -1;
+
+	fp = fopen("/sys/kernel/mm/transparent_hugepage/shmem_enabled", "r");
+	if (!fp)
+		return -1;
+
+	if (fgets(buf, 100, fp) != buf)
+		goto out;
+
+	/*
+	 * Expect shmem_enabled to be of format like "always within_size advise
+	 * [never] deny force"
+	 */
+	left = memchr(buf, '[', 100);
+	if (!left)
+		goto out;
+
+	right = memchr(buf, ']', 100);
+	if (!right)
+		goto out;
+
+	memcpy(policy, left + 1, right - left - 1);
+
+	ret = !is_valid_shmem_thp_policy(policy);
+
+out:
+	fclose(fp);
+	return ret;
+}
+
+static int write_string_to_file(const char *path, const char *string)
+{
+	FILE *fp;
+	size_t len = strlen(string);
+	int ret = -1;
+
+	fp = fopen(path, "w");
+	if (!fp)
+		return ret;
+
+	if (fwrite(string, 1, len, fp) != len)
+		goto out;
+
+	ret = 0;
+
+out:
+	fclose(fp);
+	return ret;
+}
+
+static int set_shmem_thp_policy(char *policy)
+{
+	int ret = -1;
+	/* +1 for newline */
+	char to_write[POLICY_BUF_SIZE + 1] = { 0 };
+
+	if (!is_valid_shmem_thp_policy(policy))
+		return ret;
+
+	ret = snprintf(to_write, POLICY_BUF_SIZE + 1, "%s\n", policy);
+	if (ret != strlen(policy) + 1)
+		return -1;
+
+	ret = write_string_to_file(
+		"/sys/kernel/mm/transparent_hugepage/shmem_enabled", to_write);
+
+	return ret;
+}
+
+FIXTURE(reset_shmem_enabled)
+{
+	char shmem_enabled[POLICY_BUF_SIZE];
+};
+
+FIXTURE_SETUP(reset_shmem_enabled)
+{
+	memset(self->shmem_enabled, 0, POLICY_BUF_SIZE);
+	ASSERT_EQ(0, get_shmem_thp_policy(self->shmem_enabled));
+}
+
+FIXTURE_TEARDOWN(reset_shmem_enabled)
+{
+	ASSERT_EQ(0, set_shmem_thp_policy(self->shmem_enabled));
+}
+
+TEST_F(reset_shmem_enabled, restrictedmem_fstat_shmem_enabled_never)
+{
+	int fd = -1;
+	struct stat stat;
+
+	ASSERT_EQ(0, set_shmem_thp_policy("never"));
+
+	fd = memfd_restricted(0, -1);
+	ASSERT_NE(-1, fd);
+
+	ASSERT_EQ(0, fstat(fd, &stat));
+
+	/*
+	 * st_blksize is set based on the superblock's s_blocksize_bits. For
+	 * shmem, this is set to PAGE_SHIFT
+	 */
+	ASSERT_EQ(stat.st_blksize, getpagesize());
+
+	close(fd);
+}
+
+TEST_F(reset_shmem_enabled, restrictedmem_fstat_shmem_enabled_always)
+{
+	int fd = -1;
+	struct stat stat;
+
+	ASSERT_EQ(0, set_shmem_thp_policy("always"));
+
+	fd = memfd_restricted(0, -1);
+	ASSERT_NE(-1, fd);
+
+	ASSERT_EQ(0, fstat(fd, &stat));
+
+	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
+
+	close(fd);
+}
+
+TEST(restrictedmem_tmpfile_invalid_fd)
+{
+	int fd = memfd_restricted(RMFD_TMPFILE, -2);
+
+	ASSERT_EQ(-1, fd);
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST(restrictedmem_tmpfile_fd_not_a_mount)
+{
+	int fd = memfd_restricted(RMFD_TMPFILE, STDOUT_FILENO);
+
+	ASSERT_EQ(-1, fd);
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST(restrictedmem_tmpfile_not_tmpfs_mount)
+{
+	int fd = -1;
+	int mfd = -1;
+
+	mfd = open("/proc", O_PATH);
+	ASSERT_NE(-1, mfd);
+
+	fd = memfd_restricted(RMFD_TMPFILE, mfd);
+
+	ASSERT_EQ(-1, fd);
+	ASSERT_EQ(EINVAL, errno);
+}
+
+FIXTURE(tmpfs_hugepage_sfd)
+{
+	int sfd;
+};
+
+FIXTURE_SETUP(tmpfs_hugepage_sfd)
+{
+	self->sfd = fsopen("tmpfs", 0);
+	ASSERT_NE(-1, self->sfd);
+}
+
+FIXTURE_TEARDOWN(tmpfs_hugepage_sfd)
+{
+	close(self->sfd);
+}
+
+TEST_F(tmpfs_hugepage_sfd, restrictedmem_fstat_tmpfs_huge_always)
+{
+	int ret = -1;
+	int fd = -1;
+	int mfd = -1;
+	struct stat stat;
+
+	fsconfig(self->sfd, FSCONFIG_SET_STRING, "huge", "always", 0);
+	fsconfig(self->sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+
+	mfd = fsmount(self->sfd, 0, 0);
+	ASSERT_NE(-1, mfd);
+
+	fd = memfd_restricted(RMFD_TMPFILE, mfd);
+	ASSERT_NE(-1, fd);
+
+	/* User can close reference to mount */
+	ret = close(mfd);
+	ASSERT_EQ(0, ret);
+
+	ret = fstat(fd, &stat);
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
+
+	close(fd);
+}
+
+TEST_F(tmpfs_hugepage_sfd, restrictedmem_fstat_tmpfs_huge_never)
+{
+	int ret = -1;
+	int fd = -1;
+	int mfd = -1;
+	struct stat stat;
+
+	fsconfig(self->sfd, FSCONFIG_SET_STRING, "huge", "never", 0);
+	fsconfig(self->sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+
+	mfd = fsmount(self->sfd, 0, 0);
+	ASSERT_NE(-1, mfd);
+
+	fd = memfd_restricted(RMFD_TMPFILE, mfd);
+	ASSERT_NE(-1, fd);
+
+	/* User can close reference to mount */
+	ret = close(mfd);
+	ASSERT_EQ(0, ret);
+
+	ret = fstat(fd, &stat);
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(stat.st_blksize, getpagesize());
+
+	close(fd);
+}
+
+static bool directory_exists(const char *path)
+{
+	struct stat sb;
+
+	return stat(path, &sb) == 0 && S_ISDIR(sb.st_mode);
+}
+
+FIXTURE(tmpfs_hugepage_mount_path)
+{
+	char *mount_path;
+};
+
+FIXTURE_SETUP(tmpfs_hugepage_mount_path)
+{
+	int ret = -1;
+
+	/* /tmp is an FHS-mandated world-writable directory */
+	self->mount_path = "/tmp/restrictedmem-selftest-mnt";
+
+	if (!directory_exists(self->mount_path)) {
+		ret = mkdir(self->mount_path, 0777);
+		ASSERT_EQ(0, ret);
+	}
+}
+
+FIXTURE_TEARDOWN(tmpfs_hugepage_mount_path)
+{
+	int ret = -1;
+
+	if (!directory_exists(self->mount_path))
+		return;
+
+	ret = umount2(self->mount_path, MNT_FORCE);
+	EXPECT_EQ(0, ret);
+	if (ret == -1 && errno == EINVAL)
+		fprintf(stderr, "%s was not mounted\n", self->mount_path);
+
+	ret = rmdir(self->mount_path);
+	EXPECT_EQ(0, ret);
+	if (ret == -1)
+		fprintf(stderr, "rmdir(%s) failed\n", self->mount_path);
+}
+
+/*
+ * When the restrictedmem's fd is open, a user should not be able to unmount or
+ * remove the mounted directory
+ */
+TEST_F(tmpfs_hugepage_mount_path, restrictedmem_umount_rmdir_while_file_open)
+{
+	int ret = -1;
+	int fd = -1;
+	int mfd = -1;
+	struct stat stat;
+
+	ret = mount("name", self->mount_path, "tmpfs", 0, "huge=always");
+	ASSERT_EQ(0, ret);
+
+	mfd = open(self->mount_path, O_PATH);
+	ASSERT_NE(-1, mfd);
+
+	fd = memfd_restricted(RMFD_TMPFILE, mfd);
+	ASSERT_NE(-1, fd);
+
+	/* We don't need this reference to the mount anymore */
+	ret = close(mfd);
+	ASSERT_EQ(0, ret);
+
+	/* restrictedmem's fd should still be usable */
+	ret = fstat(fd, &stat);
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
+
+	/* User should not be able to unmount directory */
+	ret = umount2(self->mount_path, MNT_FORCE);
+	ASSERT_EQ(-1, ret);
+	ASSERT_EQ(EBUSY, errno);
+
+	ret = rmdir(self->mount_path);
+	ASSERT_EQ(-1, ret);
+	ASSERT_EQ(EBUSY, errno);
+
+	close(fd);
+}
+
+/* The fd of a file on the mount can be provided as mount_fd */
+TEST_F(tmpfs_hugepage_mount_path, restrictedmem_provide_fd_of_file)
+{
+	int ret = -1;
+	int fd = -1;
+	int ffd = -1;
+	char tmp_file_path[PATH_MAX] = { 0 };
+	struct stat stat;
+
+	ret = mount("name", self->mount_path, "tmpfs", 0, "huge=always");
+	ASSERT_EQ(0, ret);
+
+	snprintf(tmp_file_path, PATH_MAX, "%s/tmp-file", self->mount_path);
+	ret = write_string_to_file(tmp_file_path, "filler\n");
+	ASSERT_EQ(0, ret);
+
+	ffd = open(tmp_file_path, O_RDWR);
+	ASSERT_NE(-1, ffd);
+
+	fd = memfd_restricted(RMFD_TMPFILE, ffd);
+	ASSERT_NE(-1, fd);
+
+	/* We don't need this reference anymore */
+	ret = close(ffd);
+	ASSERT_EQ(0, ret);
+
+	ret = fstat(fd, &stat);
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
+
+	close(fd);
+	remove(tmp_file_path);
+}
+
+/*
+ * The fd of any file on the mount (including subdirectories) can be provided as
+ * mount_fd
+ */
+TEST_F(tmpfs_hugepage_mount_path, restrictedmem_provide_fd_of_file_in_subdir)
+{
+	int ret = -1;
+	int fd = -1;
+	int ffd = -1;
+	char tmp_dir_path[PATH_MAX] = { 0 };
+	char tmp_file_path[PATH_MAX] = { 0 };
+	struct stat stat;
+
+	ret = mount("name", self->mount_path, "tmpfs", 0, "huge=always");
+	ASSERT_EQ(0, ret);
+
+	snprintf(tmp_dir_path, PATH_MAX, "%s/tmp-subdir", self->mount_path);
+	ret = mkdir(tmp_dir_path, 0777);
+	ASSERT_EQ(0, ret);
+
+	snprintf(tmp_file_path, PATH_MAX, "%s/tmp-subdir/tmp-file",
+		 self->mount_path);
+	ret = write_string_to_file(tmp_file_path, "filler\n");
+	ASSERT_EQ(0, ret);
+
+	ffd = open(tmp_file_path, O_RDWR);
+	ASSERT_NE(-1, ffd);
+
+	fd = memfd_restricted(RMFD_TMPFILE, ffd);
+	ASSERT_NE(-1, fd);
+
+	/* We don't need this reference anymore */
+	ret = close(ffd);
+	ASSERT_EQ(0, ret);
+
+	ret = fstat(fd, &stat);
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
+
+	close(fd);
+	remove(tmp_file_path);
+	rmdir(tmp_dir_path);
+}
+
+TEST_HARNESS_MAIN
-- 
2.40.0.rc2.332.ga46443480c-goog

