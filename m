Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB27432C502
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376848AbhCDASz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355872AbhCCHCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 02:02:09 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66F3C061756;
        Tue,  2 Mar 2021 23:01:28 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e2so20406719ilu.0;
        Tue, 02 Mar 2021 23:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2i07Py9mUG8cbrhoNe3VKTqajFt+rb+d2m6egdHcEIs=;
        b=e6U7HeX6j9cx3ut2LJyoG1wTSNdwhXvvD9/B4WSbmKcSl62UZAzDfaaUQfo+9ymkIt
         ZAe1vovIG02OjGwBIavrdvg8DJ+HHj6IFTK3Zie0j24Z/HVTp1fmFUTeXBysquJOhqaO
         JKvva8MXXJvoyetfnFCx6cvcs/Q7o/THjYMo/C6nTfsArp44i2Ryv0Di3dwUFPP5RhgO
         XfIhTMtT2X0NJXcqIFfmVAXTPNtTfAUAvfFkj3opIKJOiWFyg83JJAX5qrL2SV/xJJi2
         5EZVQMjDTsZyBZGXJiOTaW2CHyRWaRTrP+NnbLZD94k5NhVEIGqFiHpjBgxf8atwygKA
         JwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2i07Py9mUG8cbrhoNe3VKTqajFt+rb+d2m6egdHcEIs=;
        b=iouESE2uyJSK88FnmnSDaqA4Pb5oPJaSjr2SwsdYwFR6Pfy8z5sPX07BOsLQ2fJjqS
         G6hmqCX2Go1o5plC2fZBpH9/SCcEmkLNcR+5ghl1LY4u/nTaVHnexijPT3HH8HWGInqw
         ncOr0pLsvLG/bgDsu4NCVhU4+aMP8dq6lNTH1fRsyRMWmxsftqP8sQfyAv19Z36Qbd7B
         19KmVk2PFpqWmBKxwxAbIMCdJ4/fvK5NENPhdvgrWTCF3alVxRk7gZLD9hAFhvITLpLw
         HrvzTXelrlASd+PXesVRtBSdZ5umls3DHfNCY7aK4RxDXUBmfOW4J0NN7qX6k8HmjQ/J
         ArAg==
X-Gm-Message-State: AOAM533kiXem/O4+7ObyMN+SgqVZR0rcLss3cXhlR79n9EcoaIlOlnV7
        qhqu3IyTkiR1vI+Yog96JR9jAYBTIRmmi24Yaps2DtmMqj9Vxg==
X-Google-Smtp-Source: ABdhPJwx5NIbsIPpCLK82gaaTt4mljisYfHu5900a0SqSX0/1DkmLR1w0ihbSJJgEIyYCmbQfQ53DElt2w5dwPX2MG4=
X-Received: by 2002:a05:6e02:12ac:: with SMTP id f12mr20642111ilr.103.1614754888162;
 Tue, 02 Mar 2021 23:01:28 -0800 (PST)
MIME-Version: 1.0
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org> <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
 <m1blc1gxdx.fsf@fess.ebiederm.org>
