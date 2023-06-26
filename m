Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B5273DF81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjFZMnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFZMnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:43:46 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1C6890;
        Mon, 26 Jun 2023 05:43:42 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-86-64997d6a34e7
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 00/25] DEPT(Dependency Tracker)
Date:   Mon, 26 Jun 2023 20:56:35 +0900
Message-Id: <20230626115700.13873-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5+708lp3Y4WJQsriky70Btd6Et0iISiqEiiRjvkykvNtEw0
        q2lqLizQ5YWaM+Ztls6KLq5M85aVK4eZzKGW6VJbaDMvM5tFXx5+8Hvf59PD4JJC0pdRRJwV
        lBGyMCklIkRDXvmrT8VnywMftRNwIz0QnD9TCMi7b6DAfK8UgeHBJQzsdTvh4+gggsm3LTho
        Ms0I8rs7cXhQb0NgKrpMQesXb7A4HRQ0ZV6j4ErBfQreD7gwsGbdxKDUGAzNGToMqsf7CNDY
        KcjVXMHc0Y/BuL6EBn2iP/QU5dDg6g6CJlsbCaaOVZB920pBlamJgPrHPRi0Ps2jwGaYJqG5
        vpEA8w01CWXfdRQMjOpx0DsdNHyo1mJQrnIXfXOZMEge+U1Cg7raTXcrMLB8eobgeUoXBkZD
        GwW1zkEMKo2ZOEwU1iHouT5EQ1L6OA25l64juJaURUDLVAMJKusGmBzLo7Zv5msHHTivqjzH
        m0a1BP9ax/FPcjppXvW8g+a1xmi+smglX1Blx/j8YSfJG0tSKd44fJPm04YsGG9tq6L47+/e
        0XzjrUliz6LDoi1yIUwRIyjXbDsmCtUYdPRp45HzhmINmYjsO9KQB8Ox67myqTTsP1d8tv1l
        il3OtbeP4zM8l/XjKtVfyTQkYnC2wJPra3xFz4g57DpOW9JMzDDB+nNDAzr3EcOI2Q3cdOn2
        f51LuNLyanzml2N/MNxU3Rj+T/hwL4vaiQzkqUWzSpBEERETLlOErQ8IjY1QnA84HhluRO75
        6ONdIY/RsHlfDWIZJPUSBy6+JZeQspio2PAaxDG4dK54/phGLhHLZbEXBGXkUWV0mBBVgxYy
        hHSBeO3oObmEPSE7K5wShNOC8r/FGA/fRHSvJUF41XzxwMY5senH3mp3L7d5X0zvnt474ih8
        cbKn3JfYsYusDY6nrPtYddemuMQsZOnf2deZcUbtSOoNbrn67FfqMufS0PqQFRbCOW+r6Ivz
        o518WXUo/0mFy5p8x8+w2HUwxeu9Z7h24o1PXO9tRbF5OtD2cH9FwmzVyTFTh5SICpUFrcSV
        UbI/NTFARToDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRyG/f/P1dnkYFYHu7KIoMjsMvhBFnb1FBVRH7oRNdopV7piS1NJ
        8lZ5SVFBl7VsTlk2Z9ZZH6xcjVmmrdRSzMSkzDLvYE00LzWJvrw88L48n16WCEingliN9oKo
        06oiFbSMlO3dkLLqTEKhOsTathRyr4eA51caCcZKGw1N98sR2B4lYeh9GQ4fRgcQTLxtJMCQ
        34Sg+MsnAh7VdiJwlCXT0NztDy2eYRrq8zNpSCmppOFd/ySGjoI8DOXSHnDnmDE4x3tIMPTS
        cMuQgr3xA8O4xcqAJXEZdJXdZGDyyxqo72yloOZ2PQWO9pVQWNRBQ7WjnoTaqi4MzU+MNHTa
        /lDgrq0joSk3i4KKITMN/aMWAiyeYQbeO00YHqR6bX2TDgxXf05T8CrL6aXShxhaPj5F8Czt
        MwbJ1kpDjWcAg13KJ+D33ZcIurIHGbhyfZyBW0nZCDKvFJDQOPWKgtQOJUyMGemwUKFmYJgQ
        Uu0XBceoiRRem3nh8c1PjJD6rJ0RTFK0YC9bIZRU92KheMRDCZI1nRakkTxGyBhswUJHazUt
        DDU0MELdjQly38IjslC1GKmJEXWrN52QRRhsZua8dCzWds9AJaLe7RnIl+W59fzDr514hmlu
        Od/WNk7McCC3hLdnfacykIwluBI/vqfuBTNTzObW8Sarm5xhklvGD/abvSOWlXNK/k952D/n
        Yr78gZPIQawJ+VhRoEYbE6XSRCqD9Wcj4rSa2OCT56Ik5D2IJWEytwr9ag53IY5FilnykEU3
        1AGUKkYfF+VCPEsoAuVzxwzqALlaFRcv6s4d10VHinoXms+SinnyXQfFEwHcadUF8awonhd1
        /1vM+gYlom15PaVK9+Vwq5M5Gr02Of2A8vDO9ju1b/qS/CuMOw53F3WPONyn4tOKsIdpUA9d
        atrqv/5dBBTubtz4+pgxe7O2br+fjyuFvhrqM2fLN9PUwC5PEE449E0xUhyfWLBfKqgJWxCa
        AO5reyT7WOvxa89dpTlicqzf6kWZvvP6fkwrSH2Eas0KQqdX/QWpUFA2HAMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From now on, I can work on LKML again! I'm wondering if DEPT has been
