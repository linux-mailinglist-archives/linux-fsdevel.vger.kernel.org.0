Return-Path: <linux-fsdevel+bounces-48931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 268D4AB611A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 05:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6987B0D4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 03:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F781EB5EB;
	Wed, 14 May 2025 03:08:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7242D128395;
	Wed, 14 May 2025 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747192095; cv=none; b=FZI0/Fk1d9r/vIZvES4OBrRAxQ4Xvt6bfOTA+ywnaCe+j/73k1pnEnrBfjXtVQN5tB5t7KqbElZPgTBTTPP5glO0AZYSNi9uxRzU692NIdk4SuPgf40UIEzDJm7l0sTmKos1APkV0Tyxg0gDbS04YdUfdy79iF0j28nyznSpUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747192095; c=relaxed/simple;
	bh=v9qTBHvZLPI/56vC/yHVRFIlc6ImhLJjm3C2Qk1sI6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThotU5JnCgR8AHbdy7t9FwBv/ogGpu3gHO7JjEC9x0Z1g8Jnn7nHWyZE/Hp1WW2qUjlu4NNIm2Q3Vatd16HdixTQIcLxC/kNWU5TgmM87CM77zK/4oJXIbVQxZkJhqP9lwldYDMorsRmhkX0uGK7bansR3ktGGwl0mAZ4SiwDuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c9-68240914a88b
Date: Wed, 14 May 2025 12:07:59 +0900
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, will@kernel.org,
	tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
	sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
	johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
	hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yskelg@gmail.com, yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com
