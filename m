Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D881B32C552
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450728AbhCDAUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhCCP50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:57:26 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9766C061756;
        Wed,  3 Mar 2021 07:56:08 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id f20so26229394ioo.10;
        Wed, 03 Mar 2021 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhBVhWESGWEO8S/PFgm/8fSWVJaTXZ1s1zCrVDAHRoI=;
        b=Eq/s7Dg7Y+Qwoev/X99QbmvDCxjI5uR+6e/ZKFIpIOGE1pSxexFtahRiTo29AVYYFf
         bBHIJrIe0f+4RAzv1ieCmuBFF7qGWhAVOZQXTlkOwBOoWe2/0Dr+HmzPpOngaf7trX/S
         joj+ovVKKQ54Q8eME0uTzPV6eI0yTlHoctt4Wo4Y4Gswr73ocE5UZRSapEcDnzcvglBx
         AaYx6nZc4OY6K6sjI3MAb1VUK6hLS+Hx9diuSFUW+JUbR9aIJi2sc/Vt8ZLxY3OYTCBG
         Unnx8pM/lDHFV2KOhhROBc1PlUE6V8F++cnWHPdHvpoDYiTABMP75t2mZIcV0mebRZrq
         E5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhBVhWESGWEO8S/PFgm/8fSWVJaTXZ1s1zCrVDAHRoI=;
        b=q0Vz0ttoizsQCRKnQmjjQLmUThKyS5szGTQoahDlyCHDNYl12fad/9usVDpRBL6vHg
         0Cneb3/nGv8VWBT3qO/nIImG/0ms2tKgUR9Z69315rEVF5nojy59Vm5zW0u4qxf4CDpP
         H8d3uUMowlCAD82NZg4Rn34ypJN1bUG5fMnM/aUug2Fw3igK+ff7WEyzfF8zGzgXne/O
         /EIkYp/KRC0Qcyr94AK7YnxDqJh0TeAssGEd5NOl1v5KoSGOwEJTZQMhYseAWT1WJcNM
         cCVErc3wECxc+wp+2bZ1Zf4MrgGJU5kV93vIx2hYhspuhlmPRLcwkgzyNBYVqNLkpP4d
         FTDg==
X-Gm-Message-State: AOAM533ClYRm5IjxCduKPXrSwlVTbeZCipGwXnr2PH9RQVVWnlXUu/7i
        xYhCxKj/b8NgQaPNRNwF8Rh/zD0VRn2bxi1/x1A=
X-Google-Smtp-Source: ABdhPJwrurvlTKj5oFwlNFzBPLm+J3XtEfY4SQJ40oWWnastmW0/AoQ7GlEi1QHrfuu0Y3Lgw1IPw747u1M/nJTzrlQ=
X-Received: by 2002:a5e:cb4d:: with SMTP id h13mr17136094iok.68.1614786967796;
 Wed, 03 Mar 2021 07:56:07 -0800 (PST)
MIME-Version: 1.0
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org> <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
 <m1blc1gxdx.fsf@fess.ebiederm.org> <CALCv0x2-Q9o7k1jhzN73nZ9F5+tcp7T8SkLKQWXW=1gLLJNegA@mail.gmail.com>
 <m1r1kwdyo0.fsf@fess.ebiederm.org>
In-Reply-To: <m1r1kwdyo0.fsf@fess.ebiederm.org>
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Date:   Wed, 3 Mar 2021 07:55:56 -0800
Message-ID: <CALCv0x0FQN+LSUkJaSsV=MCjpFokfgHeqSTHYOTpzA6cOyvQoA@mail.gmail.com>
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
I will investigate the offenders more closely. However, I do not
notice this behavior on the same system based on the 5.4 kernel. Is it
possible that last year's exec changes have exposed this issue? Not
blaming exec at all, just making sure I understand the problem better.

Ilya
