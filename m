Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B166A51D517
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390765AbiEFKDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345708AbiEFKDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 06:03:37 -0400
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA215B88C
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 02:59:54 -0700 (PDT)
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
        by shout02.mail.de (Postfix) with ESMTP id 197E7A0C79;
        Fri,  6 May 2022 11:59:52 +0200 (CEST)
Received: from smtp02.mail.de (smtp02.bt.mail.de [10.0.121.212])
        by postfix03.mail.de (Postfix) with ESMTP id EDFEB801CF;
        Fri,  6 May 2022 11:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1651831192;
        bh=GwSqFqJuVviAUXborlU4R/pW/s7/wFicpF4xp3PgCx0=;
        h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
        b=lwXyusXBKqAHI3hyE85lx37ayseeF0Ddd6O8vDPnghSRg0+lnA2qar+Z0uY4lGUfs
         qp5a3kLFMosGBIneYNwL712H300l3XJGJZTdfiSf98w9n+A3WN1tab1wJe6aE5on2C
         6x9QsaaOa+hnP82bztdFeZ6kzcXKLi58+gb85MfkTZ6alBLbY76x03onBbe9ckxYlg
         8JmKNMHFeGvU1M4RY98gwbIASem0hWaRLeZQixVNygi/wJq5915O7FKXpo87MmvaWR
         RYPW85MHtD0HSzsYQM8qkUkiceJOPk79xnePoVeW/0/58HPqcVjyE5qY6By2TDhOI8
         cMRZprSErPPAw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp02.mail.de (Postfix) with ESMTPSA id 3EA13A0573;
        Fri,  6 May 2022 11:59:51 +0200 (CEST)
Message-ID: <99bb075f-60e3-9480-f253-45515da80348@mail.de>
Date:   Fri, 6 May 2022 11:59:50 +0200
MIME-Version: 1.0
Subject: Re: [RFC] Volatile fanotify marks
Content-Language: de-DE
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
 <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
 <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de>
 <CAOQ4uxhry1_tW9NPC4X3q3YUQ86Ecg+G6A2Fvs5vKQTDB0ctHQ@mail.gmail.com>
 <8c636384-8db6-d7d1-b89b-424ef1accfe8@mail.de>
 <CAOQ4uxgLovYffU5epFy+r3qa7WjD9637YNuiFJHGj_du7H8gOA@mail.gmail.com>
 <20220303092459.mglgfvq653ge4k42@quack3.lan>
 <6799146c-fa5a-7b64-bb91-6038006cf612@mail.de>
 <CAOQ4uxgXfL6_fi9rSf8_cUW0Lgbw8Rj_VcBOPiA5ec3PqBqo_Q@mail.gmail.com>
 <7887399b-a0a0-2e09-a9fb-68b758dfa2ff@mail.de>
 <CAOQ4uxj4YOg2JP6XSzYtn2-eta2SsVcTgjHfnc=raD8S7xgrkQ@mail.gmail.com>
From:   Tycho Kirchner <tychokirchner@mail.de>
In-Reply-To: <CAOQ4uxj4YOg2JP6XSzYtn2-eta2SsVcTgjHfnc=raD8S7xgrkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 6999
X-purgate-ID: 154282::1651831191-0000737C-26E18C1D/0/0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



