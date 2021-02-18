Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C7A31EA2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhBRNAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 08:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhBRMge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:36:34 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A469C061786
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 04:35:51 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q77so1820428iod.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 04:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlJ99JZQ7q/ou4SwU4854EmDgGc5VVts6YXU4XTE2SQ=;
        b=MfCdhyfN3CFYosDGPvwxSww90E0tO6M98nKgJK0sZISib2BiAW70WvK6m7Lp9sTnqR
         mNwkfI1DM7DQdJWMR1CeWKb1ofRQowjDBdg2T6gV61eo3pzVnPTZ7MQhUb7//eZM+sNI
         +vZyGMdDfPrjMHkb8XOSuLGykj2Z7M/DE9tNzGkP6eRikz3u1CEqUlh5faVSRHqDqE8d
         Wg1tB1SbHSyngtXyAcuor8WaGcDWlAKynDEU0GnL/lqwOFY9UTCvtG5lk9Jhyh6Jw0Ce
         HYaFYcqTvhRnTo+qiaWGKywcDQjEpIBGkQSdAr93cZ7wa25BXdHUJFuQCYTWG2F+jHw4
         pLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlJ99JZQ7q/ou4SwU4854EmDgGc5VVts6YXU4XTE2SQ=;
        b=fC8nbRIU14NOHgyHWqlCRH2/VfMnrcgd49H/iSYRgV/4spRjoKsLsheWpxW7segPo2
         GCXqjVonYuD3hf3RCY+/H4M7rJcVcayG7RAYMm1e5s3i+HNvlDKTmac+g9CyNa0tIK1W
         3F4120MAOBrZCz+1fRX044OcVmAL1+cKAl4kgiyu9Q5OkmPSQZ0GcLiB4jW0yAz/Ka+J
         t3eyeaswU+pdLkDKdc/4wAE3+SA6Rd3SPVnBFj9IuPAh3700f8jS5w73FYEV1uLe/q1E
         nfMK4ItIvhsoFnjpshg7gKCwxrPU4tgQ1LAo8eFgroG0MiFFVuC9HfGkWsnv1p2GzUO6
         suxQ==
X-Gm-Message-State: AOAM530GckX+zi3s2SizvPhEfwzD8tv/jKWGSOZETtU28nsi6dR+BAnf
        J+BrIVMh1F+pNfaqvVZemirilJBMHp9Chuf212jA5kXvaDQ=
X-Google-Smtp-Source: ABdhPJy0xMjWlhXgJYEWe8sQX7G7thuZ7fd2xAdD8tLWzO0lzKHSeWW2tc+0FmfeWWMyQ2BhEcTCh1kmh06CgIN4yOU=
X-Received: by 2002:a02:bb16:: with SMTP id y22mr4226074jan.123.1613651750771;
 Thu, 18 Feb 2021 04:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20210202162010.305971-1-amir73il@gmail.com> <20210216160258.GE21108@quack2.suse.cz>
 <CAOQ4uxi7NdNQOpGResWEtRDPv+yGSTkMY99tVDVv2mkOW3g97w@mail.gmail.com>
 <20210217112539.GC14758@quack2.suse.cz> <CAOQ4uxiEuWaw1VKwJvp5V-_dN=MZNXWro4q8OnO8qhN-r7dLhA@mail.gmail.com>
 <20210218111558.GB16953@quack2.suse.cz>
In-Reply-To: <20210218111558.GB16953@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Feb 2021 14:35:39 +0200
Message-ID: <CAOQ4uxj0HE1A=E3ufSVFjGa1MckkdbQz3n-tBEAS-Zx7nwOKOQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Performance improvement for fanotify merge
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 1:15 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 18-02-21 12:56:18, Amir Goldstein wrote:
> > On Wed, Feb 17, 2021 at 1:25 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 17-02-21 12:52:21, Amir Goldstein wrote:
> > > > On Tue, Feb 16, 2021 at 6:02 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > Hi Amir!
> > > > >
> > > > > Looking at the patches I've got one idea:
> > > > >
> > > > > Currently you have fsnotify_event like:
> > > > >
> > > > > struct fsnotify_event {
> > > > >         struct list_head list;
> > > > >         unsigned int key;
> > > > >         unsigned int next_bucket;
> > > > > };
> > > > >
> > > > > And 'list' is used for hashed queue list, next_bucket is used to simulate
> > > > > single queue out of all the individual lists. The option I'm considering
> > > > > is:
> > > > >
> > > > > struct fsnotify_event {
> > > > >         struct list_head list;
> > > > >         struct fsnotify_event *hash_next;
> > > > >         unsigned int key;
> > > > > };
> > > > >
> > > > > So 'list' would stay to be used for the single queue of events like it was
> > > > > before your patches. 'hash_next' would be used for list of events in the
> > > > > hash chain. The advantage of this scheme would be somewhat more obvious
> > > > > handling,
> > > >
> > > > I can agree to that.
> > > >
> > > > > also we can handle removal of permission events (they won't be
> > > > > hashed so there's no risk of breaking hash-chain in the middle, removal
> > > > > from global queue is easy as currently).
> > > >
> > > > Ok. but I do not really see a value in hashing non-permission events
> > > > for high priority groups, so this is not a strong argument.
> > >
> > > The reason why I thought it is somewhat beneficial is that someone might be
> > > using higher priority fanotify group just for watching non-permission
> > > events because so far the group priority makes little difference. And
> > > conceptually it isn't obvious (from userspace POV) why higher priority
> > > groups should be merging events less efficiently...
> > >
> >
> > So I implemented your suggestion with ->next_event, but it did not
> > end up with being able to remove from the middle of the queue.
> > The thing is we know that permission events are on list #0, but what
> > we need to find out when removing a permission event is the previous
> > event in timeline order and we do not have that information.
>
> So my idea was that if 'list' is the time ordered list and permission
> events are *never inserted into the hash* (we don't need them there as
> hashed lists are used only for merging), then removal of permission events
> is no problem.
>

We are still not talking in the same language.

I think what you mean is use a dedicated list only for permission events
which is not any one of the hash lists.

In that case, get_one_event() will have to look at both the high
priority queue and the hash queue if we want to allow mixing hashed
event with permission events.

It will also mean that permission events always get priority over non-permission
events. While this makes a lot of sense, this is not the current behavior.

So what am I missing?

Thanks,
Amir.
