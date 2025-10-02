Return-Path: <linux-fsdevel+bounces-63215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A0BB2CBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A853B8577
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791DC2D4814;
	Thu,  2 Oct 2025 08:13:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B91277003;
	Thu,  2 Oct 2025 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392791; cv=none; b=RACq9Cyl5pajeuOJqfvyAk8Hl/jMcgRD4HT9nTFcdhxQrsekb2mypBOss/G7nm8TQUkgLwY5uwIsV0cM8G3YZzr3Of7GkZEJaLLGP/5J9G8TijGFD7g5D3Z8oc4OYHiJ9vM7aOD+QJjEIzPJ94nWQlqXDxIWPJw4xHjaEuFeCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392791; c=relaxed/simple;
	bh=8opNft806bn0BC/O71uXTdkgWwuSY6TOrolnSlvGhRQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GzXN1OQTz29boIEeLk1xYig/fcnyr7I8Bv9qJ3JRLLn24fLr8NE4Uc7xkoKAsCLGnZF9G7OIgXofaZJk8AKzHRyz4Pw6CVDsQZPGuDkdEwK0dNX+V+sRj9GmEVGM048F5nodKnGsXtLnWa06CN3MOVjc6HM2Kzw7jG2eWhM9JhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-24-68de340ad56b
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
Subject: [PATCH v17 00/47] DEPT(DEPendency Tracker)
Date: Thu,  2 Oct 2025 17:12:00 +0900
Message-Id: <20251002081247.51255-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUhTYRQH8J77trkaXWblzYpqZUGYWlkdQqIy8EEIjD4EReTSm3fkVKbZ
	DKq5UlNLpNKywmY2s3xBNzAVF1PU8n1aicimlSKZbZq6RfZis/Lb75z/4XA+HDEpc1G+YmVc
	Eq+OU8TKGQklcSwr2i4JHhKCTAX7oD/VQsF1YwEN1soyBGl18xTk994iYabqNwOTJTcQjLeE
	waglA8GjxyYGfnT1kHA3z4qg6IOdBHOpjoG3rkkGnFUM6HVmGnonfhKQX+0DncU2Ch50vaGh
	0tFDQ9tQPw3Dr9JpeKF9LwLjiKcsKLQx0GBu89zwaxZBa+1HAvrKrBT01FfQYOrqJMGdswZK
	XJMiSG0spqBVvwpujU2LwDDrJMGW85mC9CfVBBhKHTS022dEcLtPz0D7XDsBZb2etc1uEpy5
	s/SBIPwtLYfC5YXlCBs6vjDY7NZTuO6+XYT1xvO4uGGcwMbnmQzOcrwlsK2/gcHO7m4RLmw7
	ioezXxHY9OQK/mQqQLg45zYdsfqEJCSaj1Um8+rA/ZESYaxpgkjQP0Waq+53tBalX85CXmKO
	DeamuvKZRefVVPw1w27lBga+kwtewW7gTDfH6AWTbMdarr/Xf8He7C7OnfeVWjDF+nFtv979
	nZeyu7l7ppb/O9dzZVUWT1/icYYXN2UaRP+C1Vxj6QCVi5bq0ZLnSKaMS1YplLHBAUJKnFIT
	EBWvMiLPM5Rc+nmyFk1bjzUhVozky6RWP7sgoxXJiSmqJsSJSfkKaWSpTZBJoxUpF3l1/Gn1
	+Vg+sQmtEVNyH+lO94VoGRujSOLP8XwCr15MCbGXrxaVR999uW6l62iENjP9uyo72OmnuXN6
	SUrohWdRCQ/HdN6+1fPag7WBzXPm+jOHggYrxFMt13YPF+W26jRhqprDhaMGWavvpv3hZ13+
	uo2RllNbhsJUGvvTNGHvnpBwy1VDqHNDZdCIcCR+X1r8Uguxce6zsHzepyYGM8ePbHb0vZZT
	iYJixzZSnaj4AwdwbzUIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+//PbY0WJ7M83WMh0cWuRi8ldoM8FUlBFPQlRx7acGpsZRpd
	psuSsrLRtFzmsjZNp01XksXKFi7KTKdZUU5TbJq6pLyUeWsr+vLye3keHp4Pj4gIyKVmihRx
	RwRVnEwppcWkOHK9NkQc2ixfUXVhOrxLriRhoD+NhBv3LDSklV2noK6kCEHLQBqCn8MGAlIr
	xkkY1TkZ6B/6xMC43Ykg06UjwHI/GUOfdYyG7uc/EOhb22nI+ppMQq85HUG2x8DA16oI8LY8
	pmDc3YHh/WAPAnP7GIb2ynMIRjNjIDfPRsNwTS0BWfo6BLda3QR0Wn3ifWczAntBCg1fMh4Q
	0NA+Gd4O9NLwUn+BBq/rBoZvVhqMKXYKcgw6BNrb92jIzCkjoeLzIwZc3SMYmjJ1GIrKdkKL
	2UNCdUYe9vXzuUqDwJClxb7TiUFf/BjDkLmQgde3m0gwa4LBUNNAQVtBNgMjrSth3BgPzqIO
	BtyX9SSUeGupjXrE/0y9RPKFtnLMp9aP0rzlpgXxw791iO83aQk+NcP3Pu/pJfgztmO8qbqH
	5n8PNNK8fdBI8q/yOP5KTQhfke1m+DNPPjK71u0Xh0ULSkWCoFoeHiWWexzd+LAxHyVqBxsp
	DTp76jyaKOLYUE5fXkz7mWYXch8+DBF+DmTnc7aLHsrPBFs9m3vnWurnqexqblD/nfQzyQZz
	L0cb//ol7Brumq2K/pc5jyuyVhIZSGREEwpRoCIuIVamUK5Zpo6RJ8UpEpcdjI8tQ77ZmE+O
	XHmI+hsiHIgVIekkiSvYLQ+gZAnqpFgH4kSENFASVdAkD5BEy5KOC6r4A6qjSkHtQLNEpDRI
	sn2fEBXAHpIdEWIE4bCg+q9i0cSZGrRq3dUT0TO2Bh1M3BH2bCmeNc2kbDu9oVg1p66epcIX
	LYhPr78ZgZYMT1mvDvVs27xpU9/cLBze4SnFpd80pjcpXdj7Kj/atMV5fbn6Tfndj96Ha4/+
	evHILt8dwnftzgnba1nQqXFk35ky1LzihXXPU65rbEeJcLGtb2pkrZCey0pJtVy2cjGhUsv+
	AAFAkRoyAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Found out a recent deadlock issue can be reported by dept.  The issue is:

   https://lore.kernel.org/all/20250513093448.592150-1-gavinguo@igalia.com/