helping kernel debugging well even though it's a form of patches yet.

I'm happy to see that DEPT reports a real problem in practice. See:

   https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/

Nevertheless, I apologize for the lack of document. I promise to add it
before it gets needed to use DEPT's APIs by users. For now, you can use
DEPT just with CONFIG_DEPT on.

---

Hi Linus and folks,

I've been developing a tool for detecting deadlock possibilities by
tracking wait/event rather than lock(?) acquisition order to try to
cover all synchonization machanisms. It's done on v6.2-rc2.

Benifit:

	0. Works with all lock primitives.
	1. Works with wait_for_completion()/complete().
	2. Works with 'wait' on PG_locked.
	3. Works with 'wait' on PG_writeback.
	4. Works with swait/wakeup.
	5. Works with waitqueue.
	6. Works with wait_bit.
	7. Multiple reports are allowed.
	8. Deduplication control on multiple reports.
	9. Withstand false positives thanks to 6.
	10. Easy to tag any wait/event.

Future work:

	0. To make it more stable.
	1. To separates Dept from Lockdep.
	2. To improves performance in terms of time and space.
	3. To use Dept as a dependency engine for Lockdep.
	4. To add any missing tags of wait/event in the kernel.
	5. To deduplicate stack trace.

How to interpret reports:

	1. E(event) in each context cannot be triggered because of the
	   W(wait) that cannot be woken.
	2. The stack trace helping find the problematic code is located
	   in each conext's detail.

Thanks,
Byungchul

---

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
	4. Clean code for applying DEPT to wait_for_completion().

Changes from v6:

	1. Tie to task scheduler code to track sleep and try_to_wake_up()
	   assuming sleeps cause waits, try_to_wake_up()s would be the
	   events that those are waiting for, of course with proper DEPT
	   annotations, sdt_might_sleep_weak(), sdt_might_sleep_strong()
	   and so on. For these cases, class is classified at sleep
	   entrance rather than the synchronization initialization code.
	   Which would extremely reduce false alarms.
	2. Remove the DEPT associated instance in each page struct for
	   tracking dependencies by PG_locked and PG_writeback thanks to
	   the 1. work above.
	3. Introduce CONFIG_DEPT_AGGRESIVE_TIMEOUT_WAIT to suppress
	   reports that waits with timeout set are involved, for those
	   who don't like verbose reporting.
	4. Add a mechanism to refill the internal memory pools on
	   running out so that DEPT could keep working as long as free
	   memory is available in the system.
	5. Re-enable tracking hashed-waitqueue wait. That's going to no
	   longer generate false positives because class is classified
	   at sleep entrance rather than the waitqueue initailization.
	6. Refactor to make it easier to port onto each new version of
	   the kernel.
	7. Apply DEPT to dma fence.
	8. Do trivial optimizaitions.

