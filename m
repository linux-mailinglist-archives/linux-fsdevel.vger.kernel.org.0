Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6BF2EBA34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 07:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbhAFGtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 01:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbhAFGtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:49:55 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C26C06134C;
        Tue,  5 Jan 2021 22:49:14 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w1so2139693pjc.0;
        Tue, 05 Jan 2021 22:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GYObx0wjjwUWLIy7GEy/eJDGKDZbtuBy10CjqHKFqk=;
        b=m0OYNPVJHfbXRG2jq+shiXmE/rFZ4hEB65jYMOy5Bqwzc6+3vr7XghWS5OPFnl4FPw
         FPh5rgzGF6P+WYE/FmuCVB2qUYRWFMluN/dfVSpFTluZWBO7Bjr1DpIFUObvcJpRGFUy
         s8ThH6j/DdTy7E8LLidflPhkyt3P0zw6CBTj/DKzPXtSwDmSaNFmnLKJJHobQdTRNvV7
         Sm7H8CTHYx8HcR64rpIGFxDHe6O6OrTNXVRIoe7UWWBn1ARBHCRtgY/77X1Tg2wvUxfH
         bcoarExnHFwa2MfztAxfp/bgG819qgC2wBH56RCPaFeeKTubCVy+8IAFBob4lQykMqH4
         h3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GYObx0wjjwUWLIy7GEy/eJDGKDZbtuBy10CjqHKFqk=;
        b=oh76+vHgXauBVVY7/lbtpfmwEOxIueLD9Lvbuuoik+BFn+sYZXi/C69yteTgzCnGDO
         LBBukr1E32eM3hYeBL+NI7xctIHtqGsrI1pnVatKWqVGoSRYHh5qi5uiLNQ41MtXLfzr
         BIN98tmGgdZFUym8hwDuPiPn6VVnsogBIDS2DFBfLQUMnE3M6cb6Lt6KgQlMFh2PVNS/
         bfuNd/bVTEizZOH9DkNvaU+k8fti/WqWkyInETaOtxRmoZzeg801FAVrvlfqGMT3K4em
         eWuoQd/7HD673ouO+vW+UaEZIVBos9XBMY2sXSc8X+Gt7p0fI/stdoH1clWrnAEH1K0Q
         d5TA==
X-Gm-Message-State: AOAM530ZuVtYUZvWZFW5rgpGvPW0cFgbrPKaPcNelsJyo0c+If52B5D5
        76tqUkDe/urV8AXiYtLjC6k=
X-Google-Smtp-Source: ABdhPJxkyS1OX2lmhMZjtgr2Avildbdz6Otn/iKsCcoNd1l34Csm2WPAfgKMbWFz5kBltaU3kllGJQ==
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr2792637pjb.203.1609915754030;
        Tue, 05 Jan 2021 22:49:14 -0800 (PST)
Received: from localhost.localdomain (76-242-91-105.lightspeed.sntcca.sbcglobal.net. [76.242.91.105])
        by smtp.gmail.com with ESMTPSA id u12sm1314451pgi.91.2021.01.05.22.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 22:49:13 -0800 (PST)
From:   sonicadvance1@gmail.com
X-Google-Original-From: Sonicadvance1@gmail.com
Cc:     Sonicadvance1@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Amanieu d'Antras" <amanieu@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>, Jan Kara <jack@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH] Adds a new ioctl32 syscall for backwards compatibility layers
Date:   Tue,  5 Jan 2021 22:48:00 -0800
Message-Id: <20210106064807.253112-1-Sonicadvance1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ryan Houdek <Sonicadvance1@gmail.com>

Problem presented:
A backwards compatibility layer that allows running x86-64 and x86
processes inside of an AArch64 process.
  - CPU is emulated
  - Syscall interface is mostly passthrough
  - Some syscalls require patching or emulation depending on behaviour
  - Not viable from the emulator design to use an AArch32 host process

x86-64 and x86 userspace emulator source:
https://github.com/FEX-Emu/FEX
Usage of ioctl32 is currently in a downstream fork. This will be the
first user of the syscall.

Cross documentation:
https://github.com/FEX-Emu/FEX/wiki/32Bit-x86-Woes#ioctl---54

ioctls are opaque from the emulator perspective and the data wants to be
passed through a syscall as unimpeded as possible.
Sadly due to ioctl struct differences between x86 and x86-64, we need a
syscall that exposes the compatibility ioctl handler to userspace in a
64bit process.

This is necessary behaves of the behaviour differences that occur
between an x86 process doing an ioctl and an x86-64 process doing an
ioctl.

Both of which are captured and passed through the AArch64 ioctl space.
This is implementing a new ioctl32 syscall that allows us to pass 32bit
x86 ioctls through to the kernel with zero or minimal manipulation.

The only supported hosts where we care about this currently is AArch64
and x86-64 (For testing purposes).
PPC64LE, MIPS64LE, and RISC-V64 might be interesting to support in the
future; But I don't have any platforms that get anywhere near Cortex-A77
performance in those architectures. Nor do I have the time to bring up
the emulator on them.
x86-64 can get to the compatibility ioctl through the int $0x80 handler.

This does not solve the following problems:
1) compat_alloc_user_space inside ioctl
2) ioctls that check task mode instead of entry point for behaviour
3) ioctls allocating memory
4) struct packing problems between architectures

