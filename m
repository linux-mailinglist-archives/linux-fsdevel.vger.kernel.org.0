Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAA62F73A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbhAOHSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 02:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAOHSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:18:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEDBC061575;
        Thu, 14 Jan 2021 23:17:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id my11so5095279pjb.1;
        Thu, 14 Jan 2021 23:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDBgTqph7U6sqOSXdt8AcS70Ilsiw0uIpXx8fn1angs=;
        b=tj4DTccmh3ZQGUeqObnceaG0RemZklXTh5qssoEslhdzP0IvX6IzjS7dNL2lxBOffY
         HkNStF1IOROuK+FkBE1ipDnikzcP3W2yAFJn1ZFOWrkZpgprx5iXGuk1HuIq/QBpXYpX
         ZnbYUnkmOaTFPBZdZGwHrMxyPm1CnRftniktjtISvy/bYUG/pY2e4cC6Z/CcR3H73ucr
         ervLAuU1fFhlXHaeEJEcU8ob7crnGhBqvTu5nFcRFE+cagJQdQIJzcq+VykJi3n9FtKM
         fKwI4DRLGQtgFnLFMTkA8X00tYzFJ9js1tYR/leJe45ACMHo9kMOAdn3gnEYsucDbWLU
         MErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDBgTqph7U6sqOSXdt8AcS70Ilsiw0uIpXx8fn1angs=;
        b=h03YwuVl3JnTRN6ihKinIpkT/xprAfwQamTs8OGWQT/voLFL0vVBuSsanhPC+oVFAT
         XFV7mWh0cE0aV2/T92hyMuh2EhQEs4HVRQM5229RJw61+AckJAvxe4MAXl4l5cH27ycz
         0IrL10worX4SuJljSAa+7LhJJWqvrUlb/FZ6r529YjH4ABqHi+EQc1u1b2UqnEML8BHM
         JR5muiJRtyI0LKlTHnM3Mrqqldx1E3v3h+d7Ww6Fm+hR88IpSURigdyUINmV0s7Dp8zU
         SemdiYZ3LeHoiMkYp0MHvEpodFNdvczpe5dCPUzzkNyyK+4NntIZi7nYT4sf4vQwozdA
         Wpjw==
X-Gm-Message-State: AOAM531xc1kXwuMiiNUzAudjERWRBDhg9RkDbKnmD/NxUHfdGwIsQiSG
        u/1+Ncbj2afrap43ebM3nr8=
X-Google-Smtp-Source: ABdhPJzxCbaWhr5YDOC8CbRfvLQL9StIWqn3Qw30/BIDB8yn3be1W3dAF+FL/5uyfEj6iJOcPD8xNw==
X-Received: by 2002:a17:90b:368f:: with SMTP id mj15mr8883373pjb.201.1610695078447;
        Thu, 14 Jan 2021 23:17:58 -0800 (PST)
Received: from localhost.localdomain (76-242-91-105.lightspeed.sntcca.sbcglobal.net. [76.242.91.105])
        by smtp.gmail.com with ESMTPSA id w1sm7037456pfn.151.2021.01.14.23.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 23:17:57 -0800 (PST)
From:   sonicadvance1@gmail.com
X-Google-Original-From: Sonicadvance1@gmail.com
Cc:     Ryan Houdek <Sonicadvance1@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willem de Bruijn <willemb@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Minchan Kim <minchan@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Rientjes <rientjes@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2] Adds a new ioctl32 syscall for backwards compatibility layers
Date:   Thu, 14 Jan 2021 23:17:14 -0800
Message-Id: <20210115071740.295973-1-Sonicadvance1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210115070326.294332-1-Sonicadvance1@gmail.com>
References: <20210115070326.294332-1-Sonicadvance1@gmail.com>
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

Changes in v2:
- Added the syscall to all architecture tables
- Disabled on 32bit and BE platforms. They can call ioctl directly.
- Disabled on x86-64 as well since you can call this from ia32 or x32
dispatch tables

