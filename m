Return-Path: <linux-fsdevel+bounces-49342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B412ABB8A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B743C16F400
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B726E16C;
	Mon, 19 May 2025 09:18:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C2826A1AD;
	Mon, 19 May 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646329; cv=none; b=LUPqEP8zpalC9KGzo/0tQqjhC65Fa7eBPDsz35yMBLZUENElNYZiKp2osDsMQjUla/TbRgDUJwnK3jHkCdE6QnSBB3X4BSLpzLrORdMds4OrxGIaKF6DjJelLAXp4D4RCwMdoqj215RfF3I8rnQVsx33F5parOhMx8hefLtsYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646329; c=relaxed/simple;
	bh=8SxiXT7aMr/Jndlc0Cvu8YV+kxqp+XaubTMN75I/AOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GMZwWm5jBqcUxkHqOQ4FjEqQZc5YqdqZ+E6EVtbBx9RKuWSRHZF4rK4FO7CaXpboP52ix0kxvRZmzIO33Wo2VnAP75MHMLcMkSRYZp71w+KeL3xbbrBf5nZ7OigPTJcQY6HD5vayBi69rQvToxRXPrrPiwwRNkfjlVlgGnntTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-73-682af76d8185
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
Subject: [PATCH v16 08/42] x86_64, dept: add support CONFIG_ARCH_HAS_DEPT_SUPPORT to x86_64
Date: Mon, 19 May 2025 18:17:52 +0900
Message-Id: <20250519091826.19752-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0xTZxSH97739t7bSpebSuadLNvSxFRrhkLEnMw5TUzmm0zjEk00Ev80
	cmObQTFFUEgWYVCtIuhMABVhBbFWKIKtJk4pKSWWgRlUqaUgVmXE2EklA1pWQVyr8cvJk/x+
	5zlfDkcpPJKlnE5/WDToNdlKRkbLwkkN3+hn1drVs11KiMyYaLjUZmPAe70Fge1mCYbQvc0w
	FJ1AMPfXAAU1VV4EDc+fUHDTE0TgtP7KwOD4p+CLTDLQW1XOQOnlNgYevJrHMFp9DkOLfSs8
	tbyg4f7ZRgw1IQZqa0pxfLzEELM0s2ApXgZj1osszD9Pg96gXwLOkZVwoX6UgQ5nLw2e22MY
	Bu9cYiBoeyeB+54/aYhWpoD3twoJtL5uZOBV1EKBJTLJwkOXGYPH/Bm0l8WFx6cXJNBT4cJw
	vOkGBt/wXQSdpmcY7DY/A92RCQwOexUFb67eQzBWGWbBeDrGQm1JJYJyYzUNZaMZMPdf/HLd
	TBqU/N5OQ+tbP9q4ntjqbYh0T0xSpMxxhLyJPGKIM2qmSV+jQP64+IQlZZ0jLDHb84nDqiaX
	O0KYNExFJMTefJIh9qlzLDkV9mHyur+f/emL3bLvssRsXYFoWPX9fpn2cV2YPtSXfHSu9Apd
	jP7hTyEpJ/BrhPMNLslHDnTcYhPM8CohEIhRCU7mvxYcFS/iHRlH8f5FwlDdMEoEi/lM4d9b
	8/GA42h+mWAqwQmU8xnCeFfBB+VXQku7671Gyq8VRsq7328q4hVfSz2dUAr8Gakw3XkBf1j4
	XOiyBuizSG5GnzQjhU5fkKPRZa9J1RbqdUdTD+Tm2FH8uyy/zGfeRlPe7W7Ec0iZJG93rtAq
	JJqCvMIcNxI4Spksb3Ys1yrkWZrCItGQu8+Qny3muVEKRyuXyNOjR7IU/EHNYfFnUTwkGj6m
	mJMuLUY6FzUrS43tcI+GTE2nxSzP32jymtmY2ipN2WnsH3DvUjfe+DbT7lNdq1ZvNIV+2BqM
	3Vmxtzpj3Vy4bZO2SMVsf7DamGRUWf2Ltjg3BGYGVEXnmR/3kKlNV4bagmq+78uFLdu8uTsX
	Tkw/Xb9uW/2CkIZ7nD3p47XHBnbLm04q6TytJk1NGfI0/wNg7ldfWQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjHfb6/O46vc+M7MXaWCEemPBuzbI3PGGNjNjYcfeeOLnbHKWMr
	V9YP3bBVox+u4pw67rrL5kdnqTmSH9FJkqhhohPqjroLF/PPs9f2ej/v55+HI2VWeiqnSTko
	6lJUyQpGQknWLzMu0P6IUS9yZSvAP5hNQYndxkDL1WoEttoMAnrvroYXgT4EwUdPSCgqaEFQ
	3v2ahFpPFwK39TgDre/Gg9ffz0BTQR4Dxko7A08/hwjoLDxDQLVzHbyxfKCg+VQFAUW9DBQX
	GYnw+EjAkKWKBUt6FPRYz7EQ6o6Fpq42GhpLm2hwd8yDs2WdDNS5myjwXO8hoPVmCQNdtt80
	NHvuUxAwRULL6XwarnypYOBzwEKCxd/PwrN6MwEe82RwZIZbTwz8ouFefj0BJy7UEOB9eQvB
	7ey3BDhtbQw0+vsIcDkLSBi+dBdBj8nHQtbJIRaKM0wI8rIKKcjsjIPgz/Dl0sFYyDjvoODK
	SBtKWIFtZTaEG/v6SZzpOoyH/c8Z7A6YKfygQsA3zr1mcebtDhabnYewyxqDK+t6CVz+3U9j
	Z1UOg53fz7A41+cl8JfHj9kN07dKlieJyRqDqFu4YqdE/arURx14IE8NGi9S6egTn4siOIFf
	IrTXXWNHmeGjhfb2IXKU5fxMwZX/gc5FEo7k28YKL0pfolExid8mfLsWCguOo/goITuDGEUp
	Hye8u2P4VzlDqHbU/62J4OOFjrzGv5uycMRbXUadQhIzGlOF5JoUg1alSY5T6vep01I0qcrd
	+7VOFP4fy7HQ6etosHV1A+I5pBgndbjnqmW0yqBP0zYggSMVcmmVa45aJk1SpR0Rdft36A4l
	i/oGFMlRiinSNVvEnTJ+j+qguE8UD4i6/5bgIqamI/zUdGvDZqNyYtSRtb7iHwni+HX2EV9s
	0F2jc5giQ0MrN80ernXl7B1mXy2YMC7AQGGJtyOk3POevPwV7VrcPf9OUbmk9WgoLlHuGVH+
	zJrV2ZyUmBNvt6Z6J22fG7QvG3g/7WL0ItNbJnHLQy7qmWKpNt4+Tbpx/kCCYVXCp70KSq9W
	xcaQOr3qD0hkd0M7AwAA
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


