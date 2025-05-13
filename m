Return-Path: <linux-fsdevel+bounces-48841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90435AB514E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D29F189B40C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8DF25394B;
	Tue, 13 May 2025 10:07:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B04E2459F9;
	Tue, 13 May 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130873; cv=none; b=RidrudEs4mygV3ub85GrONb6nOBegA7euC6NMZz4tJaPIHk2Djgv8pizSr0ZBQL4TqA1io8SFl70jCp2SMTD5s8USuK+cXz/LNIQd5itGIQq9RyfheQgbDZKkAUD4eXO81KbDfim8TfT/hSk4CCdF6BW51CHSB6QB5ynt5hQnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130873; c=relaxed/simple;
	bh=8SxiXT7aMr/Jndlc0Cvu8YV+kxqp+XaubTMN75I/AOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=s/XujMkl7vYkARKsDXnclsC95OaUaVlEn89AEmbsJEx+E4dNO4kk4aWyiLgZ1Onbl8h0lYlcKL6wOORL7/VFOy9Cute4OerJdsCtED8NlO9+InwF6AjExpFOvvUumVXIunY2DqO8s2iXCt3F9cmxDXOxXZsxOoeyLdXRE1hJe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-3a-682319ee2425
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v15 08/43] x86_64, dept: add support CONFIG_ARCH_HAS_DEPT_SUPPORT to x86_64
Date: Tue, 13 May 2025 19:06:55 +0900
Message-Id: <20250513100730.12664-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfZ/nued5Op09O60eMj/O7yjOwmeG+TlPYtPMJmXc9NTdVHKX
	fthYp6McJaaiX65wpS7qyuRHLZnTj8nRqSShEamrKXeTfnDV/PPZa+/3e+/PP28aF5sEM2lF
	eCSvDJeFSkghIbQ653r2zZgvX/k1eznYfiUSkHXPQIL5bhECQ7kag+7nO6DF3otg+OUrHNJT
	zQhyP3/AodzUgaCy4AwJTV+mgcXWT0Jd6gUS4m/eI+F1zwgG7WlXMCgy7oaP+i4CGlLyMEjv
	JiEzPR5znO8YDOkLKdDHLYTOggwKRj5Loa6jWQCVbcvgek47CU8q6wgwVXRi0PQoi4QOw18B
	NJhqCbAnu4P5cpIAivvySOix63HQ2/opeFOtw8Ckc4USjaPw3OCYAF4kVWNw7lYpBpZ3jxFU
	JX7CwGhoJuGZrReDMmMqDn/ynyPoTLZScPbiEAWZ6mQEF86mEaBpXw3Dvx2fs39JQX2jhIDi
	0Wa0aQNnyDEg7llvP85pyqK5P7a3JFdp1xFcfR7LPcz4QHGaqjaK0xlPcGUFHtzNJ90Ylztg
	E3DGwvMkZxy4QnFaqwXj+hobqT2zDgjXB/GhiiheuWLjYaH8fbaViKh3iRmOv03EoR+MFjnR
	LOPNjlVU4FpET/DVDNW4TDKL2dbWIXycXZi5bFlSl0CLhDTONE9lW7LfoXFjOhPAtr+6PMEE
	s5AdffuGGGcRs5rV3C8kJ/vnsEUl1RNFTswadjS/cSIjdmRSdEXEZCbdidVqAid5Bvu0oJVI
	QSIdmlKIxIrwqDCZItTbSx4brojxOnIszIgc69KfGgmoQAPmvTWIoZHEWVTbPU8uFsiiVLFh
	NYilcYmLSP3AIYmCZLEneeWxQ8oTobyqBrnThMRNtMoeHSRmQmSR/FGej+CV/12MdpoZhzbn
	otYd0cHO/KVFWRFyc+m6+VcX+H3p2pU2drg3sC/zdv3swaUtu65vOe0rjftWXrI1MWrfwYQx
	ssU9xI+S7p7+LdBS5W89Xmq9FlwTktCY8D0ksmrY37s4z37np327xc0n2H9n24G1SzLNXU3B
	i7b2bHztk+/rrMY9Xfm95/3o/dskhEouk3rgSpXsH/5nLBBZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzH+/6eO85+O+GHeegsNs1DKJ8ta4bNz0NiszE2+uE3d1yX3Sll
	Q7nTuJSKUyKucKUOuSvloZxaqVDRM+eomUlPG91NKrna/PPea+/3e+/PPx8Gl90jZzFK9XFR
	oxZUckpCSLYF65b0z1ygWP7y41RwDZ4n4MZDCwWNDwoQWIriMeiu2ght7l4Ew28bcEg3NiLI
	7vyEQ1G1E0FZ3lkKmr5OgWbXAAW1xkQKdLcfUvCuZwQDx9U0DAqsofDZ/I2A1yk5GKR3U3A9
	XYd55DsGQ+Z8GsxxftCVl0nDSGcA1DpbSajMqiWh7IM/XLvpoOB5WS0B1aVdGDQ9vUGB0zJG
	wuvqGgLcybOhMTWJhPv9ORT0uM04mF0DNLy3mzCoNk2HQr1nNeHXXxJeJdkxSLjzCIPmjmcI
	ys9/wcBqaaWg0tWLgc1qxOFPbhWCruQ+Gs5dHKLhenwygsRzVwnQOwJh+LfnctZgAMTfKiTg
	/mgrWhvCW25aEF/ZO4DzetsJ/o+rheLL3CaCr8vh+CeZn2heX/6B5k3WKN6Wt5i//bwb47N/
	ukjemn+B4q0/02je0NeM8f319fT2OXskaw6JKmW0qFkWEi5RfMzqI47V+cQM6+4ScegHa0AM
	w7GruCuZWgPyZih2EdfePoSPsw87n7MlfSMNSMLgbOskri2rA40HU9m9nKMhdYIJ1o8bbXlP
	jLOUDeT0xfnUOHPsPK6g0D4x5M0GcaO59RMdmaeTYiogUpDEhLzykY9SHR0hKFWBS7VHFbFq
	ZczSg5ERVuR5IPOpkdRSNNi0sQKxDJJPltZ0+ypkpBCtjY2oQByDy32k8SUeS3pIiD0paiL3
	a6JUorYCzWYI+Qzp5l1iuIw9LBwXj4riMVHzP8UY71lx6G34iqQx4U1iKCl2SMYafgcFdBaf
	znGE+Knc61cnvBLCDGe3rseJfQvb645sSF/rP6YxFmUoHkdNNr/w3Tv3R+i9B7kzttXonU5Z
	VUOYXT3lUm4LOcfrb3ByYqqC3Gn0kqbp/M94hx6YtmTHyjbXulLp1y12v9X2gchN5ZdtGSW7
	5YRWIQQsxjVa4R+GEGaMPAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

