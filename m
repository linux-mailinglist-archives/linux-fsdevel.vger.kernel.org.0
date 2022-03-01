Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F454C8BAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 13:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiCAMeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 07:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiCAMeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:34:18 -0500
X-Greylist: delayed 405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 04:33:37 PST
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698CD91370
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 04:33:37 -0800 (PST)
Received: from postfix01.mail.de (postfix03.bt.mail.de [10.0.121.127])
        by shout01.mail.de (Postfix) with ESMTP id 06466A0C15;
        Tue,  1 Mar 2022 13:26:50 +0100 (CET)
Received: from smtp03.mail.de (smtp03.bt.mail.de [10.0.121.213])
        by postfix01.mail.de (Postfix) with ESMTP id DE0AC8025A;
        Tue,  1 Mar 2022 13:26:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1646137609;
        bh=9IhNcsjktZaluDWO29BPA544rSNSFw/0PVnAkOMQfPY=;
        h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
        b=lx2HuPxYFAajh6SC822U1OvTOjfcI7/CRyprys6t6K1erV3zbFJnVnA8WKT9/E8cv
         FjrXYRMrR/sf0oroPDjuwuBGq4qvnun3VP+sLp0+7vHO9q8X9R/6mJLZjwO78O+f8u
         +cnVeenpWq2WYtWfKLoVMPFFSknMZVM7eJ3zw0PE35jYqHHde0aeSIesbdyxyXQ6bC
         6pGqhgCl1s4EvEBVgEjs8CELn/LmLCe8aoKMNIdDZNIci2Y9PwXRPXmne8ey0qXRx1
         EMVWZINqd2S8tAX/qPuYlE9qjS5MDaUo9Z2o+WSjW3GO1DnPfU7ahGTtqCL+6X/F5k
         GVvFqUex/CCvg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp03.mail.de (Postfix) with ESMTPSA id 60BACA01D3;
        Tue,  1 Mar 2022 13:26:49 +0100 (CET)
Message-ID: <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de>
Date:   Tue, 1 Mar 2022 13:26:48 +0100
MIME-Version: 1.0
Subject: Re: [RFC] Volatile fanotify marks
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
 <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
From:   Tycho Kirchner <tychokirchner@mail.de>
In-Reply-To: <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2761
X-purgate-ID: 154282::1646137609-000006A2-AE1655BD/0/0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



>>> I wanted to get your feedback on an idea I have been playing with.
>>> It started as a poor man's alternative to the old subtree watch problem.


> I do agree that we should NOT add "subtree filter" functionality to fanotify
> (or any other filter) and that instead, we should add support for attaching an
> eBPF program that implements is_subdir().
> I found this [1] convection with Tycho where you had suggested this idea.
> I wonder if Tycho got to explore this path further?
> 
> [1] https://lore.kernel.org/linux-fsdevel/20200828084603.GA7072@quack2.suse.cz/

Hi Amir, Hi Jan,
Thanks for pinging back on me. Indeed I did "explore this path further".
In my project
https://github.com/tycho-kirchner/shournal

the goal is to track read/written files of a process tree and all it's child-processes and connect this data to a given shell-command. In fact after Amir's and mine last correspondence I implemented a kernel module which instruments ftrace and tracepoints to trace fput-events (kernel/event_handler.c:event_handler_fput) of specific tasks, which are then further processed in a dedicated kernel thread. I considered eBPF for this task but found no satisfying approach to have dynamic, different filter-rules (e.g. include-paths) for each process tree of each user.


Regarding improvement of fanotify let's discriminate two cases: system-monitoring and tracing.
Regarding system-monitoring: I'm not sure how exactly FAN_MARK_VOLATILE would work (Amir, could you please elaborate?) but what do you think about the following approach, in order to solve the subtree watch problem:
- Store the include/exlude-paths of interest as *strings* in a hashset.
- on fsevent, lookup the path by calling d_path() only once and cache, whether events for the given path are of interest. This
   can either happen with a reference on the path (clear older paths periodically in a work queue)
   or with a timelimit in which potentially wrong paths are accepted (path pointer freed and address reused).
   The second approach I use myself in kernel/event_consumer_cache.c. See also kpathtree.c for a somewhat efficient
   subpath-lookup.


Regarding tracing I think fanotify would really benefit from a FAN_MARK_PID (with optional follow fork-mode). That way one of the first filter-steps would be whether events for the given task are of interest, so we have no performance problem for all other tasks. The possibility to mark specific processes would also have another substantial benefit: fanotify could be used without root privileges by only allowing the user to mark his/her own processes.
That way existing inotify-users could finally switch to the cleaner/more powerful fanotify.


Thanks and kind regards
Tycho
