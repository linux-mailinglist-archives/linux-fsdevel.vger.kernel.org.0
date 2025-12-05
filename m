Return-Path: <linux-fsdevel+bounces-70795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED7CCA699D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5008342BB6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E233C530;
	Fri,  5 Dec 2025 07:21:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF4D333438;
	Fri,  5 Dec 2025 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919294; cv=none; b=uefiky2h9b9Esk5d5rPzJBpHINPumljRTecsX8hpSwDwG4t7Htu6nvgHGOvoK4wCuoF+6wlpoWwmM9dxStEn3EPpnLOSjt3Ki14zDg9f+SeDA8Jwejb7nXFS8SvX6PrxEJZbBdqKmzaCtLNcJt3Zt6ULnVpeH8/A8YmdPLAHZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919294; c=relaxed/simple;
	bh=Maxqvp8M2/Mbhj5qDNZmaX54vuIa2E/KjRgY0LGmkyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=P4HIPWxODzvvt7uuPEXqic7nvjQDyas2C3v4wHqEwFnBa9CfwPJ+niZcbMHzI2C1zx/9hQyamhMmmHJCSOCSg8jIO5GQMBeWPcxgVmq+XruWI0ohiMYpEraUJWt6fXBtRIe3syOU8DFDXZcQobdNIoIaZbGdRdKeTNiIDiLfCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-5f-69328773bffd
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
Subject: [PATCH v18 37/42] dept: call dept_hardirqs_off() in local_irq_*() regardless of irq state
Date: Fri,  5 Dec 2025 16:18:50 +0900
Message-Id: <20251205071855.72743-38-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTH97v3dx+tVO+qkasmapoYDfjCV84favxj0esfJhqdfzgN1nGV
	G8oj5SXTZWAhIPNRG8HUirSInQEMpLW61tXU6piIVVknVESEiTDGQ0UEedYLxn9OPud8z/nm
	nOSwpLqJms9KSWmiPkmr09BKrOyLsK1Iy18jrS45xUPLqw4KGnN8GD4OFmCYsNxioMBhpuBB
	0wkMw2MWEvLcYVkw1TJQlIMg7K1F8KFmkoaeewMIito7aLjQnYPhrf0UgoudFga6/9wGTUO9
	COwdkwR0+PIRTBQnQGmZUx4qfkfDWOAJCbb2lyQMdLchuFHbiuCN0UVCX8MlAvpraLCe8FLQ
	8KgHQYnFhKCz2UuA4Uo1De42DwMNPeMEtBSbCKh07IB6Yxkhr0CD5YKBkMN/BIzYKxh4dKUF
	gz17CVgCQQrG22MgbE2G2souBupaGym4ld0m3+r5iMHbHA3myy00/OGtw1AwMYgg6LlEQ2tV
	mIK/K59iqO4KEfAicJaBJ57r1JY4YTjvDBYqnDcJoepyFRLGRk1IGLxqIIU8o5ze631LCrnO
	TME7ZMXCwzJeKD85SgjnAisE98WXjJB7p5kRrI50Ifd+H7Vz1T7lxjhRJ2WI+lWbDyrjw74b
	VErOrKN5twdwNuqbUYgULM+t4wvqS5ivbHY8w1NMc0v5UGiEnOI53GLeebqTKkRKluSCi/j8
	kTOywLKzuUN8XeOeqR7MLeH9rmpiilXcBt4wGiC+eC7iK2t80z4KuV7UNDrNam49X1o4PO3J
	c78peEP5XfrLwDz+7rUQNiKVFX1TgdRSUkaiVtKtWxmflSQdXfljcqIDye9m/3n8h9/RwNPd
	fsSxSBOh8mXGSGpKm5GalehHPEtq5qh6dasltSpOm/WTqE+O1afrxFQ/WsBiTaRqzVBmnJo7
	ok0TE0QxRdR/VQlWMT8bnV3u2hKRYjy09fWDaFO0Y/Lb0nnbk6O+j1nY43ab/n/W7J+5lF5b
	74o1fNqE+xM3/HPc3PD+yGP3NufaSLT/8f3XCTf32p6bG2t+6Z/pDbVJ/9qCu5wRlHT7WGTa
	6X63xXM9/F2X669l5Znc4V9tUfHB5RvT2+ceV5xn18eWHlhc1qnBqfHamChSn6r9DDZAbnpq
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93XrqvlbQldCioGPZA0LYvTkwqiS+8XFUWPW150OK02tSyi
	5lqamdhiE12mWQ6bmjYtM1mNVfYwy0epVKbSWplbhrnETbNZ9M/hc873e76cPw6NS6vIybQ8
	Ll5QxvEKGSUmxBuXaEJUKfPkYe6GOZCqPQ0fOhwktKhtBHj6Uwm4UlZCwbCxSgSplmwSnrUm
	E9BwqxhBhycVwYDPiIO2eoSAYV2tCPoH34tAr0YwYq1FYGjU4dDW8BCHkko1Bj/Lf1PQ86gP
	gb7LQUFWt5qAXlM6ghynUQTdT9aAu6OGhJH2Lxi0/nIhMDl+Y+CwpSAYNsRAXkGFf93wgwJf
	/WscsvQNCK51tePQ192JoLL2IwJrUTIFnzPv4NDsGA9vPL0UPNdfoMDdeAWD7+UU5CdbSWh8
	2YMg16hD4HxnxUBzvYwCQ66FgOrO+yJo7BnC4INBh0GxZQN0mJwE1GUWYP5z/a7bk8CYpcH8
	5SsG+tIaDAZNZtGKQsQNaDMIzlxxF+O0TcMUV3K1BHE+rw5x/YUanNNm+ttHrl6cO1txjCus
	c1Gc1/OW4qy/8gnuRQHL3TjvxbhL9SFcdU67aPPK3eKlkYJCnigo5y4/II4esVWSR9SBx7U1
	fcQZ5B6bhgJololgsy1viVGmmFlsW9sgPspBzHS24qKTTENiGmeap7Epgxl+gaYnMgfZ5y3b
	Rz0EM4O13ynDRlnCLGQ13nrsX+Y0trjc9jcnwD/Xt3r/spRZwOalDZCZSJyPxphRkDwuMZaX
	KxaEqmKik+Lkx0MPHY61IP87mU4NXbqH+pvX2BFDI9k4ie1YuFxK8omqpFg7YmlcFiRxKcLk
	Ukkkn3RCUB7er0xQCCo7mkITskmStTuFA1Imio8XYgThiKD8r2J0wOQz6OTq+C2eg/ZSuOFb
	fLSyKKpzU/jp9Ii6wPW8OjBy9bjHl29+Z51jkiPOlT8NnJlR01SUrndVWc2+hNzZ13OGaMUy
	R9OivWfN3K6y9SH8g31hp9zRWz/t3zC1YO+q4Hsts9flvaya8e2upvXEvoTbn9/N3zNxQpG2
	a5smKupV8I5v08NeyQhVNB8ejCtV/B+AnKgLSgMAAA==
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


