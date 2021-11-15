Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C616450458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 13:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhKOM0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 07:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhKOMZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 07:25:56 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65DBC061570;
        Mon, 15 Nov 2021 04:23:00 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id w15so16404626ill.2;
        Mon, 15 Nov 2021 04:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uG4LJI1q6rfZNwBE+cI1QdZIYZKV9ktopWDQZ6KJpsg=;
        b=FxnAf8G+gP9NT3fSmF90tQGZMVZc24Z4K120i1Bsx/d5RHK6zcI3bvVyq/1+pl57Wd
         e7YEbwI/2kPIMQBwFZukON/9HglX5GptOZ5yWM7LSR2bxvDSqFTQOQaYDoIZzvz89Fhk
         VCGoGOUA2L1zc9cg5abHvO9LI1XL42VY1UVjIF5B1zYJRsjnP8LlX3wBkz6Y8isaOltV
         0iySrM//NHpcZjeh1kifN3NC6le4hLIhhnpNeZVZyLhbgNGYrDheyhXsgIecAWWmzST8
         LnVHChQ5MSTvn9BPbu4JDi91Io+CVNYxQJzJQ5Ke0lM0JZ08YXvG1he1BozQqCQYVK33
         NWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uG4LJI1q6rfZNwBE+cI1QdZIYZKV9ktopWDQZ6KJpsg=;
        b=F+LEfKh2ecUch6/KQjtDnkhe4gUQkmjya90mfaXppmhmT0blOPkBSPSKHE4ufVB3QE
         acTpdUqWWbeVuHOPY0Pm4Ew8+wNW1HNIWHXHGth1TO79YVzkH9eZkpzuWMPmtL19UJN0
         lutS8ckv5UDl3Q8ldw5o3Dgoj1Jnd8s0Pe+kdz2u+dymFbTi6OxTNrsXVph6G9PZZPfe
         jEbCg79YPAnKGbT4s9A1KNdopSCoZLz/UZObwCamp6ZyoEVbNgJpcgI1wj8VJVDntFNB
         938FOON676NOewn2RlRMzGOuA1D+60ZSETEe6shc4UmNYcNrskhcou3f5FzMIVINCxhc
         FD1Q==
X-Gm-Message-State: AOAM531ch465hV5VKeOORP/84fUNlp8rtcq0jN1pf00TeI0I06sGsdzt
        8ZVfkB+NDG0wZ3OwswTlnmB8K/FRtsvxADmThF207xnXvsA=
X-Google-Smtp-Source: ABdhPJy2w8Pzii0blVigzXL2KaweW2YfjwjRBr2TT1xfqlrFesxQXFCsYCr7Z7jWu0tSRaxI6o24pLKU9B8M1s2V2+w=
X-Received: by 2002:a05:6e02:1ba6:: with SMTP id n6mr22327168ili.254.1636978980270;
 Mon, 15 Nov 2021 04:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20211029114028.569755-1-amir73il@gmail.com> <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
 <20211112163955.GA30295@quack2.suse.cz> <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
 <CAOQ4uxgEbjkMMF-xVTdfWcLi4y8DGNit5Eeq=evby2nWCuiDVw@mail.gmail.com> <20211115102330.GC23412@quack2.suse.cz>
In-Reply-To: <20211115102330.GC23412@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Nov 2021 14:22:49 +0200
Message-ID: <CAOQ4uxiBFkkbKU=yimLXoYKHFWOoUYrXfg4Kw_CkF=hcSGOm3A@mail.gmail.com>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > > > BTW, I did not mention the FAN_RENAME event alternative proposal in this posting
> > > > > not because I object to FAN_RENAME, just because it was simpler to implement
> > > > > the MOVED_FROM alternative, so I thought I'll start with this proposal
> > > > > and see how
> > > > > it goes.
> > > >
> > > > I've read through all the patches and I didn't find anything wrong.
> > > > Thinking about FAN_RENAME proposal - essentially fsnotify_move() would call
> > > > fsnotify_name() once more with FS_RENAME event and we'd gate addition of
> > > > second dir+name info just by FS_RENAME instead of FS_MOVED_FROM &&
> > > > FAN_REPORT_TARGET_FID. Otherwise everything would be the same as in the
> > > > current patch set, wouldn't it? IMHO it looks like a bit cleaner API so I'd
> > > > lean a bit more towards that.
> > >
> > > I grew to like FAN_RENAME better myself as well.
> > > To make sure we are talking about the same thing:
> > > 1. FAN_RENAME always reports 2*(dirfid+name)
> > > 2. FAN_REPORT_TARGET_FID adds optional child fid record to
> > >     CREATE/DELETE/RENAME/MOVED_TO/FROM
> > >
>
> Correct, that's what I meant.
>
> > Err, I tried the FAN_RENAME approach and hit a semantic issue:
> > Users can watch a directory inode and get only MOVED_FROM
> > when entries are moved from this directory. Same for MOVED_TO.
> > How would FAN_RENAME behave when setting FAN_RENAME on a directory inode?
> > Should listeners get events on files renamed in and out of that
> > directory?
> >
> > I see several options:
> > 1. Go back to FAN_MOVED_FROM as in this patch set, where semantics are clear
>
> Well, semantics are clear but in principle user does not have access to
> target dir either so the permission problems are the same as with option 2,
> aren't they?

