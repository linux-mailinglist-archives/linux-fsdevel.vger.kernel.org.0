Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11406E18BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 02:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDNAMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 20:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDNAMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:12:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291530F3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:12:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 188-20020a2504c5000000b00b8f6f5dca5dso244968ybe.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681431127; x=1684023127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv2Sbflv1PdMqZUyau/vGtw69NpiI05I8fyTNzzRBtE=;
        b=IeAvbh5LiWqeMu3W4lreAV4pEYXDzFTMIK++YoYtL9HONMbDl2n8JG1cJvXTxQ4W/Z
         GxRYbHWg5mdzTkvevWjucHzalLOLaRJPEZSOdabNIZoeGxpZJ7sqGOpBbuMaxh+N9UO4
         laslticySsTQ5Z1P33WcVcn5XKY3X/szRjrTAuUNdQOCywlR5EjataM835zXeQyYF84o
         sNh45HAi3xIJdUtIf7JG4FaHzE4kQ9wGOth27DrwXDDPKWE4i8uvOAxFPGUJWILtbFqJ
         B0wpIq7/vwtgTuDsvfcJaOD5/zbThG99OLcVYbtOP9o7ei2nNW7AfnDuSWHGLmDR7UAC
         GOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681431127; x=1684023127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv2Sbflv1PdMqZUyau/vGtw69NpiI05I8fyTNzzRBtE=;
        b=e1XVuazSLfcDF+OcyVBMnqypxyM7kxLWbiWayNzcDwe2biNBRC/kzaU+VGkOq5pTig
         aNRr+mWx8E+1242tr2AOPr+bEEcW2rHkafXrfvGmkxBqfF4VV6nTIRBcKrgPWfAJgvFz
         J0pwmDyDxmB2zFIG6zxsLlEXdrZ0cATM2iqlLNeRYNg+mTf/Lw9p0y1IxZ0Iq4zm+dxb
         4qLiWVXylKd61zcsRffhq7R+4NpfWIrxd5zLJgI+hov7p79KRJMmro99Kn7Z4rUhGLD/
         YUdfpJJ+HC7iQsFtX+sKzMulVjzuznOdBMJ9Dy5kBwA8PasdLrTPz2DFp1w46/s7+B2z
         xP2A==
X-Gm-Message-State: AAQBX9dquMWQ1OzY9mTZjUkvVPevYd4HKF1uRv1gpTBXvCCTuD4/I0qF
        uESGEnGN/rrwnBYB6fbr9LnqREk1dAxoHwSphA==
X-Google-Smtp-Source: AKy350bz8+zUcgBBK3sJ0KBBaZXIEou5c04bKvPj9N3prJO/LHXQy58hyZlX1YHGEbHTNZX5qvCYitSezXVlLtbvug==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a25:68cc:0:b0:a27:3ecc:ffe7 with SMTP
 id d195-20020a2568cc000000b00a273eccffe7mr5642963ybc.3.1681431127201; Thu, 13
 Apr 2023 17:12:07 -0700 (PDT)
Date:   Fri, 14 Apr 2023 00:11:54 +0000
In-Reply-To: <cover.1681430907.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1681430907.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <de27d8bba0b7a5a15df93d04e56b62ed3d66e232.1681430907.git.ackerleytng@google.com>
Subject: [RFC PATCH 5/6] mm: restrictedmem: Add memfd_restricted_bind() syscall
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

memfd_restricted_bind() sets the NUMA memory policy, which consists of
a policy mode and zero or more nodes, for an offset within a
restrictedmem file with file descriptor fd and continuing for len
bytes.

This is intended to be like mbind() but specially for restrictedmem
files, which cannot be mmap()ed into userspace and hence has no memory
addresses that can be used with mbind().

Unlike mbind(), memfd_restricted_bind() will override any existing
memory policy if a new memory policy is defined for the same ranges.

For now, memfd_restricted_bind() does not perform migrations and no
flags are supported.

This syscall is specialised just for restrictedmem files because this
functionality is not required by other files.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/mempolicy.h              |  2 +-
 include/linux/syscalls.h               |  5 ++
 include/uapi/asm-generic/unistd.h      |  5 +-
 include/uapi/linux/mempolicy.h         |  7 ++-
 kernel/sys_ni.c                        |  1 +
 mm/restrictedmem.c                     | 75 ++++++++++++++++++++++++++
 scripts/checksyscalls.sh               |  1 +
 9 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index dc70ba90247e..c94e9ce46cc3 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -456,3 +456,4 @@
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	memfd_restricted	sys_memfd_restricted
+452	i386	memfd_restricted_bind	sys_memfd_restricted_bind
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 06516abc8318..6bd86b45d63a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -373,6 +373,7 @@
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	memfd_restricted	sys_memfd_restricted
+452	common	memfd_restricted_bind	sys_memfd_restricted_bind
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 15facd9de087..af62233df0c0 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -126,7 +126,7 @@ struct shared_policy {
 
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst);
 struct mempolicy *mpol_create(
-	unsigned long mode, const unsigned long __user *nmask, unsigned long maxnode)
+	unsigned long mode, const unsigned long __user *nmask, unsigned long maxnode);
 void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol);
 int __mpol_set_shared_policy(struct shared_policy *info, struct mempolicy *mpol,
 			     unsigned long pgoff_start, unsigned long npages);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 660be0bf89d5..852b202d3837 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1059,6 +1059,11 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 					    unsigned long home_node,
 					    unsigned long flags);
 asmlinkage long sys_memfd_restricted(unsigned int flags);