dept needs to notice every entrance from user to kernel mode to treat
every kernel context independently when tracking wait-event dependencies.
Roughly, system call and user oriented fault are the cases.

Make dept aware of the entrances of x86_64 and add support
CONFIG_ARCH_HAS_DEPT_SUPPORT to x86_64.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/Kconfig            | 1 +
 arch/x86/entry/syscall_64.c | 7 +++++++
 arch/x86/mm/fault.c         | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5873c9e39919..4b6d9e59d96c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -38,6 +38,7 @@ config X86_64
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
 	select EXECMEM if DYNAMIC_FTRACE
+	select ARCH_HAS_DEPT_SUPPORT
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index b6e68ea98b83..66bd5af5aff1 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,6 +8,7 @@
 #include <linux/entry-common.h>
 #include <linux/nospec.h>
 #include <asm/syscall.h>
+#include <linux/dept.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
@@ -86,6 +87,12 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 /* Returns true to return using SYSRET, or false to use IRET */
 __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 {
+	/*
+	 * This is a system call from user mode.  Make dept work with a
+	 * new kernel mode context.
+	 */
+	dept_update_cxt();
+
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 296d294142c8..241537ce47fe 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -20,6 +20,7 @@
 #include <linux/mm_types.h>
 #include <linux/mm.h>			/* find_and_lock_vma() */
 #include <linux/vmalloc.h>
+#include <linux/dept.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1220,6 +1221,12 @@ void do_user_addr_fault(struct pt_regs *regs,
 	tsk = current;
 	mm = tsk->mm;
 
+	/*
+	 * This fault comes from user mode.  Make dept work with a new
+	 * kernel mode context.
+	 */
+	dept_update_cxt();
+
 	if (unlikely((error_code & (X86_PF_USER | X86_PF_INSTR)) == X86_PF_INSTR)) {
 		/*
 		 * Whoops, this is kernel mode code trying to execute from
-- 
2.17.1


