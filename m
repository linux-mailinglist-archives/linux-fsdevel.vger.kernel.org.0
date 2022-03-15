Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FA14D9AD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 13:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348133AbiCOMFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiCOMFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:05:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7ED52E72;
        Tue, 15 Mar 2022 05:04:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s42so19329908pfg.0;
        Tue, 15 Mar 2022 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uk+trKTmv4OHZazX5n2Z6Y+7WCkuvCW9bJ/ylyLCIlU=;
        b=bVptJXmwmq6k6OUSAUF/Yd1FQ97UY+8l6gG1Iu8Q3dPLGZCllHLa0o+bs5xgaEKJng
         eEubmm6FZCCeC/xB5/6J999xTjq9nXfcWjh8XJnp3jTsxPiDHccMt/GwHtCynaPRCsdd
         OpSfUrOrgKuZffNOHq+DW2hGttb9Vpfb2YsOsxnvFhZm123lCvJYCUAk3/5eICa5d7t+
         V9xgDRhMfGXU/pRIcicwDfu26iUIqHtLG6z36YR+6q4aCPpTEm5d5nCzjqDTxLFCskXH
         LJn1f88cgrUqihu2eY/8IrKZwnn9wq/mU/qTrjBuy+EW9LgTmRv/WekgNIkbYwPgGGG2
         qQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uk+trKTmv4OHZazX5n2Z6Y+7WCkuvCW9bJ/ylyLCIlU=;
        b=Yu2QD9JVEUfg6G3Y3e4RxU7Lr1jl1DmbHTJDZlDRI7f6d6mWkzjpklxHzv2rxwq4cs
         nmdvnWkRSSE/91+ZFb8lYe76pijOgpqY2BFBmD9/LWIsVEOQunAvuC/iUcPN4MlZVm6q
         IUszdNa2JiDkqkNqttgiBbVHKSCCHt5taszohMjhTpSTzJ+AY7HzC2ArqW79fqJkUQaC
         2PXTme4OOjwkcnoXiEWA4WSvA2/UN3F7v1AyQKz+mVe0yOYvegdQh/E5nKNe1VigUxjY
         eIcyLqoEBqBWlDhEjbsmKJ9bVykEtppc1GpDluh1kPUdWCyxtWfnjHLzZiCGPD8GYG2f
         G8Ow==
X-Gm-Message-State: AOAM530hLcNOJ8V0CwI0HQKo2KchDQYfJjf/Piv64MAiUNMz+hd55Tjj
        aUyT28Gonfftgx2x90cEcE4=
X-Google-Smtp-Source: ABdhPJzDMpKhPVS3UR+SPpnJBt/JV72yW+bNTlusJ5lGLtPSPFG4eaHSQgeZyvz3EZ59vk34Jl6rLg==
X-Received: by 2002:aa7:9156:0:b0:4f6:dbc5:d0be with SMTP id 22-20020aa79156000000b004f6dbc5d0bemr28531425pfi.13.1647345862671;
        Tue, 15 Mar 2022 05:04:22 -0700 (PDT)
Received: from odroid ([114.29.23.97])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00218200b004f66d50f054sm24227869pfi.158.2022.03.15.05.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 05:04:22 -0700 (PDT)
Date:   Tue, 15 Mar 2022 12:04:07 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Byungchul Park <byungchul.park@lge.com>
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
Message-ID: <20220315120407.GA1471334@odroid>
References: <1646377603-19730-1-git-send-email-byungchul.park@lge.com>
 <Yiv9Fn4kcRbXJLmu@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220314065906.GA6255@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314065906.GA6255@X58A-UD3R>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 14, 2022 at 03:59:06PM +0900, Byungchul Park wrote:
