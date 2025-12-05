Return-Path: <linux-fsdevel+bounces-70781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4152CA75DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 12:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C59735AB133
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D8338599;
	Fri,  5 Dec 2025 07:21:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13572459C5;
	Fri,  5 Dec 2025 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919262; cv=none; b=btvINZdjk88xwUAKt8ejPyWqt8POhSyn38JjfmrJ6+UlAUI/xqhCHsLZEn2j3TyJKWo2+WAXvvPyySXix8epMuXMW5KsMN8R2hG5a0PxqnQYqMeuVee2pVoWnG9sG4Wzgy3T0MkpegmB/ms3NqtC1/7Sbu9cZx1LJUlla3NLWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919262; c=relaxed/simple;
	bh=So2GcO/nGjpeS9/NgQLryBKRb0joa2qJ742OcowYmNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WhbmUajm3Ms8EHm8KAwm0bTrGyBaK7mGzjGQgTHBwurMpNq9Qi7zrqbUj29K7CniVX2BXsFAm6mr1g4Tk2ngKnqVBfy+HUJINwqIjwmeYiGnLGQihE33MfLVBmJAFyUM4NKgYdqSiMR0E62Fw7XHao4cF1LUZyqvdDHxvcXYkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-d3-693287705222
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
	linux-rt-devel@lists.linux.dev,
	2407018371@qq.com,
	dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	neilb@ownmail.net,
	bagasdotme@gmail.com,
	wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com,
	geert@linux-m68k.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v18 24/42] locking/lockdep: prevent various lockdep assertions when lockdep_off()'ed
Date: Fri,  5 Dec 2025 16:18:37 +0900
Message-Id: <20251205071855.72743-25-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH99z73BcaqncV59V9cKkhGicqhm1nxC18vC4x0/htxtRmvY7G
	UrS81rmJA6XrEBmxrdoxikhFW2ctGofSpUNtBKwWkbUoFEmwiqAQoZQiL8Mav5z88vuf8/90
	WFIWpFawam2+qNMqNXJagiUvk+vS9pdvUm88G0dgOHIIevsHKfjvsBdDdMKAYdZ6jQGD+xQF
	/VEDgtgbKwmmwwjmPT4E5s5qEsZdczSM2isQnI5YGQhOjiCwD84RMOgtR1B7pomGYfMYDW/8
	90mwmAII6gb6SLjiCyN4WnWVhK7BRfAwOkpDm+k3Gl65aLD94qGgxlqNIPLIQ0Dzk+sMdA7P
	ENBrribA4d4K/fYIBssQDebLy8BqKSUWxnMCTBdvEBC3X2Dgbn0vBqu/i4KZgXSYt+WCz/GM
	gb7jJgzuntsInBUREuqOnsXQ4mnDYJidQNB1/Q8aKlxXKQg75ykoscYoCHg7KHjgCGC49CxE
	QIfvDobH/uMMNAQ7CRh4EqKyVELsSCUWnH86kTDRUEoKN0dGSaGsqUho6BihheloNy14Jm1Y
	aD/DC7/704Tm032MUPbPI0awuQuEslsvKaGpca1Q3zJEbEv/TrJZJWrUhaJuw9e7JdlD4Siz
	r+fD4lDjFC5B9sVGlMTyXAbfEgyQ7/lS3Me8ZZpbzYdC8YRP4T7hm45FKCOSsCTXtZIvj1cm
	giWcirffq8FGxLKYS+Wbffq3Wsp9zp98fYV+17mSd7i8ifWkBW8KTidYxn3G1xpjiU6eO5fE
	T/1ahd8dLOf/bQzhKiS1oQ8uIJlaW5ijVGsy1mfrteri9d/n5rjRwrvZf5rZ+Td6HdjRijgW
	yZOl3qJ0tYxSFubpc1oRz5LyFOmIZqNaJlUp9QdEXa5CV6AR81rRxyyWL5NumixSybgflPni
	XlHcJ+repwSbtKIEaeSzmabxms0BY9aitjChX1KtYApXGRffmKoNX660tLXXRCydqzLxU+rh
	9HLfXz/O7E7dEduzZVpa/Lj0mzVfKoKtTkcwLXnXAf/Pn55Yd6e7qHHXhlEmy6Xdc02/Zani
	+erz9fnHcj66mHzwqwLJ3Bffbl+j6KnDB83zD2h9PP/FmBznZSvT15K6POX/WY+VV2oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+917d+/daHlbhpciqkX2oCyjx4keFEReAsP+igqqpZe8OR9t
	Zi6QfLQ0rdDR5mOapjlizpzOLIuVGK2sNM1Ke6gJayVqlrpsU7Np9M/hc77f7zmcPw6Ny+6K
	FtBCTDyvilEo5aSEkOzflrY2Ln2DsD43KwAytOfhU49TBO9SGghwj2YQUFhlIWHSeJeCjJp8
	ETzrSCWg9XYFgh53BoKxcSMO2vopAiZ1DgpGPR8p0KcgmLI7EBjadDh0tj7CwVKbgsGI9Q8J
	/Y+HEeh7nSTk9qUQMGS6jKDAZaSg70kIDPY8EMFU11cMOn4NIDA5/2DgbEhHMGmIguJSm2/c
	8IOE8eZXOOTqWxHc6O3CYbjvM4JaRzcC+61UEr5k38Gh3TkH3riHSGjSZ5Ew2FaIwXcrCSWp
	dhG0vexHUGTUIXB9sGOQVlZFgqGohoD6z/cpaOufwOCTQYdBRU0o9JhcBLzILsV85/pS1QFg
	zE3DfOUbBvrKBxh4TGZqVznixrRXCc5sq8M47etJkrNctyBu3KtD3Gh5Gs5ps33t44EhnLtg
	O8uVvxggOa/7LcnZf5UQ3PNSlrt5yYtxOc1rufqCLips92HJ9gheKSTwqnU7j0si+7rdVNz7
	uYmdt34Tycjkl4nENMtsZKs8DmqaSWYF29npwafZn1nC2q64RJlIQuNM+2I23XN1xpjHRLCm
	liIiE9E0wSxn6x2aaVnKbGbzhmvJfzsXsxXWhpm42KfrO7wzLGM2scWZY6JsJClBs8zIX4hJ
	iFYIyk1B6qhITYyQGBQeG12DfO9kSprIuYdG20MaEUMj+Wxpw9lgQSZSJKg10Y2IpXG5v3RA
	uV6QSSMUmnO8KvaY6oySVzeihTQhD5DuO8gflzEnFfF8FM/H8ar/LkaLFySjL55lR7ZuuCKU
	lacHrqneYd4bbo2ra1ZHBm9ctNI4MrIk9obtdeCBE3cIb/TSM6/E+b3m+WM22JNFhlq767wW
	vNFVXfkw/MJqy9O8WfzPU4eSjHmV/n7B7YqtfmLu2rvAFWEtCckX4+cmy6L42+otv1tWpR4d
	CStLDNEUnG6amN8hJ9SRiuDVuEqt+Avo2QhdSgMAAA==
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
index ebfc781c3095..9389fc859129 100644
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


