Return-Path: <linux-fsdevel+bounces-6424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC311817B52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 20:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34411C21E69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5B7348D;
	Mon, 18 Dec 2023 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEW5Tk4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4779953;
	Mon, 18 Dec 2023 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1d3ac87553bso7530865ad.3;
        Mon, 18 Dec 2023 11:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702928847; x=1703533647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CT+UJzpSfF/DLW7d290OitDA+EDNziSk6P3gUcA0R6E=;
        b=WEW5Tk4/KOaQCX5tbJ5VNj/dvOVNEQCfF6oZHQwf0awkThNj9D/sQixvLjGYBM2nfz
         lpz1zB1uhraUfUCT4Q6NeJlW6f7tNMkY7Rsbsvq4Mz2A6iQ/kal/Sl/LR/fOfVRwMJcj
         cknWPxoqeC5dhfRtf3BCVZWPE1sS9QFnX2IcAZP6nOKs4wu62p9p4tfo/gASpl9LhY1J
         CSq4G8UILGB9peXiG1rSZk0gDn2+Ff1BEQZvf1uLVm595Ndt4GahjDIsue073j8TsjSg
         GxrOxHShmexrVVGmJawPGv1idZKMxQyHLmUHzJOZXKskTHH+7VY80QhytbbDrjaMTdBj
         4Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702928847; x=1703533647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CT+UJzpSfF/DLW7d290OitDA+EDNziSk6P3gUcA0R6E=;
        b=fddmuDFTpsunq9dlXtsm/LYpv8Me78/Q8DoE8FoVZ0AUVMftso8FWahZFvcr4EGy8c
         CoLqSQcvoScqa6eONDwebEx9byanSjDD0ay8uMsIE/WDzpEky+5VH9/+M04OAKj8oUSC
         gYJKi3E86AMZTxpqJYFZhULGFDePwWdRWReT0QdpiXpghAbIHCSzp3sjORS22qNRiomv
         hJAADiIyvEGObHCGd1I4KfYtfBMbqEjNNssRLrKEZamHFj44zNoAkyMFu71x8pYg/ZfL
         SSEN/mwUsWxiOiiPjhf8zP6sRAFNVyxYJOoaMwrFpZ6RBANHNKQMMIR+VUHjxBlu94rX
         OwQw==
X-Gm-Message-State: AOJu0YzRMWQH5RkQO5ayb/2NjKNCZJmhfhUiAAJF9NDY1Pw7Qg4/BizD
	l/DnOsk7Qx6PknHpibMHcKoOzDM/ZsUVnOI=
X-Google-Smtp-Source: AGHT+IG1jFK6szw44cHtH0JsuDhilm+mnnnWqPpT7uYcL3kOLLEF0pyjX+7virr8U1nflf+Kb5x+uA==
X-Received: by 2002:a17:903:1107:b0:1d3:1be6:78dc with SMTP id n7-20020a170903110700b001d31be678dcmr7934245plh.26.1702928846801;
        Mon, 18 Dec 2023 11:47:26 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001ce664c05b0sm19456335pll.33.2023.12.18.11.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:47:26 -0800 (PST)
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
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>
Subject: [PATCH v4 10/11] mm/mempolicy: add the mbind2 syscall
Date: Mon, 18 Dec 2023 14:46:30 -0500
Message-Id: <20231218194631.21667-11-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231218194631.21667-1-gregory.price@memverge.com>
References: <20231218194631.21667-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mbind2 is an extensible mbind interface which allows a user to
set the mempolicy for one or more address ranges.

Defined as:

mbind2(unsigned long addr, unsigned long len, struct mpol_args *args,
       size_t size, unsigned long flags)

addr:         address of the memory range to operate on
len:          length of the memory range
flags:        MPOL_MF_HOME_NODE + original mbind() flags

Input values include the following fields of mpol_args:

mode:         The MPOL_* policy (DEFAULT, INTERLEAVE, etc.)
mode_flags:   The MPOL_F_* flags that were previously passed in or'd
	      into the mode.  This was split to hopefully allow future
	      extensions additional mode/flag space.
pol_nodes:    the nodemask to apply for the memory policy
pol_maxnodes: The max number of nodes described by pol_nodes
home_node:    if MPOL_MF_HOME_NODE, set home node of policy to this
              otherwise it is ignored.

The semantics are otherwise the same as mbind(), except that
the home_node can be set.

Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Rakie Kim <rakie.kim@sk.com>
Suggested-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 12 +++++-
 arch/alpha/kernel/syscalls/syscall.tbl        |  1 +
 arch/arm/tools/syscall.tbl                    |  1 +
 arch/arm64/include/asm/unistd.h               |  2 +-
 arch/arm64/include/asm/unistd32.h             |  2 +
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
 include/linux/syscalls.h                      |  3 ++
 include/uapi/asm-generic/unistd.h             |  4 +-
 include/uapi/linux/mempolicy.h                |  5 ++-
 kernel/sys_ni.c                               |  1 +
 mm/mempolicy.c                                | 43 +++++++++++++++++++
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |  1 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  1 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  1 +
 26 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 8c1fcdb30602..99e1f732cade 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -477,12 +477,18 @@ Install VMA/Shared Policy for a Range of Task's Address Space::
 	long mbind(void *start, unsigned long len, int mode,
 		   const unsigned long *nmask, unsigned long maxnode,
 		   unsigned flags);
