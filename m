Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6866DCF48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 03:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDKB3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Apr 2023 21:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjDKB3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:29:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E70719A8
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 18:29:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54ee1fd7876so71730287b3.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681176580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUMdFa7+PPMn99YcGlnAfohLLYbWjlEJWXPRhdQ3G0w=;
        b=O5jPzmxvpGvZW7A15nBNKVb9+WZg0AxtgKYK/czsKaQti101N5gb12ZgJwZ79KOqCf
         /7nLUbSt/ecPSttKIZWx6hQc09RPO2HLTAVpaRmG4dxWAxUD1XW4CPBxQwX91bGClxCM
         n9SwpkbUTkagt1qddJ5g+Zlprvg9Qx83RwrnKQyRHDiuW/iPXyr64Ji+vFI/hXtaItGe
         bKQE6xEnoGEp/6S1qqA8RVOleosKH8GoiYUjrxCrkffvfodFdsATKBc1Df5vA9mW7O0G
         wEsFs+d31y4Hn8W1fVVU7JSdUXy353YUcUPYXkJGfyphlSLdBo0eGJEp/ecFM45BsrMI
         v+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681176580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUMdFa7+PPMn99YcGlnAfohLLYbWjlEJWXPRhdQ3G0w=;
        b=d6026xAMygNcf9EB10JrN4vj5KmNl9GMyZIbX3jk8TrwZOy4HeCF6Q3sPhKiKDBkez
         +7yUJ8xl1XjGGW1xtyD7ejLG1xpyicHFKzFo3OVb4reWQafeo5gguo3KlA0TxIRVS/fI
         N+t55e1xWuak3F5BDMPjtJXhGx/YvJp3rdL+bAN3y+9IbYR8G1o1BUfs+pIap2SRcGN0
         bzv1ozHWA1LJ3l32p+CsYfNMxM/S3SzLXhsRbEVmc2kWBkjGo8s0blxhVc2E21vEn+6Q
         A62loPBHWqI1i0pwWDTNVBI56rG6tVuY+Hgwu2T2jc5Z+Hqzoid+2jBtsKqgGU4MlGOX
         IZ0A==
X-Gm-Message-State: AAQBX9fnRM9pciMB3GHVJQ6x7Ysu5g8VueQmUYflwDeU4BAW2+bth6En
        3pq6rARSRHJpoxOEiJF/ohO3eUER/bm/BeNOWQ==
X-Google-Smtp-Source: AKy350aWx1LEWUOf1FrnrMDEm7YGoW5Jf5E4LFqJ8ZnxfEUyPVRZ2iMsx9R9r5E7bVHQTgok7giMc8dxwwldHsZMKw==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:909:b0:a27:3ecc:ffe7 with
 SMTP id bu9-20020a056902090900b00a273eccffe7mr10712313ybb.3.1681176579771;
 Mon, 10 Apr 2023 18:29:39 -0700 (PDT)
Date:   Tue, 11 Apr 2023 01:29:33 +0000
In-Reply-To: <cover.1681176340.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1681176340.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <2a733e3ed673c3b9d6b1a5fcb6625953da042f42.1681176340.git.ackerleytng@google.com>
Subject: [RFC PATCH v4 2/2] selftests: restrictedmem: Check
 memfd_restricted()'s handling of provided userspace mount
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

Also includes negative tests for invalid inputs, including fds
representing read-only superblocks/mounts.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/memfd_restricted_usermnt.c   | 529 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   3 +
 4 files changed, 534 insertions(+)
 create mode 100644 tools/testing/selftests/mm/memfd_restricted_usermnt.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index fb6e4233374d..dba320c8151a 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -31,6 +31,7 @@ map_fixed_noreplace
 write_to_hugetlbfs
 hmm-tests
 memfd_restricted
+memfd_restricted_usermnt
 memfd_secret
 soft-dirty
 split_huge_page_test
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 5ec338ea1fed..2f5df7a12ea5 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -46,6 +46,7 @@ TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
 TEST_GEN_FILES += memfd_restricted
+TEST_GEN_FILES += memfd_restricted_usermnt
 TEST_GEN_FILES += memfd_secret
 TEST_GEN_FILES += migration
 TEST_GEN_FILES += mlock-random-test