Changes from v5:

	1. Use just pr_warn_once() rather than WARN_ONCE() on the lack
	   of internal resources because WARN_*() printing stacktrace is
	   too much for informing the lack. (feedback from Ted, Hyeonggon)
	2. Fix trivial bugs like missing initializing a struct before
	   using it.
	3. Assign a different class per task when handling onstack
	   variables for waitqueue or the like. Which makes Dept
	   distinguish between onstack variables of different tasks so
	   as to prevent false positives. (reported by Hyeonggon)
	4. Make Dept aware of even raw_local_irq_*() to prevent false
	   positives. (reported by Hyeonggon)
	5. Don't consider dependencies between the events that might be
	   triggered within __schedule() and the waits that requires
	    __schedule(), real ones. (reported by Hyeonggon)
	6. Unstage the staged wait that has prepare_to_wait_event()'ed
	   *and* yet to get to __schedule(), if we encounter __schedule()
	   in-between for another sleep, which is possible if e.g. a
	   mutex_lock() exists in 'condition' of ___wait_event().
	7. Turn on CONFIG_PROVE_LOCKING when CONFIG_DEPT is on, to rely
	   on the hardirq and softirq entrance tracing to make Dept more
	   portable for now.

Changes from v4:

	1. Fix some bugs that produce false alarms.
	2. Distinguish each syscall context from another *for arm64*.
	3. Make it not warn it but just print it in case Dept ring
	   buffer gets exhausted. (feedback from Hyeonggon)
	4. Explicitely describe "EXPERIMENTAL" and "Dept might produce
	   false positive reports" in Kconfig. (feedback from Ted)

Changes from v3:

	1. Dept shouldn't create dependencies between different depths
	   of a class that were indicated by *_lock_nested(). Dept
	   normally doesn't but it does once another lock class comes
	   in. So fixed it. (feedback from Hyeonggon)
	2. Dept considered a wait as a real wait once getting to
	   __schedule() even if it has been set to TASK_RUNNING by wake
	   up sources in advance. Fixed it so that Dept doesn't consider
	   the case as a real wait. (feedback from Jan Kara)
	3. Stop tracking dependencies with a map once the event
	   associated with the map has been handled. Dept will start to
	   work with the map again, on the next sleep.

Changes from v2:

	1. Disable Dept on bit_wait_table[] in sched/wait_bit.c
	   reporting a lot of false positives, which is my fault.
	   Wait/event for bit_wait_table[] should've been tagged in a
	   higher layer for better work, which is a future work.
	   (feedback from Jan Kara)
	2. Disable Dept on crypto_larval's completion to prevent a false
	   positive.

Changes from v1:

	1. Fix coding style and typo. (feedback from Steven)
	2. Distinguish each work context from another in workqueue.
	3. Skip checking lock acquisition with nest_lock, which is about
	   correct lock usage that should be checked by Lockdep.

Changes from RFC(v0):

	1. Prevent adding a wait tag at prepare_to_wait() but __schedule().
	   (feedback from Linus and Matthew)
	2. Use try version at lockdep_acquire_cpus_lock() annotation.
	3. Distinguish each syscall context from another.

