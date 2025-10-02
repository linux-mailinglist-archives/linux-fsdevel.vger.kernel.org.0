Return-Path: <linux-fsdevel+bounces-63263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4938ABB339B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE83386FA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E223631FEF2;
	Thu,  2 Oct 2025 08:14:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087C313D50;
	Thu,  2 Oct 2025 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392858; cv=none; b=P9CvJ44qWZ0KTK2gQ7MUITS1XIryLxMnPkefZKSavMqnw/EPgAfzxnvaE2/BLd/ltu5Qu/mkYHs1y19k43BwLgVd2gQlqC+smXu49CRUo3WiEge1WgrvAKxGtX7j5IUT99V0iWKHFOalJyoucNi30NESpShLqzo2CekIw04PsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392858; c=relaxed/simple;
	bh=jhmrpwTM08yBA9ZoPplcfQMQcK3SVeR5SdyXR0h1+Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/Pg+6hKCBwAa1M/EPzCTwZoZsdqimf0DjmssInqvLY8fqwod9gLRyXhhfr45CE3p9OcwxAtd5cKk6JbT1ylPkpKXRZ4fdmVZvfipEsV9xhT4OTUNN4ra7ydzj5Qdis9ibGZ1cevSUWSv8QlM3S/kP7DTp8Mcq567OfSu6PlzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-13-68de3419e02b
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
Subject: [PATCH v17 46/47] SUNRPC: relocate struct rcu_head to the first field of struct rpc_xprt
Date: Thu,  2 Oct 2025 17:12:46 +0900
Message-Id: <20251002081247.51255-47-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH89z73NuX0OXSmXgBHUsXYlYUh0NytjmzLVv2fFmyxA9bNIqd
	NLQTKCsKdi8JCGSNCsMu4NpuWCCQulbLWslEKSINzSoQituwYy0vDiEEkAVoGVrKWskyv/3y
	P+f/O1+OkJYa2VShuviUUlusKJSxYixeTGrek5IzrnqluR9gtLIXQ3hVj+F7h50FvdPIwERY
	j2DtiZmG1fU/BdA4YqDBfr2SgpWOGAvznmUEl+YqMZhmzAKY638fFiduMbAZmqXgfmQBQft0
	jILp3q8RbDSehMstLhaeDA3TcKnBj6B5KkTDde84Arf1LAsP6ztp8DWcZ+FRBwuWs24GfjAb
	EFS1OlgINhoosDk/gIn2GQyNP22HwdYghuhUNmxaNOC1zQrg2uIwA84/+hHYL8zQoL8ZxuD8
	a5QB91gmGJuCLHS7fRj0G6sIvDceUHCho5OBCvMaA/dsfgyO2QAFA95fMPhMVzAM37zKQNv9
	EQqmJgMMuIYGaYjUpYH/Yi0DgfqHCK4+amHfyidrNXWY1NzbYIm9yY7IalsVTTwLSzSpdpWT
	toEFljwO/84Sd8SCyd0Wnlwc2kO6TCEBqe4ZExCL8zRxWeWktXuO+lB+WHwgX1moLlNq9x48
	LlYNXnm7xJ18ptpwtAItSc4hoZDncnhLDJ1DoqfYY/ubSjDL7eIDgXU6wdu4F3lX7QyTYJob
	2MGPjuxO8POcgl/xhOiEBnMZ/PI/HydiCZfLW6u+Y7aU6byto/epRhTPf50awAmWcvv5mqVq
	ams/mfcZp3FCQ8fPOpqkW5fS+apOc7wqjms8Ij7ycxe15Uzh71gDuB5xpmfqpv/rpmfqFkT/
	iKTq4rIihbowJ0ulK1afyTqhKXKi+MO2fxU9cgMt+w/1IU6IZEkSf0ZIJWUUZaW6oj7EC2nZ
	Nslxa1AlleQrdJ8rtZo87elCZWkfShNi2XbJvkh5vpQrUJxSnlQqS5Ta/6aUUJRagXbKr2V5
	b3ftk1TUsmMZm7sJPf4Cdbcn1/JeQcbLj+eXSgp2JNWaWhw7v4iSL30rk8a8396YP+SNHdBp
	+t58Tf2SJk+08FnUcDvlo2D9/k/r5N++Pvnqu5kN+Hzq+sFjk6rcd2J3Uk4cfpDpCX0STg57
	e57Tmcqj8+Zuqyg7ffabtMsyXKpSZMtpbaniX2jl8TOsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9d6cRxGZ3Ksgaj6GIXsh4qulDhIejyrQgqVx7amDe2spQC
	bY6krGwxV1upKQ3bTE0rMlkMJSt11LQb6dLlskJtYpp5XWdJ1JeX3/s8P/7P8+FhcNkIOYdR
	Jx8XtcnKRDkVToTv3qBfPnvNR9VKZ/kMeJvlImBoMIeAGxVlFORUXSfhVbkDQcdQDoLhMSsO
	hpogARPGBhoGR9poCDobEOR7jDiU3c/C4EflJAU99QMITD4/BeZvWQQEbLkILN1WGr49jYO+
	jloSgt4vGLz72YvA5p/EwO86h2AiXwOFxdUUjLlf4mA2vUJwy+fF4Wul1Lzf8BGBs/QsBZ/z
	HuDQ6p8Or4cCFLwwXaCgz3MDg++VFBSddZJw02pEoC+poCD/ZhUBNZ2PafD0jGPQnm/EwFG1
	Czps3QQ05RVj0n6SdW8WWM16THq+YmC6W4vBiM1OQ3NJOwG2TAVY3a0kfCq10DDuWwXBohRo
	cHyhwXvZREB530tyiwkJw4ZLhGCvfogJhpYJSigrKEPC2KgRCYO39bhgyJO+9b0BXMiuPinc
	buqlhNGhN5Tg/FlECI3FvHDFvVyosXhpIfvJB3rv+gPhGxPERHWaqF2xKT5c1Xxna6oz4lS2
	8WAmCrDnURjDc2v4J45+LMQUt4h//34ED3Ekt4CvvthNhhjnmqL4t55lIZ7BKfkf9V7JYRiC
	U/ADv/aHyiy3li/VXyOnIqN5R6XrT0yYVG/1NREhlnGxvCGQjU35EfyL634iFINLYysKZFOT
	onn9Ayueh1jLf5bln2X5zypCuB1FqpPTkpTqxNgYnUaVnqw+FXM0JakKSQdpOzN+5REabI2r
	QxyD5NNYj8KrkpHKNF16Uh3iGVweycaXtqtkbIIyPUPUphzWnkgUdXVoLkPIZ7E794nxMu6Y
	8rioEcVUUfu3izFhczLRh8aWPRBVeFCh3fbZ3bgO254rX9072XNu4Xx3f+PchKhJfdy8q5u2
	bC5xm8/bYtpcW2MWz+zqYjtrT7ZohI0F9tPajOd7I7b7Tmc034L2nK5n9wotbOehpbFO89Xh
	w/1ZrsVc3xFFbYV5x1qHnW8zTUtN0oRFu9riBsbujAZzV8gJnUq5agmu1Sl/A2JfrD6MAwAA
