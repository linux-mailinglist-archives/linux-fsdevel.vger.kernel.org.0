Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C464C8AA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 12:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiCAL2L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 06:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiCAL2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:28:09 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D3A1A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 03:27:28 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id y5so12254485ill.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 03:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfrMNooTHLI5KIwwRE/Gzz4VRPM969ONlikH3Jo5LHg=;
        b=RldLZy2d9BxLMGBZxaTJmfCG4Pv0rijF3LjP6UPKzqaYJxP5YA6cBnoh5O4xwSMemg
         MJsqrbiniXbs3ryqEpRVyPYO/ZSF/Iadqa1Eudnxm6UtmbRXkrtcXuucfY9yIKP1GNWF
         NGKyx0yWdUHN18GaxXE0wbnmVeJxRN7b22W6F90T67oDlH4lc7kipkMgzt1t6CHSAoY0
         lytELUdpM6NooZqCaB/2O7jeBfcFVs7N0R1R7uOB/cEBbJ3J32tEt3MY3oR49uB15Szp
         kf6p5lZZgsZ+ChFzv+koIUgdPcxqYuHHEUXO952akXjDS9oYhoLBwXwpE07w550Wksfq
         1UXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfrMNooTHLI5KIwwRE/Gzz4VRPM969ONlikH3Jo5LHg=;
        b=qU50+96dYHboaSqpAkPBTuwtUfU8iZLeaayjEkW1mva+nfwjNQ7+MDdseLrah28S4m
         gnvW9lHWpG5J/yw8rSrnP8Y1rTV3ME1T+CSlPn0NkvSQl9SoCoo9ik6p/Anrse+ITM07
         7xcSLn2r6W9ciafdnOhFS6fxZpgqlUz5z1KuCh7gmtLzHeBr3sfIYWXJButZw3C75TME
         TguJChR3YI9pVZmHpxAmsE/jwbUENm8dCRGFjqTcXZ3q6dbSJFWO+d9FMUrfIpAIlq4Y
         BehzuukJ0h6sgr+GsXu+/yHlcc9Rwe4xfjYDP+D+OOYIzeNwATlClw1abQy1bVmdgE3T
         SRog==
X-Gm-Message-State: AOAM5304RVoMK3/ZwGc1I1QJUCUPCNOL5J/tS4jmE9t4pL+yG0U/iJCq
        386nqHCv68vOSZ4AgoLXxjJZ73egjpcAZGkmsPJkbrcC2zM=
X-Google-Smtp-Source: ABdhPJzHW5fUM+BR5uEGiJRt+9KfiOmd/ubL2TuSH1j+NZ+/DsM7n+eZAeiAeoVaJV2WXnCa3abjU2XbVAJQbXPOLyw=
X-Received: by 2002:a05:6e02:1aa2:b0:2c2:2fc1:face with SMTP id
 l2-20020a056e021aa200b002c22fc1facemr24040730ilv.198.1646134047663; Tue, 01
 Mar 2022 03:27:27 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan> <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
 <20220301110752.ouonih76tnbwjjfd@quack3.lan>
In-Reply-To: <20220301110752.ouonih76tnbwjjfd@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 1 Mar 2022 13:27:16 +0200
Message-ID: <CAOQ4uxhOTMA2tnB4Ro_5CL7yzHpcxxnqS1XbNErakv4CQ4Cz9g@mail.gmail.com>
Subject: Re: [RFC] Volatile fanotify marks
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Tycho Kirchner <tychokirchner@mail.de>
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

On Tue, Mar 1, 2022 at 1:07 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 28-02-22 19:40:07, Amir Goldstein wrote:
> > On Mon, Feb 28, 2022 at 4:06 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hi Amir!
> > >
> > > On Wed 23-02-22 20:42:37, Amir Goldstein wrote:
> > > > I wanted to get your feedback on an idea I have been playing with.
> > > > It started as a poor man's alternative to the old subtree watch problem.
> > > > For my employer's use case, we are watching the entire filesystem using
> > > > a filesystem mark, but would like to exclude events on a subtree
> > > > (i.e. all files underneath .private/).
> > > >
> > > > At the moment, those events are filtered in userspace.
> > > > I had considered adding directory marks with an ignored mask on every
> > > > event that is received for a directory path under .private/, but that has the
> > > > undesired side effect of pinning those directory inodes to cache.
> > > >
> > > > I have this old fsnotify-volatile branch [1] that I am using for an overlayfs
> > > > kernel internal fsnotify backend. I wonder what are your thoughts on
> > > > exposing this functionally to fanotify UAPI (i.e. FAN_MARK_VOLATILE).
> > >
> > > Interesting idea. I have some reservations wrt to the implementation (e.g.
> > > fsnotify_add_mark_list() convention of returning EEXIST when it updated
> > > mark's mask, or the fact that inode reclaim should now handle freeing of
> > > mark connector and attached marks - which may get interesting locking wise)
> > > but they are all fixable.
> >
> > Can you give me a hint as to how to implement the freeing of marks?
>
> OK, now I can see that fsnotify_inode_delete() gets called from
> __destroy_inode() and thus all marks should be freed even for inodes
> released by inode reclaim. Good.
>
> > > I'm wondering a bit whether this is really useful enough (and consequently
> > > whether we will not get another request to extend fanotify API in some
> > > other way to cater better to some other usecase related to subtree watches
> > > in the near future). I understand ignore marks are mainly a performance
> > > optimization and as such allowing inodes to be reclaimed (which means they
> > > are not used much and hence ignored mark is not very useful anyway) makes
> >
> > The problem is that we do not know in advance which of the many dirs in
> > the subtree are accessed often and which are accessed rarely (and that may
> > change over time), so volatile ignore marks are a way to set up ignore marks
> > on the most accessed dirs dynamically.
>
> Yes, I understand.
>
> > > sense. Thinking about this more, I guess it is useful to improve efficiency
> > > when you want to implement any userspace event-filtering scheme.
> > >
> > > The only remaining pending question I have is whether we should not go
> > > further and allow event filtering to happen using an eBPF program. That
> > > would be even more efficient (both in terms of memory and CPU). What do you
> > > think?
> > >
> >
> > I think that is an unrelated question.
> >
> > I do agree that we should NOT add "subtree filter" functionality to fanotify
> > (or any other filter) and that instead, we should add support for attaching an
> > eBPF program that implements is_subdir().
> > I found this [1] convection with Tycho where you had suggested this idea.
> > I wonder if Tycho got to explore this path further?
> >
> > But I think that it is one thing to recommend users to implement their
> > filters as
> > eBPF programs and another thing to stand in the way of users that prefer to
> > implement userspace event filtering. It could be that the filter
> > cannot be easily
> > described by static rules to an eBPF program (e.g. need to query a database).
> >
> > In my POV, FAN_MARK_VOLATILE does not add any new logic/filtering rule.
> > It adds resource control by stating that the ignore mark is "best effort".
> >
> > Does it make sense?
>
> OK, makes sense. So I agree the functionality is worth it. Will you post
> the patches for review of technical details?

Of course, I need to add a patch for UAPI change and write a test.
I just wanted to get a tentative ACK before I put in more effort.
I will address your comment about -EEXIST return value.

Thanks,
Amir.
