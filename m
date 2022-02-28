Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AEF4C75C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiB1R4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 12:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiB1RxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:53:03 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F3A9953
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 09:40:19 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d19so15543627ioc.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 09:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdiW19ZcNBMuyo0m1nA5bgyTAUsMudn2S3W3z/639JM=;
        b=XjK4oZ1QQgfAoSBUdQd7VkP1oPindkQo21LJDhjA/ZKSAf9rg+VvTqaYXLc/adYXO2
         OEStyHtuDJCD3Zal6+CHLCv4OWiXCM8YTrGddxwVCUKPyYtt8JXkCvIdwmF6ECOaiP0q
         BDrSkMTm5vGilDW+f9AtLvRB5XZ2AB7yNEz+apHDgq8yMSNQNGuAV27qjxc3cpiP47xN
         a7t951Tvb0i6JDA1NDBMIhZr2LJ77J4fKZN8+zMbOrk+K06MdAXholsi4mp45eS6EQyv
         KchZMc+a/Rt+IKxYgmMfycM5HwcDV/g4qInKmstvhpqmPZfcGB4ZUaPhl4goXIWP9dtB
         EAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdiW19ZcNBMuyo0m1nA5bgyTAUsMudn2S3W3z/639JM=;
        b=0LwTkGjrdXn0wvE1iBVhiNpjg+nowEiQpNk4DhUL4Qz4hJxPb/2Bb2GnnUVrIeUryy
         ZZcFod23b8OX0u+W9JZpnogeG1V7x9yB7qIxb4NQq/bqOJ7xPWu+0HlEyi06hdLHmsDl
         rcljp/PJXwdeZMAl+BxOLvA/pdq4cpryp4bbHgneV9/aXrJgwbi93vNKcEh4XCORyRHg
         IZIaoObvZ+fDcWTGVPAjXCXeEffVydLT6MP6Pog6ka/yAg7UnVSFbh+YN0V3WfdpY+jK
         Q/Lk+OnW1ipJKd//Ys8KcLJs4stCveBDEiyfkZmTdcy2CIebBDgvXWSkUtjHKesAfcU8
         lYDQ==
X-Gm-Message-State: AOAM533aX4s+eBLQo67JIr8lLxpDiaSCOR78LcXRJouxItjwCOM0F+I3
        zyHeCkR2InsrJY8DcCn9KVL0NJKFc5xhWxho2Rm+Om5S
X-Google-Smtp-Source: ABdhPJxq7eVJyaJwyE0rzRVO3d3QURitj2Pu6ufDuj71VdfWusPg4CHDYFfuB5+CNVQ1l+7FHylGh9lDENNZBi19Fl8=
X-Received: by 2002:a02:a411:0:b0:314:b51c:3b74 with SMTP id
 c17-20020a02a411000000b00314b51c3b74mr17557177jal.69.1646070018822; Mon, 28
 Feb 2022 09:40:18 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
In-Reply-To: <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 28 Feb 2022 19:40:07 +0200
Message-ID: <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
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

On Mon, Feb 28, 2022 at 4:06 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Wed 23-02-22 20:42:37, Amir Goldstein wrote:
> > I wanted to get your feedback on an idea I have been playing with.
> > It started as a poor man's alternative to the old subtree watch problem.
> > For my employer's use case, we are watching the entire filesystem using
> > a filesystem mark, but would like to exclude events on a subtree
> > (i.e. all files underneath .private/).
> >
> > At the moment, those events are filtered in userspace.
> > I had considered adding directory marks with an ignored mask on every
> > event that is received for a directory path under .private/, but that has the
> > undesired side effect of pinning those directory inodes to cache.
> >
> > I have this old fsnotify-volatile branch [1] that I am using for an overlayfs
> > kernel internal fsnotify backend. I wonder what are your thoughts on
> > exposing this functionally to fanotify UAPI (i.e. FAN_MARK_VOLATILE).
>
> Interesting idea. I have some reservations wrt to the implementation (e.g.
> fsnotify_add_mark_list() convention of returning EEXIST when it updated
> mark's mask, or the fact that inode reclaim should now handle freeing of
> mark connector and attached marks - which may get interesting locking wise)
> but they are all fixable.

Can you give me a hint as to how to implement the freeing of marks?

>
> I'm wondering a bit whether this is really useful enough (and consequently
> whether we will not get another request to extend fanotify API in some
> other way to cater better to some other usecase related to subtree watches
> in the near future). I understand ignore marks are mainly a performance
> optimization and as such allowing inodes to be reclaimed (which means they
> are not used much and hence ignored mark is not very useful anyway) makes

The problem is that we do not know in advance which of the many dirs in
the subtree are accessed often and which are accessed rarely (and that may
change over time), so volatile ignore marks are a way to set up ignore marks
on the most accessed dirs dynamically.

> sense. Thinking about this more, I guess it is useful to improve efficiency
> when you want to implement any userspace event-filtering scheme.
>
> The only remaining pending question I have is whether we should not go
> further and allow event filtering to happen using an eBPF program. That
> would be even more efficient (both in terms of memory and CPU). What do you
> think?
>

I think that is an unrelated question.

I do agree that we should NOT add "subtree filter" functionality to fanotify
(or any other filter) and that instead, we should add support for attaching an
eBPF program that implements is_subdir().
I found this [1] convection with Tycho where you had suggested this idea.
I wonder if Tycho got to explore this path further?

But I think that it is one thing to recommend users to implement their
filters as
eBPF programs and another thing to stand in the way of users that prefer to
implement userspace event filtering. It could be that the filter
cannot be easily
described by static rules to an eBPF program (e.g. need to query a database).

In my POV, FAN_MARK_VOLATILE does not add any new logic/filtering rule.
It adds resource control by stating that the ignore mark is "best effort".

Does it make sense?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20200828084603.GA7072@quack2.suse.cz/