I'm happy to see that dept reported real problems in practice.  See:

   https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/
   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
   https://lore.kernel.org/all/b6e00e77-4a8c-4e05-ab79-266bf05fcc2d@igalia.com/

I added documents describing dept, that would help you understand what
dept is and how dept works.  You can use dept just with CONFIG_DEPT on
and checking dmesg at runtime.

There are still false positives and some of them are already in progress
to suppress and the efforts need to be kept for a while as lockdep
experienced.  Especially, since dept tracks PG_locked but folios have
never been split in class - which needs help from maybe fs guys tho.. -
we should put up with the AA report of PG_locked for a while, for
instance, any nested folio_lock()s will give the dept splat for now :(

It's worth noting that *EXPERIMENTAL* in Kconfig is tagged, which means
dept is not proper for an automation tool yet.

Thanks for the support and contribution, to:

   Harry Yoo <harry.yoo@oracle.com>
   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
   Yunseong Kim <ysk@kzalloc.com>
   Yeoreum Yun <yeoreum.yun@arm.com>

---

Hi Linus and folks,

I've been developing a tool for detecting deadlock possibilities by
tracking wait/event rather than lock acquisition order to try to cover
all synchonization machanisms.

Benefits:

	0. Works with all lock primitives.
	1. Works with wait_for_completion()/complete().
	2. Works with PG_locked.
	3. Works with swait/wakeup.
	4. Works with waitqueue.
	5. Works with wait_bit.
	6. Multiple reports are allowed.
	7. Deduplication control on multiple reports.
	8. Withstand false positives thanks to 7.
	9. Easy to annotate on waits/events.

Future works after getting merged:

	0. To separates dept from lockdep.
	1. To use dept as a dependency engine for lockdep.
	2. To add missing annotations on waits/events.

How to interpret reports:
(See the document in this patchset for more detail.)

	[S] the start of the event context
	[W] the wait disturbing the event from being triggered
	[E] the event that cannot be reachable

Thanks.

	Byungchul

---

Changes from v16:
	1. Rebase on v6.17.
	2. Fix a false positive from rcu (by Yunseong Kim)
	3. Introduce APIs to set page's usage, dept_set_page_usage() and
	   dept_reset_page_usage() to avoid false positives.
	4. Consider lock_page() as a potential wait unconditionally.
	5. Consider folio_lock_killable() as a potential wait
	   unconditionally.
	6. Add support for tracking PG_writeback waits and events.
	7. Fix two build errors due to the additional debug information
	   added by dept. (by Yunseong Kim)

Changes from v15:
	1. Fix typo and improve comments and commit messages (feedbacked
	   by ALOK TIWARI, Waiman Long, and kernel test robot).
	2. Do not stop dept on detection of cicular dependency of
	   recover event, allowing to keep reporting.
	3. Add SK hynix to copyright.
	4. Consider folio_lock() as a potential wait unconditionally.
	5. Fix Kconfig dependency bug (feedbacked by kernel test rebot).
	6. Do not suppress reports that involve classes even that have
	   already involved in other reports, allowing to keep
	   reporting.

Changes from v14:
	1. Rebase on the current latest, v6.15-rc6.
	2. Refactor dept code.
	3. With multi event sites for a single wait, even if an event
	   forms a circular dependency, the event can be recovered by
	   other event(or wake up) paths.  Even though informing the
	   circular dependency is worthy but it should be suppressed
	   once informing it, if it doesn't lead an actual deadlock.  So
	   introduce APIs to annotate the relationship between event
	   site and recover site, that are, event_site() and
	   dept_recover_event().
	4. wait_for_completion() worked with dept map embedded in struct
	   completion.  However, it generates a few false positves since
	   all the waits using the instance of struct completion, share
	   the map and key.  To avoid the false positves, make it not to
	   share the map and key but each wait_for_completion() caller
	   have its own key by default.  Of course, external maps also
	   can be used if needed.
	5. Fix a bug about hardirq on/off tracing.
	6. Implement basic unit test for dept.
	7. Add more supports for dma fence synchronization.
	8. Add emergency stop of dept e.g. on panic().
	9. Fix false positives by mmu_notifier_invalidate_*().
	10. Fix recursive call bug by DEPT_WARN_*() and DEPT_STOP().
	11. Fix trivial bugs in DEPT_WARN_*() and DEPT_STOP().
	12. Fix a bug that a spin lock, dept_pool_spin, is used in
	    both contexts of irq disabled and enabled without irq
	    disabled.
	13. Suppress reports with classes, any of that already have
	    been reported, even though they have different chains but
	    being barely meaningful.
	14. Print stacktrace of the wait that an event is now waking up,
	    not only stacktrace of the event.
	15. Make dept aware of lockdep_cmp_fn() that is used to avoid
	    false positives in lockdep so that dept can also avoid them.
	16. Do do_event() only if there are no ecxts have been
	    delimited.
	17. Fix a bug that was not synchronized for stage_m in struct
	    dept_task, using a spin lock, dept_task()->stage_lock.
	18. Fix a bug that dept didn't handle the case that multiple
	    ttwus for a single waiter can be called at the same time
	    e.i. a race issue.
	19. Distinguish each kernel context from others, not only by
	    system call but also by user oriented fault so that dept can
	    work with more accuracy information about kernel context.
	    That helps to avoid a few false positives.
	20. Limit dept's working to x86_64 and arm64.

Changes from v13:

	1. Rebase on the current latest version, v6.9-rc7.
	2. Add 'dept' documentation describing dept APIs.

Changes from v12:

	1. Refine the whole document for dept.
	2. Add 'Interpret dept report' section in the document, using a
	   deadlock report obtained in practice. Hope this version of
	   document helps guys understand dept better.

	   https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
	   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/

Changes from v11:

	1. Add 'dept' documentation describing the concept of dept.
	2. Rewrite the commit messages of the following commits for
	   using weaker lockdep annotation, for better description.

	   fs/jbd2: Use a weaker annotation in journal handling
	   cpu/hotplug: Use a weaker annotation in AP thread

	   (feedbacked by Thomas Gleixner)

Changes from v10:

	1. Fix noinstr warning when building kernel source.
	2. dept has been reporting some false positives due to the folio
	   lock's unfairness. Reflect it and make dept work based on
	   dept annotaions instead of just wait and wake up primitives.
	3. Remove the support for PG_writeback while working on 2. I
	   will add the support later if needed.
	4. dept didn't print stacktrace for [S] if the participant of a
	   deadlock is not lock mechanism but general wait and event.
	   However, it made hard to interpret the report in that case.
	   So add support to print stacktrace of the requestor who asked
	   the event context to run - usually a waiter of the event does
	   it just before going to wait state.
	5. Give up tracking raw_local_irq_{disable,enable}() since it
	   totally messed up dept's irq tracking. So make it work in the
	   same way as lockdep does. I will consider it once any false
	   positives by those are observed again.
	6. Change the manual rwsem_acquire_read(->j_trans_commit_map)
	   annotation in fs/jbd2/transaction.c to the try version so
	   that it works as much as it exactly needs.
	7. Remove unnecessary 'inline' keyword in dept.c and add
	   '__maybe_unused' to a needed place.

Changes from v9:

	1. Fix a bug. SDT tracking didn't work well because of my big
	   mistake that I should've used waiter's map to indentify its
	   class but it had been working with waker's one. FYI,
	   PG_locked and PG_writeback weren't affected. They still
	   worked well. (reported by YoungJun)
	
Changes from v8:

	1. Fix build error by adding EXPORT_SYMBOL(PG_locked_map) and
	   EXPORT_SYMBOL(PG_writeback_map) for kernel module build -
	   appologize for that. (reported by kernel test robot)
	2. Fix build error by removing header file's circular dependency
	   that was caused by "atomic.h", "kernel.h" and "irqflags.h",
	   which I introduced - appolgize for that. (reported by kernel
	   test robot)

Changes from v7:

	1. Fix a bug that cannot track rwlock dependency properly,
	   introduced in v7. (reported by Boqun and lockdep selftest)
	2. Track wait/event of PG_{locked,writeback} more aggressively
	   assuming that when a bit of PG_{locked,writeback} is cleared
	   there might be waits on the bit. (reported by Linus, Hillf
	   and syzbot)
	3. Fix and clean bad style code e.i. unnecessarily introduced
	   a randome pattern and so on. (pointed out by Linux)
	4. Clean code for applying dept to wait_for_completion().

Changes from v6:

	1. Tie to task scheduler code to track sleep and try_to_wake_up()
	   assuming sleeps cause waits, try_to_wake_up()s would be the
	   events that those are waiting for, of course with proper dept
	   annotations, sdt_might_sleep_weak(), sdt_might_sleep_strong()
	   and so on. For these cases, class is classified at sleep
	   entrance rather than the synchronization initialization code.
	   Which would extremely reduce false alarms.
	2. Remove the dept associated instance in each page struct for
	   tracking dependencies by PG_locked and PG_writeback thanks to
	   the 1. work above.
	3. Introduce CONFIG_dept_AGGRESIVE_TIMEOUT_WAIT to suppress
	   reports that waits with timeout set are involved, for those
	   who don't like verbose reporting.
	4. Add a mechanism to refill the internal memory pools on
	   running out so that dept could keep working as long as free
	   memory is available in the system.
	5. Re-enable tracking hashed-waitqueue wait. That's going to no
	   longer generate false positives because class is classified
	   at sleep entrance rather than the waitqueue initailization.
	6. Refactor to make it easier to port onto each new version of
	   the kernel.
	7. Apply dept to dma fence.
	8. Do trivial optimizaitions.

Changes from v5:

	1. Use just pr_warn_once() rather than WARN_ONCE() on the lack
	   of internal resources because WARN_*() printing stacktrace is
	   too much for informing the lack. (feedback from Ted, Hyeonggon)
	2. Fix trivial bugs like missing initializing a struct before
	   using it.
	3. Assign a different class per task when handling onstack
	   variables for waitqueue or the like. Which makes dept
	   distinguish between onstack variables of different tasks so
	   as to prevent false positives. (reported by Hyeonggon)
	4. Make dept aware of even raw_local_irq_*() to prevent false
	   positives. (reported by Hyeonggon)
	5. Don't consider dependencies between the events that might be
	   triggered within __schedule() and the waits that requires
	    __schedule(), real ones. (reported by Hyeonggon)
	6. Unstage the staged wait that has prepare_to_wait_event()'ed
	   *and* yet to get to __schedule(), if we encounter __schedule()
	   in-between for another sleep, which is possible if e.g. a
	   mutex_lock() exists in 'condition' of ___wait_event().
	7. Turn on CONFIG_PROVE_LOCKING when CONFIG_DEPT is on, to rely
	   on the hardirq and softirq entrance tracing to make dept more
	   portable for now.

Changes from v4:

	1. Fix some bugs that produce false alarms.
	2. Distinguish each syscall context from another *for arm64*.
	3. Make it not warn it but just print it in case dept ring
	   buffer gets exhausted. (feedback from Hyeonggon)
	4. Explicitely describe "EXPERIMENTAL" and "dept might produce
	   false positive reports" in Kconfig. (feedback from Ted)

Changes from v3:

	1. dept shouldn't create dependencies between different depths
	   of a class that were indicated by *_lock_nested(). dept
	   normally doesn't but it does once another lock class comes
	   in. So fixed it. (feedback from Hyeonggon)
	2. dept considered a wait as a real wait once getting to
	   __schedule() even if it has been set to TASK_RUNNING by wake
	   up sources in advance. Fixed it so that dept doesn't consider
	   the case as a real wait. (feedback from Jan Kara)
	3. Stop tracking dependencies with a map once the event
	   associated with the map has been handled. dept will start to
	   work with the map again, on the next sleep.

Changes from v2:

	1. Disable dept on bit_wait_table[] in sched/wait_bit.c
	   reporting a lot of false positives, which is my fault.
	   Wait/event for bit_wait_table[] should've been tagged in a
	   higher layer for better work, which is a future work.
	   (feedback from Jan Kara)
	2. Disable dept on crypto_larval's completion to prevent a false
	   positive.

Changes from v1:

	1. Fix coding style and typo. (feedback from Steven)
	2. Distinguish each work context from another in workqueue.
	3. Skip checking lock acquisition with nest_lock, which is about
	   correct lock usage that should be checked by lockdep.

Changes from RFC(v0):

	1. Prevent adding a wait tag at prepare_to_wait() but __schedule().
	   (feedback from Linus and Matthew)
	2. Use try version at lockdep_acquire_cpus_lock() annotation.
	3. Distinguish each syscall context from another.

Byungchul Park (47):
  llist: move llist_{head,node} definition to types.h
  dept: implement DEPT(DEPendency Tracker)
  dept: add single event dependency tracker APIs
  dept: add lock dependency tracker APIs
  dept: tie to lockdep and IRQ tracing
  dept: add proc knobs to show stats and dependency graph
  dept: distinguish each kernel context from another
  x86_64, dept: add support CONFIG_ARCH_HAS_DEPT_SUPPORT to x86_64
  arm64, dept: add support CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64
  dept: distinguish each work from another
  dept: add a mechanism to refill the internal memory pools on running
    out
  dept: record the latest one out of consecutive waits of the same class
  dept: apply sdt_might_sleep_{start,end}() to
    wait_for_completion()/complete()
  dept: apply sdt_might_sleep_{start,end}() to swait
  dept: apply sdt_might_sleep_{start,end}() to waitqueue wait
  dept: apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
  dept: apply sdt_might_sleep_{start,end}() to dma fence
  dept: track timeout waits separately with a new Kconfig
  dept: apply timeout consideration to wait_for_completion()/complete()
  dept: apply timeout consideration to swait
  dept: apply timeout consideration to waitqueue wait
  dept: apply timeout consideration to hashed-waitqueue wait
  dept: apply timeout consideration to dma fence wait
  dept: make dept able to work with an external wgen
  dept: track PG_locked with dept
  dept: print staged wait's stacktrace on report
  locking/lockdep: prevent various lockdep assertions when
    lockdep_off()'ed
  dept: add documentation for dept
  cpu/hotplug: use a weaker annotation in AP thread
  fs/jbd2: use a weaker annotation in journal handling
  dept: assign dept map to mmu notifier invalidation synchronization
  dept: assign unique dept_key to each distinct dma fence caller
  dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
  dept: make dept stop from working on debug_locks_off()
  i2c: rename wait_for_completion callback to wait_for_completion_cb
  dept: assign unique dept_key to each distinct wait_for_completion()
    caller
  completion, dept: introduce init_completion_dmap() API
  dept: introduce a new type of dependency tracking between multi event
    sites
  dept: add module support for struct dept_event_site and
    dept_event_site_dep
  dept: introduce event_site() to disable event tracking if it's
    recoverable
  dept: implement a basic unit test for dept
  dept: call dept_hardirqs_off() in local_irq_*() regardless of irq
    state
  rcu/update: fix same dept key collision between various types of RCU
  dept: introduce APIs to set page usage and use subclasses_evt for the
    usage
  dept: track PG_writeback with dept
  SUNRPC: relocate struct rcu_head to the first field of struct rpc_xprt
  mm: percpu: increase PERCPU_DYNAMIC_SIZE_SHIFT on DEPT and large
    PAGE_SIZE

 Documentation/dependency/dept.txt     |  735 ++++++
 Documentation/dependency/dept_api.txt |  117 +
 arch/arm64/Kconfig                    |    1 +
 arch/arm64/kernel/syscall.c           |    7 +
 arch/arm64/mm/fault.c                 |    7 +
 arch/x86/Kconfig                      |    1 +
 arch/x86/entry/syscall_64.c           |    7 +
 arch/x86/mm/fault.c                   |    7 +
 drivers/dma-buf/dma-fence.c           |   23 +-
 drivers/i2c/algos/i2c-algo-pca.c      |    2 +-
 drivers/i2c/busses/i2c-pca-isa.c      |    2 +-
 drivers/i2c/busses/i2c-pca-platform.c |    2 +-
 fs/jbd2/transaction.c                 |    2 +-
 include/asm-generic/vmlinux.lds.h     |   13 +-
 include/linux/completion.h            |  124 +-
 include/linux/dept.h                  |  647 +++++
 include/linux/dept_ldt.h              |   78 +
 include/linux/dept_sdt.h              |   68 +
 include/linux/dept_unit_test.h        |   67 +
 include/linux/dma-fence.h             |   74 +-
 include/linux/hardirq.h               |    3 +
 include/linux/i2c-algo-pca.h          |    2 +-
 include/linux/irqflags.h              |   21 +-
 include/linux/llist.h                 |    8 -
 include/linux/local_lock_internal.h   |    1 +
 include/linux/lockdep.h               |  105 +-
 include/linux/lockdep_types.h         |    3 +
 include/linux/mm_types.h              |    4 +
 include/linux/mmu_notifier.h          |   26 +
 include/linux/module.h                |    5 +
 include/linux/mutex.h                 |    1 +
 include/linux/page-flags.h            |  204 +-
 include/linux/pagemap.h               |   37 +-
 include/linux/percpu-rwsem.h          |    2 +-
 include/linux/percpu.h                |    4 +
 include/linux/rcupdate_wait.h         |   13 +-
 include/linux/rtmutex.h               |    1 +
 include/linux/rwlock_types.h          |    1 +
 include/linux/rwsem.h                 |    1 +
 include/linux/sched.h                 |  118 +
 include/linux/seqlock.h               |    2 +-
 include/linux/spinlock_types_raw.h    |    3 +
 include/linux/srcu.h                  |    2 +-
 include/linux/sunrpc/xprt.h           |    9 +-
 include/linux/swait.h                 |    3 +
 include/linux/types.h                 |    8 +
 include/linux/wait.h                  |    3 +
 include/linux/wait_bit.h              |    3 +
 init/init_task.c                      |    2 +
 init/main.c                           |    2 +
 kernel/Makefile                       |    1 +
 kernel/cpu.c                          |    2 +-
 kernel/dependency/Makefile            |    5 +
 kernel/dependency/dept.c              | 3499 +++++++++++++++++++++++++
 kernel/dependency/dept_hash.h         |   10 +
 kernel/dependency/dept_internal.h     |   65 +
 kernel/dependency/dept_object.h       |   13 +
 kernel/dependency/dept_proc.c         |   94 +
 kernel/dependency/dept_unit_test.c    |  173 ++
 kernel/exit.c                         |    1 +
 kernel/fork.c                         |    2 +
 kernel/locking/lockdep.c              |   33 +
 kernel/module/main.c                  |   19 +
 kernel/rcu/rcu.h                      |    1 +
 kernel/rcu/update.c                   |    5 +-
 kernel/sched/completion.c             |   62 +-
 kernel/sched/core.c                   |    9 +
 kernel/workqueue.c                    |    3 +
 lib/Kconfig.debug                     |   51 +
 lib/debug_locks.c                     |    2 +
 lib/locking-selftest.c                |    2 +
 mm/filemap.c                          |   37 +
 mm/mm_init.c                          |    3 +
 mm/mmu_notifier.c                     |   31 +-
 74 files changed, 6570 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/dependency/dept.txt
 create mode 100644 Documentation/dependency/dept_api.txt
 create mode 100644 include/linux/dept.h
 create mode 100644 include/linux/dept_ldt.h
 create mode 100644 include/linux/dept_sdt.h
 create mode 100644 include/linux/dept_unit_test.h
 create mode 100644 kernel/dependency/Makefile
 create mode 100644 kernel/dependency/dept.c
 create mode 100644 kernel/dependency/dept_hash.h
 create mode 100644 kernel/dependency/dept_internal.h
 create mode 100644 kernel/dependency/dept_object.h
 create mode 100644 kernel/dependency/dept_proc.c
 create mode 100644 kernel/dependency/dept_unit_test.c


base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
-- 
2.17.1


