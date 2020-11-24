Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C752C2A4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 15:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389398AbgKXOr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 09:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbgKXOrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:47:55 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA035C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 06:47:54 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id x15so3838030ilq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 06:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyLF3pAg9adsFn6sdARR6rKqhoun4ds98Q4xdLKAV80=;
        b=IVXhRhx6U1BViXo1WdAcN+eYE6qE0QWDlRENq1afFlACQvNMr7WVqZFiJh1LnyIbwZ
         iQWvZV9Cvy/KVilFeiVLil413sgBugjF7uAV+1ny0prk1T7JTiz62/4BPA14apJpwAEx
         SbaPK1iz26WqE2LYg9hllIV8FgqgjJol7Ylt0mBFXNFIvFjZZ1pf3A+vsJkbwPholfsM
         EX2AZX9ZGVJUuHHuCwsEvu9XYhWrVvsHNR46IRpKKhyyDYEK9WHFg0bgrDWCesE8yCjs
         EHOkwtb1xFvIDTaBX85k/Jzyao/bfl9EO+INDFGyTa2Z6HP4UoVezPy/CaxgQgJiSdPZ
         58JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyLF3pAg9adsFn6sdARR6rKqhoun4ds98Q4xdLKAV80=;
        b=ipl6vOqEokdcTndmNq8HsVKG3pYH6L8JyPfl4lUqg7aPaAfR8Ss5+tf/JIpO1AdII4
         SnF/q/n8QeuSGgXo9dNgsRV37hxR22HNdxuIHvKazLOSocNRO7eZpQDJPL4cEQqAeTZK
         NhR+QjD40zYyNgBskUU8g8O5b6C+MHw4ifqpravla6pzx4YV7jV0+SbzCWl0Qtgc6zP2
         Gpw8BhZXZrgoEs9vEkxOe/cL+vixMicYo11k5gv8eIOWl0fJW3CFCtXcNrIMM73S1Ye1
         NeuGTsM43IMz00n2jqJzgA9lILvhSuZ29mjq9wwW4AN8VVsUkSMEnFrK3ozdEki/dreN
         /BAg==
X-Gm-Message-State: AOAM530yn4UUKCbtg5RKZw5c5mjUyTqGAMkBe4g+FrtuwRonEzz+EDqX
        5KEkRbRhiy1jgyvC1OYA07Rhb1t2TfJrqOrJcUOc0b1Xms8=
X-Google-Smtp-Source: ABdhPJxNCUwBMMmn7cM8g3ftrXrnJ8EpScVmoHNMrflqTXF0OUTy/6QoicFPUCyMscMeKv+JIkZjfK+ZKr0IOlWtPKs=
X-Received: by 2002:a92:5e42:: with SMTP id s63mr4577603ilb.250.1606229272993;
 Tue, 24 Nov 2020 06:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20201109180016.80059-1-amir73il@gmail.com> <20201124134916.GC19336@quack2.suse.cz>
