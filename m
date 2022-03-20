Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733904E1B33
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Mar 2022 11:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbiCTK7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Mar 2022 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244105AbiCTK7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Mar 2022 06:59:47 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AACF2CE32
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 03:58:21 -0700 (PDT)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 20 Mar 2022 19:58:21 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 20 Mar 2022 19:58:21 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Sun, 20 Mar 2022 19:57:41 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jack@suse.com,
        jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        djwong@kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com
Subject: Re: [PATCH v4 00/24] DEPT(Dependency Tracker)
Message-ID: <20220320105740.GB11318@X58A-UD3R>
References: <1646377603-19730-1-git-send-email-byungchul.park@lge.com>
 <Yiv9Fn4kcRbXJLmu@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220316043212.GA5715@X58A-UD3R>
 <YjGuGmdiZCpRt98n@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220318075129.GB17484@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318075129.GB17484@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 04:51:29PM +0900, Byungchul Park wrote:
> On Wed, Mar 16, 2022 at 09:30:02AM +0000, Hyeonggon Yoo wrote:
> > On Wed, Mar 16, 2022 at 01:32:13PM +0900, Byungchul Park wrote:
> > > On Sat, Mar 12, 2022 at 01:53:26AM +0000, Hyeonggon Yoo wrote:
> > > > On Fri, Mar 04, 2022 at 04:06:19PM +0900, Byungchul Park wrote:
> > > > > Hi Linus and folks,
> > > > > 
> > > > > I've been developing a tool for detecting deadlock possibilities by
> > > > > tracking wait/event rather than lock(?) acquisition order to try to
> > > > > cover all synchonization machanisms. It's done on v5.17-rc1 tag.
> > > > > 
> > > > > https://github.com/lgebyungchulpark/linux-dept/commits/dept1.14_on_v5.17-rc1
> > > > >
> > > > 
> > > > Small feedback unrelated to thread:
> > > > I'm not sure "Need to expand the ring buffer" is something to call
> > > > WARN(). Is this stack trace useful for something?
> > > > ========
> > > > 
> > > > Hello Byungchul. These are two warnings of DEPT on system.
> > > 
> > > Hi Hyeonggon,
> > > 
> > > Could you run scripts/decode_stacktrace.sh and share the result instead
> > > of the raw format below if the reports still appear with PATCH v5? It'd
> > > be appreciated (:
> > >
> > 
> > Hi Byungchul.
> > 
> > on dept1.18_on_v5.17-rc7, the kernel_clone() warning has gone.
> > There is one warning remaining on my system:
> > 
> > It warns when running kunit-try-catch-test testcase.
> 
> Hi Hyeonggon,
> 
> I can reproduce it thanks to you. I will let you know on all works done.

Hi Hyeonggon,

All works wrt this issue have been done. I've just updated the same
branch.

https://github.com/lgebyungchulpark/linux-dept/commits/dept1.18_on_v5.17-rc7

This is just for your information.

Thanks,
Byungchul

> 
> Thanks,
> Byungchul
> 
> > ===================================================
> > DEPT: Circular dependency has been detected.
> > 5.17.0-rc7+ #4 Not tainted
> > ---------------------------------------------------
> > summary
> > ---------------------------------------------------
> > *** AA DEADLOCK ***
> > 
> > context A
> > [S] (unknown)(&try_completion:0)
> > [W] wait_for_completion_timeout(&try_completion:0)
> > [E] complete(&try_completion:0)
> > 
> > [S]: start of the event context
> > [W]: the wait blocked
> > [E]: the event not reachable
> > ---------------------------------------------------
> > context A's detail
> > ---------------------------------------------------
> > context A
> > [S] (unknown)(&try_completion:0)
> > [W] wait_for_completion_timeout(&try_completion:0)
> > [E] complete(&try_completion:0)
> > 
> > [S] (unknown)(&try_completion:0):
> > (N/A)
> > 
> > [W] wait_for_completion_timeout(&try_completion:0):
> > kunit_try_catch_run (lib/kunit/try-catch.c:78 (discriminator 1)) 
> > stacktrace:
> > dept_wait (kernel/dependency/dept.c:2149) 
> > wait_for_completion_timeout (kernel/sched/completion.c:119 (discriminator 4) kernel/sched/completion.c:165 (discriminator 4)) 
> > kunit_try_catch_run (lib/kunit/try-catch.c:78 (discriminator 1)) 
> > kunit_test_try_catch_successful_try_no_catch (lib/kunit/kunit-test.c:43) 
> > kunit_try_run_case (lib/kunit/test.c:333 lib/kunit/test.c:374) 
> > kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:30) 
> > kthread (kernel/kthread.c:379) 
> > ret_from_fork (arch/arm64/kernel/entry.S:757)
> > 
> > [E] complete(&try_completion:0):
> > kthread_complete_and_exit (kernel/kthread.c:327) 
> > stacktrace:
> > dept_event (kernel/dependency/dept.c:2376 (discriminator 2)) 
> > complete (kernel/sched/completion.c:33 (discriminator 4)) 
> > kthread_complete_and_exit (kernel/kthread.c:327) 
> > kunit_try_catch_throw (lib/kunit/try-catch.c:18) 
> > kthread (kernel/kthread.c:379) 
> > ret_from_fork (arch/arm64/kernel/entry.S:757) 
> > 
> > ---------------------------------------------------
> > information that might be helpful
> > ---------------------------------------------------
> > Hardware name: linux,dummy-virt (DT)
> > Call trace:
> > dump_backtrace.part.0 (arch/arm64/kernel/stacktrace.c:186) 
> > show_stack (arch/arm64/kernel/stacktrace.c:193) 
> > dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
> > dump_stack (lib/dump_stack.c:114) 
> > print_circle (./arch/arm64/include/asm/atomic_ll_sc.h:112 ./arch/arm64/include/asm/atomic.h:30 ./include/linux/atomic/atomic-arch-fallback.h:511 ./include/linux/atomic/atomic-instrumented.h:258 kernel/dependency/dept.c:140 kernel/dependency/dept.c:748) 
> > cb_check_dl (kernel/dependency/dept.c:1083 kernel/dependency/dept.c:1064) 
> > bfs (kernel/dependency/dept.c:833) 
> > add_dep (kernel/dependency/dept.c:1409) 
> > do_event (kernel/dependency/dept.c:175 kernel/dependency/dept.c:1644) 
> > dept_event (kernel/dependency/dept.c:2376 (discriminator 2)) 
> > complete (kernel/sched/completion.c:33 (discriminator 4)) 
> > kthread_complete_and_exit (kernel/kthread.c:327) 
> > kunit_try_catch_throw (lib/kunit/try-catch.c:18) 
> > kthread (kernel/kthread.c:379) 
> > ret_from_fork (arch/arm64/kernel/entry.S:757)
> > 
> > -- 
> > Thank you, You are awesome!
> > Hyeonggon :-)
> > 
> > > https://lkml.org/lkml/2022/3/15/1277
> > > (or https://github.com/lgebyungchulpark/linux-dept/commits/dept1.18_on_v5.17-rc7)
> > > 
> > > Thank you very much!
> > > 
> > > --
> > > Byungchul
> > > 
> > > > Both cases look similar.
> > > > 
> > > > In what case DEPT says (unknown)?
> > > > I'm not sure we can properly debug this.
> > > > 
> > > > ===================================================
> > > > DEPT: Circular dependency has been detected.
> > > > 5.17.0-rc1+ #3 Tainted: G        W        
> > > > ---------------------------------------------------
> > > > summary
> > > > ---------------------------------------------------
> > > > *** AA DEADLOCK ***
> > > > 
> > > > context A
> > > >     [S] (unknown)(&vfork:0)
> > > >     [W] wait_for_completion_killable(&vfork:0)
> > > >     [E] complete(&vfork:0)
> > > > 
> > > > [S]: start of the event context
> > > > [W]: the wait blocked
> > > > [E]: the event not reachable
> > > > ---------------------------------------------------
> > > > context A's detail
> > > > ---------------------------------------------------
> > > > context A
> > > >     [S] (unknown)(&vfork:0)
> > > >     [W] wait_for_completion_killable(&vfork:0)
> > > >     [E] complete(&vfork:0)
> > > > 
> > > > [S] (unknown)(&vfork:0):
> > > > (N/A)
> > > > 
> > > > [W] wait_for_completion_killable(&vfork:0):
> > > > [<ffffffc00802204c>] kernel_clone+0x25c/0x2b8
> > > > stacktrace:
> > > >       dept_wait+0x74/0x88
> > > >       wait_for_completion_killable+0x60/0xa0
> > > >       kernel_clone+0x25c/0x2b8
> > > >       __do_sys_clone+0x5c/0x74
> > > >       __arm64_sys_clone+0x18/0x20
> > > >       invoke_syscall.constprop.0+0x78/0xc4
> > > >       do_el0_svc+0x98/0xd0
> > > >       el0_svc+0x44/0xe4
> > > >       el0t_64_sync_handler+0xb0/0x12c
> > > >       el0t_64_sync+0x158/0x15c
> > > > 
> > > > [E] complete(&vfork:0):
> > > > [<ffffffc00801f49c>] mm_release+0x7c/0x90
> > > > stacktrace:
> > > >       dept_event+0xe0/0x100
> > > >       complete+0x48/0x98
> > > >       mm_release+0x7c/0x90
> > > >       exit_mm_release+0xc/0x14
> > > >       do_exit+0x1b4/0x81c
> > > >       do_group_exit+0x30/0x9c
> > > >       __wake_up_parent+0x0/0x24
> > > >       invoke_syscall.constprop.0+0x78/0xc4
> > > >       do_el0_svc+0x98/0xd0
> > > >       el0_svc+0x44/0xe4
> > > >       el0t_64_sync_handler+0xb0/0x12c
> > > >       el0t_64_sync+0x158/0x15c
> > > > ---------------------------------------------------
> > > > information that might be helpful
> > > > ---------------------------------------------------
> > > > CPU: 6 PID: 229 Comm: start-stop-daem Tainted: G        W         5.17.0-rc1+ #3
> > > > Hardware name: linux,dummy-virt (DT)
> > > > Call trace:
> > > >  dump_backtrace.part.0+0x9c/0xc4
> > > >  show_stack+0x14/0x28
> > > >  dump_stack_lvl+0x9c/0xcc
> > > >  dump_stack+0x14/0x2c
> > > >  print_circle+0x2d4/0x438
> > > >  cb_check_dl+0x44/0x70
> > > >  bfs+0x60/0x168
> > > >  add_dep+0x88/0x11c
> > > >  do_event.constprop.0+0x19c/0x2c0
> > > >  dept_event+0xe0/0x100
> > > >  complete+0x48/0x98
> > > >  mm_release+0x7c/0x90
> > > >  exit_mm_release+0xc/0x14
> > > >  do_exit+0x1b4/0x81c
> > > >  do_group_exit+0x30/0x9c
> > > >  __wake_up_parent+0x0/0x24
> > > >  invoke_syscall.constprop.0+0x78/0xc4
> > > >  do_el0_svc+0x98/0xd0
> > > >  el0_svc+0x44/0xe4
> > > >  el0t_64_sync_handler+0xb0/0x12c
> > > >  el0t_64_sync+0x158/0x15c
> > > > 
> > > > 
> > > > 
> > > > 
> > > > ===================================================
> > > > DEPT: Circular dependency has been detected.
> > > > 5.17.0-rc1+ #3 Tainted: G        W        
> > > > ---------------------------------------------------
> > > > summary
> > > > ---------------------------------------------------
> > > > *** AA DEADLOCK ***
> > > > 
> > > > context A
> > > >     [S] (unknown)(&try_completion:0)
> > > >     [W] wait_for_completion_timeout(&try_completion:0)
> > > >     [E] complete(&try_completion:0)
> > > > 
> > > > [S]: start of the event context
> > > > [W]: the wait blocked
> > > > [E]: the event not reachable
> > > > ---------------------------------------------------
> > > > context A's detail
> > > > ---------------------------------------------------
> > > > context A
> > > >     [S] (unknown)(&try_completion:0)
> > > >     [W] wait_for_completion_timeout(&try_completion:0)
> > > >     [E] complete(&try_completion:0)
> > > > 
> > > > [S] (unknown)(&try_completion:0):
> > > > (N/A)
> > > > 
> > > > [W] wait_for_completion_timeout(&try_completion:0):
> > > > [<ffffffc008166bf4>] kunit_try_catch_run+0xb4/0x160
> > > > stacktrace:
> > > >       dept_wait+0x74/0x88
> > > >       wait_for_completion_timeout+0x64/0xa0
> > > >       kunit_try_catch_run+0xb4/0x160
> > > >       kunit_test_try_catch_successful_try_no_catch+0x3c/0x98
> > > >       kunit_try_run_case+0x9c/0xa0
> > > >       kunit_generic_run_threadfn_adapter+0x1c/0x28
> > > >       kthread+0xd4/0xe4
> > > >       ret_from_fork+0x10/0x20
> > > > 
> > > > [E] complete(&try_completion:0):
> > > > [<ffffffc00803dce4>] kthread_complete_and_exit+0x18/0x20
> > > > stacktrace:
> > > >       dept_event+0xe0/0x100
> > > >       complete+0x48/0x98
> > > >       kthread_complete_and_exit+0x18/0x20
> > > >       kunit_try_catch_throw+0x0/0x1c
> > > >       kthread+0xd4/0xe4
> > > >       ret_from_fork+0x10/0x20
> > > > 
> > > > ---------------------------------------------------
> > > > information that might be helpful
> > > > ---------------------------------------------------
> > > > CPU: 15 PID: 132 Comm: kunit_try_catch Tainted: G        W         5.17.0-rc1+ #3
> > > > Hardware name: linux,dummy-virt (DT)
> > > > Call trace:
> > > >  dump_backtrace.part.0+0x9c/0xc4
> > > >  show_stack+0x14/0x28
> > > >  dump_stack_lvl+0x9c/0xcc
> > > >  dump_stack+0x14/0x2c
> > > >  print_circle+0x2d4/0x438
> > > >  cb_check_dl+0x44/0x70
> > > >  bfs+0x60/0x168
> > > >  add_dep+0x88/0x11c
> > > >  do_event.constprop.0+0x19c/0x2c0
> > > >  dept_event+0xe0/0x100
> > > >  complete+0x48/0x98
> > > >  kthread_complete_and_exit+0x18/0x20
> > > >  kunit_try_catch_throw+0x0/0x1c
> > > >  kthread+0xd4/0xe4
> > > >  ret_from_fork+0x10/0x20
> > > > 
> > > > 
> > > > > Benifit:
> > > > > 
> > > > > 	0. Works with all lock primitives.
> > > > > 	1. Works with wait_for_completion()/complete().
> > > > > 	2. Works with 'wait' on PG_locked.
> > > > > 	3. Works with 'wait' on PG_writeback.
> > > > > 	4. Works with swait/wakeup.
> > > > > 	5. Works with waitqueue.
> > > > > 	6. Multiple reports are allowed.
> > > > > 	7. Deduplication control on multiple reports.
> > > > > 	8. Withstand false positives thanks to 6.
> > > > > 	9. Easy to tag any wait/event.
> > > > > 
> > > > > Future work:
> > > > 
> > > > [...]
> > > > 
> > > > > -- 
> > > > > 1.9.1
> > > > > 
> > > > 
> > > > -- 
> > > > Thank you, You are awesome!
> > > > Hyeonggon :-)
