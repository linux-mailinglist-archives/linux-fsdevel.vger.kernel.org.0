Return-Path: <linux-fsdevel+bounces-70758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6CCA6613
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 08:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BC763200694
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2352F5478;
	Fri,  5 Dec 2025 07:19:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29923239E7D;
	Fri,  5 Dec 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919159; cv=none; b=ohf5iVmuObPbfSMos7G/Wyd5gZJKhIv2xQaWfVX/vNenaRwv49e2PAVJCOgiMyyG01dxEy39DgS6GPRGHTULZhuk9htR652vrR+VZoq1FYVTJ+68maL3VMxStwjcqSB+DRbvKgPFZDjavTjKkwGv9IXFXT0Z/6ckFI6cQ+gG3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919159; c=relaxed/simple;
	bh=Okitfwld5t54PURqgkDIt9ITAZlg1mmlq1UiUdoRqy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ejq55fwG/wWrhDcoE71WOSiwX7eT4wPtV+n1XeiuDGMnKCovhflhbBefXW8TH3y/N0EbnM9ii4lCSNrRGxBNieRARZEphO+QSAjoUWwZfRJ2ID08tPuBV7WOz5TkuFd7lZ0wZ7SK1gvwgVoIGH5PqcfL6mvS4A+KR7mShDhIKH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-eb-6932876a750c
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
Subject: [PATCH v18 00/42] DEPT(DEPendency Tracker)
Date: Fri,  5 Dec 2025 16:18:13 +0900
Message-Id: <20251205071855.72743-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbZRTG89773ttLs85rN+K7aURryJItTpjTnJjFaaLxJkZDNIuJbtFO
	7kZd+Wr5XObsBrWVMceKDGmR8bWGQLdiO8zA4mqRZqxsqVRYhcHAdVUEwkbKSPmwFtzi/jl5
	8jznd55/DkfLDexmTpWVJ2qylGoFK8XSmXUNz39m2KFK+caiAKP+Cxg65sYwHzFiqLXbWDA6
	ahi4cuM4Bv+FNgQLSxYa9J0xDCsmrwQi0REJxLq9CIL+yzRM9cwhqJ48hmHWWo7AHLZIYLL3
	LZi59SMDN+5PI7CG/qEg5DYgWDlzCM42OlmorvIjuOgdQ3CnooOGQGg99FWdYOHX/ikE4eFu
	Ckqa7Cx0jndJ4OYZEwVtjnfgljWMwVfRSMXrWLBUl1Dx8RcFUWurBPqbbmKw6pJheSIVYvXZ
	MHqqCsNU2MSC4/deBJHfJigwds1jcNweYqB7eBs0fNmMwdXdh8G4EkHgvfQHBYGuWhbGbDEG
	dJYFBux/Binwea9gGLl2SgIT40EGnNf66dfSBf3ACivY6mxIWFo0IaFnepYWSp2FwjnfNCss
	zg+ywtVGIjR/tUgJneZRiVD607BEqHfkC6W/zDCCs2Wr0OSapISGuXkmLeVD6a50Ua0qEDUv
	vPqJNOO0/o2cO5dRUXttPa1DoyZUhhI4wu8ktut25qH2NJ9gVzXLbyHBYJRe1Rv5Z4jzZDi+
	I+VoPpBEDNGv14IN/ItEZx1YAzCfTO61f7umZfxL5PQPkQcFSaSt3U3/5z9O+mpCuAxx8UNb
	iL1OvmrT8ZWSDgu9ep/wVxPIwNLcA3YT+bkliCvQevMjuPl/3PwIXo/oViRXZRVkKlXqndsz
	irNURds/zc50oPh7Wj9f/ugSmvO/70E8hxTrZO7CVJWcURZoizM9iHC0YqNsWp2iksvSlcWH
	RU32x5p8taj1oCc5rHhCtuN+YbqcP6jMEw+JYo6oeZhSXMJmHUpcHNxtOanf39G6r8YXqDu8
	UHBRXzn2XNWBIZJ21pfk8r3t7/VsStz21Eg55ZBW5rTn5QY0ift2XX/lqJhypFI/TL18915P
	kaL4vb8/mDAkP3071FJ23KI5Up539Nk014bz2vx3c7M5V7R0z97xN5dbXx/PdTvufje4u+HC
	97Oxx9yZCqzNUKZupTVa5b8PHSi8mgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTdxTG97//29tLty7XiuFGP7hUp4lGfEGTk3TRacy8GufmPmiybGoj
	N/ZKqaZVkCVGSunocJK2SYu2CJVBo8CkUnxB00AgEtE5eVHAl66QXcs6ijgpkoIFC26ZX06e
	c87veXI+HBorhiQLaUF3jNfr1FolJSNlu1SmVULROmGNOLMOLOZT8CwkSqDX2ELCeMxCQll9
	HQUJ93UpWBrOSeBOXwEJnZdrEYTGLQgmptwYzE0zJCTs7VKIxZ9KwWFEMBNoR+DssmPo72zG
	UNdoJGDMN03BcNsrBI5BkYLSiJGEUe/PCFxhtxQit7fBSOiWBGaCQwT0vY4i8IrTBIgtRQgS
	ziyoqPQn7c6XFEzdf4Ch1NGJ4MJgEMOryACCxvY/EAQuFlDw3HoVQ4/4MTwcH6Wgw3GagpGu
	MgJe+CjwFAQk0PXbMILzbjuC8JMAAaZf6ilwnm8goWngphS6ht8Q8MxpJ6C24UsIecMk3LNW
	Eslzk9SVNHCXmohk+YsAx6+3CIh7a6SfVyNuwlxCcjX+awRn7k5QXF15HeKmJu2Ii1WbMGe2
	Jtu26CjmCv25XPW9KMVNjj+iuMBrD8ndrWS5qp8mCc52fxXX5ApKv978reyzTF4r5PD61RsP
	yDQ289ajz5vRCV+ZB+ejoB0VoxSaZdazrVWnqVlNMcvZ/v44ntWpzCes/0xYUoxkNGZ6FrNF
	8ZK5xXwmg833ds8ZSOZT9h/f2TktZzawtmuxf0MXs7W+FvxuPo/tOCeSxYhOBi1n68sVs2Oc
	RExX3diKPnS9R7n+p1zvUR6Ea1CqoMvJVgvaDemGLE2eTjiRfvBIdgNKvp/35BvbDRTr2daK
	GBopP5K35K4VFBJ1jiEvuxWxNFamyqPaNYJCnqnO+4HXH9mvP67lDa1oEU0q0+Q79vIHFMwh
	9TE+i+eP8vr/tgSdsjAflT0s701XaYb23t614EXi+0Ixc6KiL7pzsojbtyR+dnsiI7zCQkSW
	Hq7SxUc3Pf7gK++eLd22oMlx/M/tIykLImM3Qk8uzdNYlzX/OKhvnK7/u3xl2p2nF0qyti5V
	qTIuL1JFK4Y27/R8I27aPdDLG3/PzRe/8Jd8xxZOxcciOR18m5I0aNRrV2C9Qf0WhpQSdHoD
	AAA=