In-Reply-To: <20201124134916.GC19336@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 Nov 2020 16:47:41 +0200
Message-ID: <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 3:49 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> Thanks for the patch and sorry for a delay in my response.
>
> On Mon 09-11-20 20:00:16, Amir Goldstein wrote:
> > A filesystem view is a subtree of a filesystem accessible from a specific
> > mount point.  When marking an FS view, user expects to get events on all
> > inodes that are accessible from the marked mount, even if the events
> > were generated from another mount.
> >
> > In particular, the events such as FAN_CREATE, FAN_MOVE, FAN_DELETE that
> > are not delivered to a mount mark can be delivered to an FS view mark.
> >
> > One example of a filesystem view is btrfs subvolume, which cannot be
> > marked with a regular filesystem mark.
> >
> > Another example of a filesystem view is a bind mount, not on the root of
> > the filesystem, such as the bind mounts used for containers.
> >
> > A filesystem view mark is composed of a heads sb mark and an sb_view mark.
> > The filesystem view mark is connected to the head sb mark and the head
> > sb mark is connected to the sb object. The mask of the head sb mask is
> > a cumulative mask of all the associated sb_view mark masks.
> >
> > Filesystem view marks cannot co-exist with a regular filesystem mark on
> > the same filesystem.
> >
> > When an event is generated on the head sb mark, fsnotify iterates the
> > list of associated sb_view marks and filter events that happen outside
> > of the sb_view mount's root.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I gave this just a high-level look (no detailed review) and here are my
> thoughts:
>
> 1) I like the functionality. IMO this is what a lot of people really want
> when looking for "filesystem wide fs monitoring".
>
> 2) I don't quite like the API you propose though. IMO it exposes details of
> implementation in the API. I'd rather like to have API the same as for
> mount marks but with a dedicated mark type flag in the API - like
> FAN_MARK_FILESYSTEM_SUBTREE (or we can keep VIEW if you like it but I think
> the less terms the better ;).

Sure, FAN_MARK_FS_VIEW is a dedicated mark type.
The fact that is it a bitwise OR of MOUNT and FILESYSTEM is just a fun fact.
Sorry if that wasn't clear.
FAN_MARK_FILESYSTEM_SUBTREE sounds better for uapi.

But I suppose you also meant that we should not limit the subtree root
to bind mount points?

The reason I used a reference to mnt for a sb_view and not dentry
is because we have fsnotify_clear_marks_by_mount() callback to
handle cleanup of the sb_view marks (which I left as TODO).

Alternatively, we can play cache pinning games with the subtree root dentry
like the case with inode mark, but I didn't want to get into that nor did I know
if we should - if subtree mark requires CAP_SYS_ADMIN anyway, why not
require a bind mount as its target, which is something much more visible to
admins.

> Then internally we'd auto-create a sb mark as
> needed, we could possibly reuse the sb mark if there are multiple subtree
> marks for the same sb but that's just an internal optimization we could do
> (looking at the code now, that basically seems what you already do so maybe
> I just misunderstood the changelog).

Yes, that is what I did.

> Also I don't see the need for the
> restriction that subtree marks cannot coexist with ordinary sb marks. That
> just seems unnecessarily confusing to users. Why is that?

No need. It was just to simplify the POC (less corner cases to handle).

>
> 3) I think the d_ancestor() checks are racy (need some kind of rename /
> reclaim protection).

Yes, I noticed that shortly after posting.

> Also I think this is going to get expensive
> (e.g. imagine each write to page cache having to traverse potentially deep
> tree hierarchy potentially multiple times - once for each subtree). My
> suspicion should be verified with actual performance measurement but if I'm
> right and the overhead is indeed noticeable, I think we'll need to employ
> some caching or so to avoid repeated lookups...
>

It's true, but here is a different angle to analyse the overhead - claim:
"If users don't have kernel subtree mark, they will use filesystem mark
 and filter is userspace". If that claim is true, than one can argue that
this is fair - let the listener process pay the CPU overhead which can be
contained inside a cgroup and not everyone else. But what is the cost that
everyone else will be paying in that case?
Everyone will still pay the cost of the fanotify backend callback including
allocate, pack and queue the event.
The question then becomes, what is cheaper? The d_ancestor() traversal
or all the fanotify backend handler code?
Note that the former can be lockless and the latter does take locks.

I have a pretty good bet on the answer, but as you say only actual performance
benchmarks can tell.

From my experience, real life fsevent listeners do not listen on FAN_MODIFY
but they listen on FAN_CLOSE_WRITE, because the the former is too noisy.

The best case scenario is that users step forward to say that they want to
use fanotify but need the subtree filterting and can provide us with real life
performance measurement of the userspace vs. kernel alternatives (in terms
of penalty on the rest of the system).

> But overall as I already wrote, I like the idea.
>

Glad to hear that :)
Thanks for the feedback!

Amir.