+asmlinkage long sys_memfd_restricted_bind(int fd, struct file_range __user *range,
+					  unsigned long mode,
+					  const unsigned long __user *nmask,
+					  unsigned long maxnode,
+					  unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index e2ea7cd964f8..b5a1385bb4a7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -889,10 +889,13 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 #ifdef __ARCH_WANT_MEMFD_RESTRICTED
 #define __NR_memfd_restricted 451
 __SYSCALL(__NR_memfd_restricted, sys_memfd_restricted)
+
+#define __NR_memfd_restricted_bind 452
+__SYSCALL(__NR_memfd_restricted_bind, sys_memfd_restricted_bind)
 #endif
 
 #undef __NR_syscalls
-#define __NR_syscalls 452
+#define __NR_syscalls 453
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 046d0ccba4cd..979499abd253 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -6,9 +6,9 @@
 #ifndef _UAPI_LINUX_MEMPOLICY_H
 #define _UAPI_LINUX_MEMPOLICY_H
 
+#include <asm-generic/posix_types.h>
 #include <linux/errno.h>
 
-
 /*
  * Both the MPOL_* mempolicy mode and the MPOL_F_* optional mode flags are
  * passed by the user to either set_mempolicy() or mbind() in an 'int' actual.
@@ -72,4 +72,9 @@ enum {
 #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
 #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
 
+struct file_range {
+	__kernel_loff_t offset;
+	__kernel_size_t len;
+};
+
 #endif /* _UAPI_LINUX_MEMPOLICY_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 7c4a32cbd2e7..db24d3fe6dc5 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -362,6 +362,7 @@ COND_SYSCALL(memfd_secret);
 
 /* memfd_restricted */
 COND_SYSCALL(memfd_restricted);
+COND_SYSCALL(memfd_restricted_bind);
 
 /*
  * Architecture specific weak syscall entries.
diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
index 55e99e6c09a1..9c249722c61b 100644
--- a/mm/restrictedmem.c
+++ b/mm/restrictedmem.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/mempolicy.h>
 #include "linux/sbitmap.h"
 #include <linux/pagemap.h>
 #include <linux/pseudo_fs.h>
@@ -359,3 +360,77 @@ int restrictedmem_get_page(struct file *file, pgoff_t offset,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(restrictedmem_get_page);
+
+static int restrictedmem_set_shared_policy(
+	struct file *file, loff_t start, size_t len, struct mempolicy *mpol)
+{
+	struct restrictedmem *rm;
+	unsigned long end;
+
+	if (!PAGE_ALIGNED(start))
+		return -EINVAL;
+
+	len = PAGE_ALIGN(len);
+	end = start + len;
+
+	if (end < start)
+		return -EINVAL;
+	if (end == start)
+		return 0;
+
+	rm = file->f_mapping->private_data;
+	return __mpol_set_shared_policy(shmem_shared_policy(rm->memfd), mpol,
+					start >> PAGE_SHIFT, len >> PAGE_SHIFT);
+}
+
+static long do_memfd_restricted_bind(
+	int fd, loff_t offset, size_t len,
+	unsigned long mode, const unsigned long __user *nmask,
+	unsigned long maxnode, unsigned int flags)
+{
+	long ret;
+	struct fd f;
+	struct mempolicy *mpol;
+
+	/* None of the flags are supported */
+	if (flags)
+		return -EINVAL;
+
+	f = fdget_raw(fd);
+	if (!f.file)
+		return -EBADF;
+
+	if (!file_is_restrictedmem(f.file))
+		return -EINVAL;
+
+	mpol = mpol_create(mode, nmask, maxnode);
+	if (IS_ERR(mpol)) {
+		ret = PTR_ERR(mpol);
+		goto out;
+	}
+
+	ret = restrictedmem_set_shared_policy(f.file, offset, len, mpol);
+
+	mpol_put(mpol);
+
+out:
+	fdput(f);
+
+	return ret;
+}
+
+SYSCALL_DEFINE6(memfd_restricted_bind, int, fd, struct file_range __user *, range,
+		unsigned long, mode, const unsigned long __user *, nmask,
+		unsigned long, maxnode, unsigned int, flags)
+{
+	loff_t offset;
+	size_t len;
+
+	if (unlikely(get_user(offset, &range->offset)))
+		return -EFAULT;
+	if (unlikely(get_user(len, &range->len)))
+		return -EFAULT;
+
+	return do_memfd_restricted_bind(fd, offset, len, mode, nmask,
+					    maxnode, flags);
+}
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index 3c4d2508226a..e253529cf1ec 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -46,6 +46,7 @@ cat << EOF
 
 #ifndef __ARCH_WANT_MEMFD_RESTRICTED
 #define __IGNORE_memfd_restricted
+#define __IGNORE_memfd_restricted_bind
 #endif
 
 /* Missing flags argument */
-- 
2.40.0.634.g4ca3ef3211-goog