X-CFilter-Loop: Reflected

I'm happy to see that DEPT reported real problems in practice:

   https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/
   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
   https://lore.kernel.org/all/b6e00e77-4a8c-4e05-ab79-266bf05fcc2d@igalia.com/

I’ve added documentation describing DEPT — this should help you
understand what DEPT is and how it works.  You can use DEPT simply by
enabling CONFIG_DEPT and checking dmesg at runtime.
---

Hi Linus and folks,

I’ve been developing a tool to detect deadlock possibilities by tracking
waits/events — rather than lock acquisition order — to cover all the
synchronization mechanisms.  To summarize the design rationale, starting
from the problem statement, through analysis, to the solution:

   CURRENT STATUS
   --------------
   Lockdep tracks lock acquisition order to identify deadlock conditions.
   Additionally, it tracks IRQ state changes — via {en,dis}able — to
   detect cases where locks are acquired unintentionally during
   interrupt handling.
   
   PROBLEM
   -------
   Waits and their associated events that are never reachable can
   eventually lead to deadlocks.  However, since Lockdep focuses solely
   on lock acquisition order, it has inherent limitations when handling
   waits and events.
   
   Moreover, by tracking only lock acquisition order, Lockdep cannot
   properly handle read locks or cross-event scenarios — such as
   wait_for_completion() and complete() — making it increasingly
   inadequate as a general-purpose deadlock detection tool.
   
   SOLUTION
   --------
   Once again, waits and their associated events that are never
   reachable can eventually lead to deadlocks.  The new solution, DEPT,
   focuses directly on waits and events.  DEPT monitors waits and events,
   and reports them when any become unreachable.

