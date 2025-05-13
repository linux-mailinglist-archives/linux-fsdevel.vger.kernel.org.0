Return-Path: <linux-fsdevel+bounces-48844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39852AB5162
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFBF1B45E08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5716254B18;
	Tue, 13 May 2025 10:07:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996F024677D;
	Tue, 13 May 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130874; cv=none; b=f+kWosv6zNu9wDSKh1XfcBUlKQmpvs1rkuro8wFMH2aozFMxYEDiPj3kAPq09nk0oqILGeDp2+CNnESdV+VTS3thHDqv9ao0jNooMhuSN/Kbr2qwzVPO861EpRg5w8xM26Vm9E5VYKBaWHMwbVYXbiH+Um5p79fYGej6G1JI1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130874; c=relaxed/simple;
	bh=BG7AZBSjSmF6NrOFDpw8Rk4CMPwauNC98FDvthYcPSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fjKNTNcdNNikV1N/rGyKOc0I8apB63v4aY/FacTQm/f9mpVpMY4CmH0CWH7myjw6P/zRRHLqYpt6hbuxOA2ZMuRlMpNV/hoZ7pGbX4t3Yq4Sq69tZVvuwqxC/He3Ma9MBAE169CAitZIAf0dKG3uuTP+vDHUVf+t7HZbzlR+JpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-4a-682319eeafcf
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
Subject: [PATCH v15 09/43] arm64, dept: add support CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64
Date: Tue, 13 May 2025 19:06:56 +0900
Message-Id: <20250513100730.12664-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSXUxTdxjG/f/P6TmHatlJZ7YDGKc14KbIZBHzXuhivPE/P6IJ8WLuYjZy
	snaWjxX5mjOCogGxBGsQsaAVtVRaKrbq2AaEYai0OtYhK9jwMcgGNnw0QVpFENdivHnzy/Pk
	ed6bh6PkXZJYTp1xTNRmKDUKRkpLp1bUbZqOWafa3OPdCsHZEhpq7lgZ8NgsCKz3ijD4O3dB
	X2gSwfwff1JQVelBcH1kkIJ7ziEEreZTDDz9Nxp6gwEGXJVlDJy+cYeBvyYWMAxc0mOw2PfB
	sGmMhscVdRiq/AwYqk7j8HmOYc7UwIKpMB5GzVdYWBhJBteQVwKtvo1QfXWAgZZWFw3O5lEM
	T3+tYWDI+lYCj51dNITK48BzQSeBxuk6BiZCJgpMwQALPe1GDE7jR9BUHC48+2JRAo907RjO
	3ryLoffZbwjaSv7BYLd6GXgYnMTgsFdS8Lq+E8Fo+RQLZ87PsWAoKkdQduYSDcUDKTD/Kvy5
	djYZiq410dD4xot2bCfWq1ZEHk4GKFLsyCOvg38zpDVkpIm7TiC/XBlkSXGbjyVGew5xmDeQ
	Gy1+TK7PBCXE3lDKEPuMniXnpnoxme7uZg+sOiTdliZq1Lmi9vMvD0tVj2YbcZZLnj/epseF
	qPyDcyiKE/gtwpOq+5L37K/2LTHDrxf6++eoCK/k1wgO3VhYl3IU710u9NU+QxHjQ/5rYcw/
	sRSg+XjBrXPjCMv4rcJtt416V/qJYGlqX+KosP6mvpuOsJxPESqMFjpSKvCGKKF2McC+C8QI
	v5v76QokM6JlDUiuzshNV6o1W5JUBRnq/KQjmel2FN6X6cTCN81oxpPagXgOKVbIuvxrVXKJ
	Mje7IL0DCRylWCkr+jksydKUBT+K2sxvtTkaMbsDxXG04mPZF6G8NDn/nfKYeFQUs0Ttexdz
	UbGFqPTmQH7Z/ltNr2wJjlDO3a/aFLXeRN7wsiSlRIjbhOoPG+KHO/sCR3fquNjS5FRdQqpX
	7Y9Vm6T64xcX9+TPW+4ntgQTPws4Nfs+Pb76ZHRSjbPZ5llHNJfdjZsP+nf7EsYeNO/+/r8K
	s/xA994037WTNv1zy0/VPzxoCY5nuqIVdLZKmbyB0mYr/wde5NToWwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfZ77VuoqN5XAVbOw1VTju8RhTrLFmPnBZ0u2LNkHlX2QRi+2
	aUHXKhN1EWw1KoMVNiAqaC1aGC2KF40v0IYURVsiQ6mgCCjE4BoQDOvtBKquddmXk19+/5z/
	+XIUlLqBWagw5O0VzXk6k4ZV0spvP7eumliwWL+280I6yJHjNFRf9rDQfcmNwHO1CEP4zmbo
	i44jmL3/JwVVFd0Izg8PUnC1YwiBt/4ICz0v5kFInmQhUFHMgrX2MgsPxmIYBirLMbilb+CZ
	a5SGTrsTQ1WYhTNVVhwff2GYdjVw4CrUwkj9aQ5iwxkQGOploL0mwIC3fwWcOjvAQqs3QEPH
	jREMPbeqWRjyvGegs+MeDdHSRdBdVsJA44SThbGoiwKXPMnBwzYHhg5HKjTZ4q3H/n7HwN2S
	NgzHLlzBEHrSgsB3/DkGydPLQrs8jqFZqqBgpu4OgpHSVxwc/WWagzNFpQiKj1bSYBvIhNk3
	8cs1kQwoOtdEQ+PbXrRxA/Gc9SDSPj5JEVvzT2RGfsQSb9RBk6BTIDdPD3LE5uvniEPaR5rr
	l5Pa1jAm56dkhkgNJ1giTZVz5OSrECYTXV3cdx9nKb/YKZoM+aJ5zYZspf5upBHvCaj3v/SV
	40JUmnwSJSkE/jMhfKqfSTDLLxUeP56mEpzCfyI0l4zGvVJB8b1zhb6aJygRzOe3CaPhsQ8L
	NK8VgiVBnGAVv174I3iJ+q80XXA3tX3gpLh/W9dFJ1jNZwp2h5u2I6UDzWlAKYa8/FydwZS5
	2mLUF+QZ9q/esTtXQvEPcv0cK7uBIj2b/YhXIM1HqnvhT/VqRpdvKcj1I0FBaVJURdfjSrVT
	V3BANO/ebt5nEi1+tEhBa9JUX28Rs9X8Lt1e0SiKe0Tz/ylWJC0sRKllOVqb1R6Sd1QbWyTn
	uf7gVjk9+cWCylrr6MybLOO0ZcKdbW/duCZ6KCeNDGuviWkH5m6Sbr8v9ldkBZfEvj+Y7E/7
	6ktlrM6W80+bpZZZ96vu9dOth5nfQibfyvynqc6LwqBN1TJ5c3YqtS9S4zP+OBZa553R/r5p
	2fMr8g8a2qLXZSynzBbdvxjrewk9AwAA
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


