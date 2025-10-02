Return-Path: <linux-fsdevel+bounces-63246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D715BB31E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B957C4C5F8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B93148C0;
	Thu,  2 Oct 2025 08:14:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403030F522;
	Thu,  2 Oct 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392846; cv=none; b=YzBjjIZ/dqyyh3mUbw8pJaonlOiueK6e2UG72i3JL8znCOd+edBI7GYSN8WnT157t3ASiOhXS0ytvzynpAOONMh19OFGqmHbbNBoPimS2cJ/HKsYJRzzhQegMpBzEusjh2FrYUlLUFoEhM4QfIbdTxarGmZJD8tEfYiE3AOaMss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392846; c=relaxed/simple;
	bh=bAY3rt6aKAGfMJPQINH+hMkC8sTc5M1WU32fGvq/Um8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=S9Eh/D1A3j3aH5Pfq/SB30nG/EX28pr9+g5CaB20ohHHXSgDTMPDYOEcaathAUg0z2Ws/JIa3/bhK2aRvGdX3U/tzy4GaeRzzs4uoALLW87ieaqnm+T1FhdRQDDshera3DplWT3pHMokyE4HidpW6dn/tSAVQQ2lr7A5EqsKhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-a2-68de3413df26
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
Subject: [PATCH v17 34/47] dept: make dept stop from working on debug_locks_off()
Date: Thu,  2 Oct 2025 17:12:34 +0900
Message-Id: <20251002081247.51255-35-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5+7q9VpSp0uUC1E0NQuGm8UFV1PUVHYh7Akhx7aSmfNS1oU
	s7KW2U3y7nQmzuGWyVZpXnLaHZPUlUneck2zdAmlomUXZ/Ttx/P+nufTy+CSy+R8RqGMEVRK
	WYSUEhEi54wCX/eALvnyjzYfaCo1Iuge0SAYHm+nwXQvEYOMz4kEDOlTEGT35dDg7K4i4U/n
	Jwz0jt8YOKyXEBT0dOJgc8wEbU4qgvOFdylI15oJaB6YwMBo3g3j+hIa7IZsGiZ6VkCp8zUJ
	L7taSRjoS6Wg+/lFEsrVH2jQVI4QkJXXQUF1zUsCnlXYMbBV5lKQUnafhBZjEwFF75oxsDS+
	wuHO19sUDIzqcWix6jBIrCsk4H5tEgKzqZWCT9laDB6PDGJgv+ak4efY5MrXG8Mk5Dztojf6
	80ktvyjelGdC/OPBIZwvahik+JpRHcHfbPTlH2Z30rzOHMtbDN58YfVnjDeXXKb4ZOcbjH+R
	+ZPgC9RpOF+rNdF8vyUL7Z0TLFoXLkQo4gSV//pQkdx6pZg+3iOO77A4CDXSTk9GbgzHBnAX
	3n/HkxEzxbcaz7piivXi2trGcRd7sIs5y9U+0sU427CQa21e5mJ3dh93Lql4yiFYT+6Jxk65
	WMyu5todWuLf/CLOWGadctwmc1tPw1QuYQO5pKELWDISTToZblyaugr7V5jH1RnaiBtIrEPT
	SpBEoYyLlCkiAvzkCUpFvF9YVKQZTT6I/szEwQr0rSmoHrEMks4QN3l2yiWkLC46IbIecQwu
	9RCHGjrkEnG4LOGUoIo6rIqNEKLr0QKGkM4Vrxw9GS5hj8hihGOCcFxQ/b9ijNt8NULz1Jvw
	tUFRsVtz25fs4LZXpl9VfQnZfDo1X7QnqNB7TX9br9WjVzG2YffamSdMs7YZf4QG2FM70J7Z
	AwYfL7/9KZqjIe6KU4EH5uy69qAiMNeoLP821m4sHa30ZzRzdaqG/OBVw2cs03JjDqGgdNvO
	Ldd/jYSdtr19lJe2CTKnL5US0XLZCm9cFS37C+jR00EcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe895z8XV6rCkDhkVAwvCLoLVg0VlBDsURX0pKCiXHdrQTdnM
	MjK8jUZXG82lyzSlZc5sbRqZLIapUMtq2Y3cssnSIk0qp3hvE/ry8Hv+/9+H58PDkrImagmr
	1maLOq0yQ05LsGTv5qI1C5O+qNa7nAg+FHgwhIeNGG4+qKfB6Cyj4E2DHUFP2IhgdMJKgqF5
	BsOUqYOB4bFuBmbcHQhKfSYS6hsLCPjrmKbh57M/CMzBEA2WHwUYhmyXEJT3WRn40a6AwZ4W
	CmYC/QR8HBlAYAtNExDynEcwVZoOldUuGiY6X5NgMb9BcDsYIOG7I1I2dnxB4K4tpOFbSRMJ
	XaH58C48RMNz80UaBn03CfjloKGq0E1BhdWEoKjmAQ2lFU4MzV+fMOD7OUmAv9REgN25B3ps
	fRi8JdVE5L6I9XAxWC1FRGR8J8B8v4WAMVsdAy9r/Bhs+fFg7eyioLe2nIHJYCLMVGVCh72f
	gcBVM4aGwdfUdjMSRg1XsFDnekQIhrdTtFB/qx4JE+MmJAzfKSIFQ0lkfTYwRArFrlPCHe8A
	LYyH39OCe6QKCy+qeeFa5xqhuTzACMVPPzP7kg9JthwXM9Q5om7d1lSJynPxLpMVlJ72u0I4
	H1XMvYBYlueS+Oud5y6gGJbmVvGfPo2RUY7lVvCuy31UlEnOu5T/4EuI8kJuP19ouDvrYC6e
	bzP20lGWchv57lAFjjLPLeftDs+sExPJu4Le2VzGbeANQ8VECZJUoTl1KFatzdEo1Rkb1urT
	Vbla9em1aZkaJ4o8ky1v8tpjNNylaEUci+TzpL74gEpGKXP0uZpWxLOkPFaaWutXyaTHlbln
	RF3mUd3JDFHfiuJYLF8s3XVQTJVxJ5TZYrooZom6/y3BxizJR0nSrBtUYtmxmuq9Z/ms5MxN
	Sbf+7Fi5uXLr/jafc/e6e764w+N2g/Js3rJ34ZY0rX2uX73AO7LzkC/71cdFB47UNDnyfo+2
	pban9bu6yZ0ewz5NwhNLXErOHk69zd/ubhKTKXNjg+bF1GBIobAqDqeEUhIsKyrxdG/ZSd08
	4xY51quUiatJnV75DxGTf51IAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

