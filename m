Return-Path: <linux-fsdevel+bounces-63259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CE9BB3228
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A00188C63F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6706E31B13F;
	Thu,  2 Oct 2025 08:14:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA83126C4;
	Thu,  2 Oct 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392857; cv=none; b=gipc70xUmmCH2U7MGBVcZtcQrtdZlv2CVxHdRsH7wXQZdOkgT61dg814AqmSUkPqRoU95kzFYbHGlXpyVkTCT2hhIzMvqDBKpflA2v4KiP0F1f2SOW2YExgO9ZpbmtkGGb6zmZ7uORy79G/2iXFn3HI4hWimf0vJ4+L/fV/EUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392857; c=relaxed/simple;
	bh=Maxqvp8M2/Mbhj5qDNZmaX54vuIa2E/KjRgY0LGmkyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ebxvb2q40nYY6zZgawJQ9xP5KUNmG1tvLAdzZD8aSojXRkuCebS5s0E4bSgIT6Sg9HlnauGya4B1joSTUVfkGa3ZrUMFx0OHcnMjfw+ra0ZiUDCt4kx5mx6p+NvojmrWcA4c4AYTegAmiED0+t/sDv8m6gfeieWsyPeVdliTBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-95-68de341581f1
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
Subject: [PATCH v17 42/47] dept: call dept_hardirqs_off() in local_irq_*() regardless of irq state
Date: Thu,  2 Oct 2025 17:12:42 +0900
Message-Id: <20251002081247.51255-43-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxjHed9z6Wmh7FDdPOqMpAma6IY31GeZm8vi5XxZYjKzeYta5cQ2
	3FwLCE6TgqtDA7M2sUbKEKirXalaW2AodqkoKDbGVgxjysVOrBroGitCOihdwfjlyS+///95
	Pj0MIfuLmseo8gsFdb4iV05LSEkopf7TD7MGlMvbWj+HnjIPCTVX7DT4LjciGHxbgWB8wkSA
	7lqchJihUwSj0SciiLs7ERj9BgLsTWUY3jimaBi+FUEQtlQiqA6aRPCqYzOEBtsosAxNYRjy
	/IwgZsyB8w0uGibuPyDgpSOhmjoHELit5TQ81zcT0D2UCiF/DYZ/HTTUlbspOGa+QoN/eBJD
	n9GAodH5DQxagiR49Q0YjFfngOnsMZwYLzGcudSGIWqxicCizQDT/W4K/rFWi2AysALidQVw
	OfSAgq6BHgoG7xyn4A/tUxE4/+5AMPoogMFeGSTA+SyRnqvto+GGu4uEitgogu7rNTRUOpop
	GLDHKdCaxinwebwUPGz0kdBV/Tv5VTY/rvuF5G2uFszrHsZo3l5rR/zEfwbE6/QJujUSJvjf
	vCM0f6+B469V94v4OmcR77Iu4c03XmG+PvKW4h8Pf8E7bSfoLZk7JOuyhVxVsaBe9uVeiTLu
	aaIOln1QomuLkFoUSj6JxAzHZnHmC0bRe669GKammWYXc729UWKaZ7PpnKsqOOMJ1vsx1+P/
	5CRimFnsPs4WUE5rks3gzJdCM3Upu4a7fecZfndyIdfo8Mx4ccJ3B7zkNMvY1Zwu/FOiI0l0
	Loq5532niHcLc7mb1l5Sj6R1KMmGZKr84jyFKjcrU1maryrJ3F+Q50SJd7McndzZiiK+b9sR
	yyB5itSX0a+UUYpiTWleO+IYQj5butfap5RJsxWlhwV1wR51Ua6gaUfzGVI+R7py7FC2jD2g
	KBRyBOGgoH6fYkY8T4vmBr67voH5vkMZPv1DC/rxTdqmVdvd9bX3xrA3WvokLTl6xBaQrhX0
	mrztG2Wfra+v+tqflRr3nygsutvsxynlI4t3Gla/2Pxrk2SR5KmcWLCyWByTuyq2JbUGx460
	XK2ZSt/9UU7Va3e/+c9IWtJQ8rpU5Ce3Hj+0dNsILtmVkyYnNUrFiiWEWqP4H3kUzzhqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0xTaRSF/c/5z4WOlTMdMp4oidqEkMwgagJmZ2qMzosnRo0ao4kvUvA4
	rdxMiwwYTbg1EEaUNrZEqlghFqSACGjEWiSg9YIItSPgQGWqHbxArVGQIIVOwfiys/a3VnbW
	w2ZJ2Q1qBavOyBI1Gco0OS3Bkl2KwrVRCS9V659bEmEgvxPD1GQJhgvXGmgoaTlPQX+TDcHo
	VAmC6VkzCbr2EIY5g5OByZlhBkIOJwKTy0BCQ1s+AZ+b52kY7/6EwOj10VDxLh9DwHoaQeWY
	mYF397eBf9ROQcjzhoDBLxMIrL55AnydxQjmTKlwqbqVhtnePhIqjP0ILns9JLxtDpttzpcI
	HHUFNPxXfoMEt28Z/D0VoOGR8S8a/K4LBHxopsFS4KDgotmAoLDmGg2miy0Y2v+9zYBrPEjA
	iMlAgK1lJ4xaxzD0lFcT4X7h1PXlYK4oJMLjLQHGRjsBM9Z6Bp7UjGCw5sWAuddNwau6SgaC
	3g0QsmSC0/aGAc9ZI4Ymfx+1xYiEad0ZLNS33iQE3bM5WmioakDC7FcDEiavFJKCrjy8dk8E
	SKGo9U/hSs8ELXydek4Lji8WLDyu5gV971qhvdLDCEUd/zC7fzso2XRYTFNni5p1m5MkqlBn
	G3UsPzJHZ/+E85D/h1IUwfJcAl9VG6AWNM3F8kNDM+SCjuJW861lY4uc5Hqi+QFXXCli2Z+4
	ZL7eq1rAmIvhaxr9i3Ept5G/9+A18e3kKt7W3LnII8Lc7e3BC1rGJfK6QBFRjiQWtKQeRakz
	stOV6rTEeG2qKjdDnROfkpnegsLPZD0V1N9Ck+5tXYhjkXyp1BXjUckoZbY2N70L8Swpj5Im
	1Y2oZNLDytwToibzkOZ4mqjtQitZLF8u3X5ATJJxfyizxFRRPCZqvrsEG7EiD+XK++ePDA25
	dt8sS0k5nfJsP467e3lHxL41YvKDvuBt51XFj47pO9EF9u2xOabk8TNPi4cteved4sFh/b5V
	8ZEKf+T10ljS1ntu696f4371lH2kqjpifFxAR++piHcpqj+4DO83js09VKjHT9b+3mTX9ye8
	aHwaLe4J7tVlzcQelWOtSrnhF1KjVf4P8xIkJkgDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

