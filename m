Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C334C90FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 17:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiCAQ7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 11:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiCAQ7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:59:36 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E43FBFC
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 08:58:54 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id f2so13034337ilq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rrdrf816RXJ2Uv+fMk4XopvA8+CQ2r9+4YLd/dtc7LM=;
        b=f+00ZwSyEDFKjyi7SCKlSKGHQzKm4jmw4RwhrY9ohLeg8/7WtIiZi/furEaxd5xO6X
         K0erknikw0xcaudx6hVmaKUSs0HO0CGX4Xx4kCXO4cHdsAru/v+MVYEFm7mYKNmS+m9J
         5hoAWMiTkHFh6+LHSqWY9v/oz9x9FqIkEGIbj0sx4FLCNaNLZWiv4oLk/Hsa9YMucZfb
         h5xBqbLdruJXuyJHLfeqYhAMfgz0ewrjICF7SckiwD4YLvORfzU8Mk9i0k8aNXyH4col
         QdB1xV96qyaV80q4ugxVhEEQOSCkQ7NgBJEPercfJUwpdqHAJckVbptncea2C1Mr+sUk
         inBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rrdrf816RXJ2Uv+fMk4XopvA8+CQ2r9+4YLd/dtc7LM=;
        b=0e4xngxn+mPKtXNG8hOceswNsrQM5HftdWhG2pWLoeSC7w4yvPOdQan6Y6tvSFMa8l
         A4ynzyZjcUhUAhvYYXE/mPPnBT1uumJOuJgnoya3MSOFQPY/1W9cPoY+aXh6Jd4wFrkP
         Aax88cRu2NacsK/1s4J1R7guR8R5XUWufJt7AhwYB02gfpoqk3noEkynF5dzPUvpAlib
         vcY+k0uGzbzTOQ3vKOxfOuc8CMS+XwvJm6LwKCvCsoCGzrlNo7BCmKkmVlkpxjKs+2n4
         7U9YcHrqo/fyveHdTOEwI/h3HDTLNqqCV01es5IgNDca75RdzJQKOZdKS/sWizaBmtyn
         pI9w==
X-Gm-Message-State: AOAM530v/6V2MWAmGLbYXXHGUkbyNmX+UGHZpQUDXByCBCkB48IU1uTy
        A4l5hUXj/2QdODSoXXMofT4PTgeuoCvvKBIi8SA=
X-Google-Smtp-Source: ABdhPJwp+RVhx/LbIVZbLIF3IfkRO1H08oCYC6kldGbNokhb/NSiT9PRdFgQTEwBqNVxMtPkhVlXTKfpe8DXIufKfzg=
X-Received: by 2002:a05:6e02:1785:b0:2c2:cd72:9c0 with SMTP id
 y5-20020a056e02178500b002c2cd7209c0mr14758833ilu.254.1646153934233; Tue, 01
 Mar 2022 08:58:54 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan> <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
 <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de>
In-Reply-To: <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 1 Mar 2022 18:58:43 +0200
Message-ID: <CAOQ4uxhry1_tW9NPC4X3q3YUQ86Ecg+G6A2Fvs5vKQTDB0ctHQ@mail.gmail.com>
Subject: Re: [RFC] Volatile fanotify marks
To:     Tycho Kirchner <tychokirchner@mail.de>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 1, 2022 at 2:26 PM Tycho Kirchner <tychokirchner@mail.de> wrote=
:
>
>
>
> >>> I wanted to get your feedback on an idea I have been playing with.
> >>> It started as a poor man's alternative to the old subtree watch probl=
em.
>
>
> > I do agree that we should NOT add "subtree filter" functionality to fan=
otify
> > (or any other filter) and that instead, we should add support for attac=
hing an
> > eBPF program that implements is_subdir().
> > I found this [1] convection with Tycho where you had suggested this ide=
a.
> > I wonder if Tycho got to explore this path further?
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20200828084603.GA7072@quack2.=
suse.cz/
>
> Hi Amir, Hi Jan,
> Thanks for pinging back on me. Indeed I did "explore this path further".
> In my project
> https://github.com/tycho-kirchner/shournal
>
> the goal is to track read/written files of a process tree and all it's ch=
ild-processes and connect this data to a given shell-command. In fact after=
 Amir's and mine last correspondence I implemented a kernel module which in=
struments ftrace and tracepoints to trace fput-events (kernel/event_handler=
.c:event_handler_fput) of specific tasks, which are then further processed =
in a dedicated kernel thread. I considered eBPF for this task but found no =
satisfying approach to have dynamic, different filter-rules (e.g. include-p=
aths) for each process tree of each user.
>
>
> Regarding improvement of fanotify let's discriminate two cases: system-mo=
nitoring and tracing.
> Regarding system-monitoring: I'm not sure how exactly FAN_MARK_VOLATILE w=
ould work (Amir, could you please elaborate?)

FAN_MARK_VOLATILE is not a solution for "include" filters.
It is a solution for "exclude" filters implemented in userspace.
If monitoring program gets an event and decides that its path should be exc=
luded
it may set a "volatile" exclude mark on that directory that will
suppress further
events from that directory for as long as the directory inode remains
in inode cache.
After directory inode has not been accessed for a while and evicted
from inode cache
the monitoring program can get an event in that directory again and then it=
 can
re-install the volatile ignore mark if it wants to.

> but what do you think about the following approach, in order to solve the=
 subtree watch problem:
> - Store the include/exlude-paths of interest as *strings* in a hashset.
> - on fsevent, lookup the path by calling d_path() only once and cache, wh=
ether events for the given path are of interest. This
>    can either happen with a reference on the path (clear older paths peri=
odically in a work queue)
>    or with a timelimit in which potentially wrong paths are accepted (pat=
h pointer freed and address reused).
>    The second approach I use myself in kernel/event_consumer_cache.c. See=
 also kpathtree.c for a somewhat efficient
>    subpath-lookup.

I would implement filtering with is_subdir() and not with d_path(),
but there are
advantages to either approach.
In any case, I see there is BPF_FUNC_d_path, so why can't your approach be
implemented using an eBPF program?

>
> Regarding tracing I think fanotify would really benefit from a FAN_MARK_P=
ID (with optional follow fork-mode). That way one of the first filter-steps=
 would be whether events for the given task are of interest, so we have no =
performance problem for all other tasks. The possibility to mark specific p=
rocesses would also have another substantial benefit: fanotify could be use=
d without root privileges by only allowing the user to mark his/her own pro=
cesses.
> That way existing inotify-users could finally switch to the cleaner/more =
powerful fanotify.

We already have partial support for unprivileged fanotify.
Which features are you missing with unprivileged fanotify?
and why do you think that filtering by process tree will allow those
features to be enabled?
A child process may well have more privileges to read directories than
its parent.

Thanks,
Amir.
