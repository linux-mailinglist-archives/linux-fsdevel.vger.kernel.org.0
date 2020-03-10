Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6FE17F3BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 10:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCJJdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 05:33:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58187 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgCJJdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:33:11 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jBbG5-0006dc-62; Tue, 10 Mar 2020 09:33:05 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     christian.brauner@ubuntu.com
Cc:     christian@brauner.io, darrick.wong@oracle.com, dhowells@redhat.com,
        jannh@google.com, jlayton@redhat.com, kzak@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mszeredi@redhat.com,
        raven@themaw.net, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v19 14/14] arch: wire up fsinfo syscall
Date:   Tue, 10 Mar 2020 10:32:41 +0100
Message-Id: <20200310093241.1143777-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310093241.1143777-1-christian.brauner@ubuntu.com>
References: <20200310093116.ylq6vaunr6js4eyy@wittgenstein>
 <20200310093241.1143777-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This wires up the fsinfo() syscall for all architectures.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 2 ++
 arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 include/linux/syscalls.h                    | 4 ++++
 include/uapi/asm-generic/unistd.h           | 4 +++-
 20 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 7c0115af9010..4d0b07dde12d 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -479,3 +479,4 @@
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	watch_mount			sys_watch_mount
 550	common	watch_sb			sys_watch_sb
+551	common	fsinfo				sys_fsinfo
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index f256f009a89f..fdda8382b420 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -453,3 +453,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
 440	common	watch_sb			sys_watch_sb
+441	common	fsinfo				sys_fsinfo
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index bc0f923e0e04..388eeb71cff0 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		441
+#define __NR_compat_syscalls		442
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index c1c61635f89c..1f7d2c8d481a 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -883,6 +883,8 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_fsinfo 441
+__SYSCALL(__NR_fsinfo, sys_fsinfo)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index a4dafc659647..2316e60e031a 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -360,3 +360,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
 440	common	watch_sb			sys_watch_sb
+441	common	fsinfo				sys_fsinfo
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 893fb4151547..efc2723ca91f 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
 440	common	watch_sb			sys_watch_sb
+441	common	fsinfo				sys_fsinfo
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 54aaf0d40c64..745c0f462fce 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -445,3 +445,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
 440	common	watch_sb			sys_watch_sb
+441	common	fsinfo				sys_fsinfo
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index fd34dd0efed0..499f83562a8c 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -378,3 +378,4 @@
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	watch_mount			sys_watch_mount
 440	n32	watch_sb			sys_watch_sb
+441	n32	fsinfo				sys_fsinfo
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index db0f4c0a0a0b..b3188bc3ab3c 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -354,3 +354,4 @@
 438	n64	pidfd_getfd			sys_pidfd_getfd
 439	n64	watch_mount			sys_watch_mount
 440	n64	watch_sb			sys_watch_sb
+441	n64	fsinfo				sys_fsinfo
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index ce2e1326de8f..1a3e8ed5e538 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -427,3 +427,4 @@
 438	o32	pidfd_getfd			sys_pidfd_getfd
 439	o32	watch_mount			sys_watch_mount
 440	o32	watch_sb			sys_watch_sb
+441	o32	fsinfo				sys_fsinfo
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 6e4a7c08b64b..2572c215d861 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -437,3 +437,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
 440	common	watch_sb			sys_watch_sb
+441	common	fsinfo				sys_fsinfo
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 08943f3b8206..39d7ac7e918c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -521,3 +521,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
 440	common	watch_sb			sys_watch_sb
+441	common	fsinfo				sys_fsinfo
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index b3b8529d2b74..ae4cefd3dd1b 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -442,3 +442,4 @@
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount		sys_watch_mount			sys_watch_mount
 440	common	watch_sb		sys_watch_sb			sys_watch_sb
+441  common	fsinfo			sys_fsinfo			sys_fsinfo
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 89307a20657c..05945b9aee4b 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -442,3 +442,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
 440	common	watch_sb			sys_watch_sb
+441	common	fsinfo				sys_fsinfo
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4ff841a00450..b71b34d4b45c 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -485,3 +485,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
 440	common	watch_sb			sys_watch_sb
+441	common	fsinfo				sys_fsinfo
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index e2731d295f88..e118ba9aca4c 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -444,3 +444,4 @@
 438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
 439	i386	watch_mount		sys_watch_mount			__ia32_sys_watch_mount
 440	i386	watch_sb		sys_watch_sb			__ia32_sys_watch_sb
+441	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f4391176102c..067f247471d0 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -361,6 +361,7 @@
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 439	common	watch_mount		__x64_sys_watch_mount
 440	common	watch_sb		__x64_sys_watch_sb
+441	common	fsinfo			__x64_sys_fsinfo
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 8e7d731ed6cf..e1ec25099d10 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -410,3 +410,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
 440	common	watch_sb			sys_watch_sb
+441	common	fsinfo				sys_fsinfo
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c84440d57f52..76064c0807e5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -47,6 +47,7 @@ struct stat64;
 struct statfs;
 struct statfs64;
 struct statx;
+struct fsinfo_params;
 struct __sysctl_args;
 struct sysinfo;
 struct timespec;
@@ -1007,6 +1008,9 @@ asmlinkage long sys_watch_mount(int dfd, const char __user *path,
 				unsigned int at_flags, int watch_fd, int watch_id);
 asmlinkage long sys_watch_sb(int dfd, const char __user *path,
 			     unsigned int at_flags, int watch_fd, int watch_id);
+asmlinkage long sys_fsinfo(int dfd, const char __user *pathname,
+			   struct fsinfo_params __user *params, size_t params_size,
+			   void __user *result_buffer, size_t result_buf_size);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 5bff318b7ffa..7d764f86d3f5 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -859,9 +859,11 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
 #define __NR_watch_sb 440
 __SYSCALL(__NR_watch_sb, sys_watch_sb)
+#define __NR_fsinfo 441
+__SYSCALL(__NR_fsinfo, sys_fsinfo)
 
 #undef __NR_syscalls
-#define __NR_syscalls 441
+#define __NR_syscalls 442
 
 /*
  * 32 bit systems traditionally used different
-- 
2.25.1