Signed-off-by: Ryan Houdek <Sonicadvance1@gmail.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           |  2 ++
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 ++
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 fs/ioctl.c                                  | 18 ++++++++++++++++--
 include/linux/syscalls.h                    |  4 ++++
 include/uapi/asm-generic/unistd.h           |  9 ++++++++-
 kernel/sys_ni.c                             |  3 +++
 tools/include/uapi/asm-generic/unistd.h     |  9 ++++++++-
 23 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index a6617067dbe6..81e70fd241d7 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -481,3 +481,4 @@
 549	common	faccessat2			sys_faccessat2
 550	common	process_madvise			sys_process_madvise
 551	common	epoll_pwait2			sys_epoll_pwait2
+552	common	ioctl32			sys_ni_syscall
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 20e1170e2e0a..98fbf1af1169 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -455,3 +455,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	ioctl32			sys_ni_syscall
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
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index bfc00f2bd437..087fc9627357 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -362,3 +362,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	sys_ioctl32			sys_ioctl32
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7fe4e45c864c..502b2f87ab60 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	ioctl32			sys_ni_syscall
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index a522adf194ab..e69be6c836d2 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -447,3 +447,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	ioctl32			sys_ni_syscall
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0f03ad223f33..ba395218446f 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -380,3 +380,4 @@
 439	n32	faccessat2			sys_faccessat2
 440	n32	process_madvise			sys_process_madvise
 441	n32	epoll_pwait2			compat_sys_epoll_pwait2
+442	n32	ioctl32			sys_ni_syscall
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 91649690b52f..f42f939702e2 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -356,3 +356,5 @@
 439	n64	faccessat2			sys_faccessat2
 440	n64	process_madvise			sys_process_madvise
 441	n64	epoll_pwait2			sys_epoll_pwait2
+441	n64	epoll_pwait2			sys_epoll_pwait2
+442	n64	ioctl32			sys_ioctl32
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 4bad0c40aed6..b08ff6066f06 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -429,3 +429,4 @@
 439	o32	faccessat2			sys_faccessat2
 440	o32	process_madvise			sys_process_madvise
 441	o32	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	o32	ioctl32			sys_ni_syscall
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 6bcc31966b44..84d2b88d92fa 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	64	ioctl32			sys_ioctl32
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index f744eb5cba88..9f04d73cf649 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -531,3 +531,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	64	sys_ioctl32				sys_ioctl32
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index d443423495e5..2c90c0ecb5c7 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
 441  common	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	64	sys_ioctl32			sys_ni_syscall
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 9df40ac0ebc0..1e02a13fa049 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	ioctl32			sys_ni_syscall
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 40d8c7cd8298..f7d24678d0b1 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -487,3 +487,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	64	sys_ioctl32			sys_ioctl32
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 874aeacde2dd..b1a3461e1e20 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -446,3 +446,4 @@
 439	i386	faccessat2		sys_faccessat2
 440	i386	process_madvise		sys_process_madvise
 441	i386	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	i386	ioctl32		sys_ni_syscall
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 78672124d28b..0250a04df0df 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -363,6 +363,7 @@
 439	common	faccessat2		sys_faccessat2
 440	common	process_madvise		sys_process_madvise
 441	common	epoll_pwait2		sys_epoll_pwait2
+442	64	ioctl32		sys_ioctl32
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 46116a28eeed..34b653b36b7b 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -412,3 +412,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	ioctl32			sys_ni_syscall
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4e6cc0a7d69c..7b324a21a257 100644
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
@@ -850,4 +850,18 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 
 	return error;
 }
+
+COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
+			compat_ulong_t, arg)
+{
+	return do_ioctl32(fd, cmd, arg);
+}
+
+#if BITS_PER_LONG == 64
+SYSCALL_DEFINE3(ioctl32, unsigned int, fd, unsigned int, cmd,
+			compat_ulong_t, arg)
+{
+	return do_ioctl32(fd, cmd, arg);
+}
+#endif
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f3929aff39cf..fb7bac17167a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -386,6 +386,10 @@ asmlinkage long sys_inotify_rm_watch(int fd, __s32 wd);
 /* fs/ioctl.c */
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd,
 				unsigned long arg);
+#if defined(CONFIG_COMPAT) && BITS_PER_LONG == 64
+asmlinkage long sys_ioctl32(unsigned int fd, unsigned int cmd,
+				compat_ulong_t arg);
+#endif
 
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

