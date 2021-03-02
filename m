Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0232A524
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443427AbhCBLrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349316AbhCBIL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:11:58 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94337C06178A;
        Mon,  1 Mar 2021 23:59:48 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id f10so16663630ilq.5;
        Mon, 01 Mar 2021 23:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2tx7RyZE5U4n4frsJrirMRlQkMFmE25RpWBjXABilA=;
        b=f4Z8o8kButtcX91FYfruSaZ1qzOD/ognZCljaY0z11d2aeNIW5a3+jHJDQN9tTaYbW
         kwMBN57Mrue7x8A5EU7rsg83OtPSMmEbUVgpmqPE7b8mOPvmECfJ1Nd8XbeCHJOhBQH2
         uLrQnwImAPjeXF7ORbHYynXmhS94nzORYyA3R34JVQWJye4KOBycUPQaumtzL2uvFy+s
         GtnTLs3wRbLFoDzcg4MVicrJspCznwxh2ZjEc3kHWCssI4qweICA38NBszEIPZv3x6ld
         BtJ2rqptyl85vM5rZxnXccf3lAqjmp6KOpYINlg0GNDzoHO/L5LCd5zV1nmXT8zeYc+p
         tJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2tx7RyZE5U4n4frsJrirMRlQkMFmE25RpWBjXABilA=;
        b=s68saG8leWBc5BXNS/FqiFfM7fi6F/+a//7reS7iJ0lcjmRN2blOl4ijfvZD508fh4
         HWgNdRq4JwPG7m5x4hyDpvJ5SveezUaYOCp8XXKs46r342yr40fxlyh0ee3WyG0Y53OB
         aodIzJUX/IYBgkGl3yCg+0593uJsoRy2Hi8tbgyNCkfpDOZ8f42OS2EEE3cDzAO97WVi
         9EK7VLKmLM4YctbOH5KKCzuzHRyVMixz6fyUq+Dnlnk497lDTKxZd3yDcpRJIssrseKF
         QXLSFuEh/b8CFMpFmIbP3vVcEYS83/7H+UfCteun6wo2jhcUU8vFkOevaBAbUZb5KVBW
         W6Kw==
X-Gm-Message-State: AOAM533OoXXY/zVig+SHgSUWWdnlQymcaOY0/WB0fC3q8DLEj7hJ49ka
        DvUr9pX0DKoIFB+y5N1fM+bSY4mCmZTXGFYsi5o=
X-Google-Smtp-Source: ABdhPJzfZCjooO0cvefVY+irZIfuf/8Z9ij10/kz6slZmYic+SA221pSDCDyOUXLUdRLPMo26FAQRZWGjZRLPnjZQKE=
X-Received: by 2002:a05:6e02:ee1:: with SMTP id j1mr16425796ilk.179.1614671987911;
 Mon, 01 Mar 2021 23:59:47 -0800 (PST)
