Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F3E745949
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGCJtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjGCJtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:47 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E76C1B2;
        Mon,  3 Jul 2023 02:49:40 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-d9-64a299b1d587
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
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 rebased on v6.4 00/25] DEPT(Dependency Tracker)
Date:   Mon,  3 Jul 2023 18:47:27 +0900
Message-Id: <20230703094752.79269-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0iTexjH/f3eq6vF25LOW0HFQCKj0ih7ioig248gzMqCInK1l1xNjXlJ
        OxaW09PxEmXpakrNKWup3TaDMlfL8t7FUnamqKVJJ9FpWRst7XS06J8vH/g8z/evL08pSpnZ
        vCYuUdLFqbRKVkbLPFNLFtsum9WhOW4azueGgvfLGRqKb1Wy0HqzAkFl1SkMA3Wb4R/fEIKx
        5y8pMBS0Iijp7aagqr4HgcN6moW2/mnQ7h1hoakgh4WM0lssvBocx9BVmI+hwrYVWs6ZMTj9
        /9JgGGChyJCBJ+IDBr+lnANLejD0WY0cjPeGQVOPiwFH5yK4fKWLhRpHEw319/owtFUXs9BT
        +YOBlvpGGlrP5zFwY9jMwqDPQoHFO8LBa6cJw239RFHW5/8YaMhzYsgqu4OhveMBgodn3mKw
        VbpYeOIdwmC3FVDw7Vodgr6zHg4yc/0cFJ06iyAns5CGl98bGNB3rYCxr8XsutXkydAIRfT2
        Y8ThM9Gk2SyS+8ZujugfdnLEZEsidmsIKa0ZwKRk1MsQW/nfLLGN5nMk29OOyfCLFxxpvDRG
        k/52A942Z49sjVrSapIl3dK10bKYrIo6fLR6X4rpqx+no6GN2SiQF4XlovFRFfObXe983CSz
        wgLR7fZTkxwkzBftee8nbmQ8Jfw1RbR+fM5OihnCevGN8cJPpoVg0Vmt/8lyYYXosmawv0rn
        iRW3ndTksyh84cVPD4a5X2KW+Njqps+hKSYUUI4UmrjkWJVGu3xJTGqcJmXJwfhYG5qYjuXE
        +N57aLR1Ry0SeKScKnf/WaJWMKrkhNTYWiTylDJIntF7Va2Qq1WpxyVd/H5dklZKqEVzeFr5
        h3yZ75haIRxSJUpHJOmopPttMR84Ox0lPXV3XoxcWPs5bYZGfNW2K9R48m50AymYGxIcC/Ok
        6OzTERHdG8febyoLf7rFXBjYkesYfGfvXbimY/pcT3PLqsRZ4a7xdc3bV0aOmA4HLc2cGblh
        lSdqxyJt9U1/mON14YH6xk/SzpVl96NqnqW5v6XVbf8RYIjID0jpN4Rfj9odr6QTYlRhIZQu
        QfU/cnbScjYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMfxzHvd+fz+f9+XTfjo9kPvhuOG6MoazmNb5fsxm9Z/N7k9naOe4z
        3VTsjkixuLv4RlbspB+4wrnVUe7a0A9OrZLWD0piidLQlOjb3Trl+1XMP889tsf2+OspMEEW
        boagjzsoG+K0MSqiYBUbV5oW38nK14VYBudBxtkQ8A6dZiG3yEmg+XYhAmfJCQy91RHwwteH
        YKShiYFMazOCvK7XDJTUdCKocJwk0NIzEVq9AwTqrGcImK4VEXj6aRRDx8XzGApdG6A+PR+D
        x/+BhcxeAjmZJjw2HzH47QU82JPV0O3I5mG0KxTqOts4qLpcx0HFq0WQdaWDQHlFHQs197ox
        tJTmEuh0/s9Bfc1jFpoz0ji49TmfwCefnQG7d4CHZx4bhmLzWC3l3/84qE3zYEi5fgdD68sy
        BA9Ov8XgcrYRqPL2YXC7rAx8u1mNoPtcPw+Ws34eck6cQ3DGcpGFpu+1HJg7wmFkOJesXkmr
        +gYYanYfphU+G0uf5Ev0fvZrnpofvOKpzXWIuh0L6bXyXkzzBr0cdRX8Q6hr8DxPU/tbMf3c
        2MjTx5dGWNrTmok3/7lT8ZdOjtHHy4alq3YpolMKq/GB0qgjtmE/TkZ9a1NRgCCJYVLbOx8/
        zkScL7W3+5lxDhZnS+6091wqUgiMeOoPyfGlgYyLKeIa6U32hZ/MimrJU2r+yUoxXGpzmMiv
        6CypsNjDpCPBhiYUoGB9XHysVh8TvsS4LzohTn9kyZ79sS40dg77sdGMe2ioJaISiQJSBSrb
        E/N0QZw23pgQW4kkgVEFK01dV3VBSp024ahs2K8xHIqRjZVopsCqpinXR8q7gsS92oPyPlk+
        IBt+WywEzEhG7nTzjb+HNe2a0AXLv0yKiCzwB3gu5ExbFDa3AQVMT5xaNkwat876trY2cHv9
        sas71kVpVleXlt9ctS1sTv/x2jL6cIWrZkoP6zv5sLvFavlapOr9QBOztkUliUWPkq0a4fkQ
        TdqUFLLl2ZrvzmVNA2p1NL6bBIER9pKezepNk3erWGO0NnQhYzBqfwBW2XDWGAMAAA==
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
cover all synchonization machanisms. It's done on v6.4, the latest.

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
 kernel/module/main.c                |    4 +
 kernel/sched/completion.c           |    2 +-
 kernel/sched/core.c                 |    9 +
 kernel/workqueue.c                  |    3 +
 lib/Kconfig.debug                   |   37 +
 lib/locking-selftest.c              |    2 +
 mm/filemap.c                        |   18 +
 mm/mm_init.c                        |    3 +
 50 files changed, 4461 insertions(+), 55 deletions(-)
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

