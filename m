Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C8E34C205
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 04:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhC2CtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhC2Cs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:48:29 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308BAC061574;
        Sun, 28 Mar 2021 19:48:29 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e8so11311842iok.5;
        Sun, 28 Mar 2021 19:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L59rftjViXvOsrY5NrGI0yIgsP0PoylFj7glT8z5VLA=;
        b=KDQfUILIwMRXKsgeGaJRP6v6nywZVjOo5VuqQQ2yEjfRK5Ce08mKavK4hnXHgxP31P
         +Pg2yL1aEnoOcnVprbrict2Wjg91/HNzHOy3LMJaKrfyNNhs7wN5Xr6deLyNmWf4tveX
         Hq9cI3IqZw6x0OKYjvA9BgllorHJ4D/oNALurteYu9r3emOTxn7I6O5Qt00wYpKfZDTS
         tEqNKEFkj6xrcZnYEgCEwUKqAK6taFBlmLcyXDh1XnFNmyIgWAh8gkxA3xlKdqGbDWr9
         f43/lB2oo9Iqk2+d/96saECZ3QOXrmuupiWWJCWJoadLw/Ik90BEf/hxZb2j4KUJ6xlY
         CW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L59rftjViXvOsrY5NrGI0yIgsP0PoylFj7glT8z5VLA=;
        b=e23rCwfC23WjCbKVwWr8sjJjRwfg0f+4dzHxQZWZ6t+80Cd6z9zDGHDZHulUPXmLmT
         nGHRW/s0XKlJmpw+yuNVzSodtWeyAk+Jqis+VIwdjqgAIzU3vbaB/VYx5xRU6PJUOhPv
         abk+YlZMI9jra/qKmd7XWAnnZ6o6kFbZkAI8nJ0egXFm0y4xNrCrqmWFNfsZ00l/OaHB
         XjboUXw7bdKrlkO9gQ+8Uj6zs71r+NYbIDaGOBlYrltTvSCbjGH8AoPEqXnQ7g9KfPFE
         0fe4hUKxE6zAlRCYtA+LjKgiWeWwgn3nDIA8Fp8inSR9+ZreWX4f+8j4CU5/NJ8wgI3V
         SF1A==
X-Gm-Message-State: AOAM531f/WcVtuwc5adC3P1G35z8FIs0yFWkx2fLU1GJUfgiUS/YtZqo
        iaJ5/TAzCxoDsv0fqaLbiDvBfCG1VjgxNYNR9WQ=
X-Google-Smtp-Source: ABdhPJzjU95CYzRQQi9pPslD6ByeTpbDNCX3fOGBgTZlIQzsAXUbnrmGrHMnZlM1ZMQ16X9Larn6m9vynsl4JVkxJeA=
X-Received: by 2002:a6b:fc05:: with SMTP id r5mr18661308ioh.103.1616986108614;
 Sun, 28 Mar 2021 19:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org> <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
 <m1blc1gxdx.fsf@fess.ebiederm.org> <CALCv0x2-Q9o7k1jhzN73nZ9F5+tcp7T8SkLKQWXW=1gLLJNegA@mail.gmail.com>
 <m1r1kwdyo0.fsf@fess.ebiederm.org> <CALCv0x0FQN+LSUkJaSsV=MCjpFokfgHeqSTHYOTpzA6cOyvQoA@mail.gmail.com>
 <e52b2625-8d33-c081-adeb-f92f64ca1e8e@wanyeetech.com>
