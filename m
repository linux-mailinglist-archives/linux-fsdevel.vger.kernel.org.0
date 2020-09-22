Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBC6273A77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 08:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgIVGAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 02:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgIVGAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:00:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF33DC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 23:00:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so11444702pfn.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 23:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rBc7uz/qV7FtcBdGXj+OxjwLJZPI2n1rX8KYRkOBgg=;
        b=O0BgeuLEpLG0LivuhY3Uqm8/0iTqaQSJyp1Z3ecybQuid49MNB7JOKUXLNZGDzL7Lb
         bUjrGC+U7wBvnCfiU1qN17ozFTCCPbjebt178+Oi3OnyGuR/iwc5YGiGms16vkK3csig
         wW/he6YLcaT+oNLybJlCyRuTdSfB9XqcYjMqWf06+J+5sPMcORPySigE5QVaxgsy4TBS
         B2DTNgFSq8lGMjIIif3ZXrucEo5b7DWB9zqhlU0nwLh5V+tKRpmDiKp3k4o95Ww7q8sl
         jXBdCLEBNT+LOF8ChrFZrqQ3iuFBk95CRHUANss7a56lqi7s+kPcAHU53OkbJ4hiCrAn
         D/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rBc7uz/qV7FtcBdGXj+OxjwLJZPI2n1rX8KYRkOBgg=;
        b=QaPRvF3CxmjMKoEb99LlDlqxyCI/DmWBI2IPCh05tlQpu00dQfBWBxyGFtSzf1FOfE
         MD1gk22r4ZsCu7xu9IWkqy5r8PY4A+MQ6uwbDyLrGDaWId1Z+jFDQbVlYRHDVk1hCUdZ
         q32dIvKIhlJOo2NpBoxlSwB7Era7ZG44n7QZryUKioAreVnCpnI4wYkfQ3OwhK4NU/VG
         sF3ydS02DPblU9AwY65yu35F+hADS+aBypnPVC3O66eTHSRFKsPnr6ufP7VnMKd2qzCu
         hipYdhSFwb+H+HpHgEXCwWpMyU6UdYR/uzRmswBHsRehFDDRpj+mdoXR8ZwVunY9w7Q1
         rzdQ==
X-Gm-Message-State: AOAM532f9lkQZqKY6HtOLziZmGZPJ+6AnW7x8H4C31lXMikixoRPnp3I
        1SFKLTxcuGPS3Z2IrT9HNzfEURJWxaX3UcyrfidD+g==
X-Google-Smtp-Source: ABdhPJz3WBkzD0lB/DbAhM5MUq68p1mZUMp5hUKlGR0gh3rGpGOk4O/Wvgrp/BnXT3f4kANwxS3RqK1KeTaCOUdq0z0=
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr562592pgh.273.1600754432198;
 Mon, 21 Sep 2020 23:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200828031928.43584-1-songmuchun@bytedance.com>
 <CAMZfGtWtAYNexRq1xf=5At1+YJ+_TtN=F6bVnm9EPuqRnMuroA@mail.gmail.com>
 <8c288fd4-2ef7-ca47-1f3b-e4167944b235@linux.com> <CAMZfGtXsXWtHh_G0TWm=DxG_5xT6kN_BbfqNgoQvTRu89FJihA@mail.gmail.com>
 <2f347fde-6f8d-270b-3886-0d106fcc5a46@linux.com>
In-Reply-To: <2f347fde-6f8d-270b-3886-0d106fcc5a46@linux.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 22 Sep 2020 13:59:52 +0800
Message-ID: <CAMZfGtVhrgvWqCG140e7S5wn00ocS5L_t=KFNpbsfXhc293rSg@mail.gmail.com>
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

Hi Alexander,

Yeah, we can fix this issue on a higher level in kernel/sysctl.c. But
we will rework some kernel/sysctl.c base code. Because the commit:

    964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")

is introduced from linux-4.20. So we should backport this fix patch to the other
stable tree. Be the safe side, we can apply this patch to only fix the
stack_erasing_sysctl. In this case, the impact of backport is minimal.

In the feature, we can fix the issue(another patch) like this on a higher
level in kernel/sysctl.c and only apply it in the later kernel version. Is
this OK?

>
> I would recommend using some locking instead.
>
> But you say there are other similar issues. Should it be fixed on higher level
> in kernel/sysctl.c?
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