> On Sat, Mar 12, 2022 at 01:53:26AM +0000, Hyeonggon Yoo wrote:
> > On Fri, Mar 04, 2022 at 04:06:19PM +0900, Byungchul Park wrote:
> > > Hi Linus and folks,
> > > 
> > > I've been developing a tool for detecting deadlock possibilities by
> > > tracking wait/event rather than lock(?) acquisition order to try to
> > > cover all synchonization machanisms. It's done on v5.17-rc1 tag.
> > > 
> > > https://github.com/lgebyungchulpark/linux-dept/commits/dept1.14_on_v5.17-rc1
> > >
> > 
> > Small feedback unrelated to thread:
> > I'm not sure "Need to expand the ring buffer" is something to call
> > WARN(). Is this stack trace useful for something?
> 
> Yeah. It seems to happen too often. I won't warn it. Thanks.

Thanks!

> > ========
> > 
> > Hello Byungchul. These are two warnings of DEPT on system.
> > Both cases look similar.
> > 
> > In what case DEPT says (unknown)?
> > I'm not sure we can properly debug this.
> > 
> > ===================================================
> > DEPT: Circular dependency has been detected.
> > 5.17.0-rc1+ #3 Tainted: G        W        
> > ---------------------------------------------------
> > summary
> > ---------------------------------------------------
> > *** AA DEADLOCK ***
> > 
> > context A
> >     [S] (unknown)(&vfork:0)
> >     [W] wait_for_completion_killable(&vfork:0)
> >     [E] complete(&vfork:0)
> 
> All the reports look like having to do with kernel_clone(). I need to
> check it more. Thank you very much.
> 
> You are awesome, Hyeonggon.
>

Thank you. Let me know if there is something I can help!

