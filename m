Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38B1516D35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384134AbiEBJW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 05:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384146AbiEBJWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 05:22:48 -0400
X-Greylist: delayed 373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 02:19:18 PDT
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617613BA77
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 02:19:18 -0700 (PDT)
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
        by shout01.mail.de (Postfix) with ESMTP id AF691A093E;
        Mon,  2 May 2022 11:13:03 +0200 (CEST)
Received: from smtp03.mail.de (smtp03.bt.mail.de [10.0.121.213])
        by postfix03.mail.de (Postfix) with ESMTP id 8E1AC801CF;
        Mon,  2 May 2022 11:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1651482783;
        bh=DOW2oYQL0WjyJWaXAYshXP2A3SgKgc/TMDBB9KlJL1w=;
        h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
        b=bCw6NpcOUKq6Lif+9nvRlJfW9j4dDZM9QCeeqtO9eYleIkcv4nJyV4zMJsrdXv1QM
         GM3IVfwsJF/R4BrRTc2Igv8uzApcmYuXhvt7TNqvCPn6+6/UilZQJWwLW7mnebpgRN
         XpGcugERzLaRxR89lGjjh4DQ/8GaVlg7/aPlgI57ElGADueC1MJrwWd5AMMphiR28k
         NZOsyUQS1OjQzF1Ae/E1eF9TE4KI/VIpoOIunFMRYnBT1hB2vFOC6nv6EdL7th1NKX
         xVivSLuFkKAYmwcQ0zwVf097dDFMLMovN2fuPNTVLaz3tGBYWNVPBtoqffk0Kh2sIM
         duMSqMvuQlcUA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp03.mail.de (Postfix) with ESMTPSA id 01BDCA065B;
        Mon,  2 May 2022 11:13:02 +0200 (CEST)
Message-ID: <6799146c-fa5a-7b64-bb91-6038006cf612@mail.de>
Date:   Mon, 2 May 2022 11:13:02 +0200
MIME-Version: 1.0
Subject: Re: [RFC] Volatile fanotify marks
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
 <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
 <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de>
 <CAOQ4uxhry1_tW9NPC4X3q3YUQ86Ecg+G6A2Fvs5vKQTDB0ctHQ@mail.gmail.com>
 <8c636384-8db6-d7d1-b89b-424ef1accfe8@mail.de>
 <CAOQ4uxgLovYffU5epFy+r3qa7WjD9637YNuiFJHGj_du7H8gOA@mail.gmail.com>
 <20220303092459.mglgfvq653ge4k42@quack3.lan>
From:   Tycho Kirchner <tychokirchner@mail.de>
In-Reply-To: <20220303092459.mglgfvq653ge4k42@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3864
X-purgate-ID: 154282::1651482783-0000061A-38871D00/0/0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All right, I thought a bit more about that and returned to your
original BPF idea you mentioned on 2020-08-28:

> I was thinking that we could add a BPF hook to fanotify_handle_event()
> (similar to what's happening in packet filtering code) and you could attach
> BPF programs to this hook to do filtering of events. That way we don't have
> to introduce new group flags for various filtering options. The question is
> whether eBPF is strong enough so that filters useful for fanotify users
> could be implemented with it but this particular check seems implementable.
>
> 								Honza

Instead of changing fanotify's filesystem notification functionality,
I suggest to rather **add a tracing mode (fantrace)**.

The synchronous handling of syscalls via ptrace is of course required
for debugging purposes, however that introduces a major slowdown (even
with seccomp-bpf filters). There are a number of cases, including
[1-3], where async processing of file events of specific tasks would be
fine but is not readily available in Linux. Fanotify already ships
important infrastructure in this regard: it provides very fast
event-buffering and, by using file descriptors instead of resolved
paths, a clean and race-free API to process the events later. However,
as already stated, fanotify does not provide a clean way, to monitor
only a subset of tasks. Therefore please consider the following
proposed architecture of fantrace:

Each taks gets its own struct fsnotify_group. Within
fsnotify.c:fsnotify() it is checked if the given task has a
fsnotify_group attached where events of interest are buffered as usual.
Note that this is an additional hook - sysadmins being subscribed to
filesystem events rather than task-filesystem-events are notified as
usual - in that case two hooks possibly run. The fsnotify_group is
extended by a field optionally pointing to a BPF program which allows
for custom filters to be run.

Some implementation details:
- To let the tracee return quickly, run BPF filter program within tracer
   context during read(fan_fd) but before events are copied to userspace
- only one fantracer per task, which overrides existing ones if any
- task->fsnotify_group refcount increment on fork, decrement on exit (run
   after exit_files(tsk) to not miss final close events). When last task
   exited, send EOF to listener.
- on exec of seuid-programs the fsnotify_group is cleared (like in ptrace)
- lazy check when event occurs, if listener is still alive (refcount > 1)
- for the beginning, to keep things simple and to "solve" the cleanup of
   filesystem marks, I suggest to disable i_fsnotify_marks for fantrace
   (only allow FAN_MARK_FILESYSTEM), as that functionality can be
   implemented within the user-provided BPF-program.

A working implementation of this concept, which effectively does the
same using hardcoded filter rules can be found in my kernel module
shournalk [4]. For instance In kernel/event_handler.c:event_handler_fput()
it is checked, if the task is observed using a hashtable, and if so,
the event is stored to a buffer corresponding to that process tree.

Thanks
Tycho


[1] Chirigati F, Rampin R, Shasha D, Freire J. (2016). ReproZip:
Computational Reproducibility with Ease. Paper presented at the
Proceedings of the 2016 International Conference on Management of Data.
San Francisco, CA: New York: Association for Computing Technology.
https://github.com/VIDA-NYU/reprozip
[2] Guo, P. (2012). CDE: A Tool For Creating Portable Experimental
Software Packages. Computing in Science & Engineering 14, 332–35
[3] Tycho Kirchner, Konstantin Riege, Steve Hoffmann (2020). Bashing
irreproducibility with shournal bioRxiv 2020.08.03.232843; doi:
https://doi.org/10.1101/2020.08.03.232843
[4] https://github.com/tycho-kirchner/shournal




