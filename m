Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7030D4CA1B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 11:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbiCBKFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 05:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbiCBKFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:05:02 -0500
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E4060068
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 02:04:17 -0800 (PST)
Received: from postfix01.mail.de (postfix03.bt.mail.de [10.0.121.127])
        by shout01.mail.de (Postfix) with ESMTP id C1783A0B3A;
        Wed,  2 Mar 2022 11:04:15 +0100 (CET)
Received: from smtp04.mail.de (smtp04.bt.mail.de [10.0.121.214])
        by postfix01.mail.de (Postfix) with ESMTP id A3CEE8025A;
        Wed,  2 Mar 2022 11:04:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1646215455;
        bh=367/FEzu9XEgRAr099UUd4GOSEEbqaMyUtHIPx7CitM=;
        h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
        b=n9+2NWNhYV9rCeCEZsWZow+hWY3kRn2SJ1Gr+hRx8cKOtNbPGaJ5n0EQUvVFGlxzX
         GjgJIXdPbQ8rqjJ11iQon/4n4UEvME0ohCRr8ExabKw6SplOiYyXEIuow/JlT0kRUO
         0R5Q6Y3y5NDvB7jL2QHwBJ1Df6b/BuBYgQiVJAnE7OYEAwjJtucejHzfHhKjG8ITQK
         gWOkGACz9R6C40FOGnvTx6TVOTQjgHn+qKAvGzwB2VmujOj/gzjqE5iOj6y+9son2J
         J8UyJR8K1LAMtsJu2/H19O4LG3eS9jmTxEAsI+Dn+eX4Eo/WNtIC940cmmeE7AA4Wd
         oTCWXlSf+yjxg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp04.mail.de (Postfix) with ESMTPSA id 1FC14C0067;
        Wed,  2 Mar 2022 11:04:15 +0100 (CET)
Message-ID: <8c636384-8db6-d7d1-b89b-424ef1accfe8@mail.de>
Date:   Wed, 2 Mar 2022 11:04:14 +0100
MIME-Version: 1.0
Subject: Re: [RFC] Volatile fanotify marks
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
 <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
 <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de>
 <CAOQ4uxhry1_tW9NPC4X3q3YUQ86Ecg+G6A2Fvs5vKQTDB0ctHQ@mail.gmail.com>
From:   Tycho Kirchner <tychokirchner@mail.de>
In-Reply-To: <CAOQ4uxhry1_tW9NPC4X3q3YUQ86Ecg+G6A2Fvs5vKQTDB0ctHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 6863
X-purgate-ID: 154282::1646215455-00000607-8A21346D/0/0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 01.03.22 um 17:58 schrieb Amir Goldstein:
> On Tue, Mar 1, 2022 at 2:26 PM Tycho Kirchner <tychokirchner@mail.de> wrote:
>>
>>
>>
>>>>> I wanted to get your feedback on an idea I have been playing with.
>>>>> It started as a poor man's alternative to the old subtree watch problem.
>>
>>
>>> I do agree that we should NOT add "subtree filter" functionality to fanotify
>>> (or any other filter) and that instead, we should add support for attaching an
>>> eBPF program that implements is_subdir().
>>> I found this [1] convection with Tycho where you had suggested this idea.
>>> I wonder if Tycho got to explore this path further?
>>>
>>> [1] https://lore.kernel.org/linux-fsdevel/20200828084603.GA7072@quack2.suse.cz/
>>
>> Hi Amir, Hi Jan,
>> Thanks for pinging back on me. Indeed I did "explore this path further".
>> In my project
>> https://github.com/tycho-kirchner/shournal
>>
>> the goal is to track read/written files of a process tree and all it's child-processes and connect this data to a given shell-command. In fact after Amir's and mine last correspondence I implemented a kernel module which instruments ftrace and tracepoints to trace fput-events (kernel/event_handler.c:event_handler_fput) of specific tasks, which are then further processed in a dedicated kernel thread. I considered eBPF for this task but found no satisfying approach to have dynamic, different filter-rules (e.g. include-paths) for each process tree of each user.
>>
>>
>> Regarding improvement of fanotify let's discriminate two cases: system-monitoring and tracing.
>> Regarding system-monitoring: I'm not sure how exactly FAN_MARK_VOLATILE would work (Amir, could you please elaborate?)
> 
> FAN_MARK_VOLATILE is not a solution for "include" filters.
> It is a solution for "exclude" filters implemented in userspace.
> If monitoring program gets an event and decides that its path should be excluded
> it may set a "volatile" exclude mark on that directory that will
> suppress further
> events from that directory for as long as the directory inode remains
> in inode cache.
> After directory inode has not been accessed for a while and evicted
> from inode cache
> the monitoring program can get an event in that directory again and then it can
> re-install the volatile ignore mark if it wants to.
> 
Thanks for this explanation. Regarding few exclude-directories this sounds useful. However, if a whole directory-tree of filesystem events shall be excluded I guess the performance benefit will be rather small. A benchmark may clarify this ( I have some yet unpublished code ready, in case you are interested). If an efficient algorithm can be found I would rather vote for "include" dirs with unlimited depth. Btw. similar to the process-filter approach by unshared mount namespaces about which I wrote in our last correspondence, you may be able to exclude your .private/ directory by bind-mounting over it and otherwise only marking only those mounts of interest instead of the entire filesystem. But yeah, this is kinda messy.