Subject: Re: [PATCH v15 00/43] DEPT(DEPendency Tracker)
Message-ID: <20250514030759.GB48035@system.software.com>
References: <20250513100730.12664-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SYUxTZxSG83339t7bSs1dEfwmmi2IMWGRDaLb+bEtS2bml8xFk2XLMmO0
	s3drN0BXBGXJNpBCoAJjLEisDCu4gnBVLLi5SRnDAKsIq4DYISJ0hsCkQMA2ArWsrTHzz8mT
	9z153/PjCIzmO26dYEg/LBnTtanxnIpVeaNqtsQoE/SvPDqnBt/DQhaqLsocuC40IpBbcjFM
	de6A2/5pBMu9fzFQWeFCcGb8LgMtXaMIHPXHOBi4vxoGfbMcOCuOc5BXe5GDmw8CGEZOlGNo
	tL8H92wTLPSU1WConOLgVGUeDo1JDIu2Bh5sOZvAU2/hITCeDM7RIQU4hl+Ck9UjHLQ6nCx0
	XfFgGPitioNReUUBPV1/suAvjQPX9yUKOD9Tw8EDv40Bm2+Wh/52K4Yuayw0mUKBBQtBBXSX
	tGMoOHsJw+DfVxG0FY5hsMtDHFzzTWNotlcwsFTXicBT6uUhv3iRh1O5pQiO559gwTSyDZYf
	hZp/fJgMuaebWDj/eAi99QaVq2VEr03PMtTUfIQu+W5x1OG3svR6DaG/Wu7y1NQ2zFOrPZM2
	1yfS2tYpTM/M+xTU3lDEUft8OU/N3kFMZ/r6+N3rP1a9rpNSDVmS8eU396v0ly73okMz1eio
	fKyKzUHjmWakFIi4lXgCXuYpt1ltXJhZcRNxOpoiOiduJm73YoTXiC+S5pIJhRmpBEYsXkX+
	bc1DYSNafI1c9cxFWC0CGc7t5sOsEbeRMmsj+0R/jjhP3o8wIyYSd3AKm5EQ4jhSFxTCslJ8
	lTyu64usxIgbSfvP3TjcRcR+JWm/sYCfHPo8+aPezZYh0fJMrOWZWMv/sVbENCCNIT0rTWtI
	3Zqkz043HE06cDDNjkJvavs6sOcKmne934FEAcVHqWHLRr1Goc3KyE7rQERg4teob38ektQ6
	bfZXkvHgPmNmqpTRgeIENn6tOsV/RKcRP9Melr6QpEOS8amLBeW6HKTjU4oKE2O/jF6VN5by
	zy/9RXVLRU07VXdqF2Pnij8p2CBhV3D/NwZ1tPZesOedn+70Lkw655PEtxO8MYVnt/8QWJZ7
	bQM7Nu/69sD6CysvJDS8u2GncONm+aerV+ai1mbmX5/cvvujXb8njbkvf/Chy3wrbs9eYZ+O
	DJpkkCdoC+2MZzP02uRExpih/Q9VzKF8ogMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUyTZxSG8zzvJ5Wad7XOJxDjrJIZFByJ6En8iDGpvFvCsuzHlmDiqPJm
	LVAgrTA7s0ilEkQhaIbMCqyCKQQqYOvXkBICAnaGr4GApOBgxo2BoIw2qyLasiz65+TKfZ/7
	3H8OTyleMBG8LuOYZMjQpKtYGS37fHdejDJss/aTkh9jwLdYQEN5o4OF/oZ6BI4bZgzTnQkw
	4p9F8Kqnj4Ky0n4EVybHKbjRNYHAXXuKhcEnq2HIN8+Cp/QsC3nVjSwMzCxh8F68gKHemQiP
	7U9peFBShaFsmoXLZXk4OP7CELDXcWDPjYKpWisHS5Nx4JkYZqCjwsOAe2wrXKr0stDi9tDQ
	dWcKw2BzOQsTjjcMPOi6T4O/OBL6zxcxcG2uioUZv50Cu2+eg9/abBi6bB9CkyV4Nf+fZQa6
	i9ow5F+9jmHo0V0ErQW/Y3A6hlno8M1icDlLKXhZ04lgqvgZB6fPBTi4bC5GcPb0RRos3nh4
	9W+wuWIxDsw/N9Fw7fUw2r9PdFQ6kNgxO0+JFtd34kvfQ1Z0+220+GsVEX+xjnOipXWME23O
	bNFVGy1Wt0xj8cqCjxGddWdY0blwgRMLnw1hca63l/tifZJsT4qUrsuRDNv3Jcu012/2oKy5
	SnTccaqczkWT2YUojCfCDtJqs7MhpoUo4nE3USFmhY/J6GhghZXCR8RV9JQpRDKeEs6tIn+3
	5KGQsUbYRe5OPV9huQBkzNzNhVghxJMSWz39n/4B8Vx6ssKUEE1Gl6dxIeKDHElqlvmQHCbs
	JK9reldW1gqbSNutblyC5Nb30tb30tZ3aRui6pBSl5Gj1+jS42ONaVpThu547NFMvRMFH9H+
	w9L5O2hxMKEdCTxShcshZpNWwWhyjCZ9OyI8pVLKR1KDkjxFY/peMmR+Y8hOl4ztKJKnVevk
	n30tJSuEbzXHpDRJypIM/7uYD4vIRepB/UHLFvXjQ/tNUeEDf6h7Ejfqaxq6vW/kzUm5EXNp
	nfmrn+cHGtULxXV8ztCBwMg99/bEw3u3nkzbM3LC2adurkitVp7YmfRTgmYgeby9YFXyn58e
	OZISK/V5TaWpBke4sGHbbPTRjTNrRxvMMa6vDq75cnFv7EmDIvE22eXvvK+ijVpNXDRlMGre
	ApzpoNCEAwAA
X-CFilter-Loop: Reflected

On Tue, May 13, 2025 at 07:06:47PM +0900, Byungchul Park wrote:
> I'm happy to see that dept reported a real problem in practice. See:
> 
>    https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
>    https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
> 
> I added a document describing dept, that would help you understand what
> dept is and how dept works. You can use dept just with CONFIG_DEPT on
> and by checking dmesg in runtime.
> 
> There are still false positives here and there and some of those are
> already in progress to suppress and the efforts are essencial until it
> gets more stable as lockdep experienced.
> 
> It's worth noting that EXPERIMENTAL in Kconfig is tagged.

