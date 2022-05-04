Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994A051A25F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 16:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351385AbiEDOld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 10:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiEDOlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 10:41:32 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAD441306
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 07:37:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id e128so1051921qkd.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 May 2022 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDQYDtvtMAO7ZSU4G368+P4A7m0hqU6DX0JGAUFCbP8=;
        b=IBc47cuiZeW5kl6UqRivKUKAgfT3rqKN6jG+oq3yKfZ63FQ4q978KGBEWOBNkDbyu0
         y+8J9UKisqNUjvO6WCHP82Ic4jP5aEZjGl0a0dtTDqkhIQsPSHuLKFQ9DM7KMTr4qm5G
         6D4PZzqFF1/sLZmJFDrnnBvq6j/A5aB3UOZUftnAxajwYCWf1wIiibto4htqAlLlbsAG
         aC97Kr3Bu+mIuj59vg5dwHSjRksfRooXEld1apE9nQpDGVD6rAi/myamlI9umtQKOphO
         96SXDtKp/vgCexmJKkEKUwD77id0ts2Up2VoGbQsKIjktw9y317+gxYXxbm1frQxuNhp
         MXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDQYDtvtMAO7ZSU4G368+P4A7m0hqU6DX0JGAUFCbP8=;
        b=a9W00b8PuM9ek2OK3iplMEJIUNe6D2ebLFxGusq3+btpHEdENWceb7hiTQ/NZzwPfY
         LC1Vo0mCcxEqMlZqxTOAQQl1DRVdhe8cs1eeED+AkJ/bTYumUEBIW8XwKBJYaRNFRaVn
         t3ymbl7G8THzw5H9YpCjvXkenseGnyVzzR6K/pTixUxQGK1+0BzBqaALCzZPjzZOFLmQ
         goCwTCcLTD40FKT173pf6ZpigC4yXqQJax3ak0N9X20cT7trLrj3bmyJ8Oa8TJbRq09R
         9uYZGmvNZs3hWrBqMjkwPbjjSKm5jGTQKrj3TaToiNzC9sW4u0LWLalXbGyvt1MPlT1q
         vRDw==
X-Gm-Message-State: AOAM531Sc2xW/Wm7pFATgJe+22xfwptdimM3WBEsc6teUSobduQsMYQJ
        gBNjC+MUgdPogCu067RARIQR/N0MiSzuZQS1slqfn0YxrxQJhTgy
X-Google-Smtp-Source: ABdhPJwpoGjOy3+paUpcOif3G311QEyjW63S89KjxZ6eONJv4ZiVEMt1kpsncH66rnLUwTAxSGkjlF61aNfdRXpnzm8=
X-Received: by 2002:a37:9cd8:0:b0:69f:b618:c7ab with SMTP id
 f207-20020a379cd8000000b0069fb618c7abmr16380417qke.722.1651675075275; Wed, 04
 May 2022 07:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan> <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
 <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de> <CAOQ4uxhry1_tW9NPC4X3q3YUQ86Ecg+G6A2Fvs5vKQTDB0ctHQ@mail.gmail.com>
 <8c636384-8db6-d7d1-b89b-424ef1accfe8@mail.de> <CAOQ4uxgLovYffU5epFy+r3qa7WjD9637YNuiFJHGj_du7H8gOA@mail.gmail.com>
 <20220303092459.mglgfvq653ge4k42@quack3.lan> <6799146c-fa5a-7b64-bb91-6038006cf612@mail.de>
 <CAOQ4uxgXfL6_fi9rSf8_cUW0Lgbw8Rj_VcBOPiA5ec3PqBqo_Q@mail.gmail.com> <7887399b-a0a0-2e09-a9fb-68b758dfa2ff@mail.de>
