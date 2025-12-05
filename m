Return-Path: <linux-fsdevel+bounces-70774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF2FCA6C79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 045EB36F9A92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F031A046;
	Fri,  5 Dec 2025 07:20:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533C127B32B;
	Fri,  5 Dec 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919217; cv=none; b=urxxz8hRfGqhGxOpTVFHINdipH8bJb0/+ZwVrZd8f+o8sxvGxz9oqqjPNf60TJeDdiuS14DuBXqHO63u47hcmZOuuTQd3sQpOSHfTyux8R8RFvpRkx7wZ6R2rgIqEcv4ulKLhCQHm4bdwp6kYdnf+x6XkCDEbZk26IxScUXfVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919217; c=relaxed/simple;
	bh=Nq6eF1vNPqQexxbO5CbSo0SEOxl3ixoZ4tUAk3fFOuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ol9EO87W9Dyueebuo/GF7oXZvXqJHtBbEZP8gXZQwb231VB4Zvbgd7CaTbdg4JTxYeNN5aqbkirNCN0J23dcFFxWDruofXLGQEQhVSehZ9hl+4dVs+dZ7AAE2qlk2Bx5v0XuQqe8cgtVEvKetBycXYfIJcIPJL3jI0uLXXCbEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-e1-6932876e7ac8
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
Subject: [PATCH v18 16/42] dept: apply timeout consideration to wait_for_completion()/complete()
Date: Fri,  5 Dec 2025 16:18:29 +0900
Message-Id: <20251205071855.72743-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH99z73Odeqt1uKolXZ8TUuCXEVxRzTNSZmOiNidFo/LDtAzb0
	Ko2lmFaxLHESXrQDFNKkGq1isdIg1MLaOAGpImoDAWIBkQpUQFkdlophrQYmsoLx2y/n/z+/
	8+VwtGKAWcppdCckvU6lVRIZlkUW3liTdS5Fs763hYCp8AxcrXUSmLHeZaG1Lw+D31WDYChm
	QjBj9rEQnRpgYdbrQ3Cxy0xD+NEkAsvIKIGxJ7shMnSPgdngGwoco58puGTxI6gYCdLgrcoj
	8HfZHRp6Rr+FZ7EJAm2WYgKRrqsUvKsjYMvzMpBvryXQMNzIQlf4EwWDF80UDDlCGNrLbsRt
	YwQst+9RMOWoZqHDPojBkbsKrJ098Zu2LAiWWjC4Ik8ZCIfMBNwvniCIPhuhwFkSosHUGMPg
	fv2cgYqzNzFcLh8k0ORtw2CaiSLw1b+ioKTuDgMvnbMM5Fo/MuBvbmegu8aPofZNgIJ2XyuG
	tiu3MAx0lrJQ2ddFwchwgAFPZwe9Qy1We/6ixMLuGSI6y51I/G/ajMTK9nEiTsd6iej9YMNi
	w5UgKxbc72dFm/uk6KlKFu1NY5RYMRljxP7wNtFd/QcR3ZNmdn/yL7KtakmryZb067YflmX0
	DvbTx8tlxptvzzK5aJgrQgmcwG8S/skbJ1/5WvQFNceE/1EIBKboOU7kVwie8yGmCMk4mu9J
	Es5NXYgHHLeIPyy0XsiZ62B+lVDzuI6ZYzm/WQiUnqe/OJOEmrrmeU6Izy190/Os4FOF60Uf
	550Cb08Q7MUN7JeFJcLDqgAuQ3Ib+qYaKTS67EyVRrtpbUaOTmNcm56V6Ubxl3Oc/vRrPZr0
	H2xBPIeUC+XNpzZoFIwq25CT2YIEjlYmyse16zUKuVqV85ukz0rTn9RKhhb0PYeVi+UpH06p
	FfxR1QnpmCQdl/RfU4pLWJqL9rkPXU5vKpbtdD3Ubbf+m7S6Mc2ff9sFPb+n9jb/rC9ID6wu
	WjBd37HLsHcPtyx1wRGb3yh1Py1xQdpR2XezG0u2+cqsKWx4Y3DlD6FDf74v1jZMLL5UufyM
	vak+al9S8PbglmPG16nGRTsjhWrPZ+dPdw9M5N+yREy6B62ZNpyoxIYM1YZkWm9Q/Q8PHm8w
	bgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93XrqPFbQnd6o9qIUFQaWQcSHpA1CVIrH+ioHLYRa/OKZv5
	iKLpWpqlzcVmNl9ZrnJW01lmslxa9rCH02xW2qyWZVqLmpma2TT65/A55/s9X84fh8al9eR8
	WlCm8CqlXCGjxIQ4cq12uTJ7lRD61DAPcnRHoMfjJeFFppOAYX8OAcXXqimYMNeLIKe2iIQH
	7iwC2q9aEXiGcxCMjJtx0DVMEjBhaBWBf/S1CIyZCCYdrQhMLgMO3e1NOFTXZWLww/aHgsGW
	7wiMb70UFA5kEuCznERwtt8sgoF7W+CLp5GEyd6PGLh/DiGweP9g4HVmI5gwJUBZhT2wbvpG
	wfiTZzgUGtsRnHvbi8P3gT4Eda1vEDguZVHwQX8dh07vLHg+7KPgofEEBV9cxRh8tVFQnuUg
	wfV4EEGJ2YCg/5UDA+35axSYSmoJaOi7JQLX4G8MekwGDKy128Bj6SegTV+BBc4NuGrmgrlQ
	iwXKJwyMVxoxGLVUiTZUIm5El09wVfYbGKfrmKC46tJqxI2PGRDnr9TinE4faFuGfDh31J7G
	VbYNUdzYcBfFOX6WE9yjCpa7cHwM4wqeLOcazvaKojbuFkfs5xVCKq9auS5aHNfV8wpPLhWn
	X/h8jNSgPjoXBdEss5ot8b/EpphilrLd3aP4FAczi1h7Xj+Zi8Q0znQuZLNH8wMCTc9hotkH
	+RlTHoIJYa13beQUS5g1bPepPPxf5kLWanNOc1BgbnSPTbOUCWfLckdIPRKXoxlVKFhQpibK
	BUX4CnVCXIZSSF8Rk5RYiwLvZDn8u+Am8nduaUYMjWQzJc60MEFKylPVGYnNiKVxWbBkSBEq
	SCX75RkHeVXSPtUBBa9uRgtoQjZXsnUnHy1lYuUpfALPJ/Oq/ypGB83XIL0trT5kvXWv6ODH
	hiVr3Z8bYzwtJcW466L2pSYiZEfK7HTFndPG2aXqmDKNIdxZ0bQp4he2/Yz7+LLQPfGCfXuU
	72K0Ul30zk0cbvt12dcR39Vb5IsdrA+r/LGYVu1qr7kdaytnNGWTMasjD73XdXSYFiXd78pL
	Dt2rzzdt3kfLCHWcPGwZrlLL/wK3saJPSgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 4 ++--
 kernel/sched/completion.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bd2c207481d6..3200b741de28 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -41,9 +41,9 @@ do {							\
  */
 #define init_completion_map(x, m) init_completion(x)
 
-static inline void complete_acquire(struct completion *x)
+static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start(&x->dmap);
+	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 19ee702273c0..5e45a60ff7b3 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -115,7 +115,7 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	complete_acquire(x);
+	complete_acquire(x, timeout);
 
 	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-- 
2.17.1


