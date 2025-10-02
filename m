Return-Path: <linux-fsdevel+bounces-63223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2DFBB2DEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D0D19E0443
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2AB2ECE98;
	Thu,  2 Oct 2025 08:13:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2F2E9721;
	Thu,  2 Oct 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392808; cv=none; b=G68/PWyo8buSGyE9ihSZyJpX5l8bBUXdy7wxH7PnyUuZfULd1FPe6f3IKisvABtp1oXo/Q8GEwJBdotPl12AzfXj36RdKi1HPubGoWhRVA7dUk5oGEU0KMynamN9dNG401V1OfceJtJYRcZ6hlpHXcUQh9h0uP6S79RfPt+/oNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392808; c=relaxed/simple;
	bh=qC+IR5GZA2zhKidsaNPgh+s2SNwZBlAHaPQiuaDTpZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jI1p/81X6xXIbu6ZiTr9MO1I33beN7FmstrSdP7hHLYe1E0KdXyOIid+esGFrhmlgLPYMM9gfymXiA5tLHHdoY2uLoL6wWB4H/L//K/IpKGU2pWBt1vzgD0Qvp3hp52v0x9KzBBzjeb3G7Si7Bn5XNIJGcYLGSPavyEy4PzRBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-16-68de340c3f0a
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
	yunseong.kim@ericsson.com,
	ysk@kzalloc.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	sumit.semwal@linaro.org,
	gustavo@padovan.org,
	christian.koenig@amd.com,
	andi.shyti@kernel.org,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	chuck.lever@oracle.com,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	wangkefeng.wang@huawei.com,
	broonie@kernel.org,
	kevin.brodsky@arm.com,
	dwmw@amazon.co.uk,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	ziy@nvidia.com,
	yuzhao@google.com,
	baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com,
	joel.granados@kernel.org,
	richard.weiyang@gmail.com,
	geert+renesas@glider.be,
	tim.c.chen@linux.intel.com,
	linux@treblig.org,
	alexander.shishkin@linux.intel.com,
	lillian@star-ark.net,
	chenhuacai@kernel.org,
	francesco@valla.it,
	guoweikang.kernel@gmail.com,
	link@vivo.com,
	jpoimboe@kernel.org,
	masahiroy@kernel.org,
	brauner@kernel.org,
	thomas.weissschuh@linutronix.de,
	oleg@redhat.com,
	mjguzik@gmail.com,
	andrii@kernel.org,
	wangfushuai@baidu.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v17 08/47] x86_64, dept: add support CONFIG_ARCH_HAS_DEPT_SUPPORT to x86_64
