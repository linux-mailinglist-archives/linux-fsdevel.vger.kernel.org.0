Return-Path: <linux-fsdevel+bounces-6850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5FE81D5AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 19:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A1F2831B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 18:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73788224F5;
	Sat, 23 Dec 2023 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCETgdSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCE22EE9;
	Sat, 23 Dec 2023 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1d2e6e14865so17395805ad.0;
        Sat, 23 Dec 2023 10:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703355110; x=1703959910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+vmIcmRf6Ee/4rLLXFmmzQaLaa/fXF/nVhNbjE4zU8=;
        b=XCETgdSbdZZSp/Vb7PRPYiRN2wM7HH6EAIPP/DBORxjtrfuXhdZCZ1OPWztCReE/yA
         DiNMC3jITjRrWVOBqa3iKhxhoNOAhfifliqpy7IHVjcI4CtK6HGN5MTGBCq9C82Eosdj
         BjiANu9klLTjgKnHuA1i+i841a0rKFq53ssRmrHWSiO/Gy9tCYkk+ALjtEPsksliekBA
         o8g/7W8O5AIKOklA5GkfNegf9yub6Dkzf++BECZEU02T+USSt5BFL8uL+lLr4yAKEN2B
         2kwlXMptfLoVzZFfistHoh/nZMir2jB+hCJjz7E+0BuUYKlIQh4o/bK5PqBEvHfMqGkW
         Bj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703355110; x=1703959910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+vmIcmRf6Ee/4rLLXFmmzQaLaa/fXF/nVhNbjE4zU8=;
        b=lD0RYWMdM8XGNVZHe3dFfc6KpcCqxUxYxrJxztX+4gYBhlYWWmkyvJ2c25lioQANuQ
         mgYkZQUqeLpK8ePG+xIcdR4xefPKRhx3iPg+LLqLjZRdfhu5eM5SX+Zl6xpZo/v7Dce2
         4XuaS5yGCIMQOfkRG5AZ7Ard/5WKhQY7ptY5JqXDDSJK0kjhl48Dz/lfbgMwpF7xZXj4
         odlpHHJ0+KUd7g61NQD9KdShEfdZivanQT9Z9yBwsx8eQlBdWOWTEmLHgdaMe/4OEvHn
         ZW6yBhIUnLrGTwKR21jNCCDpoxNzBBl8t1ZW7ehJf1CN/3lymbuS7KLRm/nGngsVURrv
         wjLw==
X-Gm-Message-State: AOJu0YxD0qTbLhYZ0BVMCR20rySuEfyREjIhejzGKsqsCnvmaufHzi0z
	I1CR1SHNJeQYofJcqp+rAA==
X-Google-Smtp-Source: AGHT+IGWptmXkqXEtOGXPdrKMGn5ZSg8CddLj5kV13HyEI0Ero2ed1rwUgY93kSXhGNv8kqOfHObaQ==
X-Received: by 2002:a17:902:7848:b0:1d4:36ae:ff7e with SMTP id e8-20020a170902784800b001d436aeff7emr430287pln.60.1703355110432;
        Sat, 23 Dec 2023 10:11:50 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902a5c600b001d3bfd30886sm4316396plq.37.2023.12.23.10.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 10:11:50 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v5 08/11] mm/mempolicy: add set_mempolicy2 syscall
Date: Sat, 23 Dec 2023 13:10:58 -0500
Message-Id: <20231223181101.1954-9-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231223181101.1954-1-gregory.price@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_mempolicy2 is an extensible set_mempolicy interface which allows
a user to set the per-task memory policy.

Defined as:

set_mempolicy2(struct mpol_args *args, size_t size, unsigned long flags);

relevant mpol_args fields include the following:

mode:         The MPOL_* policy (DEFAULT, INTERLEAVE, etc.)
mode_flags:   The MPOL_F_* flags that were previously passed in or'd
              into the mode.  This was split to hopefully allow future
              extensions additional mode/flag space.
home_node:    ignored (see note below)
pol_nodes:    the nodemask to apply for the memory policy
pol_maxnodes: The max number of nodes described by pol_nodes

The usize arg is intended for the user to pass in sizeof(mpol_args)
to allow forward/backward compatibility whenever possible.