Workarounds for the problems presented:
1a) Do a stack pivot to the lower 32bits from userspace
  - Forces host 64bit process to have its thread stacks to live in 32bit
  space. Not ideal.
  - Only do a stack pivot on ioctl to save previous 32bit VA space
1b) Teach kernel that compat_alloc_userspace can return a 64bit pointer
  - x86-64 truncates stack from this function
  - AArch64 returns the full stack pointer
  - Only ~29 users. Validating all of them support a 64bit stack is
  trivial?

2a) Any application using these can be checked for compatibility in
userspace and put on a block list.
2b) Fix any ioctls doing broken behaviour based on task mode rather than
ioctl entry point

3a) Userspace consumes all VA space above 32bit. Forcing allocations to
occur in lower 32bits
  - This is the current implementation
3b) Ensure any allocation in the ioctl handles ioctl entrypoint rather
than just allow generic memory allocations in full VA space
  - This is hard to guarantee

4a) Blocklist any application using ioctls that have different struct
packing across the boundary
  - Can happen when struct packing of 32bit x86 application goes down
  the aarch64 compat_ioctl path
  - Userspace is a AArch64 process passing 32bit x86 ioctl structures
  through the compat_ioctl path which is typically for AArch32 processes
  - None currently identified
4b) Work with upstream kernel and userspace projects to evaluate and fix
  - Identify the problem ioctls
  - Implement a new ioctl with more sane struct packing that matches
  cross-arch
  - Implement new ioctl while maintaining backwards compatibility with
  previous ioctl handler
  - Change upstream project to use the new compatibility ioctl
  - ioctl deprecation will be case by case per device and project
4b) Userspace implements a full ioctl emulation layer
  - Parses the full ioctl tree
  - Either passes through ioctls that it doesn't understand or
  transforms ioctls that it knows are trouble
  - Has the downside that it can still run in to edge cases that will
  fail
  - Performance of additional tracking is a concern
  - Prone to failure keeping the kernel ioctl and userspace ioctl
  handling in sync
  - Really want to have it in the kernel space as much as possible

Signed-off-by: Ryan Houdek <Sonicadvance1@gmail.com>
---
 arch/arm64/include/asm/unistd.h         |  2 +-
 arch/arm64/include/asm/unistd32.h       |  2 ++
 fs/ioctl.c                              | 16 ++++++++++++++--
 include/linux/syscalls.h                |  2 ++
 include/uapi/asm-generic/unistd.h       |  9 ++++++++-
 kernel/sys_ni.c                         |  3 +++
 tools/include/uapi/asm-generic/unistd.h |  9 ++++++++-
 7 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 86a9d7b3eabe..949788f5ba40 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		442
+#define __NR_compat_syscalls		443
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index cccfbbefbf95..35e3bc83dbdc 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
 #define __NR_epoll_pwait2 441
 __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
+#define __NR_ioctl32 442
+__SYSCALL(__NR_ioctl32, compat_sys_ioctl)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4e6cc0a7d69c..116b9bca8c07 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -790,8 +790,8 @@ long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 EXPORT_SYMBOL(compat_ptr_ioctl);
 
-COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
-		       compat_ulong_t, arg)
+long do_ioctl32(unsigned int fd, unsigned int cmd,
+			compat_ulong_t arg)
 {
 	struct fd f = fdget(fd);
 	int error;
@@ -850,4 +850,16 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 
 	return error;
 }
+
+COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
+			compat_ulong_t, arg)
+{
+	return do_ioctl32(fd, cmd, arg);
+}
+
+SYSCALL_DEFINE3(ioctl32, unsigned int, fd, unsigned int, cmd,
+			compat_ulong_t, arg)
+{
+	return do_ioctl32(fd, cmd, arg);
+}
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f3929aff39cf..470f928831eb 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -386,6 +386,8 @@ asmlinkage long sys_inotify_rm_watch(int fd, __s32 wd);
 /* fs/ioctl.c */
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd,
 				unsigned long arg);
+asmlinkage long sys_ioctl32(unsigned int fd, unsigned int cmd,
+				compat_ulong_t arg);
 
 /* fs/ioprio.c */
 asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 728752917785..18279e5b7b4f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -862,8 +862,15 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 #define __NR_epoll_pwait2 441
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
 
+#define __NR_ioctl32 442
+#ifdef CONFIG_COMPAT
+__SC_COMP(__NR_ioctl32, sys_ioctl32, compat_sys_ioctl)
+#else
+__SC_COMP(__NR_ioctl32, sys_ni_syscall, sys_ni_syscall)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 442
+#define __NR_syscalls 443
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 19aa806890d5..5a2f25eb341c 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -302,6 +302,9 @@ COND_SYSCALL(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time64);
 
+COND_SYSCALL(ioctl32);
+COND_SYSCALL_COMPAT(ioctl32);
+
 /*
  * Architecture specific syscalls: see further below
  */
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 728752917785..18279e5b7b4f 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -862,8 +862,15 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 #define __NR_epoll_pwait2 441
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
 
+#define __NR_ioctl32 442
+#ifdef CONFIG_COMPAT
+__SC_COMP(__NR_ioctl32, sys_ioctl32, compat_sys_ioctl)
+#else
+__SC_COMP(__NR_ioctl32, sys_ni_syscall, sys_ni_syscall)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 442
+#define __NR_syscalls 443
 
 /*
  * 32 bit systems traditionally used different
-- 
2.27.0

