Return-Path: <linux-fsdevel+bounces-63231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F8BB2F2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E0B42616B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC822F83AC;
	Thu,  2 Oct 2025 08:13:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366E2F3C34;
	Thu,  2 Oct 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392820; cv=none; b=Pkf7GpbORIXJF5yh11v7OKQRnMw+N38773TQnVnzpVPDizjVFjEtjgHEtf3eojAh9cCfX+hkYVIjaB+xLl+dKyvLs8ocbSUVZ8UnFAd/tf/i8lLZUcy/Vy9ykhCuHHkMNZoe9VGewgVFRA1bMxqRVTrSmy0YOHyW8gdGRYrwCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392820; c=relaxed/simple;
	bh=+bd9WiorYKiALUTe/ZE9Twmt5uX3p97amk10CfbvR3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=odNafNQCRTvAkHVPj/sUTSSosyxOd00/SwAZgRxujrhh61D4q4b8xMjZVJATWHGrcQdVzYPUEPFGGFbbxTtyU6qwDSmEz0fc9mwr9A0ujXv+tSpdAE/APHLhkomHRvKpwN7qZ786tea9ow3DwW4SLbKJGEjp6w6u+uLsDEIZYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-4f-68de340e0c3a
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
Subject: [PATCH v17 16/47] dept: apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
Date: Thu,  2 Oct 2025 17:12:16 +0900
Message-Id: <20251002081247.51255-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+937u3d3w9FtSt6szBZmSG+sTm+poEugBRFBETXy4kY6ZT7K
	oLDaTC3Llq3anE4tW2lpU3pYmpkavWBaLYupiTHNspG19dCsTemfw4fP+X7PX4chZSeoEEal
	ThU0akWCnJZgyWBAybyJUV3Khe32SeA40ojB8z0bw49hEwm6u38x/K1vRWBo05PwsWUjlH8Y
	JaC4tIaGkp5OEmpbuxC88rhpMJv0CI6VVdFgMNswOA16AipsMWC4GQxPuhwUfHLpabC9bUGQ
	XefBUJJ1CcPFIicN9+ufYHhZV0hDpukHBe0VdgzlHrcIrF/PU+B6nUVAtdYogqxvoxQ8zmsk
	4PL3LyQ4Tw1gaMh+T0Bz1W2fsw5S0Gc0E3C23UKDQ19Mw5DZ1zg3kk3DkW/dCLTOJXD9jwOB
	qaVLFL2QryyqRLwu3zcefXaTvLZmP//b85rm670WzD8t5fgzL+bxd42dIl7b8E7EW2xpvLZ5
	kOJrrJF82f2PBG+7lkPzuYOviC2hOySr4oQEVbqgWbBmj0RZ+zwHJXczB8rsVWQm6qZzkZjh
	2CiuzTPkY2aMj1uX+TXNRnAdHb9IPwexYVxNnovyM8k+m8Y52ub6OZDdxekrdWNnMBvO9Z7s
	GctL2aVcXYEZjZ+fwVVUN455sc+/7HmG/Sxjl3A6t5bIRRJfxiTmBiz3iPHCFO6htQPnI6kF
	TbiGZCp1eqJClRA1X5mhVh2Yvzcp0YZ8L1J+aGTnHTRk39qEWAbJA6T28E6ljFKkp2QkNiGO
	IeVB0j1Wp1ImjVNkHBQ0Sbs1aQlCShOaymB5sHSxd3+cjI1XpAr7BCFZ0PzfEow4JBMtXb8h
	YnJLbUxphHpz7aN1s1em2t60Bj7oXX9BGiYifnvD4s//NBhjY71RZZtjt+esKud2ykZvqE7S
	+a6CkSnS5qt431rd6tiAvH7H8vDp4lt90TN7ZxhuNxCbZh2++pQ8GlR5OnJxYcaV+ORQkXeb
	O62/Z3SFaziueG3VsHGInMPIcYpSsSiS1KQo/gFuqG19HgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+59zds5xNDmtVQcNioEU0TRB66UbRR88diMisQLJkYc2dGpb
	WQaRt6Gp1VpNyal5wTXm0qWz0poto1GZ6LJ7zrUyU9KE0sTU1hb05eH3XD68H14aF7cJwmhl
	+glenS5Pk5JCQrh3U74sNGZQsc55Qwavc50ETE0WEVDZbCWhqOWaAPqaGhF4p4oQTM8acdC2
	+wmY17somJz5QIHf4UJQ5tbjYLXnYvDT9oeEb49+IDD4hkgoH80lYMJUiqBi2EjB6OM4GPfe
	E4Df8xWDN7/GEJiG/mAw5CxEMF+WCtfrWkmY7enFodzQh6DW58FhxBYo7a5BBA5zHglfdG04
	9A+FwsupCRKeGkpIGHdXYvDdRkJNnkMAVUY9gvz6ZhLKqloIaP/YQYH72xwGA2V6DBpb9oDX
	NExAt64OC9wXWN1aBsbyfCwgIxgYbt7DYMZkoeB5/QABppwIMPb0C+CTuYKCOV80+GsywNX4
	lQLPJQMBTeO9gm0GxE1rLxKcpfU2xmlfzJOctdqKuNnfesRNNuTjnFYXsI/GJnCuoPUU19A9
	RnK/p16RnONXDcE9q2O5yz0yrr3CQ3EFne+pfRsPCzen8GnKLF4dtTVZqLA/P48yvfTp+r5m
	PAd5yWJE0ywTwxaaNxSjEJpkVrFv387gQZYwK9nWC8OCIONM93L2tXttkBczSazeqiWDTDAR
	7OdS37+9iFnPdlytQkFmmRVso835Lw8J5P2+biLIYiaW1U4UYDokrEELLEiiTM9SyZVpsZGa
	VEV2uvJ05NEMVQsKPJPp7Nzlu2iyP64LMTSSLhS5IzwKsUCepclWdSGWxqUSUbJ5QCEWpciz
	z/DqjCPqk2m8pguF04R0mWhnIp8sZo7JT/CpPJ/Jq/+3GB0SloOM00W+ut17u5J20bV84uj+
	a3cyYw/cP2TfUbxjT/aWqw7ZlYfhlD8ylI2yZfZ9rE2wrB7RbTansIna49VgOTUrOVfsrN8U
	vztsrWyJ6pk9PtnhStoWE/IkwoDbHqCDul1LNr56eXxR5868pdQxbvCdle2VnDerUhLGnDe3
	W9aXSAmNQh69Bldr5H8BWyT3Y0gDAAA=
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


