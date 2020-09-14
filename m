Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9007A268CF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgINOKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgINOKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:10:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106A8C061788
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 07:10:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so5631298pjh.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRqXshFDT+vnZmomkxjfH2FYDG36/bbMKP3d6/TVV9M=;
        b=SA6T4f5wMMABu+t8mm80Smz6yCnXmOq4zhzbzYWqAt4U6dd1B4KI5EWZkoOvr2B1gU
         QgoGOV3mSA281/6F47ccWVGpociAdB0LrUQA4l3YR2SeyfI0wSm9qf8US52gEW0KQF2y
         H6qrSGtKEVOqURphrLheizNfZf4sq3h89O0/czzgZVCEWsLf/BKneKHsAOwbCHap5+Wp
         NJHyoJF/o+ebSmCYqBF+eB4fDR9e+bO/d/Q19gWKyxze0kMq7WVFrF/ap0HI6pPiOytZ
         LjjmKZXYYXnmskJR37USBx1R4oRyBc/NmCl86+YGHoIKRxnuD4UbSgs6aAfL3sGcD1Yi
         bnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRqXshFDT+vnZmomkxjfH2FYDG36/bbMKP3d6/TVV9M=;
        b=FaObm76x93j9WrzolZiLHm2eJY+ZZ7+h/oUKz8FOQ8eeN9q2Sry4xh5fqCkXOVRglh
         IkQbjGTDDk+mCYUSI8ItD44pvf8Y8BUL4CPBuuZRgqUcuHkTz31+xjcfzieIrTyKLyYt
         Tozgl51lwnL+B44/Rord54EGR5bxUnnieLcBpPyLtprFPsRMXFgbpo9E0L8TlGGD1JBt
         H+D9E8pH6dckyH0rpV5gahxBoq9IThjkxVlHz0ngozlX0iGms+2Pcol4w1bO8OAmXO4X
         MJ1SaKMBQCJxz7HjZisMoGIROaHPaEh50EZRwQgwa198N3KgjvB2RY5r7RLUr5/N21Rm
         72Fw==
X-Gm-Message-State: AOAM530BIWK4xisMmjZ6Lytk8S4gQOONwUhPJlaTnyFFA5tDlzVgYGFO
        576jZihw6VCUafUQslinPVKU7uUZEnNkSJhJjXAsHQ==
X-Google-Smtp-Source: ABdhPJw9BQptYud9GJhEfnROZuP65PKWdze/0QkF0LIi84zuolcXFlUe3SubWt2yYGeG0S67y6BktHx0FAti4nACcww=
X-Received: by 2002:a17:90a:fa94:: with SMTP id cu20mr14131322pjb.147.1600092600608;
 Mon, 14 Sep 2020 07:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200828031928.43584-1-songmuchun@bytedance.com>
 <CAMZfGtWtAYNexRq1xf=5At1+YJ+_TtN=F6bVnm9EPuqRnMuroA@mail.gmail.com>
 <8c288fd4-2ef7-ca47-1f3b-e4167944b235@linux.com> <CAMZfGtXsXWtHh_G0TWm=DxG_5xT6kN_BbfqNgoQvTRu89FJihA@mail.gmail.com>
 <2f347fde-6f8d-270b-3886-0d106fcc5a46@linux.com>
In-Reply-To: <2f347fde-6f8d-270b-3886-0d106fcc5a46@linux.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 14 Sep 2020 22:09:24 +0800
Message-ID: <CAMZfGtVRXVuzUc_ddJJPD9D4tzvDAJTbQxaEx=+ghSOh4w4iKA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] stackleak: Fix a race between stack
 erasing sysctl handlers