For many reasons, debug_locks_off() is called to stop lock debuging
feature e.g. on panic().  dept should also stop it in the conditions.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 2 ++
 kernel/dependency/dept.c | 6 ++++++
 lib/debug_locks.c        | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 8b4d97fc4627..b164f74e86e5 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -390,6 +390,7 @@ struct dept_ext_wgen {
 	unsigned int wgen;
 };
 
+extern void dept_stop_emerg(void);
 extern void dept_on(void);
 extern void dept_off(void);
 extern void dept_init(void);
@@ -442,6 +443,7 @@ struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 
+#define dept_stop_emerg()				do { } while (0)
 #define dept_on()					do { } while (0)
 #define dept_off()					do { } while (0)
 #define dept_init()					do { } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index a0eb4b108de0..1de61306418b 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -187,6 +187,12 @@ static void dept_unlock(void)
 	arch_spin_unlock(&dept_spin);
 }
 
+void dept_stop_emerg(void)
+{
+	WRITE_ONCE(dept_stop, 1);
+}
+EXPORT_SYMBOL_GPL(dept_stop_emerg);
+
 enum bfs_ret {
 	BFS_CONTINUE,
 	BFS_DONE,
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index a75ee30b77cb..14a965914a8f 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
  */
 int debug_locks_off(void)
 {
+	dept_stop_emerg();
+
 	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {
 			console_verbose();
-- 
2.17.1


