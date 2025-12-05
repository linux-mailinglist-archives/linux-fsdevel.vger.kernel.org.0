Return-Path: <linux-fsdevel+bounces-70771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D5CA6B83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFBFC366688D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0802731326F;
	Fri,  5 Dec 2025 07:20:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A5C205AB6;
	Fri,  5 Dec 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919191; cv=none; b=jWAo3oX9Dsy0Xm//luAQXqFwUUkKE5nR1v3pVwxiLhxeTC7qdZoVvgZIn8Ey/ckcZ12PPK1SjSMrBzxj0511/sLkY0H3bgAld6Ai9xq3SrLpR/pfvrh5WxoymzRhjG1/lLeEHc4pDSQb2DzMEaF4TFeVeip0M/pSh61JxGS0SXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919191; c=relaxed/simple;
	bh=+bd9WiorYKiALUTe/ZE9Twmt5uX3p97amk10CfbvR3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WrbeZAu712HddTLkOUMAFTQZ4/yx6TARpcNZlMlpNK5WazizbRVSqy+gYWkK0/terwtJMrLSbmjLDbClEMMEC8Kcx+yjJWROo9s6QD/NFB3owoYkDqGzuo+O6iJCSk23TWdsun0prUKHTCnXW72+nX4l0L0Y87H9tHtOdMM2b4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-83-6932876ddb02
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
Subject: [PATCH v18 13/42] dept: apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
Date: Fri,  5 Dec 2025 16:18:26 +0900
Message-Id: <20251205071855.72743-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxjF+d/7v7e3jc1uKpE7XObSxJloYGDUPDHLZvjC30XNkn3Y4jK3
	Rq7jhlJMQV6cc0DQKuJkTdplFKEg6RCqvNaXabOKGw7UWQSlmpYrWqsdIIZYGC9dV7r57Zdz
	nnNyPjwcrXnApHKSoUg0GnR6LavCqqkVTWkG00Ypo8ulAb8cZOB+hQdD5NUxDPUdThaitosK
	+GO0EoP3fDsCOXIMwdyijYYjl2MYouZ+BVgqEMTc/QisQ2YafN5fabCMB1n4MVyBYdpRgyD8
	ezZMyVcYiAWeUTA6O4nAEfyHgqDHhCBqzYMJ68v4vcWLoGk8QMNM+BGC3v4xBO7WShae1rpo
	GIlMszBgOcHC1FA9BfZKNwNDtyYQnLaZEYQeuikYmliiwG81U9DevRNkRwjHN7Bg7UqBeUeb
	Ahzla8F2e5iBx611CojZCyBwyoJhYOw+A/KNowy8GhmnwFkToqH7SVxrOtqC4acGPwtX3QMY
	ajpdDIw5Ywx4PTcZuNvujWfrzuJtOaSt5wJFjtyNssTZ4ERkccGMyPXJaZpU9ZSQhcg9lrhn
	7ZgMNguk5fgCRX64nUYu1wUUxN59gFT9NsWQntb15MzVMPVx2m7V+zmiXioWje998JUqt/fW
	cbRf5krPeDvociSz1UjJCfwm4emVCH7N/sBJxTKz/DrB55unlzmZf0foORliqpGKo/nhNYJp
	/vuEsZL/QmgYvZMIY36tEPKdoJZZzW8Rzi3+rPivdI3Q3ulJ3CvjumV0IcEafrPQWD2XKBX4
	RqUw9+ez/1e8KVxr9eFapLajpDakkQzF+TpJvyk9t8wglabvLcjvRvGHc3y79PklNOP9pA/x
	HNKuUHtKMiUNoysuLMvvQwJHa5PVk/oMSaPO0ZUdFI0FXxoP6MXCPrSaw9oU9cbZkhwN/7Wu
	SMwTxf2i8bVLccrUclSbfTYpMPaZNLiq0fR81V+d2/2KzI7gp+7ISGXR7lQmZZ/cZdsVOpS1
	JevOu65oxNT8Vl991fZB5R77hplS9brnN/YxycUkb+cv32nl7GvOb5IebN2w+cWON0oyhve4
	9ubPfpRuzj3sGPxwl1nz9k25a6Al6WBec1Fv1qPw6a3J1/9e0uLCXF3metpYqPsX41p+/mwD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+917d+91ubithZeKFoMIAi2l5EQPKigvvZCCgiBy5CUvTqtt
	+Sgi3Vqaqelgk1qlaa7wkeajshoNI+lhumXlKNe01kycGTYTt8ym0T+Hzznf7/ly/jg0Ln0g
	WkQL6Vpena5UKUgxId6zXh+dlhcnrG4PrYB8w1no83hF8D7XTsB4IJ+Aqw11JExZ7lOQ33RZ
	BM97dQQ47tQi8IznI5gIWXAwtE0TMGXsoCAw+ZECUy6CaVsHArPTiIPL8QSHupZcDH42/iFh
	+OkYAtOAl4SyoVwCRq2FCK74LBQMPUuAEc8jEUy7BzHo/eVHYPX+wcBrz0MwZU6F8srm8Lr5
	Bwmh1904lJkcCG4MuHEYG+pH0NLxCYHtto6EryWtOPR458Hb8VESXpgukjDivIrB90YSKnQ2
	ETg7hxFcsxgR+D7YMNBXNZBgvtZEQFv/Qwqcw78x6DMbMaht2g0eq4+AVyWVWPjcsOtuFFjK
	9Fi4fMPAVP8Ig0lrDbW5GnEThmKCq2m+h3GGN1MkV3e9DnGhoBFxgWo9zhlKwu1T/yjOnWvO
	5Kpf+UkuOP6O5Gy/KgjuZSXL3bwQxLjS19Fc2xU3lbjloHhDMq8SMnj1qk1J4pSWzgvouIfO
	qnI04DnIQxagCJpl1rB97iJqhklmBetyTeIzLGOWsc1FPlEBEtM40yNn8yaLZ4UFzCH2em83
	McMEs5z1uS5iMyxh4tn60C3qX6icrW20z/ojwnNTb3CWpcxatrxgQlSCxBVoTg2SCekZaUpB
	tTZGk5qSnS5kxRw5ltaEwv9kPfO79AEK9CS0I4ZGikiJPTNWkIqUGZrstHbE0rhCJvGrVgtS
	SbIy+xSvPnZYfVLFa9rRYppQREl2HOCTpMxRpZZP5fnjvPq/itERi3LQ6a7WpdHnE8c+j50s
	Ly4U9nbFc8MbLer4wcZCR0DsXyr0lC5ftemElnHmZCXEF408s8fN10s2xAYLd92IXJLhWqM7
	pXJWyEN7Ytw6uvTS462R3+7VLJvQFuMyy8G5+5OGMnfK1x2R7/sZyospd50t2KaVtQ3WH+7M
	jOv/st2YuFBBaFKUsStxtUb5FyE0OqdLAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by hashed-waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 9e29d79fc790..179a616ad245 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -6,6 +6,7 @@
  * Linux wait-bit related types and methods:
  */
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 
 struct wait_bit_key {
 	unsigned long		*flags;
@@ -257,6 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
+	sdt_might_sleep_start(NULL);					\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
@@ -274,6 +276,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 		cmd;							\
 	}								\
 	finish_wait(__wq_head, &__wbq_entry.wq_entry);			\
+	sdt_might_sleep_end();						\
 __out:	__ret;								\
 })
 
-- 
2.17.1