>> but what do you think about the following approach, in order to solve the subtree watch problem:
>> - Store the include/exlude-paths of interest as *strings* in a hashset.
>> - on fsevent, lookup the path by calling d_path() only once and cache, whether events for the given path are of interest. This
>>     can either happen with a reference on the path (clear older paths periodically in a work queue)
>>     or with a timelimit in which potentially wrong paths are accepted (path pointer freed and address reused).
>>     The second approach I use myself in kernel/event_consumer_cache.c. See also kpathtree.c for a somewhat efficient
>>     subpath-lookup.
> 
> I would implement filtering with is_subdir() and not with d_path(),
> but there are
> advantages to either approach.
> In any case, I see there is BPF_FUNC_d_path, so why can't your approach be
> implemented using an eBPF program?
>It seems that bpf_d_path was introduced with v5.10 (6e22ab9da79343532cd3cde39df25e5a5478c692), however, shournal must still run on older kernels (e.g. openSUSE Leap v5.3.18). Further, as far as I remember, at least in Linux 4.19 there was quite some overhead to just install the fd into the eBPF user-space process, but I have to re-check that once that functionality is more widespread.


>>
>> Regarding tracing I think fanotify would really benefit from a FAN_MARK_PID (with optional follow fork-mode). That way one of the first filter-steps would be whether events for the given task are of interest, so we have no performance problem for all other tasks. The possibility to mark specific processes would also have another substantial benefit: fanotify could be used without root privileges by only allowing the user to mark his/her own processes.
>> That way existing inotify-users could finally switch to the cleaner/more powerful fanotify.
> 
> We already have partial support for unprivileged fanotify.
> Which features are you missing with unprivileged fanotify?
> and why do you think that filtering by process tree will allow those
> features to be enabled?


I am missing the ability to filter for (close-)events of large directory trees in a race-free manner, so that no events are lost on newly created dirs. Even without the race, monitoring my home-directory is impossible (without privileges) as I have far more than 8192 directories (393941 as of writing (; ).
Monitoring mounts solves these problems but introduces two others:
First it requires privileges, second a potentially large number of events *not of interest* have to be copied to user-space (except unshared mount namespaces are used). Allowing a user to only monitor his/her own processes would make mark_mount privileges unnecessary (please correct me if I'm wrong). While still events above the directory of interest are reported, at least events from other users are filtered beforehand.

> A child process may well have more privileges to read directories than
> its parent.
> 
Similar to ptrace fanotiy should then not follow suid-programs, so this case should not occur.

After all I totally understand that you do not want to feature-bloat fanotify and maybe my use-case is already too far from the one casual users have. On the other hand, pid- or path-filtering is maybe basic enough and fanotify does offer the ability to filter for paths - it is just quite limited due to the mark-concept. I think it should not be necessary in order to monitor a directory tree, to touch every single directory inside beforehand. Maybe a hybrid-solution fits best here: hard-code pid-filtering as a security feature into fanotify, allow marking of mounts for the user's own processes and allow for eBPF filter rules afterwards.

Thanks and kind regards
Tycho





