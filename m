Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E039B30156E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 14:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbhAWNb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jan 2021 08:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAWNbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jan 2021 08:31:52 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D816BC06174A
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Jan 2021 05:31:11 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d81so17088989iof.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Jan 2021 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/ASTo4x1dp/9IOXsFyJIcvrNT9Jd2BimdYdXK+Ukg8=;
        b=EiL0KnHr+T21/1rBPD3i2kBbOJeJAukWZ/tA8dAVFYAisRkA3fB2R5BhlDgMzqy+y9
         GdDwyKORyJitYckUFNlHosUbLRjU5hM67NeI6Wr1fiKN2TEPZ6POO0Ec/jKt6RdUbFzO
         YRFBXZQb0FG9QCH5jg+iPECVLXLGRchIOciumL+UUO/ThAmw17P4mVLrIgQ1HtEH+Zko
         8PckBtYvPOlYupWDFe0BBBDIbc/CYNkAZiQ0BqnMaoOsIhRtaEkBdn08Xbvwh62MBLPK
         jolQdI8XvaZNKlnaTnm+ra6e73a0ht+QMrQh/+eJIv5njXz6k3nUp+WAUawKH5PkE1x5
         Ce7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/ASTo4x1dp/9IOXsFyJIcvrNT9Jd2BimdYdXK+Ukg8=;
        b=dXtlAfSrvIi8w5fd48M7xpLx8gxbUtPtt32hQWOmQnS3W51zhryGSJBXwaJuBCipCE
         OoUm7x5dlOGMIaXhF0JEFstp3kyyS1VlaGPcz1QbarpjZIvzCLnsF6Pl+HurqdY7s0rA
         K//X6BK0vRfZvlh4mKhNx4odM0Q0l7c6Bs6YFlEex8akmB7hikZGbMop9mgGV5FR5Jel
         EJP5LYJA+ZZZLZHzCOY/T6gV7IPiyBcH0qHHW8ofqMuSN8BuyiYwvgxag48dYAWojmd5
         o6iwYfU4ngBMhgLoeHx6LqNhEUO/UMUwTupvQIo0pJCUZU6726tOus/85MvQC5Zf+yPg
         FTIA==
X-Gm-Message-State: AOAM530lOcpHYb6+455IdE7HmoV3lv3L/G6JSZfSLB5mI/KOMbcO0sUD
        gb90llSItmkC7081+liNoKlkG4Vt6EylLJopCP55XC2pO7w=
X-Google-Smtp-Source: ABdhPJy8n/Pj8QxpX6hh+8kLZZPNJdBcf90meWoo2ULJFocnalnJZHQxK1jajXRyjKvIsAFX2Nj4FsG78egK+5pTrMw=
X-Received: by 2002:a05:6e02:14ce:: with SMTP id o14mr3092075ilk.9.1611408670694;
 Sat, 23 Jan 2021 05:31:10 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-9-amir73il@gmail.com>
 <20200226091804.GD10728@quack2.suse.cz> <CAOQ4uxiXbGF+RRUmnP4Sbub+3TxEavmCvi0AYpwHuLepqexdCA@mail.gmail.com>
 <20200226143843.GT10728@quack2.suse.cz> <CAOQ4uxh+Mpr-f3LY5PHNDtCoqTrey69-339DabzSkhRR4cbUYA@mail.gmail.com>
In-Reply-To: <CAOQ4uxh+Mpr-f3LY5PHNDtCoqTrey69-339DabzSkhRR4cbUYA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Jan 2021 15:30:59 +0200
Message-ID: <CAOQ4uxj_C4EbzwwcrE09P5Z83WqmwNVdeZRJ6qNaThM3pkUinQ@mail.gmail.com>
Subject: Re: fanotify_merge improvements
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 3:59 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > Hum, now thinking about this, maybe we could clean this up even a bit more.
> > > > event->inode is currently used only by inotify and fanotify for merging
> > > > purposes. Now inotify could use its 'wd' instead of inode with exactly the
> > > > same results, fanotify path or fid check is at least as strong as the inode
> > > > check. So only for the case of pure "inode" events, we need to store inode
> > > > identifier in struct fanotify_event - and we can do that in the union with
> > > > struct path and completely remove the 'inode' member from fsnotify_event.
> > > > Am I missing something?
> > >
> > > That generally sounds good and I did notice it is strange that wd is not
> > > being compared.  However, I think I was worried that comparing fid+name
> > > (in following patches) would be more expensive than comparing dentry (or
> > > object inode) as a "rule out first" in merge, so I preferred to keep the
> > > tag/dentry/id comparison for fanotify_fid case.
> >
> > Yes, that could be a concern.
> >
> > > Given this analysis (and assuming it is correct), would you like me to
> > > just go a head with the change suggested above? or anything beyond that?
> >
> > Let's go just with the change suggested above for now. We can work on this
> > later (probably with optimizing of the fanotify merging code).
> >
>
> Hi Jan,
>
> Recap:
> - fanotify_merge is very inefficient and uses extensive CPU if queue contains
>   many events, so it is rather easy for a poorly written listener to
> cripple the system
> - You had an idea to store in event->objectid a hash of all the compared
>   fields (e.g. fid+name)
> - I think you had an idea to keep a hash table of events in the queue
> to find the
>   merge candidates faster
> - For internal uses, I carry a patch that limits the linear search for
> last 128 events
>   which is enough to relieve the CPU overuse in case of unattended long queues
>
> I tried looking into implementing the hash table idea, assuming I understood you
> correctly and I struggled to choose appropriate table sizes. It seemed to make
> sense to use a global hash table, such as inode/dentry cache for all the groups
> but that would add complexity to locking rules of queue/dequeue and
> group cleanup.
>
> A simpler solution I considered, similar to my 128 events limit patch,
> is to limit
> the linear search to events queued in the last X seconds.
> The rationale is that event merging is not supposed to be long term at all.
> If a listener fails to perform read from the queue, it is not fsnotify's job to
> try and keep the queue compact. I think merging events mechanism was
> mainly meant to merge short bursts of events on objects, which are quite
> common and surely can happen concurrently on several objects.
>
> My intuition is that making event->objectid into event->hash in addition
> to limiting the age of events to merge would address the real life workloads.
> One question if we do choose this approach is what should the age limit be?
> Should it be configurable? Default to infinity and let distro cap the age or
> provide a sane default by kernel while slightly changing behavior (yes please).
>
> What are your thoughts about this?

Aha! found it:
https://lore.kernel.org/linux-fsdevel/20200227112755.GZ10728@quack2.suse.cz/
You suggested a small hash table per group (128 slots).

My intuition is that this will not be good enough for the worst case, which is
not that hard to hit is real life:
1. Listener sets FAN_UNLIMITED_QUEUE
2. Listener adds a FAN_MARK_FILESYSTEM watch
3. Many thousands of events are queued
4. Listener lingers (due to bad implementation?) in reading events
5. Every single event now incurs a huge fanotify_merge() cost

Reducing the cost of merge from O(N) to O(N/128) doesn't really fix the problem.

> Do you have a better idea maybe?

Thanks,
Amir.
