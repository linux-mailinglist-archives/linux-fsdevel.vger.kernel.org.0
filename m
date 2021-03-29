Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959E934C203
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 04:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhC2CrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 22:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhC2Cqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:46:48 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0BC061574;
        Sun, 28 Mar 2021 19:46:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d2so10016072ilm.10;
        Sun, 28 Mar 2021 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mMCjLRbIjMiUSToAvmZJzIfnIV25RQ2WsQmT7UZYZU=;
        b=QOMWHgd2QrWw7jiMAnI/xdmwpXQN1T5eU38h3H1fzTbID7W0mjd14mTdNW5r5fEW9P
         jZQ3viFABq+K91BFW8yCOI2PFIv2AWX8Hz6qDozShpGSt3mbhYSEALAg595qJDWP3l9O
         Po3cBn4i4Uxi4Bk8c4a2ID36rQv9n+APgx3CJUDa0B0tSBIYQT00Pqiin8i+sGqOhDpy
         GpO6iy6ExksRuVUhrccykuraaT+nK/4h996zXxvtTKBankpDlj0PW6RPc6Pbi5fd12KR
         ZAI3GISSVPEerJijFMLdGHiu0s2ct1d33EXac2s7wckG/GViWk5L+qbM2I7e6N2FGVOM
         hE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mMCjLRbIjMiUSToAvmZJzIfnIV25RQ2WsQmT7UZYZU=;
        b=RCSsoDH1Tfwk4X902es68J+20/OUL5YrnWguwewEcyLf1q51yt3Dm2eu41qaj9Er6/
         MHJuKetN0NhHzcPZg+LU5+UAV6IrQAuI1yvPJja+ojsaA6zc9zzX53JWiAJU5yLokjkM
         6/Rz8sjQkQV4YFwb5pUyVO3hOLyMIHJOPG3hDgjuizTijop4q/1Tz3Ou3fF2OxiqxNvs
         kJ9aMcVqwNKgWQt6dgEVtOriXGt/hJfJqgjM8ARbtuKM5Jax63lqYiQOnadAJNrgnl6G
         OMKo1luGjlNvQGpIPCW8lEZh1MiI9HZeeHJSWtgR+GXN2xRtgTgbNA5Mzuh9tD/ouPGy
         +Mjw==
X-Gm-Message-State: AOAM533slVrqmDfACnaFirucWIxkLDxZodKVTxgtn5J5dFR96fSGoIfm
        8GVkClEUeVbEXZkTQhSMGLz4qVvzzRbZw9bSRFE=
X-Google-Smtp-Source: ABdhPJz5iVWuJngtZQd1nTkw9/ta5qlvbGiWhBQE+Kw7sLtJVUTusR+2Vyb9eADCOVBwe83aZ5iwojG17zaHNb3ftSw=
X-Received: by 2002:a05:6e02:104b:: with SMTP id p11mr12438494ilj.77.1616986007664;
 Sun, 28 Mar 2021 19:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org> <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
 <m1blc1gxdx.fsf@fess.ebiederm.org> <CALCv0x2-Q9o7k1jhzN73nZ9F5+tcp7T8SkLKQWXW=1gLLJNegA@mail.gmail.com>
 <m1r1kwdyo0.fsf@fess.ebiederm.org>
