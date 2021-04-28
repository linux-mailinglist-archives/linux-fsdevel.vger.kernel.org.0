Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224CF36DEF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 20:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbhD1S3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 14:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhD1S3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:29:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461CDC061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 11:28:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d11so6261664wrw.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 11:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8NL8xmy49OHYcn/s+ac0+IFRWTRffO8UrGY7le05bE=;
        b=sBuLdx18zjUknwfb2UmXlaACMdcCsNKzJ5Lo0EQ6nYbbg1oQ3TOnsR0AmoyaYRau/t
         myw9eT0xoLQFXZ5aRXjVZVp6V9dcKnbi2bfjf/GfQ5y+Eue/vluzDZBQ1whlCM4+GUCK
         xngD1WZrNyAPHBJEYqFMk1UiYe2sF8BcfuLvLhngrFWVAvo9BUM22Gxzn4NsN5pMxmXO
         xjstwJQYFHFXFVANnfUkxUBhQcjMwvCW/BFzDU1SaWRsAFQZGQ2pbYQXeXjxCzFXT8bi
         LEBJWCuG4rxjqZipZCclp3yACDCraLwHkDIy+voSNFFI//e2/Cw9MStELhqY31Gr+Jlk
         xmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8NL8xmy49OHYcn/s+ac0+IFRWTRffO8UrGY7le05bE=;
        b=Sj24aEmQbHuioy2C0Cp9u1YG95wmmOzO7HSzUfZUmuVD4EK40gS73adnUf78SV9V+T
         m8wjqAxb4xsF79LrWSbtDqC6hX8dkbShEtZcyHi5uxXZjJ0reLYtJoSsa8UNiMsk7n7V
         RPXvnVlog+vspuPbUDLQBWXZj7SpSXAJABnbtbn7UrHYZtWY3v+6YXszsMD8ksCKFn94
         lpXZL32keb63PHcNoiC2DTWWcyR4hBqEzQ9ik0/YFdnXC6057mGFGPSk62vA3XyQAF/5
         aThJxB6CjpvzQiIe2rruWmskgqG5VbKBduRo73bQh0zXcXqsIQBd2QUm8Y4S84xdlgfJ
         hSSQ==
X-Gm-Message-State: AOAM532Vy5vxJ8xmStZYaaIZR4l+nFunNTdSbldCT1GcoQoDvabTMkh0
        Gc1yBhkD/41j+pHaSS+2RLdpX+psId8Gl/hWumZd1qd8yvM=
X-Google-Smtp-Source: ABdhPJxCuv/KFgVLShxDlMa0ow8iwDOwDNqOhjb9byeAS1GMQexkhDOj9J9qFMkn8SOybKh2ZCxWqQsSqAXXhiUykHs=
X-Received: by 2002:a5d:4308:: with SMTP id h8mr37051228wrq.371.1619634509914;
 Wed, 28 Apr 2021 11:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201109180016.80059-1-amir73il@gmail.com> <20201124134916.GC19336@quack2.suse.cz>
 <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com>
 <20201125110156.GB16944@quack2.suse.cz> <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
 <20201126111725.GD422@quack2.suse.cz>