>>> On Mon, May 2, 2022 at 12:13 PM Tycho Kirchner <tychokirchner@mail.de> wrote:
>>>>
>>>> All right, I thought a bit more about that and returned to your
>>>> original BPF idea you mentioned on 2020-08-28:
>>>>
>>>>> I was thinking that we could add a BPF hook to fanotify_handle_event()
>>>>> (similar to what's happening in packet filtering code) and you could attach
>>>>> BPF programs to this hook to do filtering of events. That way we don't have
>>>>> to introduce new group flags for various filtering options. The question is
>>>>> whether eBPF is strong enough so that filters useful for fanotify users
>>>>> could be implemented with it but this particular check seems implementable.
>>>>>
>>>>>                                                                 Honza
>>>>
>>>> Instead of changing fanotify's filesystem notification functionality,
>>>> I suggest to rather **add a tracing mode (fantrace)**.
>>>>
>>>> The synchronous handling of syscalls via ptrace is of course required
>>>> for debugging purposes, however that introduces a major slowdown (even
>>>> with seccomp-bpf filters). There are a number of cases, including
>>>> [1-3], where async processing of file events of specific tasks would be
>>>> fine but is not readily available in Linux. Fanotify already ships
>>>> important infrastructure in this regard: it provides very fast
>>>> event-buffering and, by using file descriptors instead of resolved
>>>> paths, a clean and race-free API to process the events later. However,
>>>> as already stated, fanotify does not provide a clean way, to monitor
>>>> only a subset of tasks. Therefore please consider the following
>>>> proposed architecture of fantrace:
>>>>
>>>> Each taks gets its own struct fsnotify_group. Within
>>>> fsnotify.c:fsnotify() it is checked if the given task has a
>>>> fsnotify_group attached where events of interest are buffered as usual.
>>>> Note that this is an additional hook - sysadmins being subscribed to
>>>> filesystem events rather than task-filesystem-events are notified as
>>>> usual - in that case two hooks possibly run. The fsnotify_group is
>>>> extended by a field optionally pointing to a BPF program which allows
>>>> for custom filters to be run.
>>>>
>>>> Some implementation details:
>>>> - To let the tracee return quickly, run BPF filter program within tracer
>>>>      context during read(fan_fd) but before events are copied to userspace
>>>> - only one fantracer per task, which overrides existing ones if any
>>>> - task->fsnotify_group refcount increment on fork, decrement on exit (run
>>>>      after exit_files(tsk) to not miss final close events). When last task
>>>>      exited, send EOF to listener.
>>>> - on exec of seuid-programs the fsnotify_group is cleared (like in ptrace)
>>>> - lazy check when event occurs, if listener is still alive (refcount > 1)
>>>> - for the beginning, to keep things simple and to "solve" the cleanup of
>>>>      filesystem marks, I suggest to disable i_fsnotify_marks for fantrace
>>>>      (only allow FAN_MARK_FILESYSTEM), as that functionality can be
>>>>      implemented within the user-provided BPF-program.
>>>>
>>>
>>> Maybe I am slow, but I did not understand the need for this task fsnotify_group.
>>>
>>> What's wrong with Jan's suggestion? (add a BPF hook to fanotify_handle_event())
>>> that hook is supposed to filter by pid so why all this extra complexity?
>>>
>>> We may consider the option to have another BFP hook when reading
>>> events if there is
>>> good justification, but subtree filters will have to be in handle_event().
>>>
>>> Thanks,
>>> Amir.
>>
>> To be a reasonable async replacement for ptrace (see e.g. mentioned reprozip)
>> file-events from all paths have to be reported, which is difficult
>> using i_fsnotify_marks, because
>> - marking whole mountpoints requires privileges
>> - marking the whole filesystem using directory marks is unfeasible
>>
>> However, we need a quick way to find out, if a file event is of
>> interest (find its beloning fsnotify_group). For the purpose of tracing
>> it appears reasonable to consider all file events of a traced task as
>> "interesting" in the first place. So, in this way, we allow a user to
>> trace file events of his own tasks without slowing down other,
>> non-traced tasks.
>>
>> After all, it's all about the order of running filters - first inode,
>> then pid or reverse. With my proposed architecture for the purpose of
>> tracing I would hand the inode-filter to the user in form of an
>> optional BPF hook. Performance-wise that's also the "fair" solution.
>> Let's assume we allow marking the whole filesystem (via mountpoints).
>> Now, the BPF-pid-filter code has to run for every single file event (of
>> all users!), if multiple users trace the filesystem even multiple hooks
>> have to run, slowing down the whole system.
>>
>
> I understand now what you were trying to do, but still not convinced
> that the added complexity to the kernel is worth it, because you may be
> able to achieve the same with userspace LD_PRELOAD hooking.

In fact, I use that approach in shournal's fanotify backend, as the
shell process cannot join the mount namespace of the currently executing
command (without re-exec). See here, for example:
https://github.com/tycho-kirchner/shournal/blob/master/src/shell-integration-fanotify/libshournal-shellwatch.cpp

However, while this works for the supported shells bash and zsh,
the LD_PRELOAD approach in general is problematic:

- Static compiled executables cannot be traced (rare, ptrace with
   seccomp-bpf filters might be ok for those)
- killed tasks may still have fd's open, so signals also have to be hooked.
   SIGKILL or crashing tasks (e.g. segfault) cannot be handled at all (though
   this would be ok)
- close- or other library-calls are potentially inlined. Some programs may
   even use syscalls directly (probably a rare issue, but I'm not sure)
- quite some hooks required: close, fclose (glibc does not use the close wrapper),
   fcloseall, dup2, dup3, exit, _exit and possibly others

Actually, this sounds more of a complexity. I guess I could make a
proof-of-principle implementation of my proposed fantrace in a few days,
but of course this makes only sense if there is a slight chance this
could be accepted.

>
> BTW, the fanotify_userns patch set [1] was an attempt to allow unprivileged
> user watch over subtree with low performance impact on the rest of the
> file system.
> This is not exactly what you need, but maybe it could be made
> into what you need.
> [1] https://github.com/amir73il/linux/commits/fanotify_userns

I'll take at look, but while I'm fine in compiling a custom kernel
users of my tool are not. Further, using user namespaces in the
outermost shell layer (where my tool runs) is problematic for
administrators or users of setuid binaries.

Thanks,
Tycho