+	long mbind2(void* start, unsigned long len, struct mpol_args args,
+		    size_t size, unsigned long flags);
 
 mbind() installs the policy specified by (mode, nmask, maxnodes) as a
 VMA policy for the range of the calling task's address space specified
 by the 'start' and 'len' arguments.  Additional actions may be
 requested via the 'flags' argument.
 
+mbind2() is an extended version of mbind() capable of setting extended
+mempolicy features. For example, one can set the home node for the memory
+policy without an additional call to set_mempolicy_home_node().
+
 See the mbind(2) man page for more details.
 
 Set home node for a Range of Task's Address Spacec::
@@ -498,6 +504,9 @@ closest to which page allocation will come from. Specifying the home node overri
 the default allocation policy to allocate memory close to the local node for an
 executing CPU.
 
+mbind2() also provides a way for the home node to be set at the time the
+mempolicy is set. See the mbind(2) man page for more details.
+
 Extended Mempolicy Arguments::
 
 	struct mpol_args {
@@ -512,7 +521,8 @@ Extended Mempolicy Arguments::
 The extended mempolicy argument structure is defined to allow the mempolicy
 interfaces future extensibility without the need for additional system calls.
 
-Extended interfaces (set_mempolicy2 and get_mempolicy2) use this structure.
+Extended interfaces (set_mempolicy2, get_mempolicy2, and mbind2) use this
+this argument structure.
 
 The core arguments (mode, mode_flags, pol_nodes, and pol_maxnodes) apply to
 all interfaces relative to their non-extended counterparts. Each additional
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 0301a8b0a262..e8239293c35a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -498,3 +498,4 @@
 566	common	futex_requeue			sys_futex_requeue
 567	common	set_mempolicy2			sys_set_mempolicy2
 568	common	get_mempolicy2			sys_get_mempolicy2
+569	common	mbind2				sys_mbind2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 771a33446e8e..a3f39750257a 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -472,3 +472,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index b63f870debaf..abe10a833fcd 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		459
+#define __NR_compat_syscalls		460
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index f8d01007aee0..89aaae33b81f 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -923,6 +923,8 @@ __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 __SYSCALL(__NR_set_mempolicy2, sys_set_mempolicy2)
 #define __NR_get_mempolicy2 458
 __SYSCALL(__NR_get_mempolicy2, sys_get_mempolicy2)
+#define __NR_get_mbind2 459
+__SYSCALL(__NR_get_mbind2, sys_get_mbind2)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 048a409e684c..9a12dface18e 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -458,3 +458,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 327b01bd6793..6cb740123137 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -464,3 +464,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 921d58e1da23..52cf720f8ae2 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -397,3 +397,4 @@
 456	n32	futex_requeue			sys_futex_requeue
 457	n32	set_mempolicy2			sys_set_mempolicy2
 458	n32	get_mempolicy2			sys_get_mempolicy2
+459	n32	mbind2				sys_mbind2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 9271c83c9993..fd37c5301a48 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -446,3 +446,4 @@
 456	o32	futex_requeue			sys_futex_requeue
 457	o32	set_mempolicy2			sys_set_mempolicy2
 458	o32	get_mempolicy2			sys_get_mempolicy2
+459	o32	mbind2				sys_mbind2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 0654f3f89fc7..fcd67bc405b1 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -457,3 +457,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index ac11d2064e7a..89715417014c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -545,3 +545,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 1cdcafe1ccca..c8304e0d0aa7 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -461,3 +461,4 @@
 456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
 457  common	set_mempolicy2		sys_set_mempolicy2		sys_set_mempolicy2
 458  common	get_mempolicy2		sys_get_mempolicy2		sys_get_mempolicy2
+459  common	mbind2			sys_mbind2			sys_mbind2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index f71742024c29..e5c51b6c367f 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -461,3 +461,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 2fbf5dbe0620..74527f585500 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -504,3 +504,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0af813b9a118..be2e2aa17dd8 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -463,3 +463,4 @@
 456	i386	futex_requeue		sys_futex_requeue
 457	i386	set_mempolicy2		sys_set_mempolicy2
 458	i386	get_mempolicy2		sys_get_mempolicy2
+459	i386	mbind2			sys_mbind2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 0b777876fc15..6e2347eb8773 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -380,6 +380,7 @@
 456	common	futex_requeue		sys_futex_requeue
 457	common	set_mempolicy2		sys_set_mempolicy2
 458	common	get_mempolicy2		sys_get_mempolicy2
+459	common	mbind2			sys_mbind2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 4536c9a4227d..f00a21317dc0 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -429,3 +429,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f696855cbe8c..b42622ea9ed9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -817,6 +817,9 @@ asmlinkage long sys_mbind(unsigned long start, unsigned long len,
 				const unsigned long __user *nmask,
 				unsigned long maxnode,
 				unsigned flags);
+asmlinkage long sys_mbind2(unsigned long start, unsigned long len,
+			   const struct mpol_args __user *uargs, size_t usize,
+			   unsigned long flags);
 asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long __user *nmask,
 				unsigned long maxnode,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 719accc731db..cd31599bb9cc 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -832,9 +832,11 @@ __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 __SYSCALL(__NR_set_mempolicy2, sys_set_mempolicy2)
 #define __NR_get_mempolicy2 458
 __SYSCALL(__NR_get_mempolicy2, sys_get_mempolicy2)
+#define __NR_mbind2 459
+__SYSCALL(__NR_mbind2, sys_mbind2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 459
+#define __NR_syscalls 460
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index c06f2afa7fe3..ec1402dae35b 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -54,13 +54,14 @@ struct mpol_args {
 #define MPOL_F_ADDR	(1<<1)	/* look up vma using address */
 #define MPOL_F_MEMS_ALLOWED (1<<2) /* return allowed memories */
 
-/* Flags for mbind */
+/* Flags for mbind/mbind2 */
 #define MPOL_MF_STRICT	(1<<0)	/* Verify existing pages in the mapping */
 #define MPOL_MF_MOVE	 (1<<1)	/* Move pages owned by this process to conform
 				   to policy */
 #define MPOL_MF_MOVE_ALL (1<<2)	/* Move every page to conform to policy */
 #define MPOL_MF_LAZY	 (1<<3)	/* UNSUPPORTED FLAG: Lazy migrate on fault */
-#define MPOL_MF_INTERNAL (1<<4)	/* Internal flags start here */
+#define MPOL_MF_HOME_NODE (1<<4)	/* mbind2: set home node */
+#define MPOL_MF_INTERNAL (1<<5)	/* Internal flags start here */
 
 #define MPOL_MF_VALID	(MPOL_MF_STRICT   | 	\
 			 MPOL_MF_MOVE     | 	\
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index e4883eaa4e61..5239c2e94e37 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -187,6 +187,7 @@ COND_SYSCALL(process_madvise);
 COND_SYSCALL(process_mrelease);
 COND_SYSCALL(remap_file_pages);
 COND_SYSCALL(mbind);
+COND_SYSCALL(mbind2);
 COND_SYSCALL(get_mempolicy);
 COND_SYSCALL(get_mempolicy2);
 COND_SYSCALL(set_mempolicy);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ebb08261d7cb..0882fa4aa516 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1603,6 +1603,49 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 	return kernel_mbind(start, len, mode, nmask, maxnode, flags);
 }
 
+SYSCALL_DEFINE5(mbind2, unsigned long, start, unsigned long, len,
+		const struct mpol_args __user *, uargs, size_t, usize,
+		unsigned long, flags)
+{
+	struct mpol_args kargs;
+	struct mempolicy_args margs;
+	nodemask_t policy_nodes;
+	unsigned long __user *nodes_ptr;
+	int err;
+
+	if (!start || !len)
+		return -EINVAL;
+
+	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
+	if (err)
+		return -EINVAL;
+
+	err = validate_mpol_flags(kargs.mode, &kargs.mode_flags);
+	if (err)
+		return err;
+
+	margs.mode = kargs.mode;
+	margs.mode_flags = kargs.mode_flags;
+
+	/* if home node given, validate it is online */
+	if (flags & MPOL_MF_HOME_NODE) {
+		if ((kargs.home_node >= MAX_NUMNODES) ||
+			!node_online(kargs.home_node))
+			return -EINVAL;
+		margs.home_node = kargs.home_node;
+	} else
+		margs.home_node = NUMA_NO_NODE;
+	flags &= ~MPOL_MF_HOME_NODE;
+
+	nodes_ptr = u64_to_user_ptr(kargs.pol_nodes);
+	err = get_nodes(&policy_nodes, nodes_ptr, kargs.pol_maxnodes);
+	if (err)
+		return err;
+	margs.policy_nodes = &policy_nodes;
+
+	return do_mbind(untagged_addr(start), len, &margs, flags);
+}
+
 /* Set the process memory policy */
 static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 				 unsigned long maxnode)
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index c34c6877379e..4fd9f742d903 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -373,3 +373,4 @@
 456	n64	futex_requeue			sys_futex_requeue
 457	n64	set_mempolicy2			sys_set_mempolicy2
 458	n64	get_mempolicy2			sys_get_mempolicy2
+459	n64	mbind2				sys_mbind2
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index ac11d2064e7a..89715417014c 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -545,3 +545,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 1cdcafe1ccca..c8304e0d0aa7 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -461,3 +461,4 @@
 456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
 457  common	set_mempolicy2		sys_set_mempolicy2		sys_set_mempolicy2
 458  common	get_mempolicy2		sys_get_mempolicy2		sys_get_mempolicy2
+459  common	mbind2			sys_mbind2			sys_mbind2
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index edf338f32645..3fc74241da5d 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -380,6 +380,7 @@
 456	common	futex_requeue		sys_futex_requeue
 457	common 	set_mempolicy2		sys_set_mempolicy2
 458	common 	get_mempolicy2		sys_get_mempolicy2
+459	common 	mbind2			sys_mbind2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.39.1