The flags argument is intended to future proof the syscall against
future extensions which may require interpreting the arguments in
the structure differently.

Semantics of `set_mempolicy` are otherwise the same as `set_mempolicy`
as of this patch.

As of this patch, setting the home node of a task-policy is not
supported, as this functionality was not supported by set_mempolicy.
Additional research should be done to determine whether adding this
functionality is safe, but doing so would only require setting
MPOL_MF_HOME_NODE and providing a valid home node value.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 10 ++++++
 arch/alpha/kernel/syscalls/syscall.tbl        |  1 +
 arch/arm/tools/syscall.tbl                    |  1 +
 arch/arm64/include/asm/unistd.h               |  2 +-
 arch/arm64/include/asm/unistd32.h             |  2 ++
 arch/m68k/kernel/syscalls/syscall.tbl         |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |  1 +
 arch/s390/kernel/syscalls/syscall.tbl         |  1 +
 arch/sh/kernel/syscalls/syscall.tbl           |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |  1 +
 include/linux/syscalls.h                      |  2 ++
 include/uapi/asm-generic/unistd.h             |  4 ++-
 kernel/sys_ni.c                               |  1 +
 mm/mempolicy.c                                | 36 +++++++++++++++++++
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |  1 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  1 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  1 +
 25 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 5ee047b0d981..4720978ab1c2 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -432,6 +432,8 @@ Set [Task] Memory Policy::
 
 	long set_mempolicy(int mode, const unsigned long *nmask,
 					unsigned long maxnode);
+	long set_mempolicy2(struct mpol_args args, size_t size,
+			    unsigned long flags);
 
 Set's the calling task's "task/process memory policy" to mode
 specified by the 'mode' argument and the set of nodes defined by
@@ -440,6 +442,12 @@ specified by the 'mode' argument and the set of nodes defined by
 'mode' argument with the flag (for example: MPOL_INTERLEAVE |
 MPOL_F_STATIC_NODES).
 
+set_mempolicy2() is an extended version of set_mempolicy() capable
+of setting a mempolicy which requires more information than can be
+passed via get_mempolicy().  For example, weighted interleave with
+task-local weights requires a weight array to be passed via the
+'mpol_args->il_weights' argument in the 'struct mpol_args' arg.
+
 See the set_mempolicy(2) man page for more details
 
 
@@ -495,6 +503,8 @@ Extended Mempolicy Arguments::
 The extended mempolicy argument structure is defined to allow the mempolicy
 interfaces future extensibility without the need for additional system calls.
 
+Extended interfaces (set_mempolicy2) use this argument structure.
+
 The core arguments (mode, mode_flags, pol_nodes, and pol_maxnodes) apply to
 all interfaces relative to their non-extended counterparts. Each additional
 field may only apply to specific extended interfaces.  See the respective
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 18c842ca6c32..0dc288a1118a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -496,3 +496,4 @@
 564	common	futex_wake			sys_futex_wake
 565	common	futex_wait			sys_futex_wait
 566	common	futex_requeue			sys_futex_requeue
+567	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 584f9528c996..50172ec0e1f5 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -470,3 +470,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 531effca5f1f..298313d2e0af 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		457
+#define __NR_compat_syscalls		458
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 9f7c1bf99526..cee8d669c342 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -919,6 +919,8 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
+#define __NR_set_mempolicy2 457
+__SYSCALL(__NR_set_mempolicy2, sys_set_mempolicy2)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7a4b780e82cb..839d90c535f2 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 5b6a0b02b7de..567c8b883735 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -462,3 +462,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index a842b41c8e06..cc0640e16f2f 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -395,3 +395,4 @@
 454	n32	futex_wake			sys_futex_wake
 455	n32	futex_wait			sys_futex_wait
 456	n32	futex_requeue			sys_futex_requeue
+457	n32	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 525cc54bc63b..f7262fde98d9 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -444,3 +444,4 @@
 454	o32	futex_wake			sys_futex_wake
 455	o32	futex_wait			sys_futex_wait
 456	o32	futex_requeue			sys_futex_requeue
+457	o32	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index a47798fed54e..e10f0e8bd064 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 7fab411378f2..4f03f5f42b78 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -543,3 +543,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 86fec9b080f6..f98dadc2e9df 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -459,3 +459,4 @@
 454  common	futex_wake		sys_futex_wake			sys_futex_wake
 455  common	futex_wait		sys_futex_wait			sys_futex_wait
 456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
