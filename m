Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199574CBE05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 13:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiCCMjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 07:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiCCMji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:39:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B126B3CFEB;
        Thu,  3 Mar 2022 04:38:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so4720943pjl.4;
        Thu, 03 Mar 2022 04:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xw1t8RJEBLs6nNo618ULi5yqJsMgKqz1ONvJ2a5MT3c=;
        b=BzrkK1hJiQ+JPPG9UrxzPIeXGct5pIgTB7o+w9LPLZpdlhw7yhoWA1GMh5N61uZfF/
         PncBXmid0UFMAuiub2OnBJ72eeoETL66hxSZhF+f6FXTMhgAP82GWSXHwZEIimpTW2Qq
         7c61woZrDZKYd5zhfndnPY5TegWp8YItlyVknSXTgeVSZ+T6iyQLaEJqoglIo/hdtHs4
         Z8HVrCi7NFr6cs8zHgPcouRaNQ7Lab/z+IYkC5z/RIoeNT2FKku0gTGOQnu+pzm7NStv
         unipj1p2yZj7cPNJekdxtvWRdtz5+OLkobNPxtRBn30IJ2Tc5sJpjX6tA+yZp7pogBRh
         YbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xw1t8RJEBLs6nNo618ULi5yqJsMgKqz1ONvJ2a5MT3c=;
        b=kYlEVtnkbIYMNQ0yUduLD6xlawP03jWEwdRaEIKfdRHp2a8AMQgCmLiBMcESwB0WQE
         tI6zSQu6tVMvrPSMEGdlCNhg8+N/T2Zi+ZQ+b3YM53H1blykZvl9GOHfmgq2K34SM5CU
         Kn/GlWjaZIAhhO877qnXuzthrCiPQbhnvbGq9kAOHG5d/oCkyQgv3FHQ3AH/jZqE6wyX
         g35adIINLxIaxXsCWuNCLnfnImRrYg4Dgm/kGt6seWKf6m6G2bCT9eRWOaO8JJ7F9aJJ
         iwck+3ghuUb8sEIS+0A3abEcnBF6/oilT3HsYqRkbj1w3T1klubV0FVNJC8Xdnprnwhj
         Dcrg==
X-Gm-Message-State: AOAM530m4ySj81c89NGZwihX3W4LQamYaXDeemaDkniwvEzt/a4lJNpP
        x9ct5W7o/kbVhhK9vzanzV0=
X-Google-Smtp-Source: ABdhPJz17qOFmFlBrNJNUqYdHV9n7lTWYbm2jjytljRWsyBIk/kiynuY77vwBHskQjfvfh0lM0uI3g==
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id q13-20020a17090a430d00b001bcf3408096mr5017886pjg.93.1646311131665;
        Thu, 03 Mar 2022 04:38:51 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id d2-20020a056a0010c200b004f102a13040sm2550047pfu.19.2022.03.03.04.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 04:38:51 -0800 (PST)
Date:   Thu, 3 Mar 2022 12:38:39 +0000
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
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 00/21] DEPT(Dependency Tracker)
Message-ID: <YiC2z2NDbiYd2nEA@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <1646042220-28952-1-git-send-email-byungchul.park@lge.com>
 <Yh70VkRkUfwIjPWv@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <Yh74VbNZZt35wHZD@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220303001812.GA20752@X58A-UD3R>
 <YiB2SZFzgBEcywgg@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220303094824.GA24977@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303094824.GA24977@X58A-UD3R>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 06:48:24PM +0900, Byungchul Park wrote:
> On Thu, Mar 03, 2022 at 08:03:21AM +0000, Hyeonggon Yoo wrote:
> > On Thu, Mar 03, 2022 at 09:18:13AM +0900, Byungchul Park wrote:
> > > Hi Hyeonggon,
> > > 
> > > Dept also allows the following scenario when an user guarantees that
> > > each lock instance is different from another at a different depth:
> > >
> > >    lock A0 with depth
> > >    lock A1 with depth + 1
> > >    lock A2 with depth + 2
> > >    lock A3 with depth + 3
> > >    (and so on)
> > >    ..
> > >    unlock A3
> > >    unlock A2
> > >    unlock A1
> > >    unlock A0
> 

