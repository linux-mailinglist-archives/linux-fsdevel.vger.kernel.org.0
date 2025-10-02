Return-Path: <linux-fsdevel+bounces-63226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA0BB2E3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743D819E0C1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4322F1FE6;
	Thu,  2 Oct 2025 08:13:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F5C2EA475;
	Thu,  2 Oct 2025 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392813; cv=none; b=ZxrY7Z5NheMbTjteFYZdm2BulDv/lk2kRrP2199ct0b8mLKUNoJjWSpdOEfN0UZeloDBa9yd+r02Hp9xg3gtqudaeKQxJJ0Z73OAERrjyjBaoMBfAJ0SFcqxuer2b68E7Z+gp41AjDQcox8GFyrclqwGBK9MBdygn3MJEUQL+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392813; c=relaxed/simple;
	bh=OrmCL7AMrlriaPZyremlA931PaCPQXdxGExlE/vjDx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t9DZ8jbQEpPm7rsMWRRnLn8097djGEukSS5MqWYh1X9BdxTIstrwWRyvjP19DPl8x4hBRzGMxcn7B2pAOeM9++pe8P2v5McieClsJ5Dqx/pVJTP6I31IGENE2nrkoW1lCr1sjnTjJ8WTuC+fmrBizy9S2on8hwpFCDccVvUMllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-9c-68de340db706
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
Subject: [PATCH v17 12/47] dept: record the latest one out of consecutive waits of the same class
Date: Thu,  2 Oct 2025 17:12:12 +0900
Message-Id: <20251002081247.51255-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH++3+7mOzxW0Z3TQoBhJEWonJIUp6ENyoKIgiel/cpY18xDRz
	haS1qQ0te6ilKbN0LYswTTJzaJaVWrJpmdAerMwKndKmEx9F0/Cfw4fP+Z7z15chFPlkGKNJ
	ShW1SUKCkpJhmXd+ReSCGJd6bd6thTA2mothfKqUgNGJLzQU2a8T4K/5S0HxrywMI+Y8BF73
	CxL6W3IQ/Ck6BcWFNgQVHicBT9+4EAzXUGC6aCWhqKwWg31wWgIT5moapj3roN3VS0JFdiWG
	Jms7hp7GOxRklo6TYGvpJKH7oQ1D3Yf3BNwYHkAwGDATkPXyHgbL72ISBj5lS6BGX0KDrzKA
	Idv/l4TsyicSqLJ4SXg1NiSBDqefhhvdJgomnQ0k+MqCEUPeBA2F07kU1LeN05DldyPQO9ZD
	aZuL3ryWHzdcwbyh+w/FPyp/hHhDQXDo687yVZ1DFG8NmDDfcZfjn5c4ad5Ue4bXv/aS/L2m
	XxK+tvoyxRu9HyW8o7eJ4oe7uui9YYdkG1VigiZN1K6JOyFTv3CX4dPfQ9Jdpmt0JnotNSIp
	w7ExnPVbI5pj19UKcoYpdiXX1zdBzHAou4Kryx+Y9QTbuYzrta82IoZZxArcWK5uRmM2grO/
	K5iNyNlYzjVQQvx/uZx7WNMyy9Kg7/F04hlWsOs5w4heYkSyYOa+lGvp/0H/P1jKvbT04QIk
	N6F51UihSUpLFDQJMVFqXZImPSo+ObEWBUtizpg+3IB8tn2tiGWQcr7cFuFUK0ghLUWX2Io4
	hlCGyk9YHGqFXCXozona5OPaMwliSisKZ7ByiTw6cFalYE8KqeIpUTwtaue2EkYalol2+BsD
	9scOvHXP48tbjox+vZn+2Zizuzd29OjhxQcfvJuimiPTQ/eH16sPiEOb43w686erk8dGhMLo
	t+6QjktxF27vHD6f4RwcGZs8Wt482fymvS1k6ro7pE8VrrEti3RsOJeTV3Wxy9PouevbtK1D
	64vPiYh1sttZ67Py5l0qy08lTlEL61YR2hThHy0cNHggAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUhTexjH+51zds7ZvKvD0jy9QDWQICqLUh6ucrn3n/pxvUV/BEEQOezQ
	hrrJpiuDQtN1pZfbXGyWy+syHKaWy2lky5DNzDJz02q9uC1rrTdtl64rfMum0T8Pn+f7/fLw
	/eNhSVm7aBmrUhcKWrUiT05LKMmOjLL10i1B5caHrlR4UtpFQWy8goILLc00VLSeF4H3ahOC
	UKwCwdcpKwmGjlkKZkw9DIxPvGBgtrMHgcVnIqG5rZSA/x3faPjo+YzAPBKmoep9KQVR+ykE
	1RErA+/vbIOxkEsEs4G3BPi/jCKwh78REO76G8GMJRdq65w0TPUPkFBl9iK4OBIg4Z0jbrb1
	BBF0Nhyj4Y2xnYSh8EJ4FIvScM98koYx3wUCPjlosB3rFEGN1YSg7FILDZaaVgo6Xt5kwPdx
	moBhi4mAptbtELJHKOgz1hHxfvHUtWSwVpUR8fGOAPMVFwET9kYGHlwapsBekgLW/iERvGqo
	ZmB6ZBPM2jTQ0/SWgcAZMwVXxwZEv5sR/mr4h8KNzusENgzO0Lj532aEpyZNCI/Xl5HYYIyv
	ntEoicudB3F93yiNJ2OPadz5xUbh+3U8ruxfjzuqAwwuv/2c2fnrHknmfiFPpRe0qb9lS5Su
	UA1V8CbhUNBWyZSgbvEJJGZ5bgsfPHNRNMc0t4Z/+nSCnONEbhXvPB2Z10mubwX/xLfuBGLZ
	xZyCj1UUz8kUl8L7eo3zESmXzgcj1eSPkyv5JkfXPIvj+tBIHzXHMi6NN0TLCSOS2NCCRpSo
	UuvzFaq8tA26XGWxWnVoQ44mvxXFn8l+ZLryBhof2uZGHIvkv0h9KQGlTKTQ64rz3YhnSXmi
	NLthWCmT7lcUHxa0mn3aojxB50bLWUqeLP1zt5At4w4oCoVcQSgQtD9dghUvK0E54tys20kZ
	gt5vntTcfE1vfOhOCK30FI56/EXbT9Wu3rV16Uvbdc+HrCODJ7uPe5M/ec8NhNPPPovqlnj9
	WXs//MFeySyPZKoS4PIgdvylb6/3HsXdbSVJS6ZL7973E5b0ImeGGzarC5KqbqFFut7/JtNe
	rFteq6k9KnPF7tyTUzqlYtNaUqtTfAeSC7G1SAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The current code records all the waits for later use to track relation