For dept to function properly, dept_task()->hardirqs_enabled must be set
correctly.  If it fails to set this value to false, for example, dept
may mistakenly think irq is still enabled even when it's not.

Do dept_hardirqs_off() regardless of irq state not to miss any
unexpected cases by any chance e.g. changes of the state by asm code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/irqflags.h | 14 ++++++++++++++
 kernel/dependency/dept.c |  1 +
 2 files changed, 15 insertions(+)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index d8b9cf093f83..586f5bad4da7 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -214,6 +214,13 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_disable();		\
 		if (!was_disabled)			\
 			trace_hardirqs_off();		\
+		/*					\
+		 * Just in case that C code has missed	\
+		 * trace_hardirqs_off() at the first	\
+		 * place e.g. disabling irq at asm code.\
+		 */					\
+		else					\
+			dept_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_save(flags)				\
@@ -221,6 +228,13 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_save(flags);		\
 		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_off();		\
+		/*					\
+		 * Just in case that C code has missed	\
+		 * trace_hardirqs_off() at the first	\
+		 * place e.g. disabling irq at asm code.\
+		 */					\
+		else					\
+			dept_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_restore(flags)			\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 0f4464657288..a17b185d6a6a 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2248,6 +2248,7 @@ void noinstr dept_hardirqs_off(void)
 	 */
 	dept_task()->hardirqs_enabled = false;
 }
+EXPORT_SYMBOL_GPL(dept_hardirqs_off);
 
 void noinstr dept_update_cxt(void)
 {
-- 
2.17.1