In-Reply-To: <m1r1kwdyo0.fsf@fess.ebiederm.org>
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Date:   Sun, 28 Mar 2021 19:46:36 -0700
Message-ID: <CALCv0x2YqOXEAy2Q=hafjhHCtTHVodChv1qpM=niAXOpqEbt7w@mail.gmail.com>
Subject: Re: exec error: BUG: Bad rss-counter
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 3, 2021 at 7:50 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
>
> > On Tue, Mar 2, 2021 at 11:37 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
> >>
> >> > On Mon, Mar 1, 2021 at 12:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> >>
> >> >> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
> >> >>
> >> >> > Eric, All,
> >> >> >
> >> >> > The following error appears when running Linux 5.10.18 on an embedded
> >> >> > MIPS mt7621 target:
> >> >> > [    0.301219] BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:1
> >> >> >
> >> >> > Being a very generic error, I started digging and added a stack dump
> >> >> > before the BUG:
> >> >> > Call Trace:
> >> >> > [<80008094>] show_stack+0x30/0x100
> >> >> > [<8033b238>] dump_stack+0xac/0xe8
> >> >> > [<800285e8>] __mmdrop+0x98/0x1d0
> >> >> > [<801a6de8>] free_bprm+0x44/0x118
> >> >> > [<801a86a8>] kernel_execve+0x160/0x1d8
> >> >> > [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
> >> >> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
> >> >> >
> >> >> > So that's how I got to looking at fs/exec.c and noticed quite a few
> >> >> > changes last year. Turns out this message only occurs once very early
> >> >> > at boot during the very first call to kernel_execve. current->mm is
> >> >> > NULL at this stage, so acct_arg_size() is effectively a no-op.
> >> >>
> >> >> If you believe this is a new error you could bisect the kernel
> >> >> to see which change introduced the behavior you are seeing.
> >> >>
> >> >> > More digging, and I traced the RSS counter increment to:
> >> >> > [<8015adb4>] add_mm_counter_fast+0xb4/0xc0
> >> >> > [<80160d58>] handle_mm_fault+0x6e4/0xea0
> >> >> > [<80158aa4>] __get_user_pages.part.78+0x190/0x37c
> >> >> > [<8015992c>] __get_user_pages_remote+0x128/0x360
> >> >> > [<801a6d9c>] get_arg_page+0x34/0xa0
> >> >> > [<801a7394>] copy_string_kernel+0x194/0x2a4
> >> >> > [<801a880c>] kernel_execve+0x11c/0x298
> >> >> > [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
> >> >> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
> >> >> >
> >> >> > In fact, I also checked vma_pages(bprm->vma) and lo and behold it is set to 1.
> >> >> >
> >> >> > How is fs/exec.c supposed to handle implied RSS increments that happen
> >> >> > due to page faults when discarding the bprm structure? In this case,
> >> >> > the bug-generating kernel_execve call never succeeded, it returned -2,
> >> >> > but I didn't trace exactly what failed.
> >> >>
> >> >> Unless I am mistaken any left over pages should be purged by exit_mmap
> >> >> which is called by mmput before mmput calls mmdrop.
> >> > Good to know. Some more digging and I can say that we hit this error
> >> > when trying to unmap PFN 0 (is_zero_pfn(pfn) returns TRUE,
> >> > vm_normal_page returns NULL, zap_pte_range does not decrement
> >> > MM_ANONPAGES RSS counter). Is my understanding correct that PFN 0 is
> >> > usable, but special? Or am I totally off the mark here?
> >>
> >> It would be good to know if that is the page that get_user_pages_remote
> >> returned to copy_string_kernel.  The zero page that is always zero,
> >> should never be returned when a writable mapping is desired.
> >
> > Indeed, pfn 0 is returned from get_arg_page: (page is 0x809cf000,
> > page_to_pfn(page) is 0) and it is the same page that is being freed and not
> > refcounted in mmput/zap_pte_range. Confirmed with good old printk. Also,
> > ZERO_PAGE(0)==0x809fc000 -> PFN 5120.
> >
> > I think I have found the problem though, after much digging and thanks to all
> > the information provided. init_zero_pfn() gets called too late (after
> > the call to
> > is_zero_pfn(0) from mmput returns true), until then zero_pfn == 0, and after,
> > zero_pfn == 5120. Boom.
> >
> > So PFN 0 is special, but only for a little bit, enough for something
> > on my system
> > to call kernel_execve :)
> >
> > Question: is my system not supposed to be calling kernel_execve this
> > early or does
> > init_zero_pfn() need to happen earlier? init_zero_pfn is currently a
> > core_initcall.
>
> Looking quickly it seems that init_zero_pfn() is in mm/memory.c and is
> common for both mips and x86.  Further it appears init_zero_pfn() has
> been that was since 2009 a13ea5b75964 ("mm: reinstate ZERO_PAGE").
>
> Given the testing that x86 gets and that nothing like this has been
> reported it looks like whatever driver is triggering the kernel_execve
> is doing something wrong.
>
> Because honestly.  If the zero page isn't working there is not a chance
> that anything in userspace is working so it is clearly much too early.
>
> I suspect there is some driver that is initialized very early that is
> doing something that looks innocuous (like triggering a hotplug event)
> and that happens to cause a call_usermode_helper which then calls
> kernel_execve.

Here is the data that's passed into the very first kernel_execve call:
kernel_filename: /sbin/hotplug
argv: [/sbin/hotplug, bus]
envp: [ACTION=add, DEVPATH=/bus/workqueue, SUBSYSTEM=bus, SEQNUM=4,
HOME=/, PATH=/sbin:/bin:/usr/sbin:/usr/bin]

It comes from kobject_uevent_env() calling call_usermodehelper_exec()
with UMH_NO_WAIT.

Trace:
[<80340dc8>] kobject_uevent_env+0x7e4/0x7ec
[<8033f8b8>] kset_register+0x68/0x88
[<803cf824>] bus_register+0xdc/0x34c
[<803cfac8>] subsys_virtual_register+0x34/0x78
[<8086afb0>] wq_sysfs_init+0x1c/0x4c
[<80001648>] do_one_initcall+0x50/0x1a8
[<8086503c>] kernel_init_freeable+0x230/0x2c8
[<8066bca0>] kernel_init+0x10/0x100
[<80003038>] ret_from_kernel_thread+0x14/0x1c

A bunch of other bus devices are initialized at the same time, but
SEQNUM=4 gets to go first for some reason:
[    0.420497] smp: Brought up 1 node, 4 CPUs
[    0.431204] ACTION:add DEVPATH:/bus/platform SUBSYSTEM:bus SEQNUM: 1
[    0.431249] ACTION:add DEVPATH:/bus/cpu SUBSYSTEM:bus SEQNUM: 2
[    0.440594] ACTION:add DEVPATH:/bus/container SUBSYSTEM:bus SEQNUM: 3
[    0.449994] ACTION:add DEVPATH:/bus/workqueue SUBSYSTEM:bus SEQNUM: 4

Since both wq_sysfs_init() and init_zero_pfn() are annotated with
core_initcall() is there a race?

Maybe there is still an argument for moving init_zero_pfn() to
early_initcall()? According to the comment above init_zero_pfn(),
"CONFIG_MMU architectures set up ZERO_PAGE in their paging_init()".
paging_init() gets called in setup_arch(), which is way before
do_pre_smp_initcalls(), so it should work, right? Obviously something
that needs to be tested, but are my assumptions correct?

FWIW I tested it on my MIPS device and it boots fine and the BUG
message is gone. I still don't know why it started appearing on 5.10+,
maybe some core_initcalls got added that made the race worse?

Ilya
