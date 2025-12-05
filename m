Return-Path: <linux-fsdevel+bounces-70770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AF6CA6B86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A11A23667112
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C03112DB;
	Fri,  5 Dec 2025 07:20:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8802F39C9;
	Fri,  5 Dec 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919191; cv=none; b=WSu7TkhH8MUtv36bxIxKpeDhuqWl4I+nqsNzVTmfpBM7IQ9mijVxeAkpNbMPxsoOc4qVOpxoncMuU+UiamwuznaCdCy3lRiRxnShUOxGXLNBmAZYhtuk+vEFqqiqBPiJc1ASyig1mrLRQ6/4zavpGBToLqLyr/pmidDHv9iu090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919191; c=relaxed/simple;
	bh=/Hj2k0/9+7au7dlYwNhN7nUvrBQ4fhO0DAuGqcmuK0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=J7xhCRMJChYwQjbTUMsHG7n6rNn2cNRxWW4OnW2trAu36E6Zn0VV92s7q6Oz6N1ZDauXYFfLzWeq/PRdIIljS3n+KNoxNq/V++KTF9XyAlxNkR3iVbmsc8sGqYSTyVoweNzMPLzfHuJ3EvWWR/8CNtgLppycdXiaY4WfVcXd8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-64-6932876d86aa
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
Subject: [PATCH v18 12/42] dept: apply sdt_might_sleep_{start,end}() to waitqueue wait
Date: Fri,  5 Dec 2025 16:18:25 +0900
Message-Id: <20251205071855.72743-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d/XttLlphK9ajKXJsSN+YZRc4y4mH3Zf3PLlixxyTRiIzfS
	WAq2iGBiUgsOxZZ1zMIAJ9KGglBedqtWEbWtghIktPGlVSqCQZTQglPqAiis1vjl5HeeJ89z
	vhwJqRikl0nU2jxBp1VplIyMkkWTbKuzS9ar13mdW+DBUQ8F72rcLBwXq2i4HTRS4G9tRvCu
	vJuFqekBFioC5SSE/NdJcJ4/SoB1eISBSYcJQfVoDQtjXd+AY2SOgBFPCYLxipcMzPb1k1Bp
	9SO42mhk4JnlAgn3YpMM9FhPMhANnCagyN7GQMXfIgXhinICmsUfoNdiI6ByLC7/swRqKouI
	+HgRP9dyhYA79jAFDkMKPG2sZuHtcBp0Nz9n4fHvVgpao/009Aw+oOHJrd9ocBuGWBAfdiGY
	ujdMgNM0SsLxjhgFVWfCDHRe7aGg+9JTAu52nGbA1H6BhkHnPA1+Ty8Nbc9DBPRUn6Ogv6OF
	hvpggIDhoRANrr47JPj/MNMQsjxD0DJhY7Zl4ibXRQI7zzgRnp0pR3iqvojExyzx9UZkksT1
	vREGz8TuM/hy9WMWF197xOKz4kFcfDNKY1djKrZ3jhG47lWMxmLTCeanL3+VpWcKGnW+oFv7
	1R5Z1rXSKTK3TFpQ29fNGpCZLUVSCc9t4H3XHcxHrnV6qffMcCv5UGiafM/J3Ge8yzxKlyKZ
	hOTuruBLpssSxiJuB1/X0JEIU1wKH/xzIlEq5zbxVRED+aF0Bd/c7kmwNK5bgzMJVnAb+drS
	/xKlPGeX8gPiKPEhsJT3NoYoC5KfRQuakEKtzc9WqTUb1mQVatUFa/bmZIso/nWOI293XkKv
	/D/7ECdByiS551CaWkGr8vWF2T7ES0hlsjyiWadWyDNVhYcFXU6G7qBG0PvQcgmlXCJf/+ZQ
	poLbp8oT9gtCrqD76BIS6TIDsi7f+vX282VzbsHmPvXvpNmY8Trlk2O7Q9/NLXafe91WkzV7
	eCQwv8seCOrLBhf+Fd620JfBThh31rnGx1ts5rXE7MD+dCbvZcHD3JUm+VCgN5Y+923XgbpT
	m7abGkTj50c2h+d/9H6Kc0jVF1Ec+aVBm7F11QJv666k798U+9xuJaXPUqWlkjq96n8JnShO
	cQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG+997d+91tLgswYtR1jAyo1crTi/0SnSJiojIqA+58pI3N1ub
	WUaRLw2XNZuLTWyaZrlCV5qz1GRllpaZpFkplZq0VubM0C2ZL9k0+nL4nec55+F8ODQurRQF
	00JcPK+OkytkpJgQ71yTulCZtkxYMugKBJ32HHzqcorgfXINAV6PjoCcEhsJY5YKCnRl2SJ4
	0ZZCQPPdYgRdXh2CoRELDtqqcQLGjPUUeHwfKTAlIxh31CMwtxhxaG9+jIOtPBmDwdI/JPQ+
	HUBg6naSkNWTTEC/9RKCqy4LBT11W6Gvq1oE4x3fMGj77UZgdf7BwFmThmDMHAt5BXb/uvkX
	CSNNr3HIMjUjuN7dgcNAz2cE5fWdCBy3U0j4ariPQ6tzGrz19pPQYLpIQl9LDgY/S0nIT3GI
	oOVVL4JcixGB64MDg9QbJSSYc8sIqPr8kIKW3lEMPpmNGBSX7YAuq4uARkMB5j/XP3UvCCxZ
	qZi/fMfAdKcaA5+1iNpQiLghbQbBFdkfYJz2zRjJ2a7ZEDcybEScpzAV57QGf/vU3Y9z5+0n
	ucJGN8kNe9+RnON3PsG9LGC5mxeGMS6zaSFXdbWD2rVxv3htNK8QEnj14nVR4phH6R5clRFw
	Kq+pnkpCeiodBdAss5zNsz0hJphk5rHt7T58ggOZ2axd7xKlIzGNM60hbJovY9KYzuxlr996
	SE4wwcxl2678nAySMCvZbHcS/i80hC0urZnkAL9uahueZCmzgs1LHxIZkDgfTSlCgUJcglIu
	KFYs0sTGJMYJpxYdPqYsQ/5/sp4dzaxEntattYihkWyqpObkUkEqkidoEpW1iKVxWaDErVgi
	SCXR8sTTvPrYQfUJBa+pRTNoQhYk2RbJR0mZI/J4PpbnVbz6v4vRAcFJqPMQSCK+3JjTrM8U
	5zo71wgz88NUG0JXqRLhYpAjrG5Te+XgGbphweiZOv2+1RE/dgTNtDduGd29vWh5VPWWlGd9
	l8MqyrPhhOlo5L7b6+YWPn6/flZkqCa0r1t/fM9HQhd/XnlA1fRo/s0Qn2Eg51y4Z8/44Obn
	66c2eN564zvNc2SEJka+NBxXa+R/AQHrLutLAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index f648044466d5..7815caf61a15 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -7,6 +7,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/dept_sdt.h>
 
 #include <asm/current.h>
 
@@ -305,6 +306,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
+	sdt_might_sleep_start(NULL);						\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
@@ -323,6 +325,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 			break;							\
 	}									\
 	finish_wait(&wq_head, &__wq_entry);					\
+	sdt_might_sleep_end();							\
 __out:	__ret;									\
 })
 
-- 
2.17.1