In-Reply-To: <20201126111725.GD422@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 28 Apr 2021 21:28:18 +0300
Message-ID: <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 1:17 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 26-11-20 05:42:01, Amir Goldstein wrote:
> > On Wed, Nov 25, 2020 at 1:01 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 24-11-20 16:47:41, Amir Goldstein wrote:
> > > > On Tue, Nov 24, 2020 at 3:49 PM Jan Kara <jack@suse.cz> wrote:
> > > > > On Mon 09-11-20 20:00:16, Amir Goldstein wrote:
> > > > > > A filesystem view is a subtree of a filesystem accessible from a specific
> > > > > > mount point.  When marking an FS view, user expects to get events on all
> > > > > > inodes that are accessible from the marked mount, even if the events
> > > > > > were generated from another mount.
> > > > > >
> > > > > > In particular, the events such as FAN_CREATE, FAN_MOVE, FAN_DELETE that
> > > > > > are not delivered to a mount mark can be delivered to an FS view mark.
> > > > > >
> > > > > > One example of a filesystem view is btrfs subvolume, which cannot be
> > > > > > marked with a regular filesystem mark.
> > > > > >
> > > > > > Another example of a filesystem view is a bind mount, not on the root of
> > > > > > the filesystem, such as the bind mounts used for containers.
> > > > > >
> > > > > > A filesystem view mark is composed of a heads sb mark and an sb_view mark.
> > > > > > The filesystem view mark is connected to the head sb mark and the head
> > > > > > sb mark is connected to the sb object. The mask of the head sb mask is
> > > > > > a cumulative mask of all the associated sb_view mark masks.
> > > > > >
> > > > > > Filesystem view marks cannot co-exist with a regular filesystem mark on
> > > > > > the same filesystem.
> > > > > >
> > > > > > When an event is generated on the head sb mark, fsnotify iterates the
> > > > > > list of associated sb_view marks and filter events that happen outside
> > > > > > of the sb_view mount's root.
> > > > > >
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > I gave this just a high-level look (no detailed review) and here are my
> > > > > thoughts:
> > > > >
> > > > > 1) I like the functionality. IMO this is what a lot of people really want
> > > > > when looking for "filesystem wide fs monitoring".
> > > > >
> > > > > 2) I don't quite like the API you propose though. IMO it exposes details of
> > > > > implementation in the API. I'd rather like to have API the same as for
> > > > > mount marks but with a dedicated mark type flag in the API - like
> > > > > FAN_MARK_FILESYSTEM_SUBTREE (or we can keep VIEW if you like it but I think
> > > > > the less terms the better ;).
> > > >
> > > > Sure, FAN_MARK_FS_VIEW is a dedicated mark type.
> > > > The fact that is it a bitwise OR of MOUNT and FILESYSTEM is just a fun fact.
> > > > Sorry if that wasn't clear.
> > > > FAN_MARK_FILESYSTEM_SUBTREE sounds better for uapi.
> > > >
> > > > But I suppose you also meant that we should not limit the subtree root
> > > > to bind mount points?
> > > >
> > > > The reason I used a reference to mnt for a sb_view and not dentry
> > > > is because we have fsnotify_clear_marks_by_mount() callback to
> > > > handle cleanup of the sb_view marks (which I left as TODO).
> > > >
> > > > Alternatively, we can play cache pinning games with the subtree root dentry
> > > > like the case with inode mark, but I didn't want to get into that nor did I know
> > > > if we should - if subtree mark requires CAP_SYS_ADMIN anyway, why not
> > > > require a bind mount as its target, which is something much more visible to
> > > > admins.
> > >
> > > Yeah, I don't have problems with bind mounts in particular. Just I was
> > > thinking that concievably we could make these marks less priviledged (just
> > > with CAP_DAC_SEARCH or so) and then mountpoints may be unnecessarily
> > > restricting. I don't think pinning of subtree root dentry would be
> > > problematic as such - inode marks pin the inode anyway, this is not
> > > substantially different - if we can make it work reliably...
> > >
> > > In fact I was considering for a while that we could even make subtree
> > > watches completely unpriviledged - when we walk the dir tree anyway, we
> > > could also check permissions along the way. Due to locking this would be
> > > difficult to do when generating the event but it might be actually doable
> > > if we perform the permission check when reporting the event to userspace.
> > > Just a food for thought...
> > >
> >
> > I think unprivileged subtree watches are something nice for the future, but
> > for these FS_VIEW (or whatnot) marks, there is a lower hanging opportunity -
> > make them require privileges relative to userns.
>
> Agreed, that's a middle step.
>
> > We don't need to relax that right from the start and it may requires some
> > more work, but it could allow  unprivileged container user to set a
> > filesystem-like watch on a filesystem where user is privileged relative
> > to s_user_ns and that is a big win already.
>
> Yep, I'd prefer to separate these two problems. I.e., first handle the
> subtree watches on their own (just keeping in mind we might want to make
> them less priviledged eventually), when that it working, we can look in all
> the implications of making fanotify accessible to less priviledged tasks.
>
> > It may also be possible in the future to allow setting this mark on a
> > "unserns contained" mount - I'm not exactly sure of the details of idmapped
> > mounts [1], but if mount has a userns associated with it to map fs uids then
> > in theory we can check the view-ability of the event either at event read time
> > or at event generation time - it requires that all ancestors have uid/gid that
> > are *mapped* to the mount userns and nothing else, because we know
> > that the listener process has CAP_DAC_SEARCH (or more) in the target
> > userns.
>
> Event read is *much* simpler for permission checks IMO. First due to
> locking necessary for permission checks (i_rwsem, xattr locks etc.), second
> so that you don't have to mess with credentials used for checking.
>

Jan,

I've lost track of all the "subtree mark" related threads ;-)

Getting back to this old thread, because the "fs view" concept that
it presented is very close to two POCs I tried out recently which leverage
the availability of mnt_userns in most of the call sites for fsnotify hooks.

The first POC was replacing the is_subtree() check with in_userns()
which is far less expensive:

https://github.com/amir73il/linux/commits/fanotify_in_userns

This approach reduces the cost of check per mark, but there could
still be a significant number of sb marks to iterate for every fs op
in every container.

The second POC is based off the first POC but takes the reverse
approach - instead of marking the sb object and filtering by userns,
it places a mark on the userns object and filters by sb:

https://github.com/amir73il/linux/commits/fanotify_idmapped

The common use case is a single host filesystem which is
idmapped via individual userns objects to many containers,
so normally, fs operations inside containers would have to
iterate a single mark.

I am well aware of your comments about trying to implement full
blown subtree marks (up this very thread), but the userns-sb
join approach is so much more low hanging than full blown
subtree marks. And as a by-product, it very naturally provides
the correct capability checks so users inside containers are
able to "watch their world".

Patches to allow resolving file handles inside userns with the
needed permission checks are also available on the POC branch,
which makes the solution a lot more useful.

In that last POC, I introduced an explicit uapi flag
FAN_MARK_IDMAPPED in combination with
FAN_MARK_FILESYSTEM it provides the new capability.
This is equivalent to a new mark type, it was just an aesthetic
decision.

Let me know what you think of this direction.

Thanks,
Amir.