diff --git a/tools/testing/selftests/mm/memfd_restricted_usermnt.c b/tools/testing/selftests/mm/memfd_restricted_usermnt.c
new file mode 100644
index 000000000000..0be04e3d714d
--- /dev/null
+++ b/tools/testing/selftests/mm/memfd_restricted_usermnt.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define _GNU_SOURCE /* for O_PATH */
+#define _POSIX_C_SOURCE /* for PATH_MAX */
+#include <limits.h>
+#include <sys/syscall.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+
+#include "linux/restrictedmem.h"
+
+#include "../kselftest_harness.h"
+
+static int memfd_restricted(unsigned int flags, int fd)
+{
+	return syscall(__NR_memfd_restricted, flags, fd);
+}
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
+/*
+ * Expect shmem thp policy to be one of always, within_size, advise, never,
+ * deny, force
+ */
+#define POLICY_BUF_SIZE 12
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
+	ASSERT_EQ(get_shmem_thp_policy(self->shmem_enabled), 0);
+}
+
+FIXTURE_TEARDOWN(reset_shmem_enabled)
+{
+	ASSERT_EQ(set_shmem_thp_policy(self->shmem_enabled), 0);
+}
+
+TEST_F(reset_shmem_enabled, restrictedmem_fstat_shmem_enabled_never)
+{
+	int fd = -1;
+	struct stat stat;
+
+	ASSERT_EQ(set_shmem_thp_policy("never"), 0);
+
+	fd = memfd_restricted(0, -1);
+	ASSERT_GT(fd, 0);
+
+	ASSERT_EQ(fstat(fd, &stat), 0);
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
+	ASSERT_EQ(set_shmem_thp_policy("always"), 0);
+
+	fd = memfd_restricted(0, -1);
+	ASSERT_GT(fd, 0);
+
+	ASSERT_EQ(fstat(fd, &stat), 0);
+
+	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
+
+	close(fd);
+}
+
+TEST(restrictedmem_tmpfile_invalid_fd)
+{
+	int fd = memfd_restricted(MEMFD_RSTD_USERMNT, -2);
+
+	ASSERT_EQ(fd, -1);
+	ASSERT_EQ(errno, EBADF);
+}
+
+TEST(restrictedmem_tmpfile_fd_not_a_mount)
+{
+	int fd = memfd_restricted(MEMFD_RSTD_USERMNT, STDOUT_FILENO);
+
+	ASSERT_EQ(fd, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+TEST(restrictedmem_tmpfile_not_tmpfs_mount)
+{
+	int fd = -1;
+	int mfd = -1;
+
+	mfd = open("/proc", O_PATH);
+	ASSERT_NE(mfd, -1);
+
+	fd = memfd_restricted(MEMFD_RSTD_USERMNT, mfd);
+
+	ASSERT_EQ(fd, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+FIXTURE(tmpfs_sfd)
+{
+	int sfd;
+};
+
+FIXTURE_SETUP(tmpfs_sfd)
+{
+	self->sfd = fsopen("tmpfs", 0);
+	ASSERT_NE(self->sfd, -1);
+}
+
+FIXTURE_TEARDOWN(tmpfs_sfd)
+{
+	EXPECT_EQ(close(self->sfd), 0);
+}
+
+TEST_F(tmpfs_sfd, restrictedmem_fstat_tmpfs_huge_always)
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
+	ASSERT_NE(mfd, -1);
+
+	fd = memfd_restricted(MEMFD_RSTD_USERMNT, mfd);
+	ASSERT_GT(fd, 0);
+
+	/* User can close reference to mount */
+	ret = close(mfd);
+	ASSERT_EQ(ret, 0);
+
+	ret = fstat(fd, &stat);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
+
+	close(fd);
+}
+
+TEST_F(tmpfs_sfd, restrictedmem_fstat_tmpfs_huge_never)
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
+	ASSERT_NE(mfd, -1);
+
+	fd = memfd_restricted(MEMFD_RSTD_USERMNT, mfd);
+	ASSERT_GT(fd, 0);
+
+	/* User can close reference to mount */
+	ret = close(mfd);
+	ASSERT_EQ(ret, 0);
+
+	ret = fstat(fd, &stat);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(stat.st_blksize, getpagesize());
+
+	close(fd);
+}
+
+TEST_F(tmpfs_sfd, restrictedmem_check_mount_flags)
+{
+	int ret = -1;
+	int fd = -1;
+	int mfd = -1;
+
+	fsconfig(self->sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+
+	mfd = fsmount(self->sfd, 0, MOUNT_ATTR_RDONLY);
+	ASSERT_NE(mfd, -1);
+
+	fd = memfd_restricted(MEMFD_RSTD_USERMNT, mfd);
+	ASSERT_EQ(fd, -1);
+	ASSERT_EQ(errno, EROFS);
+
+	ret = close(mfd);
+	ASSERT_EQ(ret, 0);
+}
+
+TEST_F(tmpfs_sfd, restrictedmem_check_superblock_flags)
+{
+	int ret = -1;
+	int fd = -1;
+	int mfd = -1;
+
+	fsconfig(self->sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
+	fsconfig(self->sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+
+	mfd = fsmount(self->sfd, 0, 0);
+	ASSERT_NE(mfd, -1);
+
+	fd = memfd_restricted(MEMFD_RSTD_USERMNT, mfd);
+	ASSERT_EQ(fd, -1);
+	ASSERT_EQ(errno, EROFS);
+
+	ret = close(mfd);
+	ASSERT_EQ(ret, 0);
+}
+
+static bool directory_exists(const char *path)
+{
+	struct stat sb;
+
+	return stat(path, &sb) == 0 && S_ISDIR(sb.st_mode);
+}
+
+FIXTURE(restrictedmem_test_mount_path)
+{
+	char *mount_path;
+};
+
+FIXTURE_SETUP(restrictedmem_test_mount_path)
+{
+	int ret = -1;
+
+	/* /tmp is an FHS-mandated world-writable directory */
+	self->mount_path = "/tmp/restrictedmem-selftest-mnt";
+
+	if (!directory_exists(self->mount_path)) {
+		ret = mkdir(self->mount_path, 0777);
+		ASSERT_EQ(ret, 0);
+	}
+}
+
+FIXTURE_TEARDOWN(restrictedmem_test_mount_path)
+{
+	int ret = -1;
+
+	if (!directory_exists(self->mount_path))
+		return;
+
+	ret = umount2(self->mount_path, MNT_FORCE);
+	EXPECT_EQ(ret, 0);
+	if (ret == -1 && errno == EINVAL)
+		fprintf(stderr, "  %s was not mounted\n", self->mount_path);
+
+	ret = rmdir(self->mount_path);
+	EXPECT_EQ(ret, 0);
+	if (ret == -1)
+		fprintf(stderr, "  rmdir(%s) failed: %m\n", self->mount_path);
+}
+
+/*
+ * memfd_restricted() syscall can only be used with the fd of the root of the
+ * mount. When the restrictedmem's fd is open, a user should not be able to
+ * unmount or remove the mounted directory
+ */
+TEST_F(restrictedmem_test_mount_path, restrictedmem_umount_rmdir_while_file_open)
+{
+	int ret = -1;
+	int fd = -1;
+	int mfd = -1;
+	struct stat stat;
+
+	ret = mount("name", self->mount_path, "tmpfs", 0, "huge=always");
+	ASSERT_EQ(ret, 0);
+
+	mfd = open(self->mount_path, O_PATH);
+	ASSERT_NE(mfd, -1);
+
+	fd = memfd_restricted(MEMFD_RSTD_USERMNT, mfd);
+	ASSERT_GT(fd, 0);
+
+	/* We don't need this reference to the mount anymore */
+	ret = close(mfd);
+	ASSERT_EQ(ret, 0);
+
+	/* restrictedmem's fd should still be usable */
+	ret = fstat(fd, &stat);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
+
+	/* User should not be able to unmount directory */
+	ret = umount2(self->mount_path, MNT_FORCE);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EBUSY);
+
+	ret = rmdir(self->mount_path);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EBUSY);
+
+	close(fd);
+}
+
+/* The fd of a file on the mount cannot be provided as mount_fd */
+TEST_F(restrictedmem_test_mount_path, restrictedmem_provide_fd_of_file)
+{
+	int ret = -1;
+	int fd = -1;
+	int ffd = -1;
+	char tmp_file_path[PATH_MAX] = { 0 };
+
+	ret = mount("name", self->mount_path, "tmpfs", 0, "huge=always");
+	ASSERT_EQ(ret, 0);
+
+	snprintf(tmp_file_path, PATH_MAX, "%s/tmp-file", self->mount_path);
+	ret = write_string_to_file(tmp_file_path, "filler\n");
+	ASSERT_EQ(ret, 0);
+
+	ffd = open(tmp_file_path, O_RDWR);
+	ASSERT_GT(ffd, 0);
+
+	fd = memfd_restricted(MEMFD_RSTD_USERMNT, ffd);
+	ASSERT_LT(fd, 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret = close(ffd);
+	ASSERT_EQ(ret, 0);
+
+	close(fd);
+	remove(tmp_file_path);
+}
+
+/* The fd of files on the mount cannot be provided as mount_fd */
+TEST_F(restrictedmem_test_mount_path, restrictedmem_provide_fd_of_file_in_subdir)
+{
+	int ret = -1;
+	int fd = -1;
+	int ffd = -1;
+	char tmp_dir_path[PATH_MAX] = { 0 };
+	char tmp_file_path[PATH_MAX] = { 0 };
+
+	ret = mount("name", self->mount_path, "tmpfs", 0, "huge=always");
+	ASSERT_EQ(ret, 0);
+
+	snprintf(tmp_dir_path, PATH_MAX, "%s/tmp-subdir", self->mount_path);
+	ret = mkdir(tmp_dir_path, 0777);
+	ASSERT_EQ(ret, 0);
+
+	snprintf(tmp_file_path, PATH_MAX, "%s/tmp-subdir/tmp-file",
+		 self->mount_path);
+	ret = write_string_to_file(tmp_file_path, "filler\n");
+	ASSERT_EQ(ret, 0);
+
+	ffd = open(tmp_file_path, O_RDWR);
+	ASSERT_NE(ffd, -1);
+
+	fd = memfd_restricted(MEMFD_RSTD_USERMNT, ffd);
+	ASSERT_LT(fd, 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret = close(ffd);
+	ASSERT_EQ(ret, 0);
+
+	remove(tmp_file_path);
+	rmdir(tmp_dir_path);
+}
+
+/*
+ * fds representing bind mounts must represent the root of the original
+ * filesystem
+ */
+TEST_F(restrictedmem_test_mount_path, restrictedmem_provide_fd_of_original_fs)
+{
+	int ret = -1;
+	int fd = -1;
+	int mfd = -1;
+	char tmp_dir_path_0[PATH_MAX] = { 0 };
+	char tmp_dir_path_1[PATH_MAX] = { 0 };
+
+	ret = mount("name", self->mount_path, "tmpfs", 0, "huge=always");
+	ASSERT_EQ(ret, 0);
+
+	snprintf(tmp_dir_path_0, PATH_MAX, "%s/tmp-subdir-0", self->mount_path);
+	ret = mkdir(tmp_dir_path_0, 0777);
+	ASSERT_EQ(ret, 0);
+
+	snprintf(tmp_dir_path_1, PATH_MAX, "%s/tmp-subdir-1", self->mount_path);
+	ret = mkdir(tmp_dir_path_1, 0777);
+	ASSERT_EQ(ret, 0);
+
+	ret = mount(tmp_dir_path_0, tmp_dir_path_1, "tmpfs", MS_BIND, NULL);
+	ASSERT_EQ(ret, 0);
+
+	mfd = open(tmp_dir_path_1, O_PATH);
+	ASSERT_NE(mfd, -1);
+
+	fd = memfd_restricted(MEMFD_RSTD_USERMNT, mfd);
+	ASSERT_LT(fd, 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret = close(mfd);
+	ASSERT_EQ(ret, 0);
+
+	ret = umount2(tmp_dir_path_1, MNT_FORCE);
+	ASSERT_EQ(ret, 0);
+
+	rmdir(tmp_dir_path_0);
+	rmdir(tmp_dir_path_1);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 53de84e3ec2c..04238f86f037 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -40,6 +40,8 @@ separated by spaces:
 	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
 - memfd_restricted_
 	test memfd_restricted(2)
+- memfd_restricted_usermnt
+	test memfd_restricted(2)'s handling of provided userspace mounts
 - memfd_secret
 	test memfd_secret(2)
 - process_mrelease
@@ -239,6 +241,7 @@ CATEGORY="hmm" run_test ./test_hmm.sh smoke
 CATEGORY="madv_populate" run_test ./madv_populate
 
 CATEGORY="memfd_restricted" run_test ./memfd_restricted
+CATEGORY="memfd_restricted_usermnt" run_test ./memfd_restricted_usermnt
 
 CATEGORY="memfd_secret" run_test ./memfd_secret
 
-- 
2.40.0.577.gac1e443424-goog