+457  common	set_mempolicy2		sys_set_mempolicy2		sys_set_mempolicy2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 363fae0fe9bf..f47ba9f2d05d 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -459,3 +459,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 7bcaa3d5ea44..53fb16616728 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -502,3 +502,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c8fac5205803..4b4dc41b24ee 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -461,3 +461,4 @@
 454	i386	futex_wake		sys_futex_wake
 455	i386	futex_wait		sys_futex_wait
 456	i386	futex_requeue		sys_futex_requeue
+457	i386	set_mempolicy2		sys_set_mempolicy2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 8cb8bf68721c..1bc2190bec27 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -378,6 +378,7 @@
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
+457	common	set_mempolicy2		sys_set_mempolicy2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 06eefa9c1458..e26dc89399eb 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -427,3 +427,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a52395ca3f00..451f0089601f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -823,6 +823,8 @@ asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long addr, unsigned long flags);
 asmlinkage long sys_set_mempolicy(int mode, const unsigned long __user *nmask,
 				unsigned long maxnode);
+asmlinkage long sys_set_mempolicy2(struct mpol_args __user *args, size_t size,
+				   unsigned long flags);
 asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
 				const unsigned long __user *from,
 				const unsigned long __user *to);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 756b013fb832..55486aba099f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -828,9 +828,11 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
+#define __NR_set_mempolicy2 457
+__SYSCALL(__NR_set_mempolicy2, sys_set_mempolicy2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 457
+#define __NR_syscalls 458
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 9a846439b36a..fa1373c8bff8 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -189,6 +189,7 @@ COND_SYSCALL(remap_file_pages);
 COND_SYSCALL(mbind);
 COND_SYSCALL(get_mempolicy);
 COND_SYSCALL(set_mempolicy);
+COND_SYSCALL(set_mempolicy2);
 COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 35a0f8630ead..d1abb1fc5a53 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1634,6 +1634,42 @@ SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
 	return kernel_set_mempolicy(mode, nmask, maxnode);
 }
 
+SYSCALL_DEFINE3(set_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
+		unsigned long, flags)
+{
+	struct mpol_args kargs;
+	struct mempolicy_args margs;
+	int err;
+	nodemask_t policy_nodemask;
+	unsigned long __user *nodes_ptr;
+
+	if (flags)
+		return -EINVAL;
+
+	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
+	if (err)
+		return err;
+
+	err = validate_mpol_flags(kargs.mode, &kargs.mode_flags);
+	if (err)
+		return err;
+
+	memset(&margs, 0, sizeof(margs));
+	margs.mode = kargs.mode;
+	margs.mode_flags = kargs.mode_flags;
+	if (kargs.pol_nodes) {
+		nodes_ptr = u64_to_user_ptr(kargs.pol_nodes);
+		err = get_nodes(&policy_nodemask, nodes_ptr,
+				kargs.pol_maxnodes);
+		if (err)
+			return err;
+		margs.policy_nodes = &policy_nodemask;
+	} else
+		margs.policy_nodes = NULL;
+
+	return do_set_mempolicy(&margs);
+}
+
 static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 				const unsigned long __user *old_nodes,
 				const unsigned long __user *new_nodes)
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 116ff501bf92..bb1351df51d9 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -371,3 +371,4 @@
 454	n64	futex_wake			sys_futex_wake
 455	n64	futex_wait			sys_futex_wait
 456	n64	futex_requeue			sys_futex_requeue
+457	n64	set_mempolicy2			sys_set_mempolicy2
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 7fab411378f2..4f03f5f42b78 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -543,3 +543,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 86fec9b080f6..f98dadc2e9df 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -459,3 +459,4 @@
 454  common	futex_wake		sys_futex_wake			sys_futex_wake
 455  common	futex_wait		sys_futex_wait			sys_futex_wait
 456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
+457  common	set_mempolicy2		sys_set_mempolicy2		sys_set_mempolicy2
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 8cb8bf68721c..21f2579679d4 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -378,6 +378,7 @@
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
+457	common 	set_mempolicy2		sys_set_mempolicy2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.39.1