[+Cc kmemleak maintainer]

> Look at this. Dept allows object->lock -> other_object->lock (with a
> different depth using *_lock_nested()) so won't report it.
>

No, It did.

S: object->lock ( _raw_spin_lock_irqsave)
W: other_object->lock (_raw_spin_lock_nested)

DEPT reported this as AA deadlock.

===================================================
DEPT: Circular dependency has been detected.
5.17.0-rc1+ #1 Tainted: G        W
---------------------------------------------------
summary
---------------------------------------------------
*** AA DEADLOCK ***

context A
    [S] __raw_spin_lock_irqsave(&object->lock:0)
    [W] _raw_spin_lock_nested(&object->lock:0)
    [E] spin_unlock(&object->lock:0)

[S]: start of the event context
[W]: the wait blocked
[E]: the event not reachable
---------------------------------------------------
context A's detail
---------------------------------------------------
context A
    [S] __raw_spin_lock_irqsave(&object->lock:0)
    [W] _raw_spin_lock_nested(&object->lock:0)
    [E] spin_unlock(&object->lock:0)
---------------------------------------------------
context A's detail
---------------------------------------------------
context A
    [S] __raw_spin_lock_irqsave(&object->lock:0)
    [W] _raw_spin_lock_nested(&object->lock:0)
    [E] spin_unlock(&object->lock:0)

[S] __raw_spin_lock_irqsave(&object->lock:0):
[<ffffffc00810302c>] scan_gray_list+0x84/0x13c
stacktrace:
      dept_ecxt_enter+0x88/0xf4
      _raw_spin_lock_irqsave+0xf0/0x1c4
      scan_gray_list+0x84/0x13c
      kmemleak_scan+0x2d8/0x54c
      kmemleak_scan_thread+0xac/0xd4
      kthread+0xd4/0xe4
      ret_from_fork+0x10/0x20

[W] _raw_spin_lock_nested(&object->lock:0):
[<ffffffc008102f34>] scan_block+0xb4/0x128
stacktrace:
      __dept_wait+0x8c/0xa4
      dept_wait+0x6c/0x88
      _raw_spin_lock_nested+0xa8/0x1b0
      scan_block+0xb4/0x128
      scan_gray_list+0xc4/0x13c
      kmemleak_scan+0x2d8/0x54c
      kmemleak_scan_thread+0xac/0xd4
      kthread+0xd4/0xe4
      ret_from_fork+0x10/0x20

[E] spin_unlock(&object->lock:0):
[<ffffffc008102ee0>] scan_block+0x60/0x128
---------------------------------------------------
information that might be helpful
---------------------------------------------------
CPU: 2 PID: 38 Comm: kmemleak Tainted: G        W         5.17.0-rc1+ #1
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.part.0+0x9c/0xc4
 show_stack+0x14/0x28
 dump_stack_lvl+0x9c/0xcc
 dump_stack+0x14/0x2c
 print_circle+0x2d4/0x438
 cb_check_dl+0x44/0x70
 bfs+0x60/0x168
 add_dep+0x88/0x11c
 add_wait+0x2d0/0x2dc
 __dept_wait+0x8c/0xa4
 dept_wait+0x6c/0x88
 _raw_spin_lock_nested+0xa8/0x1b0
 scan_block+0xb4/0x128
 scan_gray_list+0xc4/0x13c
 kmemleak_scan+0x2d8/0x54c
 kmemleak_scan_thread+0xac/0xd4
 kthread+0xd4/0xe4
 ret_from_fork+0x10/0x20

> > > However, Dept does not allow the following scenario where another lock
> > > class cuts in the dependency chain:
> > > 
> > >    lock A0 with depth
> > >    lock B
> > >    lock A1 with depth + 1
> > >    lock A2 with depth + 2
> > >    lock A3 with depth + 3
> > >    (and so on)
> > >    ..
> > >    unlock A3
> > >    unlock A2
> > >    unlock A1
> > >    unlock B
> > >    unlock A0
> > > 
> > > This scenario is clearly problematic. What do you think is going to
> > > happen with another context running the following?
> > >
> > 
> > First of all, I want to say I'm not expert at locking primitives.
> > I may be wrong.
> 
> It's okay. Thanks anyway for your feedback.
>