To:     alex.popov@linux.com
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        miguel.ojeda.sandonis@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 9:56 PM Alexander Popov <alex.popov@linux.com> wrote:
>
> On 07.09.2020 16:53, Muchun Song wrote:
> > On Mon, Sep 7, 2020 at 7:24 PM Alexander Popov <alex.popov@linux.com> wrote:
> >>
> >> On 07.09.2020 05:54, Muchun Song wrote:
> >>> Hi all,
> >>>
> >>> Any comments or suggestions? Thanks.
> >>>
> >>> On Fri, Aug 28, 2020 at 11:19 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >>>>
> >>>> There is a race between the assignment of `table->data` and write value
> >>>> to the pointer of `table->data` in the __do_proc_doulongvec_minmax() on
> >>>> the other thread.
> >>>>
> >>>>     CPU0:                                 CPU1:
> >>>>                                           proc_sys_write
> >>>>     stack_erasing_sysctl                    proc_sys_call_handler
> >>>>       table->data = &state;                   stack_erasing_sysctl
> >>>>                                                 table->data = &state;
> >>>>       proc_doulongvec_minmax
> >>>>         do_proc_doulongvec_minmax             sysctl_head_finish
> >>>>           __do_proc_doulongvec_minmax           unuse_table
> >>>>             i = table->data;
> >>>>             *i = val;  // corrupt CPU1's stack
> >>
> >> Hello everyone!
> >>
> >> As I remember, I implemented stack_erasing_sysctl() very similar to other sysctl
> >> handlers. Is that issue relevant for other handlers as well?
> >
> > Yeah, it's very similar. But the difference is that others use a
> > global variable as the
> > `table->data`, but here we use a local variable as the `table->data`.
> > The local variable
> > is allocated from the stack. So other thread could corrupt the stack
> > like the diagram
> > above.
>
> Hi Muchun,
>
> I don't think that the proposed copying of struct ctl_table to local variable is
> a good fix of that issue. There might be other bugs caused by concurrent
> execution of stack_erasing_sysctl().

I can not figure out how the bug happened when there is concurrent
execution of stack_erasing_sysctl().

>
> I would recommend using some locking instead.
>
> But you say there are other similar issues. Should it be fixed on higher level
> in kernel/sysctl.c?

Yeah, we can see the same issue here.

    https://lkml.org/lkml/2020/8/22/105.

I agree with you. Maybe a fix on the higher level is a good choice in
kernel/sysctl.c. If someone also agrees with this solution, I can do
this work.

>
> [Adding more knowing people to CC]
>
> Thanks!
>
> >> Muchun, could you elaborate how CPU1's stack is corrupted and how you detected
> >> that? Thanks!
> >
> > Why did I find this problem? Because I solve another problem which is
> > very similar to
> > this issue. You can reference the following fix patch. Thanks.
> >
> >   https://lkml.org/lkml/2020/8/22/105
> >>
> >>>> Fix this by duplicating the `table`, and only update the duplicate of
> >>>> it.
> >>>>
> >>>> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> >>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>>> ---
> >>>> changelogs in v2:
> >>>>  1. Add more details about how the race happened to the commit message.
> >>>>
> >>>>  kernel/stackleak.c | 11 ++++++++---
> >>>>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> >>>> index a8fc9ae1d03d..fd95b87478ff 100644
> >>>> --- a/kernel/stackleak.c
> >>>> +++ b/kernel/stackleak.c
> >>>> @@ -25,10 +25,15 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
> >>>>         int ret = 0;
> >>>>         int state = !static_branch_unlikely(&stack_erasing_bypass);
> >>>>         int prev_state = state;
> >>>> +       struct ctl_table dup_table = *table;
> >>>>
> >>>> -       table->data = &state;
> >>>> -       table->maxlen = sizeof(int);
> >>>> -       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> >>>> +       /*
> >>>> +        * In order to avoid races with __do_proc_doulongvec_minmax(), we
> >>>> +        * can duplicate the @table and alter the duplicate of it.
> >>>> +        */
> >>>> +       dup_table.data = &state;
> >>>> +       dup_table.maxlen = sizeof(int);
> >>>> +       ret = proc_dointvec_minmax(&dup_table, write, buffer, lenp, ppos);
> >>>>         state = !!state;
> >>>>         if (ret || !write || state == prev_state)
> >>>>                 return ret;
> >>>> --
> >>>> 2.11.0



-- 
Yours,
Muchun