Date: Thu,  2 Oct 2025 17:12:08 +0900
Message-Id: <20251002081247.51255-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSWUwTaxTH/Wa+mSkN1bGiDO5pJMZ9CZgTc2OuvjiaGDU+uCZaZbRVKFoW
	QUNShHqJCGIVjYBSVBBsldKqYatW1CpWpAVEUAsWFaLCJUEoikgtGN9+J//l5CRHREpbqaki
	pSpWUKvkkTJajMU9gQWLJGFtiqV3hqZAc7INw0B/Goa8UiMNaeZLFDhvGxBoK3wYfunsDPT/
	eMuAz2pHcMGlI8F4J5mAb6YRGr4+6kPw+cla6GmvosDn7iLgtbcbQdHHEQI+2v5DkH/VQkOB
	x02CtfgEDZ+y7pLQNNBLQ212Og09rjwC/jfRoD9hpeByrg5ByrVSGi5cNmOoeF/JgOvrMAEG
	8wZoL+rEcPGzXysLhuxbVQQUaUIht67Rv1cfDXZDFwPuM9kYbvfUU1Db1kxB+9OTFJhbnyDo
	b/IQkFY5gMH6ZgEUnLyOodpai8Fe3kFAm9FHgSZ30H+2zUFBg8GJobSrhQCH/RmG+spbFBS+
	dhFgqXtBgjdzGjjPZlD/RvCD2kzM37TcI3htwy+aN14xIv7nkA7x/YUpJK/N8o+PuntJPtVy
	lC90dNP80MArmrd69Zg/W7eIr8hxM3zq/TcMrzfHbVq+Q/xPhBCpjBfUS1btESuumm8whx8H
	JXyxlzMa1MGeQgEijg3jLl0Zwn85fVhDjzLNzuVaWn6QoxzEzuYsGZ3UKJOsYzrX7Fo4ypPY
	ndy36pdjWcyGchWVDWMsYcO57w+c1J/OWZzBZBvrCWBXcI0ex5hH6vdoe1OJU0js9+QHcLVN
	FuZPIIR7WNyCs5BEj8bdRFKlKj5KrowMW6xIVCkTFu+LjjIj/8MVJQ3vLEd9zi01iBUhWaDE
	GepWSCl5fExiVA3iRKQsSLKn+J1CKomQJx4T1NG71XGRQkwNmibCsmDJcu/RCCl7QB4rHBKE
	w4L6r0qIAqZq0Lyc5Mwz+47vKjzi1Xt+zjlHJOWUbCp78XJy9YjPun6C60Ps+5KZx7aXNKTY
	sjsaraKwcPpL/baQZ6Hh+v3uI891e7eXnV6Dq1qfBxMe07ym9Rnc+PS+pM2ob2L3upCDtvyN
	mZCgOZ+WsULVNjj58dbrxwM7V5viZpxfycGN6cqLE2Q4RiFfNp9Ux8h/A7lLWjJsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe895zznbaHFYVocMipEE3S9WD93wm6eiCPoQFKQrD214ZauV
	SeVtJV1ttVmui2kuc2a2WbnSMs1FmeZarSinKba0tFE6zabZZvTl4ffw//Hn+fCISNk9arpI
	lbRXUCcpEuS0BEs2r85aMDGyTbm4YWgeuDNqMfgHcjBcul1GQ471IgUt5RYE7f4cBEMBEwk6
	+xiGUb2DgYHhjwyM1TgQGJ16EsoqMwjor/hDw7f6nwgMHV005PVkYPCZTyLI95oY6GmIhr72
	hxSMeb4Q8G6wF4G56w8BXbXHEIwa4+FqoY2GQNMrEvIMLQiudXhI6K4IhpWONgQ1JZk0fM69
	S4KraxK88ftoeG44QUOf8xIB3ytoKMisoeCySY8gq+g2DcbLVgz2Tw8YcH4bIaDVqCfAYt0E
	7WYvhsbcQiJ4X9C6Mw1MeVlEcHQTYLj1kIBhcykDL4taMZjTI8DU5KKgsySfgZGOJTBWkAwO
	yxcGPGcMGMr7XlFRBsQP6U5jvtR2j+B1r0dpvuxKGeIDv/WIHyjOInldbnCt7/WRfLZtP1/c
	2Evzv/1vab5msADzLwo5/mzTAt6e72H47EcfmC2rtkvWxAkJKq2gXrQuVqIstN5gUp6GHfjq
	qGLSUSd7HIlFHBvJnRhJp0NMs3O49++HyRCHsbM42ykvFWKSbZzBuZ3zQzyZ3cH1VzfjEGM2
	grM/eD3OUnY59+txC/WvcyZnqagd7xGzKzhXR+O4Iws6Ol82kYskBWhCKQpTJWkTFaqE5Qs1
	8crUJNWBhbuTE60o+E3mQyNnq9CAK7oOsSIknyh1RniUMkqh1aQm1iFORMrDpLElrUqZNE6R
	elBQJ8eo9yUImjoULsLyadIN24RYGbtHsVeIF4QUQf0/JUTi6enI/Wv0CTHXH1OqXfy9s/pp
	1K7oVqUnZspSY3hzQCI6tPaILPBj1dBbZ2LxvGWDVc3nPrlmn5dlp7hPp02t9L7sv45jIvPP
	uW1pV2v7qm/uzFk/Y1nlUUvy9fC19psrceYFMfG1/lnbfX98WoqkYatFWyTuvvJu80Zfb9xh
	r2aN82iUHGuUiiVzSbVG8Rd7PnfISQMAAA==
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
index 05880301212e..46021cf5934b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -38,6 +38,7 @@ config X86_64
 	select ZONE_DMA32
 	select EXECMEM if DYNAMIC_FTRACE
 	select ACPI_MRRM if ACPI
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
index 998bd807fc7b..017edb75f0a0 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -19,6 +19,7 @@
 #include <linux/mm_types.h>
 #include <linux/mm.h>			/* find_and_lock_vma() */
 #include <linux/vmalloc.h>
+#include <linux/dept.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1219,6 +1220,12 @@ void do_user_addr_fault(struct pt_regs *regs,
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