Byungchul Park (25):
  llist: Move llist_{head,node} definition to types.h
  dept: Implement Dept(Dependency Tracker)
  dept: Add single event dependency tracker APIs
  dept: Add lock dependency tracker APIs
  dept: Tie to Lockdep and IRQ tracing
  dept: Add proc knobs to show stats and dependency graph
  dept: Apply sdt_might_sleep_{start,end}() to
    wait_for_completion()/complete()
  dept: Apply sdt_might_sleep_{start,end}() to PG_{locked,writeback}
    wait
  dept: Apply sdt_might_sleep_{start,end}() to swait
  dept: Apply sdt_might_sleep_{start,end}() to waitqueue wait
  dept: Apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
  dept: Distinguish each syscall context from another
  dept: Distinguish each work from another
  dept: Add a mechanism to refill the internal memory pools on running
    out
  locking/lockdep, cpu/hotplus: Use a weaker annotation in AP thread
  dept: Apply sdt_might_sleep_{start,end}() to dma fence wait
  dept: Track timeout waits separately with a new Kconfig
  dept: Apply timeout consideration to wait_for_completion()/complete()
  dept: Apply timeout consideration to swait
  dept: Apply timeout consideration to waitqueue wait
  dept: Apply timeout consideration to hashed-waitqueue wait
  dept: Apply timeout consideration to dma fence wait
  dept: Record the latest one out of consecutive waits of the same class
  dept: Make Dept able to work with an external wgen
  dept: Track the potential waits of PG_{locked,writeback}

 arch/arm64/kernel/syscall.c         |    2 +
 arch/x86/entry/common.c             |    4 +
 drivers/dma-buf/dma-fence.c         |    5 +
 include/linux/completion.h          |   30 +-
 include/linux/dept.h                |  614 ++++++
 include/linux/dept_ldt.h            |   77 +
 include/linux/dept_sdt.h            |   66 +
 include/linux/hardirq.h             |    3 +
 include/linux/irqflags.h            |   22 +-
 include/linux/llist.h               |    8 -
 include/linux/local_lock_internal.h |    1 +
 include/linux/lockdep.h             |  102 +-
 include/linux/lockdep_types.h       |    3 +
 include/linux/mm_types.h            |    3 +
 include/linux/mutex.h               |    1 +
 include/linux/page-flags.h          |  112 +-
 include/linux/pagemap.h             |    7 +-
 include/linux/percpu-rwsem.h        |    2 +-
 include/linux/rtmutex.h             |    1 +
 include/linux/rwlock_types.h        |    1 +
 include/linux/rwsem.h               |    1 +
 include/linux/sched.h               |    3 +
 include/linux/seqlock.h             |    2 +-
 include/linux/spinlock_types_raw.h  |    3 +
 include/linux/srcu.h                |    2 +-
 include/linux/swait.h               |    3 +
 include/linux/types.h               |    8 +
 include/linux/wait.h                |    3 +
 include/linux/wait_bit.h            |    3 +
 init/init_task.c                    |    2 +
 init/main.c                         |    2 +
 kernel/Makefile                     |    1 +
 kernel/cpu.c                        |    2 +-
 kernel/dependency/Makefile          |    4 +
 kernel/dependency/dept.c            | 3167 +++++++++++++++++++++++++++
 kernel/dependency/dept_hash.h       |   10 +
 kernel/dependency/dept_internal.h   |   26 +
 kernel/dependency/dept_object.h     |   13 +
 kernel/dependency/dept_proc.c       |   93 +
 kernel/exit.c                       |    1 +
 kernel/fork.c                       |    2 +
 kernel/locking/lockdep.c            |   23 +
 kernel/module/main.c                |    2 +
 kernel/sched/completion.c           |    2 +-
 kernel/sched/core.c                 |    9 +
 kernel/workqueue.c                  |    3 +
 lib/Kconfig.debug                   |   37 +
 lib/locking-selftest.c              |    2 +
 mm/filemap.c                        |   18 +
 mm/page_alloc.c                     |    3 +
 50 files changed, 4459 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/dept.h
 create mode 100644 include/linux/dept_ldt.h
 create mode 100644 include/linux/dept_sdt.h
 create mode 100644 kernel/dependency/Makefile
 create mode 100644 kernel/dependency/dept.c
 create mode 100644 kernel/dependency/dept_hash.h
 create mode 100644 kernel/dependency/dept_internal.h
 create mode 100644 kernel/dependency/dept_object.h
 create mode 100644 kernel/dependency/dept_proc.c

-- 
2.17.1

