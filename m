Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E98E6E18CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 02:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjDNAMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 20:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjDNAMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:12:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3833A3A86
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:12:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 18-20020a250b12000000b00b8f6cf4f5c9so753439ybl.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681431129; x=1684023129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIdXLIzbqoaS1yDLNUT0qQstKE8tePtbIkE0dhqmXxw=;
        b=tYf5bMIhxkr3hMt+lIl1PwjzLoiSUpfQWFuv6YVcAfFgRdEoudCktx2A+d0JqBuvOp
         z7jDltQapqSgAAhCbia4ma/bs6+Elmvi2Gje0GcQy+s+haBTRtk+BaqUdfLeOeW36uBM
         6MypyFUJxdUxMweXKlUl7CO/Q1AO0eUVAwfsLrKRHXW02ZCD/fodZ/BhJs3hNjpCIo+Y
         cIPpRQQptnvuiKd6Qf6tMjU2sO+NUQFKpX/Achfnm+Vek4M3QErvwjtnfJ6Clswfoz0b
         wIt6IvVXO9FiMRR1epVuwOCV/qP/1d3QqZG2bG2qG2X3Hmji5CKuZuuD4fO544jPiWvf
         +lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681431129; x=1684023129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIdXLIzbqoaS1yDLNUT0qQstKE8tePtbIkE0dhqmXxw=;
        b=lUokp31xqHZlXPjTGHv3tVUCX4mLNEtIWVnLjjjUawhFP986e6aLX7F95GpPVD8TjZ
         aKtif/GJfKYoZGE6nkK/4N1B78yGTkSLSILNDPVbZJVelUVOR2VEkVzdXUR6lOJl3Gy5
         mIYMH1NIdLmFKcLy7kRQdBPsh7yn02GRfD64ENGl9ZbH4Miu9SNL9gWYZF9BxyjYZpQj
         rude3bticfphyml1ewXW1xGWPzOIM++CkL1tYjOPjthLIT59APvigV4XOzJXQMdwK0vP
         h8iwZjMa4gDW9o+xdGdOMt9zS5R+rB07eNjqDhVw0ANQDqywCcXZsyKyJkoaoMBWG5ty
         CBVw==
X-Gm-Message-State: AAQBX9dT21kdY9EUD4V9cEmXCDE87UY/4SlKupNd17Ce6uO9scdlXQnE
        lS66Humr4SW/I6+XXy7NMjfz7WGT7UR0hzgOTQ==
X-Google-Smtp-Source: AKy350aw1qXzddjDywjx3OQ/Kkf8aSm9qQ52ggrXe9lxiXXBS/UAEkiIAH3/1jEr1IF4yNFdix0pirr9uwMpC8d++w==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a25:d288:0:b0:b75:3fd4:1b31 with SMTP
 id j130-20020a25d288000000b00b753fd41b31mr2693074ybg.1.1681431128801; Thu, 13
 Apr 2023 17:12:08 -0700 (PDT)
Date:   Fri, 14 Apr 2023 00:11:55 +0000
In-Reply-To: <cover.1681430907.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1681430907.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <7b40fc4afa41e382d72f556399ed5e0808b969b5.1681430907.git.ackerleytng@google.com>
Subject: [RFC PATCH 6/6] selftests: mm: Add selftest for memfd_restricted_bind()
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
        muchun.song@linux.dev, feng.tang@intel.com, brgerst@gmail.com,
        rdunlap@infradead.org, masahiroy@kernel.org,
        mailhol.vincent@wanadoo.fr, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This selftest uses memfd_restricted_bind() to set the mempolicy for a
restrictedmem file, and then checks that pages were indeed allocated
according to that policy.

Because restrictedmem pages are never mapped into userspace memory,
the usual ways of checking which NUMA node the page was allocated
on (e.g. /proc/pid/numa_maps) cannot be used.

This selftest adds a small kernel module that overloads the ioctl
syscall on /proc/restrictedmem to request a restrictedmem page and get
the node it was allocated on. The page is freed within the ioctl handler.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   8 +
 .../selftests/mm/memfd_restricted_bind.c      | 139 ++++++++++++++++++
 .../mm/restrictedmem_testmod/Makefile         |  21 +++
 .../restrictedmem_testmod.c                   |  89 +++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   6 +
 6 files changed, 264 insertions(+)
 create mode 100644 tools/testing/selftests/mm/memfd_restricted_bind.c
 create mode 100644 tools/testing/selftests/mm/restrictedmem_testmod/Makefile
 create mode 100644 tools/testing/selftests/mm/restrictedmem_testmod/restrictedmem_testmod.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index fb6e4233374d..10c5701b9645 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -31,6 +31,7 @@ map_fixed_noreplace
 write_to_hugetlbfs
 hmm-tests
 memfd_restricted
+memfd_restricted_bind
 memfd_secret
 soft-dirty
 split_huge_page_test
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 5ec338ea1fed..4a6cf922db45 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -46,6 +46,8 @@ TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
 TEST_GEN_FILES += memfd_restricted