X-CFilter-Loop: Reflected

While compiling Linux kernel with DEPT on, the following error was
observed:

   ./include/linux/rcupdate.h:1084:17: note: in expansion of macro
   ‘BUILD_BUG_ON’
   1084 | BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);	\
        | ^~~~~~~~~~~~
   ./include/linux/rcupdate.h:1047:29: note: in expansion of macro
   'kvfree_rcu_arg_2'
   1047 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
        |                             ^~~~~~~~~~~~~~~~
   net/sunrpc/xprt.c:1856:9: note: in expansion of macro 'kfree_rcu'
   1856 | kfree_rcu(xprt, rcu);
        | ^~~~~~~~~
    CC net/kcm/kcmproc.o
   make[4]: *** [scripts/Makefile.build:203: net/sunrpc/xprt.o] Error 1

Since kfree_rcu() assumes 'offset of struct rcu_head in a rcu-managed
struct < 4096', the offest of struct rcu_head in struct rpc_xprt should
not exceed 4096 but does, due to the debug information added by DEPT.

Relocate struct rcu_head to the first field of struct rpc_xprt from an
arbitrary location to avoid the issue and meet the assumption.

Reported-by: Yunseong Kim <ysk@kzalloc.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sunrpc/xprt.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index f46d1fb8f71a..666e42a17a31 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -211,6 +211,14 @@ enum xprt_transports {
 
 struct rpc_sysfs_xprt;
 struct rpc_xprt {
+	/*
+	 * Place struct rcu_head within the first 4096 bytes of struct
+	 * rpc_xprt if sizeof(struct rpc_xprt) > 4096, so that
+	 * kfree_rcu() can simply work assuming that.  See the comment
+	 * in kfree_rcu().
+	 */
+	struct rcu_head		rcu;
+
 	struct kref		kref;		/* Reference count */
 	const struct rpc_xprt_ops *ops;		/* transport methods */
 	unsigned int		id;		/* transport id */
@@ -317,7 +325,6 @@ struct rpc_xprt {
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	struct dentry		*debugfs;		/* debugfs directory */
 #endif
-	struct rcu_head		rcu;
 	const struct xprt_class	*xprt_class;
 	struct rpc_sysfs_xprt	*xprt_sysfs;
 	bool			main; /*mark if this is the 1st transport */
-- 
2.17.1


