Return-Path: <linux-fsdevel+bounces-49344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FBBABB8BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EA3174F16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A92701AB;
	Mon, 19 May 2025 09:18:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E72B266B76;
	Mon, 19 May 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646330; cv=none; b=fQxmiiate4GSyaFSl6bW5P5ZEF9PQ7pHwkx6xBrYrxMaryDSa24cQjUgHKJI/5mBewatE4bgk6h3LtqY6osTQmdsnN1RNl3JlpHjp3ib5hgGaW/X+yWKADaQ+HEbRHnmSCu5Z0YiBrilQBahoNhNhEaewUOZ/FkQNYXWiSAKpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646330; c=relaxed/simple;
	bh=BG7AZBSjSmF6NrOFDpw8Rk4CMPwauNC98FDvthYcPSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TcKULzPIS3gyvRzWIn6Joe44xPe4s/lIYMZvmdEOR/BFGK4NziKYsCNSMXEVXlcl7vWqGRxHlrhpNAo8FTzwyUt8OtDEnZxV5vbGlQGnxdquG1q1HY90WVFBdAFUo6t8etOLuk/Ja86RpN77hHOsaH6LNSXA8AjbmMm/XLC575c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-74-682af76de41b
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
Subject: [PATCH v16 09/42] arm64, dept: add support CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64
Date: Mon, 19 May 2025 18:17:53 +0900
Message-Id: <20250519091826.19752-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe99zm6vVaUWd7jEYlWJldHmCCulDnT4UQRRlQa48tdVcNcuc
	FGjNMs1RkkkXdVpM0Vl2FnSdLcWVibXS1MRLjtKNNg1zM8suW9KXhx/P5ff/8kgI+UtqpkSj
	Oy7odSqtgpaSUv+EkmjdcKR6aYNDAYGhTBJu3rXS4LpTgcB6Px2Dt24jtAZ9CH42viEgP8+F
	oLink4D7zi4E9rIzNDR9mgjNgQEa6vOyaTh76y4Nb7+MYui4mouhQtwM3ZZeEhoulWDI99Jw
	I/8sDhUPhhFLOQOWNCW4y64zMNoTA/VdLRTY26PgWmEHDU/t9SQ4H7oxND2+SUOX9Q8FDc6X
	JARNs8B1OYeCyv4SGr4ELQRYAgMMvHOYMTjN06DKGBKe+/abghc5Dgznbt/D0PzhCYLqzI8Y
	RGsLDbUBHwabmEfAj9I6BG6Tn4GMiyMM3Eg3IcjOuEqCsWMF/PweSi4YioH0oioSKn+1oNi1
	vLXQivha3wDBG20n+R+B9zRvD5pJ/lUJxz+63snwxup2hjeLJ3hbWSR/66kX88WDAYoXyy/Q
	vDiYy/BZ/mbM979+zWydHSddkyBoNcmCfsm6eKn6xVAlPlovT+mrzsVpyDQpC0VIOHY51/3K
	hf9zf2ktCjPNLuDa2kaIME9l53O2nF4qC0klBNsynmst+PBvaQq7i3v3+A0dZpJVck/Si6kw
	y9iVXMblVnpMOo+rqHL8E0WE+u3ZYwFydgXXXFFIhqUcmx/B/cnIJMcOZnDPy9rIS0hmRuPK
	kVyjS05UabTLF6sNOk3K4v1HEkUU+i/L6dHdD9Gga1sNYiVIMUFWZV+kllOq5CRDYg3iJIRi
	qqzctlAtlyWoDKmC/she/QmtkFSDZklIxXTZsuDJBDl7UHVcOCwIRwX9/ymWRMxMQ9xB0+Sv
	95SrlJ4D81P87tXvlVv6ivI+dis7BU98lDf1lCFt+0pxntObuqmRcG94tqNx55XJcWtik6eV
	9hi0bFPc7wPnP3Xv+fYguM+TQO7uOzQULfeZPJnDpmNR43sXrb9ijl0dP1dTLQ7n+pi14y4c
	c6ibRg6tT2k8X/DZuNU/R0EmqVUxkYQ+SfUXE5tQ7VsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0iTeRzH+36fn65WDzuph6ROBmYZdQkZHyiiCOqh644oq7v6w3b1cBtO
	022ZBoFrGp3LkR4mZ802jSnzUdcmnJUTUbKbkpouNTFTC038sX64lWl2s+ifDy8+7w+v9z8f
	llA4qbWsJtUg6lJVWiUtI2W/7jRtSfkQp94WGt8IwdmrJNyqlWjoqqlCINUZMUw8PAB9oSkE
	8487CSgu6kJgH3lOQF3rEAJv5WUael6tBH8wQIOvyEyDqbyWhieTCxgGbxRiqHL/Ai8cYyS0
	Xy/DUDxBw81iEw6P1xjmHE4GHNkxMFpZwsDCSDz4hnopaLH6KPAObIZ/SgdpaPD6SGitH8XQ
	c/8WDUPSFwraW/8jIWSJgq6CfAqqZ8pomAw5CHAEAwx0N9kwtNpWgysnbL3yfpGCR/lNGK7c
	uYvB/+wBgsarwxjcUi8NLcEpDB53EQGfKh4iGLVMM5B7bY6Bm0YLAnPuDRJyBhNg/mO42Tob
	D8bbLhKqP/eiPbsFqVRCQstUgBByPBeET8GntOAN2UihrYwX7pU8Z4ScxgFGsLnPC57KOKG8
	YQIL9ndBSnA7/6IF97tCRsib9mNhpqODObzupGzXWVGryRB1P+0+LVM/mq3GaT5F5nhjIc5G
	llV5KILlue38TEULWmKai+X7++eIJY7konlP/hiVh2QswfUu5/usz74e/cD9znff76SXmORi
	+AdGO7XEcm4Hn1vQR3+T/shXuZq+iiLC+wHztwIFl8D7q0rJ60hmQ8ucKFKTmpGi0mgTtuqT
	1VmpmsytZ86luFH4gxyXFgrq0WzPgWbEsUi5Qu7yblIrKFWGPiulGfEsoYyUOz0b1Qr5WVXW
	RVF3Lkl3Xivqm1EUSyrXyA+eEE8ruD9VBjFZFNNE3fcUsxFrs9F+uXWffa7NerTkzPGxvYvR
	wZg6nb/ij3TbISkT/Xbq7+WSf8O6hrEeMzOyfSf8/FIqX/9vbIf62GT0nTitPKo5sTjKdW/V
	mkIImWv2WIZNSdMT7fVGU9bRw/NvDNWBI9pkw0KdoXv00nEI2RMD6W9JNj12uKZ+3LmonP6o
	PKQk9WpVfByh06v+B0+8G4g9AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

