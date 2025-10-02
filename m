Return-Path: <linux-fsdevel+bounces-63244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC7DBB307D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6725319E3D6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68622311C14;
	Thu,  2 Oct 2025 08:14:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C77230C351;
	Thu,  2 Oct 2025 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392843; cv=none; b=gyfTTVLHyNa6LTU4ukdnmBEEgq/l+qgO1OjucKmpRSgOlSWMHs1bTjRAdMTi/pwEsJRrSRP2P1+6qz3EIXZcvKGySiTi+u2J6x5+KfoDWNS7HbZRj7661ASiGm3YREPX/IG5ka99ujNN/4h2ccJ3b2saS0Pvuel0UkzTqM/w7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392843; c=relaxed/simple;
	bh=uxA2pKVGO15yL5SVbzphFFQl8yPZJWX0XsMIhvQNHQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=i4hc0lKVY851ASW3q4dPBk/EbU6yoOyZC5wL5reS6x6KgQk9ri6pNUnlEmQBfG3cDYk5M4RceSx3oYeXLgZvR+EpAMY6tA1D/46I4hS139/yBQ2ed5sgs3R3Qoqr+N9zEtt5u79coRPFrz8m7gU0uQNT7Rmoh7wvxQBaPM6dt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-b2-68de34112b76
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
Subject: [PATCH v17 27/47] locking/lockdep: prevent various lockdep assertions when lockdep_off()'ed
Date: Thu,  2 Oct 2025 17:12:27 +0900
Message-Id: <20251002081247.51255-28-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfVDLcRzH+/6etnaNn8X5kcPtPIbIhc8fOOfO+f3jjnOO4w/Gfmc7tdxi
	lYcTNaLJiuVqclPXT9piNo89XXJNSSx1WWnNyNT1dOhBLNnCf6/7fN6v9+efjxCXuMjZQqXq
	GKdWyWKllIgQ9YfdWiGJ6VSs+qSbD61nqwkYHkon4MY9CwXptlwSnHfNCDzD6QhGfxlxGBp7
	L4CJSgeCnKZsHL5bf1Ng8HZRMMjrEPTUboV+TzkJE+4vGLwb6UPAd/3G4LrBiaDbegHBA0cn
	guauKdAyPEhBvSGDgv6mGxgMWCkwnaskISffRkBHTjYGHt5HQIO+IKD3UJBzfyYYr3djMMaX
	COBVYQcBxsZmEj4W5wnA742GCVM8OMxfBOC+YiCgvrOVhF5fNgWeF+dJsLXVIsi92UFBRWU9
	AenjQwgcTz5ioLM+JKHTMkFCinGUhLdmZ+Cmo46AN2WlJBS9a8LA+8FFgr3xFQ4jmRHgzLpM
	gkv/GUHpQAEFVwd8aJOcHdVmEmyJ/RHGat+OU6zlpgWxQ0WpOKvVByjNnsgWNfRR7MsChn2a
	5xawaVXtAtZkO87aiyPZwooejG3v3cDaSi5S25fsFa2Xc7FKDadeufGASHFW208cbZuW9LK6
	F6UgfuolFCpk6Bjmh6NM8J+dvtdYkCl6MeNyjeFBnk7PZ+yXfWSQcbphDtPatDzI4bScqcro
	ncwT9ELG4C+f7BHTa5mqlNJ/nfMYs7V6sic0MG/2NhBBltBrGO1gWsAVBTLGUMaZ2YP9FWYx
	z4pdhB6JTSikBEmUKk2cTBkbE6VIVimTog7Fx9lQ4N/40/59T9A3584aRAuRNEzsXOhWSEiZ
	JiE5rgYxQlw6XXyguEMhEctlySc4dfx+9fFYLqEGRQgJ6Uzx6pFEuYQ+LDvGHeG4o5z6/xYT
	hs5OQScP/7ry+DUdddGqz1p0KsJWa0g8UacNn/W8fbMqdbfxgrCvMLJSvOa2eG4b6DR+95Y8
	jXzsIJ/USP+0VodnTC073fJzBp+6bkGWudykXGnzVVg0uSGru8ajPao9C7jh/O/blnZvavTn
	z2O+puqutWQ+PBMSsuzgjjveXfz5uiNhUiJBIYuOxNUJsj+jVpGvawMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+7/XuZq9LcmXipLhEsSy6MLJIqovvZVdqA9BRDnzbVtOra1M
	A8HbSOw2F5vlLM1qiFrazMhEEyMhbeWy7Lapq6WFs6Fuijm1rejL4XfO8/DwfDgCXPyYXCxQ
	pp7h1akylYQSEsK9m/JWLljXq1g9+WQR9OS0EuDzFhBQWltDQYHlBgldD6oR9PkKEExMmXDQ
	Ns4SMK1vp8E7+YWG2eZ2BEabHoeaRzkYjNXNUDD0fBSBwemioPhnDgEe8yUEJQMmGn6+2AHD
	fU0kzDoGMfgw7kZgds1g4Gq9gGDamAxlFfUUTFnf4FBs6EJw2+nA4UddQHzU3ouguTKXgu+6
	Bhy6XaHwzueh4KXhIgXDtlIMftVRUJ7bTMJNkx5B3p1aCow3LQQ09j+lwTbkx8Bu1GNQbdkD
	feYBAjp1FVigX8D1MBxMxXlYYPzAwHC/CYNJcxUNr+7YCTBnS8Fk7Sbha2UJDX7nGpgtT4P2
	6kEaHFcNBDwYfkNuNSBuQnuF4KrqH2Oc9u00xdXcqkHc1G894rz38nBOqwusz90enMuvP8fd
	63RT3G/fe4prHi8nuI4KliuyruQaSxw0l9/ymd4fd1i4OYlXKdN5deyWBKEiRztMnPq0IKOj
	dQhlI/P8QhQiYJl1bNfAayzIFBPFfvw4iQc5jIlg6y8PkEHGmc6lbI8tJsgLmSS25eLQXz/B
	SFmDv4kOsojZwLZk36f/ZS5nq+ta/+aEBO7dzk4iyGJmPav15GM6JCxHc6pQmDI1PUWmVK1f
	pUlWZKYqM1YdT0uxoMA3mbP8RU+Qt3tHG2IESDJPZJM6FGJSlq7JTGlDrACXhIkSKu0KsShJ
	lnmeV6cdU59V8Zo2tERASMJFuw7xCWJGLjvDJ/P8KV79X8UEIYuz0dr+I0cfbrX74z06edhI
	TOiYceO4PDdKXjg6o9cXvhYljpSmOYWVB2pN8e4G6bLrDd7Efct2WkczX13LkL7YHjehEj77
	5iuMihTFDmqje8LfFmfN9Z8Yc9uLxLBaXpa+7aQg3rXb6rWsOHj6nHhXmTA69C552JL1LjLi
	Q4SkbUZCaBSyNdG4WiP7A0laOYtJAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