between waits and events within each context.  However, since the same
class is handled the same way, it'd be okay to record only one on behalf
of the others if they all have the same class.

Even though it's the ideal to search the whole history buffer for that,
since it'd cost too high, alternatively, let's keep the latest one when
the same class'ed waits consecutively appear.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/dept.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 1b16a6095b3c..f4c08758f8db 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1486,9 +1486,28 @@ static struct dept_wait_hist *new_hist(void)
 	return wh;
 }
 
+static struct dept_wait_hist *last_hist(void)
+{
+	int pos_n = hist_pos_next();
+	struct dept_wait_hist *wh_n = hist(pos_n);
+
+	/*
+	 * This is the first try.
+	 */
+	if (!pos_n && !wh_n->wait)
+		return NULL;
+
+	return hist(pos_n + DEPT_MAX_WAIT_HIST - 1);
+}
+
 static void add_hist(struct dept_wait *w, unsigned int wg, unsigned int ctxt_id)
 {
-	struct dept_wait_hist *wh = new_hist();
+	struct dept_wait_hist *wh;
+
+	wh = last_hist();
+
+	if (!wh || wh->wait->class != w->class || wh->ctxt_id != ctxt_id)
+		wh = new_hist();
 
 	if (likely(wh->wait))
 		put_wait(wh->wait);
-- 
2.17.1