DEPT provides:

   * Correct handling of read locks.
   * Support for general waits and events.
   * Continuous operation, even after multiple reports.
   * Simple, intuitive annotation APIs.

There are still false positives, and some are already being worked on
for suppression.  Especially splitting the folio class into several
appropriate classes e.g. block device mapping class and regular file
mapping class, is currently under active development by me and Yeoreum
Yun.

Anyway, these efforts will need to continue for a while, as we’ve seen
with lockdep over two decades.  DEPT is tagged as EXPERIMENTAL in
Kconfig — meaning it’s not yet suitable for use as an automation tool.

However, for those who are interested in using DEPT to analyze complex
synchronization patterns and extract dependency insights, DEPT would be
a great tool for the purpose.

Thanks for your support and contributions to:

   Harry Yoo <harry.yoo@oracle.com>
   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
   Yunseong Kim <ysk@kzalloc.com>
   Yeoreum Yun <yeoreum.yun@arm.com>

FAQ
---
Q. Is this the first attempt to solve this problem?
A. No. The cross-release feature (commit b09be676e0ff2) attempted to
   address it — as a Lockdep extension.  It was merged, but quickly
   reverted, because:

   While it uncovered valuable hidden issues, it also introduced false
   positives.  Since these false positives mask further real problems
   with Lockdep — and developers strongly dislike them — the feature was
   rolled back.

Q. Why wasn’t DEPT built as a Lockdep extension?
A. Lockdep is the result of years of work by kernel developers — and is
   now very stable. But I chose to build DEPT separately, because:

   While reusing BFS(Breadth First Search) and Lockdep’s hashing is
   beneficial, the rest of the system must be rebuilt from scratch to
   align with DEPT’s wait-event model — since Lockdep was originally
   designed for tracking lock acquisition orders, not wait-event
   dependencies.

Q. Do you plan to replace Lockdep entirely?
A. Not at all — Lockdep still plays a vital role in validating correct
   lock usage.  While its dependency-checking logic should eventually be
   superseded by DEPT, the rest of its functionality should stay.

Q. Should we replace the dependency check immediately?
A. Absolutely not.  Lockdep’s stability is the result of years of hard
   work by kernel developers.  Lockdep and DEPT should run side by side
   until DEPT matures.

Q. Stronger detection often leads to more false positives — which was a
   major pain point when cross-release was added.  Is DEPT designed to
   handle this?
A. Yes.  DEPT’s simple, generalized design enables flexible reporting —
   so while false positives still need fixing, they’re far less
   disruptive than they were under the Lockdep extension, cross-release.

Q. Why not fix all false positives out-of-tree before merging?
A. Since the affected subsystems span the entire kernel, like Lockdep,
   which has relied on annotations to avoid false positives over the
   last two decades, DEPT too will require the annotation efforts.

   Performing annotation work within the mainline will help us add
   annotations more appropriately and will also make DEPT a useful tool
   for a wider range of users more quickly.

   CONFIG_DEPT is marked EXPERIMENTAL, so it’s opt-in. Some users are
   already interested in using DEPT to analyze complex synchronization
   patterns and extract dependency insights.

	Byungchul
---
Changes from v17:

	1. Rebase on the mainline as of 2025 Dec 5.
	2. Convert the documents' format from txt to rst. (feedbacked
	   by Jonathan Corbet and Bagas Sanjaya)
	3. Move the documents from 'Documentation/dependency' to
	   'Documentation/dev-tools'. (feedbakced by Jonathan Corbet)
	4. Improve the documentation. (feedbacked by NeilBrown)
	5. Use a common function, enter_from_user_mode(), instead of
	   arch specific code, to notice context switch from user mode.
	   (feedbacked by Dave Hansen, Mark Rutland, and Mark Brown)
	6. Resolve the header dependency issue by using dept's internal
	   header, instead of relocating 'struct llist_{head,node}' to
	   another header. (feedbacked by Greg KH)
	7. Improve page(or folio) usage type APIs.
	8. Add rust helper for wait_for_completion(). (feedbacked by
	   Guangbo Cui, Boqun Feng, and Danilo Krummrich)
	9. Refine some commit messages.

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