I missed thanks for the support and contribution to:

   Harry Yoo <harry.yoo@oracle.com>
   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
   Yunseong Kim <yskelg@gmail.com>
   Yeoreum Yun <yeoreum.yun@arm.com>

Thank you :)

	Byungchul

> ---
> 
> Hi Linus and folks,
> 
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock acquisition order to try to cover
> all synchonization machanisms.
> 
> Benefits:
> 
> 	0. Works with all lock primitives.
> 	1. Works with wait_for_completion()/complete().
> 	2. Works with PG_locked.
> 	3. Works with swait/wakeup.
> 	4. Works with waitqueue.
> 	5. Works with wait_bit.
> 	6. Multiple reports are allowed.
> 	7. Deduplication control on multiple reports.
> 	8. Withstand false positives thanks to 7.
> 	9. Easy to tag any wait/event.
> 
> Future works:
> 
> 	0. To make it more stable.
> 	1. To separates dept from lockdep.
> 	2. To improves performance in terms of time and space.
> 	3. To use dept as a dependency engine for lockdep.
> 	4. To add any missing tags of wait/event in the kernel.
> 	5. To deduplicate memory space for stack traces.
> 
> How to interpret reports:
> (See the document in this patchset for more detail.)
> 
> 	[S] the start of the event context
> 	[W] the wait disturbing the event from being triggered
> 	[E] the event that cannot be reachable
> 
> Thanks.
> 
> 	Byungchul
> 
> ---
> 
> Changes from v14:
> 	1. Rebase on the current latest, v6.15-rc6.
> 	2. Refactor dept code.
> 	3. With multi event sites for a single wait, even if an event
> 	   forms a circular dependency, the event can be recovered by
> 	   other event(or wake up) paths.  Even though informing the
> 	   circular dependency is worthy but it should be suppressed
> 	   once informing it, if it doesn't lead an actual deadlock.  So
> 	   introduce APIs to annotate the relationship between event
> 	   site and recover site, that are, event_site() and
> 	   dept_recover_event().
> 	4. wait_for_completion() worked with dept map embedded in struct
> 	   completion.  However, it generates a few false positves since
> 	   all the waits using the instance of struct completion, share
> 	   the map and key.  To avoid the false positves, make it not to
> 	   share the map and key but each wait_for_completion() caller
> 	   have its own key by default.  Of course, external maps also
> 	   can be used if needed.
> 	5. Fix a bug about hardirq on/off tracing.
> 	6. Implement basic unit test for dept.
> 	7. Add more supports for dma fence synchronization.
> 	8. Add emergency stop of dept e.g. on panic().
> 	9. Fix false positives by mmu_notifier_invalidate_*().
> 	10. Fix recursive call bug by DEPT_WARN_*() and DEPT_STOP().
> 	11. Fix trivial bugs in DEPT_WARN_*() and DEPT_STOP().
> 	12. Fix a bug that a spin lock, dept_pool_spin, is used in
> 	    both contexts of irq disabled and enabled without irq
> 	    disabled.
> 	13. Suppress reports with classes, any of that already have
> 	    been reported, even though they have different chains but
> 	    being barely meaningful.
> 	14. Print stacktrace of the wait that an event is now waking up,
> 	    not only stacktrace of the event.
> 	15. Make dept aware of lockdep_cmp_fn() that is used to avoid
> 	    false positives in lockdep so that dept can also avoid them.
> 	16. Do do_event() only if there are no ecxts have been
> 	    delimited.
> 	17. Fix a bug that was not synchronized for stage_m in struct
> 	    dept_task, using a spin lock, dept_task()->stage_lock.
> 	18. Fix a bug that dept didn't handle the case that multiple
> 	    ttwus for a single waiter can be called at the same time
> 	    e.i. a race issue.
> 	19. Distinguish each kernel context from others, not only by
> 	    system call but also by user oriented fault so that dept can
> 	    work with more accuracy information about kernel context.
> 	    That helps to avoid a few false positives.
> 	20. Limit dept's working to x86_64 and arm64.
> 
> Changes from v13:
> 
> 	1. Rebase on the current latest version, v6.9-rc7.
> 	2. Add 'dept' documentation describing dept APIs.
> 
> Changes from v12:
> 
> 	1. Refine the whole document for dept.
> 	2. Add 'Interpret dept report' section in the document, using a
> 	   deadlock report obtained in practice. Hope this version of
> 	   document helps guys understand dept better.
> 
> 	   https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
> 	   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
> 
> Changes from v11:
> 
> 	1. Add 'dept' documentation describing the concept of dept.
> 	2. Rewrite the commit messages of the following commits for
> 	   using weaker lockdep annotation, for better description.
> 
> 	   fs/jbd2: Use a weaker annotation in journal handling
> 	   cpu/hotplug: Use a weaker annotation in AP thread
> 
> 	   (feedbacked by Thomas Gleixner)
> 
> Changes from v10:
> 
> 	1. Fix noinstr warning when building kernel source.
> 	2. dept has been reporting some false positives due to the folio
> 	   lock's unfairness. Reflect it and make dept work based on
> 	   dept annotaions instead of just wait and wake up primitives.
> 	3. Remove the support for PG_writeback while working on 2. I
> 	   will add the support later if needed.
> 	4. dept didn't print stacktrace for [S] if the participant of a
> 	   deadlock is not lock mechanism but general wait and event.
> 	   However, it made hard to interpret the report in that case.
> 	   So add support to print stacktrace of the requestor who asked
> 	   the event context to run - usually a waiter of the event does
> 	   it just before going to wait state.
> 	5. Give up tracking raw_local_irq_{disable,enable}() since it
> 	   totally messed up dept's irq tracking. So make it work in the
> 	   same way as lockdep does. I will consider it once any false
> 	   positives by those are observed again.
> 	6. Change the manual rwsem_acquire_read(->j_trans_commit_map)
> 	   annotation in fs/jbd2/transaction.c to the try version so
> 	   that it works as much as it exactly needs.
> 	7. Remove unnecessary 'inline' keyword in dept.c and add
> 	   '__maybe_unused' to a needed place.
> 
> Changes from v9:
> 
> 	1. Fix a bug. SDT tracking didn't work well because of my big
> 	   mistake that I should've used waiter's map to indentify its
> 	   class but it had been working with waker's one. FYI,
> 	   PG_locked and PG_writeback weren't affected. They still
> 	   worked well. (reported by YoungJun)
> 	
> Changes from v8:
> 
> 	1. Fix build error by adding EXPORT_SYMBOL(PG_locked_map) and
> 	   EXPORT_SYMBOL(PG_writeback_map) for kernel module build -
> 	   appologize for that. (reported by kernel test robot)
> 	2. Fix build error by removing header file's circular dependency
> 	   that was caused by "atomic.h", "kernel.h" and "irqflags.h",
> 	   which I introduced - appolgize for that. (reported by kernel
> 	   test robot)
> 
> Changes from v7:
> 
> 	1. Fix a bug that cannot track rwlock dependency properly,
> 	   introduced in v7. (reported by Boqun and lockdep selftest)
> 	2. Track wait/event of PG_{locked,writeback} more aggressively
> 	   assuming that when a bit of PG_{locked,writeback} is cleared
> 	   there might be waits on the bit. (reported by Linus, Hillf
> 	   and syzbot)
> 	3. Fix and clean bad style code e.i. unnecessarily introduced
> 	   a randome pattern and so on. (pointed out by Linux)
> 	4. Clean code for applying dept to wait_for_completion().
> 
> Changes from v6:
> 
> 	1. Tie to task scheduler code to track sleep and try_to_wake_up()
> 	   assuming sleeps cause waits, try_to_wake_up()s would be the
> 	   events that those are waiting for, of course with proper dept
> 	   annotations, sdt_might_sleep_weak(), sdt_might_sleep_strong()
> 	   and so on. For these cases, class is classified at sleep
> 	   entrance rather than the synchronization initialization code.
> 	   Which would extremely reduce false alarms.
> 	2. Remove the dept associated instance in each page struct for
> 	   tracking dependencies by PG_locked and PG_writeback thanks to
> 	   the 1. work above.
> 	3. Introduce CONFIG_dept_AGGRESIVE_TIMEOUT_WAIT to suppress
> 	   reports that waits with timeout set are involved, for those
> 	   who don't like verbose reporting.
> 	4. Add a mechanism to refill the internal memory pools on
> 	   running out so that dept could keep working as long as free
> 	   memory is available in the system.
> 	5. Re-enable tracking hashed-waitqueue wait. That's going to no
> 	   longer generate false positives because class is classified
> 	   at sleep entrance rather than the waitqueue initailization.
> 	6. Refactor to make it easier to port onto each new version of
> 	   the kernel.
> 	7. Apply dept to dma fence.
> 	8. Do trivial optimizaitions.
> 
> Changes from v5:
> 
> 	1. Use just pr_warn_once() rather than WARN_ONCE() on the lack
> 	   of internal resources because WARN_*() printing stacktrace is
> 	   too much for informing the lack. (feedback from Ted, Hyeonggon)
> 	2. Fix trivial bugs like missing initializing a struct before
> 	   using it.
> 	3. Assign a different class per task when handling onstack
> 	   variables for waitqueue or the like. Which makes dept
> 	   distinguish between onstack variables of different tasks so
> 	   as to prevent false positives. (reported by Hyeonggon)
> 	4. Make dept aware of even raw_local_irq_*() to prevent false
> 	   positives. (reported by Hyeonggon)
> 	5. Don't consider dependencies between the events that might be
> 	   triggered within __schedule() and the waits that requires
> 	    __schedule(), real ones. (reported by Hyeonggon)
> 	6. Unstage the staged wait that has prepare_to_wait_event()'ed
> 	   *and* yet to get to __schedule(), if we encounter __schedule()
> 	   in-between for another sleep, which is possible if e.g. a
> 	   mutex_lock() exists in 'condition' of ___wait_event().
> 	7. Turn on CONFIG_PROVE_LOCKING when CONFIG_DEPT is on, to rely
> 	   on the hardirq and softirq entrance tracing to make dept more
> 	   portable for now.
> 
> Changes from v4:
> 
> 	1. Fix some bugs that produce false alarms.
> 	2. Distinguish each syscall context from another *for arm64*.
> 	3. Make it not warn it but just print it in case dept ring
> 	   buffer gets exhausted. (feedback from Hyeonggon)
> 	4. Explicitely describe "EXPERIMENTAL" and "dept might produce
> 	   false positive reports" in Kconfig. (feedback from Ted)
> 
> Changes from v3:
> 
> 	1. dept shouldn't create dependencies between different depths
> 	   of a class that were indicated by *_lock_nested(). dept
> 	   normally doesn't but it does once another lock class comes
> 	   in. So fixed it. (feedback from Hyeonggon)
> 	2. dept considered a wait as a real wait once getting to
> 	   __schedule() even if it has been set to TASK_RUNNING by wake
> 	   up sources in advance. Fixed it so that dept doesn't consider
> 	   the case as a real wait. (feedback from Jan Kara)
> 	3. Stop tracking dependencies with a map once the event
> 	   associated with the map has been handled. dept will start to
> 	   work with the map again, on the next sleep.
> 
> Changes from v2:
> 
> 	1. Disable dept on bit_wait_table[] in sched/wait_bit.c
> 	   reporting a lot of false positives, which is my fault.
> 	   Wait/event for bit_wait_table[] should've been tagged in a
> 	   higher layer for better work, which is a future work.
> 	   (feedback from Jan Kara)
> 	2. Disable dept on crypto_larval's completion to prevent a false
> 	   positive.
> 
> Changes from v1:
> 
> 	1. Fix coding style and typo. (feedback from Steven)
> 	2. Distinguish each work context from another in workqueue.
> 	3. Skip checking lock acquisition with nest_lock, which is about
> 	   correct lock usage that should be checked by lockdep.
> 
> Changes from RFC(v0):
> 
> 	1. Prevent adding a wait tag at prepare_to_wait() but __schedule().
> 	   (feedback from Linus and Matthew)
> 	2. Use try version at lockdep_acquire_cpus_lock() annotation.
> 	3. Distinguish each syscall context from another.
> 
> Byungchul Park (43):
>   llist: move llist_{head,node} definition to types.h
>   dept: implement DEPT(DEPendency Tracker)
>   dept: add single event dependency tracker APIs
>   dept: add lock dependency tracker APIs
>   dept: tie to lockdep and IRQ tracing
>   dept: add proc knobs to show stats and dependency graph
>   dept: distinguish each kernel context from another
>   x86_64, dept: add support CONFIG_ARCH_HAS_DEPT_SUPPORT to x86_64
>   arm64, dept: add support CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64
>   dept: distinguish each work from another
>   dept: add a mechanism to refill the internal memory pools on running
>     out
>   dept: record the latest one out of consecutive waits of the same class
>   dept: apply sdt_might_sleep_{start,end}() to
>     wait_for_completion()/complete()
>   dept: apply sdt_might_sleep_{start,end}() to swait
>   dept: apply sdt_might_sleep_{start,end}() to waitqueue wait
>   dept: apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
>   dept: apply sdt_might_sleep_{start,end}() to dma fence
>   dept: track timeout waits separately with a new Kconfig
>   dept: apply timeout consideration to wait_for_completion()/complete()
>   dept: apply timeout consideration to swait
>   dept: apply timeout consideration to waitqueue wait
>   dept: apply timeout consideration to hashed-waitqueue wait
>   dept: apply timeout consideration to dma fence wait
>   dept: make dept able to work with an external wgen
>   dept: track PG_locked with dept
>   dept: print staged wait's stacktrace on report
>   locking/lockdep: prevent various lockdep assertions when
>     lockdep_off()'ed
>   dept: suppress reports with classes that have been already reported
>   dept: add documentation for dept
>   cpu/hotplug: use a weaker annotation in AP thread
>   fs/jbd2: use a weaker annotation in journal handling
>   dept: assign dept map to mmu notifier invalidation synchronization
>   dept: assign unique dept_key to each distinct dma fence caller
>   dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
>   dept: make dept stop from working on debug_locks_off()
>   i2c: rename wait_for_completion callback to wait_for_completion_cb
>   dept: assign unique dept_key to each distinct wait_for_completion()
>     caller
>   completion, dept: introduce init_completion_dmap() API
>   dept: introduce a new type of dependency tracking between multi event
>     sites
>   dept: add module support for struct dept_event_site and
>     dept_event_site_dep
>   dept: introduce event_site() to disable event tracking if it's
>     recoverable
>   dept: implement a basic unit test for dept
>   dept: call dept_hardirqs_off() in local_irq_*() regardless of irq
>     state
> 
>  Documentation/dependency/dept.txt     |  735 ++++++
>  Documentation/dependency/dept_api.txt |  117 +
>  arch/arm64/Kconfig                    |    1 +
>  arch/arm64/kernel/syscall.c           |    7 +
>  arch/arm64/mm/fault.c                 |    7 +
>  arch/x86/Kconfig                      |    1 +
>  arch/x86/entry/syscall_64.c           |    7 +
>  arch/x86/mm/fault.c                   |    7 +
>  drivers/dma-buf/dma-fence.c           |   17 +-
>  drivers/i2c/algos/i2c-algo-pca.c      |    2 +-
>  drivers/i2c/busses/i2c-pca-isa.c      |    2 +-
>  drivers/i2c/busses/i2c-pca-platform.c |    2 +-
>  fs/jbd2/transaction.c                 |    2 +-
>  include/asm-generic/vmlinux.lds.h     |   13 +-
>  include/linux/completion.h            |  124 +-
>  include/linux/dept.h                  |  625 +++++
>  include/linux/dept_ldt.h              |   77 +
>  include/linux/dept_sdt.h              |   67 +
>  include/linux/dept_unit_test.h        |   67 +
>  include/linux/dma-fence.h             |   74 +-
>  include/linux/hardirq.h               |    3 +
>  include/linux/i2c-algo-pca.h          |    2 +-
>  include/linux/irqflags.h              |   21 +-
>  include/linux/llist.h                 |    8 -
>  include/linux/local_lock_internal.h   |    1 +
>  include/linux/lockdep.h               |  105 +-
>  include/linux/lockdep_types.h         |    3 +
>  include/linux/mm_types.h              |    2 +
>  include/linux/mmu_notifier.h          |   26 +
>  include/linux/module.h                |    5 +
>  include/linux/mutex.h                 |    1 +
>  include/linux/page-flags.h            |  125 +-
>  include/linux/pagemap.h               |    7 +-
>  include/linux/percpu-rwsem.h          |    2 +-
>  include/linux/rtmutex.h               |    1 +
>  include/linux/rwlock_types.h          |    1 +
>  include/linux/rwsem.h                 |    1 +
>  include/linux/sched.h                 |  120 +-
>  include/linux/seqlock.h               |    2 +-
>  include/linux/spinlock_types_raw.h    |    3 +
>  include/linux/srcu.h                  |    2 +-
>  include/linux/swait.h                 |    3 +
>  include/linux/types.h                 |    8 +
>  include/linux/wait.h                  |    3 +
>  include/linux/wait_bit.h              |    3 +
>  init/init_task.c                      |    2 +
>  init/main.c                           |    2 +
>  kernel/Makefile                       |    1 +
>  kernel/cpu.c                          |    2 +-
>  kernel/dependency/Makefile            |    5 +
>  kernel/dependency/dept.c              | 3510 +++++++++++++++++++++++++
>  kernel/dependency/dept_hash.h         |   10 +
>  kernel/dependency/dept_internal.h     |   64 +
>  kernel/dependency/dept_object.h       |   13 +
>  kernel/dependency/dept_proc.c         |   93 +
>  kernel/dependency/dept_unit_test.c    |  173 ++
>  kernel/exit.c                         |    1 +
>  kernel/fork.c                         |    2 +
>  kernel/locking/lockdep.c              |   33 +
>  kernel/module/main.c                  |   19 +
>  kernel/sched/completion.c             |   62 +-
>  kernel/sched/core.c                   |    8 +
>  kernel/workqueue.c                    |    3 +
>  lib/Kconfig.debug                     |   51 +
>  lib/debug_locks.c                     |    2 +
>  lib/locking-selftest.c                |    2 +
>  mm/filemap.c                          |   26 +
>  mm/mm_init.c                          |    2 +
>  mm/mmu_notifier.c                     |   31 +-
>  69 files changed, 6404 insertions(+), 125 deletions(-)
>  create mode 100644 Documentation/dependency/dept.txt
>  create mode 100644 Documentation/dependency/dept_api.txt
>  create mode 100644 include/linux/dept.h
>  create mode 100644 include/linux/dept_ldt.h
>  create mode 100644 include/linux/dept_sdt.h
>  create mode 100644 include/linux/dept_unit_test.h
>  create mode 100644 kernel/dependency/Makefile
>  create mode 100644 kernel/dependency/dept.c
>  create mode 100644 kernel/dependency/dept_hash.h
>  create mode 100644 kernel/dependency/dept_internal.h
>  create mode 100644 kernel/dependency/dept_object.h
>  create mode 100644 kernel/dependency/dept_proc.c
>  create mode 100644 kernel/dependency/dept_unit_test.c
> 
> 
> base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
> -- 
> 2.17.1