> Thank you,
> Byungchul
> 
> > [S]: start of the event context
> > [W]: the wait blocked
> > [E]: the event not reachable
> > ---------------------------------------------------
> > context A's detail
> > ---------------------------------------------------
> > context A
> >     [S] (unknown)(&vfork:0)
> >     [W] wait_for_completion_killable(&vfork:0)
> >     [E] complete(&vfork:0)
> > 
> > [S] (unknown)(&vfork:0):
> > (N/A)
> > 
> > [W] wait_for_completion_killable(&vfork:0):
> > [<ffffffc00802204c>] kernel_clone+0x25c/0x2b8
> > stacktrace:
> >       dept_wait+0x74/0x88
> >       wait_for_completion_killable+0x60/0xa0
> >       kernel_clone+0x25c/0x2b8
> >       __do_sys_clone+0x5c/0x74
> >       __arm64_sys_clone+0x18/0x20
> >       invoke_syscall.constprop.0+0x78/0xc4
> >       do_el0_svc+0x98/0xd0
> >       el0_svc+0x44/0xe4
> >       el0t_64_sync_handler+0xb0/0x12c
> >       el0t_64_sync+0x158/0x15c
> > 
> > [E] complete(&vfork:0):
> > [<ffffffc00801f49c>] mm_release+0x7c/0x90
> > stacktrace:
> >       dept_event+0xe0/0x100
> >       complete+0x48/0x98
> >       mm_release+0x7c/0x90
> >       exit_mm_release+0xc/0x14
> >       do_exit+0x1b4/0x81c
> >       do_group_exit+0x30/0x9c
> >       __wake_up_parent+0x0/0x24
> >       invoke_syscall.constprop.0+0x78/0xc4
> >       do_el0_svc+0x98/0xd0
> >       el0_svc+0x44/0xe4
> >       el0t_64_sync_handler+0xb0/0x12c
> >       el0t_64_sync+0x158/0x15c
> > ---------------------------------------------------
> > information that might be helpful
> > ---------------------------------------------------
> > CPU: 6 PID: 229 Comm: start-stop-daem Tainted: G        W         5.17.0-rc1+ #3
> > Hardware name: linux,dummy-virt (DT)
> > Call trace:
> >  dump_backtrace.part.0+0x9c/0xc4
> >  show_stack+0x14/0x28
> >  dump_stack_lvl+0x9c/0xcc
> >  dump_stack+0x14/0x2c
> >  print_circle+0x2d4/0x438
> >  cb_check_dl+0x44/0x70
> >  bfs+0x60/0x168
> >  add_dep+0x88/0x11c
> >  do_event.constprop.0+0x19c/0x2c0
> >  dept_event+0xe0/0x100
> >  complete+0x48/0x98
> >  mm_release+0x7c/0x90
> >  exit_mm_release+0xc/0x14
> >  do_exit+0x1b4/0x81c
> >  do_group_exit+0x30/0x9c
> >  __wake_up_parent+0x0/0x24
> >  invoke_syscall.constprop.0+0x78/0xc4
> >  do_el0_svc+0x98/0xd0
> >  el0_svc+0x44/0xe4
> >  el0t_64_sync_handler+0xb0/0x12c
> >  el0t_64_sync+0x158/0x15c
> > 
> > 
> > 
> > 
> > ===================================================
> > DEPT: Circular dependency has been detected.
> > 5.17.0-rc1+ #3 Tainted: G        W        
> > ---------------------------------------------------
> > summary
> > ---------------------------------------------------
> > *** AA DEADLOCK ***
> > 
> > context A
> >     [S] (unknown)(&try_completion:0)
> >     [W] wait_for_completion_timeout(&try_completion:0)
> >     [E] complete(&try_completion:0)
> > 
> > [S]: start of the event context
> > [W]: the wait blocked
> > [E]: the event not reachable
> > ---------------------------------------------------
> > context A's detail
> > ---------------------------------------------------
> > context A
> >     [S] (unknown)(&try_completion:0)
> >     [W] wait_for_completion_timeout(&try_completion:0)
> >     [E] complete(&try_completion:0)
> > 
> > [S] (unknown)(&try_completion:0):
> > (N/A)
> > 
> > [W] wait_for_completion_timeout(&try_completion:0):
> > [<ffffffc008166bf4>] kunit_try_catch_run+0xb4/0x160
> > stacktrace:
> >       dept_wait+0x74/0x88
> >       wait_for_completion_timeout+0x64/0xa0
> >       kunit_try_catch_run+0xb4/0x160
> >       kunit_test_try_catch_successful_try_no_catch+0x3c/0x98
> >       kunit_try_run_case+0x9c/0xa0
> >       kunit_generic_run_threadfn_adapter+0x1c/0x28
> >       kthread+0xd4/0xe4
> >       ret_from_fork+0x10/0x20
> > 
> > [E] complete(&try_completion:0):
> > [<ffffffc00803dce4>] kthread_complete_and_exit+0x18/0x20
> > stacktrace:
> >       dept_event+0xe0/0x100
> >       complete+0x48/0x98
> >       kthread_complete_and_exit+0x18/0x20
> >       kunit_try_catch_throw+0x0/0x1c
> >       kthread+0xd4/0xe4
> >       ret_from_fork+0x10/0x20
> > 
> > ---------------------------------------------------
> > information that might be helpful
> > ---------------------------------------------------
> > CPU: 15 PID: 132 Comm: kunit_try_catch Tainted: G        W         5.17.0-rc1+ #3
> > Hardware name: linux,dummy-virt (DT)
> > Call trace:
> >  dump_backtrace.part.0+0x9c/0xc4
> >  show_stack+0x14/0x28
> >  dump_stack_lvl+0x9c/0xcc
> >  dump_stack+0x14/0x2c
> >  print_circle+0x2d4/0x438
> >  cb_check_dl+0x44/0x70
> >  bfs+0x60/0x168
> >  add_dep+0x88/0x11c
> >  do_event.constprop.0+0x19c/0x2c0
> >  dept_event+0xe0/0x100
> >  complete+0x48/0x98
> >  kthread_complete_and_exit+0x18/0x20
> >  kunit_try_catch_throw+0x0/0x1c
> >  kthread+0xd4/0xe4
> >  ret_from_fork+0x10/0x20
> 
> 
> > -- 
> > Thank you, You are awesome!
> > Hyeonggon :-)