Correct.

>
> > 2. Report FAN_RENAME if either old or new dir is watched (or mount/sb)
> > 3. Report FAN_RENAME only if both old and new dirs are watched (or mount/sb)
> >
> > For option 2, we may need to hide information records, For example,
> > because an unprivileged listener may not have access to old or new
> > directory.
>
> Good spotting. That can indeed be a problem.
>
> > A variant of option 3, is that FAN_RENAME will be an event mask flag
> > that can be added to FAN_MOVE events, to request that if both FROM/TO events
> > are going to be reported, then a single joint event will be reported
> > instead, e.g:
> >
> > #define FAN_MOVE (FAN_MOVED_FROM | FAN_MOVED_TO)
> > #define FAN_RENAME (FAN_MOVE | __FAN_MOVE_JOIN)
> >
> > Instead of generating an extra FS_RENAME event in fsnotify_move(),
> > fsnotify() will search for matching marks on the moved->d_parent->d_inode
> > of MOVED_FROM event add the mark as the FSNOTIFY_OBJ_TYPE_PARENT
> > mark iterator type and then fanotify_group_event_mask() will be able
> > to tell if the
> > event should be reported as FAN_MOVED_FROM, FAN_MOVED_TO or a joint
> > FAN_RENAME.
> >
> > If a group has the FAN_RENAME mask on the new parent dir, then
> > FS_MOVED_TO events can be dropped, because the event was already
> > reported as FAN_MOVED_TO or FAN_RENAME with the FS_MOVED_FROM
> > event.
> >
> > Am I over complicating this?
> > Do you have a better and clearer semantics to propose?
>
> So from API POV I like most keeping FAN_RENAME separate from FAN_MOVED_TO &
> FAN_MOVED_FROM. It would be generated whenever source or target is tagged
> with FAN_RENAME, source info is provided if source is tagged, target info
> is provided when target is tagged (both are provides when both are tagged).
> So it is kind of like FAN_MOVED_FROM | FAN_MOVED_TO but with guaranteed
> merging. This looks like a clean enough and simple to explain API. Sure it
> duplicates FAN_MOVED_FROM & FAN_MOVED_TO a lot but I think the simplicity
> of the API outweights the duplication. Basically FAN_MOVED_FROM &
> FAN_MOVED_TO could be deprecated with this semantics of FAN_RENAME although
> I don't think we want to do it for compatibility reasons.

Well, not only for compatibility.
The ability to request events for files moved into directory ~/inbox/ and files
moved out of directory ~/outbox/ cannot be expressed with FAN_RENAME
alone...

>
> Implementation-wise we have couple of options. Currently the simplest I can
> see is that fsnotify() would iterate marks on both source & target dirs
> (like we already do for inode & parent) when it handles FS_RENAME event. In

Yes. I already have a WIP branch (fan_reanme) using
FSNOTIFY_OBJ_TYPE_PARENT for the target dir mark.

Heads up: I intend to repurpose FS_DN_RENAME, by sending FS_RENAME
to ->handle_inode_event() backends only if (parent_mark == inode_mark).
Duplicating FS_MOVED_FROM I can cope with, but wasting 3 flags for
the same event is too much for me to bare ;-)

> fanotify_handle_event() we will decide which info to report with FAN_RENAME
> event based on which marks in iter_info have FS_RENAME set (luckily mount
> marks are out of question for rename events so it will be relatively
> simple). What do you think?

I like it. However,
If FAN_RENAME can have any combination of old,new,old+new info
we cannot get any with a single new into type
FAN_EVENT_INFO_TYPE_DFID_NAME2

(as in this posting)

We can go with:
#define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME   6
#define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME  7
#define FAN_EVENT_INFO_TYPE_OLD_DFID               8
#define FAN_EVENT_INFO_TYPE_NEW_DFID              9

Or we can go with:
/* Sub-types common to all three fid info types */
#define FAN_EVENT_INFO_FID_OF_OLD_DIR     1
#define FAN_EVENT_INFO_FID_OF_NEW_DIR    2

struct fanotify_event_info_header {
       __u8 info_type;
       __u8 sub_type;
       __u16 len;
};

(as in my wip branch fanotify_fid_of)

We could also have FAN_RENAME require FAN_REPORT_NAME
that would limit the number of info types, but I cannot find a good
justification for this requirement.

Any preference?

Thanks,
Amir.