In-Reply-To: <7887399b-a0a0-2e09-a9fb-68b758dfa2ff@mail.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 May 2022 17:37:43 +0300
Message-ID: <CAOQ4uxj4YOg2JP6XSzYtn2-eta2SsVcTgjHfnc=raD8S7xgrkQ@mail.gmail.com>
Subject: Re: [RFC] Volatile fanotify marks
To:     Tycho Kirchner <tychokirchner@mail.de>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 4, 2022 at 1:01 PM Tycho Kirchner <tychokirchner@mail.de> wrote:
>
>
>
> Am 04.05.22 um 08:13 schrieb Amir Goldstein:
> > On Mon, May 2, 2022 at 12:13 PM Tycho Kirchner <tychokirchner@mail.de> wrote:
> >>
> >> All right, I thought a bit more about that and returned to your
> >> original BPF idea you mentioned on 2020-08-28:
> >>
> >>> I was thinking that we could add a BPF hook to fanotify_handle_event()
> >>> (similar to what's happening in packet filtering code) and you could attach
> >>> BPF programs to this hook to do filtering of events. That way we don't have
> >>> to introduce new group flags for various filtering options. The question is
> >>> whether eBPF is strong enough so that filters useful for fanotify users
> >>> could be implemented with it but this particular check seems implementable.
> >>>
> >>>                                                                Honza
> >>
> >> Instead of changing fanotify's filesystem notification functionality,
> >> I suggest to rather **add a tracing mode (fantrace)**.
> >>
> >> The synchronous handling of syscalls via ptrace is of course required
> >> for debugging purposes, however that introduces a major slowdown (even
> >> with seccomp-bpf filters). There are a number of cases, including
> >> [1-3], where async processing of file events of specific tasks would be
> >> fine but is not readily available in Linux. Fanotify already ships
> >> important infrastructure in this regard: it provides very fast
> >> event-buffering and, by using file descriptors instead of resolved
> >> paths, a clean and race-free API to process the events later. However,
> >> as already stated, fanotify does not provide a clean way, to monitor
> >> only a subset of tasks. Therefore please consider the following
> >> proposed architecture of fantrace:
> >>
> >> Each taks gets its own struct fsnotify_group. Within
> >> fsnotify.c:fsnotify() it is checked if the given task has a
> >> fsnotify_group attached where events of interest are buffered as usual.
> >> Note that this is an additional hook - sysadmins being subscribed to
> >> filesystem events rather than task-filesystem-events are notified as
> >> usual - in that case two hooks possibly run. The fsnotify_group is
> >> extended by a field optionally pointing to a BPF program which allows
> >> for custom filters to be run.
> >>
> >> Some implementation details:
> >> - To let the tracee return quickly, run BPF filter program within tracer
> >>     context during read(fan_fd) but before events are copied to userspace
> >> - only one fantracer per task, which overrides existing ones if any
> >> - task->fsnotify_group refcount increment on fork, decrement on exit (run
> >>     after exit_files(tsk) to not miss final close events). When last task
> >>     exited, send EOF to listener.
> >> - on exec of seuid-programs the fsnotify_group is cleared (like in ptrace)
> >> - lazy check when event occurs, if listener is still alive (refcount > 1)
> >> - for the beginning, to keep things simple and to "solve" the cleanup of
> >>     filesystem marks, I suggest to disable i_fsnotify_marks for fantrace
> >>     (only allow FAN_MARK_FILESYSTEM), as that functionality can be
> >>     implemented within the user-provided BPF-program.
> >>
> >
> > Maybe I am slow, but I did not understand the need for this task fsnotify_group.
> >
> > What's wrong with Jan's suggestion? (add a BPF hook to fanotify_handle_event())
> > that hook is supposed to filter by pid so why all this extra complexity?
> >
> > We may consider the option to have another BFP hook when reading
> > events if there is
> > good justification, but subtree filters will have to be in handle_event().
> >
> > Thanks,
> > Amir.
>
> To be a reasonable async replacement for ptrace (see e.g. mentioned reprozip)
> file-events from all paths have to be reported, which is difficult
> using i_fsnotify_marks, because
> - marking whole mountpoints requires privileges
> - marking the whole filesystem using directory marks is unfeasible
>
> However, we need a quick way to find out, if a file event is of
> interest (find its beloning fsnotify_group). For the purpose of tracing
> it appears reasonable to consider all file events of a traced task as
> "interesting" in the first place. So, in this way, we allow a user to
> trace file events of his own tasks without slowing down other,
> non-traced tasks.
>
> After all, it's all about the order of running filters - first inode,
> then pid or reverse. With my proposed architecture for the purpose of
> tracing I would hand the inode-filter to the user in form of an
> optional BPF hook. Performance-wise that's also the "fair" solution.
> Let's assume we allow marking the whole filesystem (via mountpoints).
> Now, the BPF-pid-filter code has to run for every single file event (of
> all users!), if multiple users trace the filesystem even multiple hooks
> have to run, slowing down the whole system.
>

I understand now what you were trying to do, but still not convinced
that the added complexity to the kernel is worth it, because you may be
able to achieve the same with userspace LD_PRELOAD hooking.

BTW, the fanotify_userns patch set [1] was an attempt to allow unprivileged
user watch over subtree with low performance impact on the rest of the
file system.
This is not exactly what you need, but maybe it could be made
into what you need.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_userns