Byungchul Park (41):
  dept: implement DEPT(DEPendency Tracker)
  dept: add single event dependency tracker APIs
  dept: add lock dependency tracker APIs
  dept: tie to lockdep and IRQ tracing
  dept: add proc knobs to show stats and dependency graph
  dept: distinguish each kernel context from another
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
  dept: add documents for dept
  cpu/hotplug: use a weaker annotation in AP thread
  dept: assign dept map to mmu notifier invalidation synchronization
  dept: assign unique dept_key to each distinct dma fence caller
  dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
  dept: make dept stop from working on debug_locks_off()
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
  dept: introduce APIs to set page usage and use subclasses_evt for the
    usage
  dept: track PG_writeback with dept
  SUNRPC: relocate struct rcu_head to the first field of struct rpc_xprt
  mm: percpu: increase PERCPU_DYNAMIC_SIZE_SHIFT on DEPT and large
    PAGE_SIZE

Yunseong Kim (1):
  rcu/update: fix same dept key collision between various types of RCU

 Documentation/dev-tools/dept.rst     |  778 ++++++
 Documentation/dev-tools/dept_api.rst |  125 +
 drivers/dma-buf/dma-fence.c          |   23 +-
 include/asm-generic/vmlinux.lds.h    |   13 +-
 include/linux/completion.h           |  124 +-
 include/linux/dept.h                 |  402 +++
 include/linux/dept_ldt.h             |   78 +
 include/linux/dept_sdt.h             |   68 +
 include/linux/dept_unit_test.h       |   67 +
 include/linux/dma-fence.h            |   74 +-
 include/linux/hardirq.h              |    3 +
 include/linux/irq-entry-common.h     |    4 +
 include/linux/irqflags.h             |   21 +-
 include/linux/local_lock_internal.h  |    1 +
 include/linux/lockdep.h              |  105 +-
 include/linux/lockdep_types.h        |    3 +
 include/linux/mm_types.h             |    4 +
 include/linux/mmu_notifier.h         |   26 +
 include/linux/module.h               |    5 +
 include/linux/mutex.h                |    1 +
 include/linux/page-flags.h           |  217 +-
 include/linux/pagemap.h              |   37 +-
 include/linux/percpu-rwsem.h         |    2 +-
 include/linux/percpu.h               |    4 +
 include/linux/rcupdate_wait.h        |   13 +-
 include/linux/rtmutex.h              |    1 +
 include/linux/rwlock_types.h         |    1 +
 include/linux/rwsem.h                |    1 +
 include/linux/sched.h                |  118 +
 include/linux/seqlock.h              |    2 +-
 include/linux/spinlock_types_raw.h   |    3 +
 include/linux/srcu.h                 |    2 +-
 include/linux/sunrpc/xprt.h          |    9 +-
 include/linux/swait.h                |    3 +
 include/linux/wait.h                 |    3 +
 include/linux/wait_bit.h             |    3 +
 init/init_task.c                     |    2 +
 init/main.c                          |    2 +
 kernel/Makefile                      |    1 +
 kernel/cpu.c                         |    2 +-
 kernel/dependency/Makefile           |    5 +
 kernel/dependency/dept.c             | 3499 ++++++++++++++++++++++++++
 kernel/dependency/dept_hash.h        |   10 +
 kernel/dependency/dept_internal.h    |  314 +++
 kernel/dependency/dept_object.h      |   13 +
 kernel/dependency/dept_proc.c        |   94 +
 kernel/dependency/dept_unit_test.c   |  173 ++
 kernel/exit.c                        |    1 +
 kernel/fork.c                        |    2 +
 kernel/locking/lockdep.c             |   33 +
 kernel/module/main.c                 |   19 +
 kernel/rcu/rcu.h                     |    1 +
 kernel/rcu/update.c                  |    5 +-
 kernel/sched/completion.c            |   62 +-
 kernel/sched/core.c                  |    9 +
 kernel/workqueue.c                   |    3 +
 lib/Kconfig.debug                    |   48 +
 lib/debug_locks.c                    |    2 +
 lib/locking-selftest.c               |    2 +
 mm/filemap.c                         |   38 +
 mm/mm_init.c                         |    3 +
 mm/mmu_notifier.c                    |   31 +-
 rust/helpers/completion.c            |    5 +
 63 files changed, 6602 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/dev-tools/dept.rst
 create mode 100644 Documentation/dev-tools/dept_api.rst
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


base-commit: 43dfc13ca972988e620a6edb72956981b75ab6b0
-- 
2.17.1