In-Reply-To: <e52b2625-8d33-c081-adeb-f92f64ca1e8e@wanyeetech.com>
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Date:   Sun, 28 Mar 2021 19:48:17 -0700
Message-ID: <CALCv0x29Dvs2R=Hg9FebGUFZpd+vN1Lzz2N6a2Zohgo47ZhsGg@mail.gmail.com>
Subject: Re: exec error: BUG: Bad rss-counter
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 8:59 AM Zhou Yanjie <zhouyanjie@wanyeetech.com> wro=
te:
>
> Hi Ilya,
>
> On 2021/3/3 =E4=B8=8B=E5=8D=8811:55, Ilya Lipnitskiy wrote:
> > On Wed, Mar 3, 2021 at 7:50 AM Eric W. Biederman <ebiederm@xmission.com=
> wrote:
> >> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
> >>
> >>> On Tue, Mar 2, 2021 at 11:37 AM Eric W. Biederman <ebiederm@xmission.=
com> wrote:
> >>>> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
> >>>>
> >>>>> On Mon, Mar 1, 2021 at 12:43 PM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
> >>>>>> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
> >>>>>>
> >>>>>>> Eric, All,
> >>>>>>>
> >>>>>>> The following error appears when running Linux 5.10.18 on an embe=
dded
> >>>>>>> MIPS mt7621 target:
> >>>>>>> [    0.301219] BUG: Bad rss-counter state mm:(ptrval) type:MM_ANO=
NPAGES val:1
> >>>>>>>
> >>>>>>> Being a very generic error, I started digging and added a stack d=
ump
> >>>>>>> before the BUG:
> >>>>>>> Call Trace:
> >>>>>>> [<80008094>] show_stack+0x30/0x100
> >>>>>>> [<8033b238>] dump_stack+0xac/0xe8
> >>>>>>> [<800285e8>] __mmdrop+0x98/0x1d0
> >>>>>>> [<801a6de8>] free_bprm+0x44/0x118
> >>>>>>> [<801a86a8>] kernel_execve+0x160/0x1d8
> >>>>>>> [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
> >>>>>>> [<80003198>] ret_from_kernel_thread+0x14/0x1c
> >>>>>>>
> >>>>>>> So that's how I got to looking at fs/exec.c and noticed quite a f=
ew
> >>>>>>> changes last year. Turns out this message only occurs once very e=
arly
> >>>>>>> at boot during the very first call to kernel_execve. current->mm =
is
> >>>>>>> NULL at this stage, so acct_arg_size() is effectively a no-op.
> >>>>>> If you believe this is a new error you could bisect the kernel
> >>>>>> to see which change introduced the behavior you are seeing.
> >>>>>>
> >>>>>>> More digging, and I traced the RSS counter increment to:
> >>>>>>> [<8015adb4>] add_mm_counter_fast+0xb4/0xc0
> >>>>>>> [<80160d58>] handle_mm_fault+0x6e4/0xea0
> >>>>>>> [<80158aa4>] __get_user_pages.part.78+0x190/0x37c
> >>>>>>> [<8015992c>] __get_user_pages_remote+0x128/0x360
> >>>>>>> [<801a6d9c>] get_arg_page+0x34/0xa0
> >>>>>>> [<801a7394>] copy_string_kernel+0x194/0x2a4
> >>>>>>> [<801a880c>] kernel_execve+0x11c/0x298
> >>>>>>> [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
> >>>>>>> [<80003198>] ret_from_kernel_thread+0x14/0x1c
> >>>>>>>
> >>>>>>> In fact, I also checked vma_pages(bprm->vma) and lo and behold it=
 is set to 1.
> >>>>>>>
> >>>>>>> How is fs/exec.c supposed to handle implied RSS increments that h=
appen
> >>>>>>> due to page faults when discarding the bprm structure? In this ca=
se,
> >>>>>>> the bug-generating kernel_execve call never succeeded, it returne=
d -2,
> >>>>>>> but I didn't trace exactly what failed.
> >>>>>> Unless I am mistaken any left over pages should be purged by exit_=
mmap
> >>>>>> which is called by mmput before mmput calls mmdrop.
> >>>>> Good to know. Some more digging and I can say that we hit this erro=
r
> >>>>> when trying to unmap PFN 0 (is_zero_pfn(pfn) returns TRUE,
> >>>>> vm_normal_page returns NULL, zap_pte_range does not decrement
> >>>>> MM_ANONPAGES RSS counter). Is my understanding correct that PFN 0 i=
s
> >>>>> usable, but special? Or am I totally off the mark here?
> >>>> It would be good to know if that is the page that get_user_pages_rem=
ote
> >>>> returned to copy_string_kernel.  The zero page that is always zero,
> >>>> should never be returned when a writable mapping is desired.
> >>> Indeed, pfn 0 is returned from get_arg_page: (page is 0x809cf000,
> >>> page_to_pfn(page) is 0) and it is the same page that is being freed a=
nd not
> >>> refcounted in mmput/zap_pte_range. Confirmed with good old printk. Al=
so,
> >>> ZERO_PAGE(0)=3D=3D0x809fc000 -> PFN 5120.
> >>>
> >>> I think I have found the problem though, after much digging and thank=
s to all
> >>> the information provided. init_zero_pfn() gets called too late (after
> >>> the call to
> >>> is_zero_pfn(0) from mmput returns true), until then zero_pfn =3D=3D 0=
, and after,
> >>> zero_pfn =3D=3D 5120. Boom.
> >>>
> >>> So PFN 0 is special, but only for a little bit, enough for something
> >>> on my system
> >>> to call kernel_execve :)
> >>>
> >>> Question: is my system not supposed to be calling kernel_execve this
> >>> early or does
> >>> init_zero_pfn() need to happen earlier? init_zero_pfn is currently a
> >>> core_initcall.
> >> Looking quickly it seems that init_zero_pfn() is in mm/memory.c and is
> >> common for both mips and x86.  Further it appears init_zero_pfn() has
> >> been that was since 2009 a13ea5b75964 ("mm: reinstate ZERO_PAGE").
> >>
> >> Given the testing that x86 gets and that nothing like this has been
> >> reported it looks like whatever driver is triggering the kernel_execve
> >> is doing something wrong.
> >> Because honestly.  If the zero page isn't working there is not a chanc=
e
> >> that anything in userspace is working so it is clearly much too early.
> >>
> >> I suspect there is some driver that is initialized very early that is
> >> doing something that looks innocuous (like triggering a hotplug event)
> >> and that happens to cause a call_usermode_helper which then calls
> >> kernel_execve.
> > I will investigate the offenders more closely. However, I do not
> > notice this behavior on the same system based on the 5.4 kernel. Is it
>
>
> I also encountered this problem on Ingenic X1000 and X1830. This is the
> printed information:
>
> [    0.120715] BUG: Bad rss-counter state mm:(ptrval)
>   type:MM_ANONPAGES val:1
>
> I tested kernel 5.9, kernel 5.10, kernel 5.11, and kernel 5.12, only
> kernel 5.9 did not have this problem, so we can know that this problem
> was introduced in kernel 5.10, have you found any effective solution?
Try:
diff --git a/mm/memory.c b/mm/memory.c
index c8e357627318..1fd753245369 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -166,7 +166,7 @@ static int __init init_zero_pfn(void)
        zero_pfn =3D page_to_pfn(ZERO_PAGE(0));
        return 0;
 }
-core_initcall(init_zero_pfn);
+early_initcall(init_zero_pfn);

 void mm_trace_rss_stat(struct mm_struct *mm, int member, long count)
 {