Thanks.

> > > >   45  *   scan_mutex [-> object->lock] -> kmemleak_lock -> other_object->lock (SINGLE_DEPTH_NESTING)
> > > >   46  *
> > > >   47  * No kmemleak_lock and object->lock nesting is allowed outside scan_mutex
> > > >   48  * regions.
> > 
> > lock order in kmemleak is described above.
> > 
> > and DEPT detects two cases as deadlock:
> > 
> > 1) object->lock -> other_object->lock
> 
> It's not a deadlock *IF* two have different depth using *_lock_nested().
> Dept also allows this case. So Dept wouldn't report it.
>
> > 2) object->lock -> kmemleak_lock, kmemleak_lock -> other_object->lock
>
> But this usage is risky. I already explained it in the mail you replied
> to. I copied it. See the below.
>

I understand why you said this is risky.
Its lock ordering is not good.

> context A
> > >    lock A0 with depth
> > >    lock B
> > >    lock A1 with depth + 1
> > >    lock A2 with depth + 2
> > >    lock A3 with depth + 3
> > >    (and so on)
> > >    ..
> > >    unlock A3
> > >    unlock A2
> > >    unlock A1
> > >    unlock B
> > >    unlock A0
>
> ...
>
> context B
> > >    lock A1 with depth
> > >    lock B
> > >    lock A2 with depth + 1
> > >    lock A3 with depth + 2
> > >    (and so on)
> > >    ..
> > >    unlock A3
> > >    unlock A2
> > >    unlock B
> > >    unlock A1
> 
> where Ax : object->lock, B : kmemleak_lock.
> 
> A deadlock might occur if the two contexts run at the same time.
>

But I want to say kmemleak is getting things under control. No two contexts
can run at same time.

> > And in kmemleak case, 1) and 2) is not possible because it must hold
> > scan_mutex first.
> 
> This is another issue. Let's focus on whether the order is okay for now.
>

Why is it another issue?

> > I think the author of kmemleak intended lockdep to treat object->lock
> > and other_object->lock as different class, using raw_spin_lock_nested().
> 
> Yes. The author meant to assign a different class according to its depth
> using a Lockdep API. Strictly speaking, those are the same class anyway
> but we assign a different class to each depth to avoid Lockdep splats
> *IF* the user guarantees the nesting lock usage is safe, IOW, guarantees
> each lock instance is different at a different depth.

Then why DEPT reports 1) and 2) as deadlock?
Does DEPT assign same class unlike Lockdep?

> I was fundamentally asking you... so... is the nesting lock usage safe
> for real?

I don't get what the point is. I agree it's not a good lock ordering.
But in kmemleak case, I think kmemleak is getting things under control.

-- 
Thank you, You are awesome!
Hyeonggon :-)