MIME-Version: 1.0
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org>
In-Reply-To: <m1wnuqhaew.fsf@fess.ebiederm.org>
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Date:   Mon, 1 Mar 2021 23:59:36 -0800
Message-ID: <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
Subject: Re: exec error: BUG: Bad rss-counter
To:     "Eric W. Biederman" <ebiederm@xmission.com>, linux-mm@kvack.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 1, 2021 at 12:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
>
> > Eric, All,
> >
> > The following error appears when running Linux 5.10.18 on an embedded
> > MIPS mt7621 target:
> > [    0.301219] BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:1
> >
> > Being a very generic error, I started digging and added a stack dump
> > before the BUG:
> > Call Trace:
> > [<80008094>] show_stack+0x30/0x100
> > [<8033b238>] dump_stack+0xac/0xe8
> > [<800285e8>] __mmdrop+0x98/0x1d0
> > [<801a6de8>] free_bprm+0x44/0x118
> > [<801a86a8>] kernel_execve+0x160/0x1d8
> > [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
> >
> > So that's how I got to looking at fs/exec.c and noticed quite a few
> > changes last year. Turns out this message only occurs once very early
> > at boot during the very first call to kernel_execve. current->mm is
> > NULL at this stage, so acct_arg_size() is effectively a no-op.
>
> If you believe this is a new error you could bisect the kernel
> to see which change introduced the behavior you are seeing.
>
> > More digging, and I traced the RSS counter increment to:
> > [<8015adb4>] add_mm_counter_fast+0xb4/0xc0
> > [<80160d58>] handle_mm_fault+0x6e4/0xea0
> > [<80158aa4>] __get_user_pages.part.78+0x190/0x37c
> > [<8015992c>] __get_user_pages_remote+0x128/0x360
> > [<801a6d9c>] get_arg_page+0x34/0xa0
> > [<801a7394>] copy_string_kernel+0x194/0x2a4
> > [<801a880c>] kernel_execve+0x11c/0x298
> > [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
> >
> > In fact, I also checked vma_pages(bprm->vma) and lo and behold it is set to 1.
> >
> > How is fs/exec.c supposed to handle implied RSS increments that happen
> > due to page faults when discarding the bprm structure? In this case,
> > the bug-generating kernel_execve call never succeeded, it returned -2,
> > but I didn't trace exactly what failed.
>
> Unless I am mistaken any left over pages should be purged by exit_mmap
> which is called by mmput before mmput calls mmdrop.
Good to know. Some more digging and I can say that we hit this error
when trying to unmap PFN 0 (is_zero_pfn(pfn) returns TRUE,
vm_normal_page returns NULL, zap_pte_range does not decrement
MM_ANONPAGES RSS counter). Is my understanding correct that PFN 0 is
usable, but special? Or am I totally off the mark here?

Here is the (optimized) stack trace when the counter does not get decremented:
[<8015b078>] vm_normal_page+0x114/0x1a8
[<8015dc98>] unmap_page_range+0x388/0xacc
[<8015e5a0>] unmap_vmas+0x6c/0x98
[<80166194>] exit_mmap+0xd8/0x1ac
[<800290c0>] mmput+0x58/0xf8
[<801a6f8c>] free_bprm+0x2c/0xc4
[<801a8890>] kernel_execve+0x160/0x1d8
[<800420e0>] call_usermodehelper_exec_async+0x114/0x194
[<80003198>] ret_from_kernel_thread+0x14/0x1c

>
> AKA it looks very very fishy this happens and this does not look like
> an execve error.
I think you are right, I'm probably wrong to bother you. However,
since the thread is already started, let me add linux-mm here :)
>
> On the other hand it would be good to know why kernel_execve is failing.
> Then the error handling paths could be scrutinized, and we can check to
> see if everything that should happen on an error path does.
I can check on this, but likely it's the init system not doing things
quite in the right order on my platform, or something similar. The
error is ENOENT from do_open_execat().
>
> > Interestingly, this "BUG:" message is timing-dependent. If I wait a
> > bit before calling free_bprm after bprm_execve the message seems to go
> > away (there are 3 other cores running and calling into kernel_execve
> > at the same time, so there is that). The error also only ever happens
> > once (probably because no more page faults happen?).
> >
> > I don't know enough to propose a proper fix here. Is it decrementing
> > the bprm->mm RSS counter to account for that page fault? Or is
> > current->mm being NULL a bigger problem?
>
> This is call_usermode_helper calls kernel_execve from a kernel thread
> forked by kthreadd.  Which means current->mm == NULL is expected, and
> current->active_mm == &init_mm.
>
> Similarly I bprm->mm having an incremented RSS counter appears correct.
>
> The question is why doesn't that count get consistently cleaned up.
>
> > Apologies in advance, but I have looked hard and do not see a clear
> > resolution for this even in the latest kernel code.
>
> I may be blind but I see two possibilities.
>
> 1) There is a memory stomp that happens early on and bad timing causes
>    the memory stomp to result in an elevated rss count.
>
> 2) There is a buggy error handling path, and whatever failure you are
>     running into that early in boot walks through that buggy failure
>     path.
>
> I don't think this is a widespread issue or yours would not be the first
> report like this I have seen.
>
> The two productive paths I can see for tracing down your problem are:
> 1) git bisect (assuming you have a known good version)
> 2) Figuring out what exec failed.
>
> I really think exec_mmap should have cleaned up anything in the mm.  So
> the fact that it doesn't worries me.
>
> Eric

Ilya