dept needs to notice every entrance from user to kernel mode to treat
every kernel context independently when tracking wait-event dependencies.
Roughly, system call and user oriented fault are the cases.

Make dept aware of the entrances of arm64 and add support
CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/Kconfig          | 1 +
 arch/arm64/kernel/syscall.c | 7 +++++++
 arch/arm64/mm/fault.c       | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a182295e6f08..6c69598a6423 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -279,6 +279,7 @@ config ARM64
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select USER_STACKTRACE_SUPPORT
 	select VDSO_GETRANDOM
+	select ARCH_HAS_DEPT_SUPPORT
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index c442fcec6b9e..bbd306335179 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -7,6 +7,7 @@
 #include <linux/ptrace.h>
 #include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
+#include <linux/dept.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/exception.h>
@@ -96,6 +97,12 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	 * (Similarly for HVC and SMC elsewhere.)
 	 */
 
+	/*
+	 * This is a system call from user mode.  Make dept work with a
+	 * new kernel mode context.
+	 */
+	dept_update_cxt();
+
 	if (flags & _TIF_MTE_ASYNC_FAULT) {
 		/*
 		 * Process the asynchronous tag check fault before the actual
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ec0a337891dd..0fcc3dc9c2a9 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -26,6 +26,7 @@
 #include <linux/pkeys.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/dept.h>
 
 #include <asm/acpi.h>
 #include <asm/bug.h>
@@ -616,6 +617,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!(mm_flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+	/*
+	 * This fault comes from user mode.  Make dept work with a new
+	 * kernel mode context.
+	 */
+	dept_update_cxt();
+
 	vma = lock_vma_under_rcu(mm, addr);
 	if (!vma)
 		goto lock_mmap;
-- 
2.17.1