> I hope you distinguish between the safe case and the risky
> case when *_lock_nested() is involved. Thoughts?
>
> Thanks,
> Byungchul
> 
> > Am I missing something?
> > 
> > Thanks.
> > 
> > >    lock A1 with depth
> > >    lock B
> > >    lock A2 with depth + 1
> > >    lock A3 with depth + 2
> > >    (and so on)
> > >    ..
> > >    unlock A3
> > >    unlock A2
> > >    unlock B
> > >    unlock A1
> > > 
> > > It's a deadlock. That's why Dept reports this case as a problem. Or am I
> > > missing something?
> > >
> > > Thanks,
> > > Byungchul
> > > 
> > > > ---------------------------------------------------
> > > > context A's detail
> > > > ---------------------------------------------------
> > > > context A
> > > >     [S] __raw_spin_lock_irqsave(&object->lock:0)
> > > >     [W] __raw_spin_lock_irqsave(kmemleak_lock:0)
> > > >     [E] spin_unlock(&object->lock:0)
> > > > 
> > > > [S] __raw_spin_lock_irqsave(&object->lock:0):
> > > > [<ffffffc00810302c>] scan_gray_list+0x84/0x13c
> > > > stacktrace:
> > > >       dept_ecxt_enter+0x88/0xf4
> > > >       _raw_spin_lock_irqsave+0xf0/0x1c4
> > > >       scan_gray_list+0x84/0x13c
> > > >       kmemleak_scan+0x2d8/0x54c
> > > >       kmemleak_scan_thread+0xac/0xd4
> > > >       kthread+0xd4/0xe4
> > > >       ret_from_fork+0x10/0x20
> > > > 
> > > > [W] __raw_spin_lock_irqsave(kmemleak_lock:0):
> > > > [<ffffffc008102ebc>] scan_block+0x3c/0x128
> > > > stacktrace:
> > > >       __dept_wait+0x8c/0xa4
> > > >       dept_wait+0x6c/0x88
> > > >       _raw_spin_lock_irqsave+0xb8/0x1c4
> > > >       scan_block+0x3c/0x128
> > > >       scan_gray_list+0xc4/0x13c
> > > >       kmemleak_scan+0x2d8/0x54c
> > > >       kmemleak_scan_thread+0xac/0xd4
> > > >       kthread+0xd4/0xe4
> > > >       ret_from_fork+0x10/0x20
> > > > 
> > > > [E] spin_unlock(&object->lock:0):
> > > > [<ffffffc008102ee0>] scan_block+0x60/0x128
> > > > 
> > > > ---------------------------------------------------
> > > > context B's detail
> > > > ---------------------------------------------------
> > > > context B
> > > >     [S] __raw_spin_lock_irqsave(kmemleak_lock:0)
> > > >     [W] _raw_spin_lock_nested(&object->lock:0)
> > > >     [E] spin_unlock(kmemleak_lock:0)
> > > > 
> > > > [S] __raw_spin_lock_irqsave(kmemleak_lock:0):
> > > > [<ffffffc008102ebc>] scan_block+0x3c/0x128
> > > > stacktrace:
> > > >       dept_ecxt_enter+0x88/0xf4
> > > >       _raw_spin_lock_irqsave+0xf0/0x1c4
> > > >       scan_block+0x3c/0x128
> > > >       kmemleak_scan+0x19c/0x54c
> > > >       kmemleak_scan_thread+0xac/0xd4
> > > >       kthread+0xd4/0xe4
> > > >       ret_from_fork+0x10/0x20
> > > > 
> > > > [W] _raw_spin_lock_nested(&object->lock:0):
> > > > [<ffffffc008102f34>] scan_block+0xb4/0x128
> > > > stacktrace:
> > > >       dept_wait+0x74/0x88
> > > >       _raw_spin_lock_nested+0xa8/0x1b0
> > > >       scan_block+0xb4/0x128
> > > >       kmemleak_scan+0x19c/0x54c
> > > >       kmemleak_scan_thread+0xac/0xd4
> > > >       kthread+0xd4/0xe4
> > > >       ret_from_fork+0x10/0x20
> > > > [E] spin_unlock(kmemleak_lock:0):
> > > > [<ffffffc008102ee0>] scan_block+0x60/0x128
> > > > stacktrace:
> > > >       dept_event+0x7c/0xfc
> > > >       _raw_spin_unlock_irqrestore+0x8c/0x120
> > > >       scan_block+0x60/0x128
> > > >       kmemleak_scan+0x19c/0x54c
> > > >       kmemleak_scan_thread+0xac/0xd4
> > > >       kthread+0xd4/0xe4
> > > >       ret_from_fork+0x10/0x20
> > > > ---------------------------------------------------
> > > > information that might be helpful
> > > > ---------------------------------------------------
> > > > CPU: 1 PID: 38 Comm: kmemleak Tainted: G        W         5.17.0-rc1+ #1
> > > > Hardware name: linux,dummy-virt (DT)
> > > > Call trace:
> > > >  dump_backtrace.part.0+0x9c/0xc4
> > > >  show_stack+0x14/0x28
> > > >  dump_stack_lvl+0x9c/0xcc
> > > >  dump_stack+0x14/0x2c
> > > >  print_circle+0x2d4/0x438
> > > >  cb_check_dl+0x6c/0x70
> > > >  bfs+0xc0/0x168
> > > >  add_dep+0x88/0x11c
> > > >  add_wait+0x2d0/0x2dc
> > > >  __dept_wait+0x8c/0xa4
> > > >  dept_wait+0x6c/0x88
> > > >  _raw_spin_lock_irqsave+0xb8/0x1c4
> > > >  scan_block+0x3c/0x128
> > > >  scan_gray_list+0xc4/0x13c
> > > >  kmemleak_scan+0x2d8/0x54c
> > > >  kmemleak_scan_thread+0xac/0xd4
> > > >  kthread+0xd4/0xe4
> > > >  ret_from_fork+0x10/0x20
> > > > 
> > > > > ===================================================
> > > > > DEPT: Circular dependency has been detected.
> > > > > 5.17.0-rc1+ #1 Tainted: G        W
> > > > > ---------------------------------------------------
> > > > > summary
> > > > > ---------------------------------------------------
> > > > > *** AA DEADLOCK ***
> > > > > 
> > > > > context A
> > > > >     [S] __raw_spin_lock_irqsave(&object->lock:0)
> > > > >     [W] _raw_spin_lock_nested(&object->lock:0)
> > > > >     [E] spin_unlock(&object->lock:0)
> > > > > 
> > > > > [S]: start of the event context
> > > > > [W]: the wait blocked
> > > > > [E]: the event not reachable
> > > > > ---------------------------------------------------
> > > > > context A's detail
> > > > > ---------------------------------------------------
> > > > > context A
> > > > >     [S] __raw_spin_lock_irqsave(&object->lock:0)
> > > > >     [W] _raw_spin_lock_nested(&object->lock:0)
> > > > >     [E] spin_unlock(&object->lock:0)
> > > > > 
> > > > > [S] __raw_spin_lock_irqsave(&object->lock:0):
> > > > > [<ffffffc00810302c>] scan_gray_list+0x84/0x13c
> > > > > stacktrace:
> > > > >       dept_ecxt_enter+0x88/0xf4
> > > > >       _raw_spin_lock_irqsave+0xf0/0x1c4
> > > > >       scan_gray_list+0x84/0x13c
> > > > >       kmemleak_scan+0x2d8/0x54c
> > > > >       kmemleak_scan_thread+0xac/0xd4
> > > > >       kthread+0xd4/0xe4
> > > > >       ret_from_fork+0x10/0x20
> > > > > 
> > > > > [E] spin_unlock(&object->lock:0):
> > > > > [<ffffffc008102ee0>] scan_block+0x60/0x128
> > > > > ---------------------------------------------------
> > > > > information that might be helpful
> > > > > ---------------------------------------------------
> > > > > CPU: 1 PID: 38 Comm: kmemleak Tainted: G        W         5.17.0-rc1+ #1
> > > > > Hardware name: linux,dummy-virt (DT)
> > > > > Call trace:
> > > > >  dump_backtrace.part.0+0x9c/0xc4
> > > > >  show_stack+0x14/0x28
> > > > >  dump_stack_lvl+0x9c/0xcc
> > > > >  dump_stack+0x14/0x2c
> > > > >  print_circle+0x2d4/0x438
> > > > >  cb_check_dl+0x44/0x70
> > > > >  bfs+0x60/0x168
> > > > >  add_dep+0x88/0x11c
> > > > >  add_wait+0x2d0/0x2dc
> > > > >  __dept_wait+0x8c/0xa4
> > > > >  dept_wait+0x6c/0x88
> > > > >  _raw_spin_lock_nested+0xa8/0x1b0
> > > > >  scan_block+0xb4/0x128
> > > > >  scan_gray_list+0xc4/0x13c
> > > > >  kmemleak_scan+0x2d8/0x54c
> > > > >  kmemleak_scan_thread+0xac/0xd4
> > > > >  kthread+0xd4/0xe4
> > > > >  ret_from_fork+0x10/0x20
> > > > >
> > > > [...]
> > > > 
> > > > --
> > > > Thank you, You are awesome!
> > > > Hyeonggon :-)
> > 
> > -- 
> > Thank you, You are awesome!
> > Hyeonggon :-)