+TEST_GEN_FILES += memfd_restricted_bind
+TEST_GEN_FILES += restrictedmem_testmod.ko
 TEST_GEN_FILES += memfd_secret
 TEST_GEN_FILES += migration
 TEST_GEN_FILES += mlock-random-test
@@ -171,6 +173,12 @@ $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
 
 $(OUTPUT)/migration: LDLIBS += -lnuma
 
+$(OUTPUT)/memfd_restricted_bind: LDLIBS += -lnuma
+$(OUTPUT)/restrictedmem_testmod.ko: $(wildcard restrictedmem_testmod/Makefile restrictedmem_testmod/*.[ch])
+	$(call msg,MOD,,$@)
+	$(Q)$(MAKE) -C restrictedmem_testmod
+	$(Q)cp restrictedmem_testmod/restrictedmem_testmod.ko $@
+
 local_config.mk local_config.h: check_config.sh
 	/bin/sh ./check_config.sh $(CC)
 
diff --git a/tools/testing/selftests/mm/memfd_restricted_bind.c b/tools/testing/selftests/mm/memfd_restricted_bind.c
new file mode 100644
index 000000000000..64aa44c72d09
--- /dev/null
+++ b/tools/testing/selftests/mm/memfd_restricted_bind.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <fcntl.h>
+#include <linux/mempolicy.h>
+#include <numa.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+int memfd_restricted(int flags, int fd)
+{
+	return syscall(__NR_memfd_restricted, flags, fd);
+}
+
+int memfd_restricted_bind(
+	int fd, loff_t offset, unsigned long len, unsigned long mode,
+	const unsigned long *nmask, unsigned long maxnode, unsigned int flags)
+{
+	struct file_range range = {
+		.offset = offset,
+		.len = len,
+	};
+
+	return syscall(__NR_memfd_restricted_bind, fd, &range, mode, nmask, maxnode, flags);
+}
+
+int memfd_restricted_bind_node(
+	int fd, loff_t offset, unsigned long len,
+	unsigned long mode, int node, unsigned int flags)
+{
+	int ret;
+	struct bitmask *mask = numa_allocate_nodemask();
+
+	numa_bitmask_setbit(mask, node);
+
+	ret = memfd_restricted_bind(fd, offset, len, mode, mask->maskp, mask->size, flags);
+
+	numa_free_nodemask(mask);
+
+	return ret;
+}
+
+/**
+ * Allocates a page in restrictedmem_fd, reads the node that the page was
+ * allocated it and returns it. Returns -1 on error.
+ */
+int read_node(int restrictedmem_fd, unsigned long offset)
+{
+	int ret;
+	int fd;
+
+	fd = open("/proc/restrictedmem", O_RDWR);
+	if (!fd)
+		return -ENOTSUP;
+
+	ret = ioctl(fd, restrictedmem_fd, offset);
+
+	close(fd);
+
+	return ret;
+}
+
+bool restrictedmem_testmod_loaded(void)
+{
+	struct stat buf;
+
+	return stat("/proc/restrictedmem", &buf) == 0;
+}
+
+FIXTURE(restrictedmem_file)
+{
+	int fd;
+	size_t page_size;
+};
+
+FIXTURE_SETUP(restrictedmem_file)
+{
+	int fd;
+	int ret;
+	struct stat stat;
+
+	fd = memfd_restricted(0, -1);
+	ASSERT_GT(fd, 0);
+
+#define RESTRICTEDMEM_TEST_NPAGES 16
+	ret = ftruncate(fd, getpagesize() * RESTRICTEDMEM_TEST_NPAGES);
+	ASSERT_EQ(ret, 0);
+
+	ret = fstat(fd, &stat);
+	ASSERT_EQ(ret, 0);
+
+	self->fd = fd;
+	self->page_size = stat.st_blksize;
+};
+
+FIXTURE_TEARDOWN(restrictedmem_file)
+{
+	int ret;
+
+	ret = close(self->fd);
+	EXPECT_EQ(ret, 0);
+}
+
+#define ASSERT_REQUIREMENTS()					\
+	do {							\
+		struct bitmask *mask = numa_get_membind();	\
+		ASSERT_GT(numa_num_configured_nodes(), 1);	\
+		ASSERT_TRUE(numa_bitmask_isbitset(mask, 0));	\
+		ASSERT_TRUE(numa_bitmask_isbitset(mask, 1));	\
+		numa_bitmask_free(mask);			\
+		ASSERT_TRUE(restrictedmem_testmod_loaded());	\
+	} while (0)
+
+TEST_F(restrictedmem_file, memfd_restricted_bind_works_as_expected)
+{
+	int ret;
+	int node;
+	int i;
+	int node_bindings[] = { 1, 0, 1, 0, 1, 1, 0, 1 };
+
+	ASSERT_REQUIREMENTS();
+
+	for (i = 0; i < ARRAY_SIZE(node_bindings); i++) {
+		ret = memfd_restricted_bind_node(
+			self->fd, i * self->page_size, self->page_size,
+			MPOL_BIND, node_bindings[i], 0);
+		ASSERT_EQ(ret, 0);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(node_bindings); i++) {
+		node = read_node(self->fd, i * self->page_size);
+		ASSERT_EQ(node, node_bindings[i]);
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/restrictedmem_testmod/Makefile b/tools/testing/selftests/mm/restrictedmem_testmod/Makefile
new file mode 100644
index 000000000000..11b1d5d15e3c
--- /dev/null
+++ b/tools/testing/selftests/mm/restrictedmem_testmod/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+RESTRICTEDMEM_TESTMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(RESTRICTEDMEM_TESTMOD_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = restrictedmem_testmod.ko
+
+obj-m += restrictedmem_testmod.o
+CFLAGS_restrictedmem_testmod.o = -I$(src)
+
+all:
+	+$(Q)make -C $(KDIR) M=$(RESTRICTEDMEM_TESTMOD_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=$(RESTRICTEDMEM_TESTMOD_DIR) clean
diff --git a/tools/testing/selftests/mm/restrictedmem_testmod/restrictedmem_testmod.c b/tools/testing/selftests/mm/restrictedmem_testmod/restrictedmem_testmod.c
new file mode 100644
index 000000000000..d35f55d26408
--- /dev/null
+++ b/tools/testing/selftests/mm/restrictedmem_testmod/restrictedmem_testmod.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "linux/printk.h"
+#include "linux/types.h"
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/restrictedmem.h>
+
+MODULE_DESCRIPTION("A kernel module to support restrictedmem testing");
+MODULE_AUTHOR("ackerleytng@google.com");
+MODULE_LICENSE("GPL");
+
+void dummy_op(struct restrictedmem_notifier *notifier, pgoff_t start, pgoff_t end)
+{
+}
+
+static const struct restrictedmem_notifier_ops dummy_notifier_ops = {
+	.invalidate_start = dummy_op,
+	.invalidate_end = dummy_op,
+	.error = dummy_op,
+};
+
+static struct restrictedmem_notifier dummy_notifier = {
+	.ops = &dummy_notifier_ops,
+};
+
+static long restrictedmem_testmod_ioctl(
+	struct file *file, unsigned int cmd, unsigned long offset)
+{
+	long ret;
+	struct fd f;
+	struct page *page;
+	pgoff_t start = offset >> PAGE_SHIFT;
+
+	f = fdget(cmd);
+	if (!f.file)
+		return -EBADF;
+
+	ret = -EINVAL;
+	if (!file_is_restrictedmem(f.file))
+		goto out;
+
+
+	ret = restrictedmem_bind(f.file, start, start + 1, &dummy_notifier, true);
+	if (ret)
+		goto out;
+
+	ret = restrictedmem_get_page(f.file, (unsigned long)start, &page, NULL);
+	if (ret)
+		goto out;
+
+	ret = page_to_nid(page);
+
+	folio_put(page_folio(page));
+
+	restrictedmem_unbind(f.file, start, start + 1, &dummy_notifier);
+
+out:
+	fdput(f);
+
+	return ret;
+}
+
+static const struct proc_ops restrictedmem_testmod_ops = {
+	.proc_ioctl = restrictedmem_testmod_ioctl,
+};
+
+static struct proc_dir_entry *restrictedmem_testmod_entry;
+
+static int restrictedmem_testmod_init(void)
+{
+	restrictedmem_testmod_entry = proc_create(
+		"restrictedmem", 0660, NULL, &restrictedmem_testmod_ops);
+
+	return 0;
+}
+
+static void restrictedmem_testmod_exit(void)
+{
+	proc_remove(restrictedmem_testmod_entry);
+}
+
+module_init(restrictedmem_testmod_init);
+module_exit(restrictedmem_testmod_exit);
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 53de84e3ec2c..bdc853d6afe4 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -40,6 +40,8 @@ separated by spaces:
 	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
 - memfd_restricted_
 	test memfd_restricted(2)
+- memfd_restricted_bind
+	test memfd_restricted_bind(2)
 - memfd_secret
 	test memfd_secret(2)
 - process_mrelease
@@ -240,6 +242,10 @@ CATEGORY="madv_populate" run_test ./madv_populate
 
 CATEGORY="memfd_restricted" run_test ./memfd_restricted
 
+test_selected "memfd_restricted_bind" && insmod ./restrictedmem_testmod.ko && \
+  CATEGORY="memfd_restricted_bind" run_test ./memfd_restricted_bind && \
+  rmmod restrictedmem_testmod > /dev/null
+
 CATEGORY="memfd_secret" run_test ./memfd_secret
 
 # KSM MADV_MERGEABLE test with 10 identical pages
-- 
2.40.0.634.g4ca3ef3211-goog