lockdep provides APIs for assertion only if lockdep is enabled at the
moment asserting to avoid unnecessary confusion, using the following
condition, debug_locks && !this_cpu_read(lockdep_recursion).

However, lockdep_{off,on}() are also used for disabling and enabling
lockdep for a simular purpose.  Add !lockdep_recursing(current) that is
updated by lockdep_{off,on}() to the condition so that the assertions
are aware of !__lockdep_enabled if lockdep_off()'ed.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/lockdep.h  |  3 ++-
 kernel/locking/lockdep.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index ef03d8808c10..c83fe95199db 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -303,6 +303,7 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 	lockdep_assert_once(!current->lockdep_depth)
 
 #define lockdep_recursing(tsk)	((tsk)->lockdep_recursion)
+extern bool lockdep_recursing_current(void);
 
 #define lockdep_pin_lock(l)	lock_pin_lock(&(l)->dep_map)
 #define lockdep_repin_lock(l,c)	lock_repin_lock(&(l)->dep_map, (c))
@@ -630,7 +631,7 @@ DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 DECLARE_PER_CPU(unsigned int, lockdep_recursion);
 
-#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursion))
+#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursion) && !lockdep_recursing_current())
 
 #define lockdep_assert_irqs_enabled()					\
 do {									\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dc97f2753ef8..39b9e3e27c0b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6900,3 +6900,13 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
+
+/*
+ * For avoiding header dependency when using (struct task_struct *)current
+ * and lockdep_recursing() at the same time.
+ */
+noinstr bool lockdep_recursing_current(void)
+{
+	return lockdep_recursing(current);
+}
+EXPORT_SYMBOL_GPL(lockdep_recursing_current);
-- 
2.17.1


