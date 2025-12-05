Return-Path: <linux-fsdevel+bounces-70796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF2FCA6940
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB34F327705B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244CA342CB4;
	Fri,  5 Dec 2025 07:21:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477B2335BD5;
	Fri,  5 Dec 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919298; cv=none; b=mw+ND7GUw4cOK5W1K/rmzUWclKwOjnRwCll9hv8o2vCp4IN7+E4Y9qlSJvLaAwDXg4diTn/7MLhXlHDj1ez9mLT+qcxdr2nPdhZICieK+JWe8DRb5+yzLKWm8oSzd4qgBeV/40F/qzfDT61VT6AaT3t/bMn0X5e8mpzAVnTpASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919298; c=relaxed/simple;
	bh=jhmrpwTM08yBA9ZoPplcfQMQcK3SVeR5SdyXR0h1+Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL6ZgAIFB9x8L+O39eYeEm31ulBiSmR2mXU0xJo87LkCXgOpiYeOQGm+D0PEvur7yWJptXoK7PuOZI7fXqU65pu6XrCT5puldA9Ta898RARljhI+hGxJrqlr0kYZ/gANm1APi+nL0NR9Xsvdu92d7iXNJYPGNpGEr7EMTkllYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-de-693287767d46
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
Subject: [PATCH v18 41/42] SUNRPC: relocate struct rcu_head to the first field of struct rpc_xprt
Date: Fri,  5 Dec 2025 16:18:54 +0900
Message-Id: <20251205071855.72743-42-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxSA9373NjT5rIa90hhJE7fMCxN15mCMqfv1xfljyf7skmV+kS+0
	saApNzEzQ6GldorYBRqKl8IGIpdRqxDF1gEiCYS6ggoMLZdoqggFbLEKQ7GFLPPPm+c95zzn
	nLx5OVJZySRwuowsyZAh6tWMnJIH4yq35BRt021dbPwEzMZf4HxTAwNmVzkNvj/rEYy+MiMw
	3lyi4K21i4UlTxeCsj4rCZN3QghsEycomKk5jSA4eouGJf8zAp62FSGYLJtlwFbqQ1A57ich
	NDGG4HrXCAJP7UkGukt/ZWDaycCFCiuCx2VWAipsBbHjOQHzNXUsVHjv07A4ngxzD8YJMLe+
	osD1ZIAGz/AmqDT9QYHb001Bf72Pgkfesyz83dpIQ/VgHwG+c2doaJyuYmAyUkNCf5uDgNqX
	NhoCD00EXPF4GehyxIM1EGKh+S8jAlP4HQ23zWMENAXukFBdG6Thmf0CAT3+MAvXXKUkDFgv
	MbBw+W70JU7PR7W7r1lwvrzMwInwKILpkjlaoxGM/W8ZoeFiAxL+XbAiYa66gBSMJdGrJ+Kg
	hJ4qLJzzbhFu2v2sUHh7mBUcrmyhsDNIC7+7JwjBVXeKER4PuBlh+t499mv19/LdqZJelyMZ
	Pt9zQK7tvbL3iGfV0ULrj/loRmFBHIf5HXj4icaCZMv4wjlMxJjhP8VDQ/NkjNfwifjamQBt
	QXKO5O+vx0XzxcuJ1byIJ8JTTIwpfgMOjYxTMVbwO/E/v80RK03X43pn23K9LBovHVxYZiX/
	Bb5keU2v1K/C3eVPqdg+ZHRw00VlLExG1YLmCjI2F/MjMuzubyFXeq7F7bVDVAni7R/o9v91
	+we6A5F1SKnLyEkXdfodSdq8DN3RpIOH010o+nFrji/+cAOFfN90IJ5D6jhFW26yTkmLOZl5
	6R0Ic6R6jWJKv1WnVKSKecckw+GfDNl6KbMDqThK/bFiWyQ3VcmniVnSIUk6Ihn+yxKcLCEf
	OU8pzN/t7lMKadlVxQ9f5G8Oth+f2eBvT7J3BtdFNsYnfRspmC3LTXG8+dnUMmBbbdHzg729
	gZQ9zds7zPtUyabWAzwd2jTYmRAfHnPnB7/UvJv1PppKO1a+a6Zxv+ozLd6vuqqVyTWJidd7
	io0p8izD+a+K/XFOUWXpbdn3kZrK1IrJG0lDpvgeQnsaDLQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxjHPffce3tpvHrtSLhTo67GuJjoZBnLE3VGv+h1UdRkyYzZJo29
	SkMB0zKERaNQKxXUYJcWvbWIKI2WbmDxDU21gQ3n1AyGGy8TgaQyC8VOaMHyIt5iFv1y8jvP
	8/uf83x4GKyaoOYyuqwc0ZCl0atpJalMXW1anlv0qW5lo5MCi/kQPOkOUPB3gZ+EaMRCwtka
	Dw2TjhsKsHjPUPBbWyEJzT9XI+iOWhCMjjswmOunSJi0NikgEvtHAbYCBFO+JgT2FiuG9ua7
	GDxXCwgYrn1Nw0DjEAJbb4CGsmABCWHXcQRSn0MBwV83wmD3bQqmuv4loG0khMAVeE1AwF+E
	YNKeAecq6+S4/T8axh/9gaHM1ozgfG8XhqFgD4KrTU8R+C4V0vCs9BqG1sAseBwN03DfVkLD
	YMtZAl7U0lBR6KOg5eEAAqfDiqCv00eA6UINDXanl4T6nlsKaBmYIOCJ3UpAtXcLdLv6SHhQ
	WknI48rWlSRwlJkI+XhOgO2n2wTEXG7FuiokjJpPkoK77johmP+cpAVPuQcJ42NWJESqTFgw
	l8rXxlAYC0fq9gtVD0K0MBb9ixZ8IxWk8HslL1w8NkYIpx4tF+qlLsW29TuVa7SiXpcrGj5Z
	m6ZMf3h5/T7fnLwj1m8PozBbjBIYnvuM76/tJOJMc0v59vYYjnMit4ivO9FHFSMlg7nWhXxR
	7OR04wNOwweHQ3ScSW4JP/S0l4wzy33Od/wYId4+upCvrvVP+wly3dY2Ns0qLoU/VzxKvfXn
	8PfPBOQsI3+wlK8pV8XLWI6arjlwKWKl9yzpnSW9Z1Ug7EaJuqzcTI1On7LCmJGen6XLW7E7
	O9OL5J10HZw4dRNFWjc2II5B6pmsf3+yTkVpco35mQ2IZ7A6kQ3pV+pUrFaT/4NoyN5l+F4v
	GhvQPIZUJ7Fffi2mqbi9mhwxQxT3iYb/uwSTMPcw6nyV8UV2dJOpavTjjus7FvRfvPO415oz
	Q5JubnC+7J+f73U74cqqxJLsj/Zou0La4VUWIe/Od4de+ljX7JgntXzmL5ulo+7kA5sstxbv
	Zi8ot4bX4CTvV3vd1L00NlV6Vfbssn173uDd537tYOuinmPf6MV789pHSj48vTiYXjnUqCaN
	6ZrkZdhg1LwBtNOU7o8DAAA=
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