In-Reply-To: <m1blc1gxdx.fsf@fess.ebiederm.org>
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Date:   Tue, 2 Mar 2021 23:01:16 -0800
Message-ID: <CALCv0x2-Q9o7k1jhzN73nZ9F5+tcp7T8SkLKQWXW=1gLLJNegA@mail.gmail.com>
Subject: Re: exec error: BUG: Bad rss-counter
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 2, 2021 at 11:37 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
>
> > On Mon, Mar 1, 2021 at 12:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
> >>
> >> > Eric, All,
> >> >
> >> > The following error appears when running Linux 5.10.18 on an embedded
> >> > MIPS mt7621 target:
> >> > [    0.301219] BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:1
> >> >
> >> > Being a very generic error, I started digging and added a stack dump
> >> > before the BUG:
> >> > Call Trace:
> >> > [<80008094>] show_stack+0x30/0x100
> >> > [<8033b238>] dump_stack+0xac/0xe8
> >> > [<800285e8>] __mmdrop+0x98/0x1d0
> >> > [<801a6de8>] free_bprm+0x44/0x118
> >> > [<801a86a8>] kernel_execve+0x160/0x1d8
> >> > [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
> >> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
> >> >
> >> > So that's how I got to looking at fs/exec.c and noticed quite a few
> >> > changes last year. Turns out this message only occurs once very early
> >> > at boot during the very first call to kernel_execve. current->mm is
> >> > NULL at this stage, so acct_arg_size() is effectively a no-op.
> >>
> >> If you believe this is a new error you could bisect the kernel
> >> to see which change introduced the behavior you are seeing.
> >>
> >> > More digging, and I traced the RSS counter increment to:
> >> > [<8015adb4>] add_mm_counter_fast+0xb4/0xc0
> >> > [<80160d58>] handle_mm_fault+0x6e4/0xea0
> >> > [<80158aa4>] __get_user_pages.part.78+0x190/0x37c
> >> > [<8015992c>] __get_user_pages_remote+0x128/0x360
> >> > [<801a6d9c>] get_arg_page+0x34/0xa0
> >> > [<801a7394>] copy_string_kernel+0x194/0x2a4
> >> > [<801a880c>] kernel_execve+0x11c/0x298
> >> > [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
> >> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
> >> >
> >> > In fact, I also checked vma_pages(bprm->vma) and lo and behold it is set to 1.
> >> >
> >> > How is fs/exec.c supposed to handle implied RSS increments that happen
> >> > due to page faults when discarding the bprm structure? In this case,
> >> > the bug-generating kernel_execve call never succeeded, it returned -2,
> >> > but I didn't trace exactly what failed.
> >>
> >> Unless I am mistaken any left over pages should be purged by exit_mmap
> >> which is called by mmput before mmput calls mmdrop.
> > Good to know. Some more digging and I can say that we hit this error
> > when trying to unmap PFN 0 (is_zero_pfn(pfn) returns TRUE,
> > vm_normal_page returns NULL, zap_pte_range does not decrement
> > MM_ANONPAGES RSS counter). Is my understanding correct that PFN 0 is
> > usable, but special? Or am I totally off the mark here?
>
> It would be good to know if that is the page that get_user_pages_remote
> returned to copy_string_kernel.  The zero page that is always zero,
> should never be returned when a writable mapping is desired.

Indeed, pfn 0 is returned from get_arg_page: (page is 0x809cf000,
page_to_pfn(page) is 0) and it is the same page that is being freed and not
refcounted in mmput/zap_pte_range. Confirmed with good old printk. Also,
ZERO_PAGE(0)==0x809fc000 -> PFN 5120.

I think I have found the problem though, after much digging and thanks to all
the information provided. init_zero_pfn() gets called too late (after
the call to
is_zero_pfn(0) from mmput returns true), until then zero_pfn == 0, and after,
zero_pfn == 5120. Boom.

So PFN 0 is special, but only for a little bit, enough for something
on my system
to call kernel_execve :)

Question: is my system not supposed to be calling kernel_execve this
early or does
init_zero_pfn() need to happen earlier? init_zero_pfn is currently a
core_initcall.

>
> > Here is the (optimized) stack trace when the counter does not get decremented:
> > [<8015b078>] vm_normal_page+0x114/0x1a8
> > [<8015dc98>] unmap_page_range+0x388/0xacc
> > [<8015e5a0>] unmap_vmas+0x6c/0x98
> > [<80166194>] exit_mmap+0xd8/0x1ac
> > [<800290c0>] mmput+0x58/0xf8
> > [<801a6f8c>] free_bprm+0x2c/0xc4
> > [<801a8890>] kernel_execve+0x160/0x1d8
> > [<800420e0>] call_usermodehelper_exec_async+0x114/0x194
> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
> >
> >>
> >> AKA it looks very very fishy this happens and this does not look like
> >> an execve error.
> > I think you are right, I'm probably wrong to bother you. However,
> > since the thread is already started, let me add linux-mm here :)
>
> It happens during exec.  I don't mind looking and pointing you a useful
> direction.
>
> >>
> >> On the other hand it would be good to know why kernel_execve is failing.
> >> Then the error handling paths could be scrutinized, and we can check to
> >> see if everything that should happen on an error path does.
> > I can check on this, but likely it's the init system not doing things
> > quite in the right order on my platform, or something similar. The
> > error is ENOENT from do_open_execat().
>
> That does narrow things down considerably.
> After the error all we do is:
> Clear in_execve and fs->in_exec.
> Return from bprm_execve
> Call free_bprm
> Which does:
>         if (bprm->mm) {
>                 acct_arg_size(bprm, 0);
>                 mmput(bprm->mm);
>         }
>
> So it really needs to be the mmput that cleans things up.\
>
> I would really verify the correspondence between what get_arg_page
> returns and what gets freed in mmput if it is not too difficult.
> I think it should just be a page or two.
>
> Eric

Ilya
