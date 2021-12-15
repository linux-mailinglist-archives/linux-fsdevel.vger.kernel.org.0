Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1443F47623D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 20:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhLOTyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 14:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLOTyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:54:50 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0117CC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Dec 2021 11:54:50 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id x6so31703530iol.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Dec 2021 11:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALt1Hb7Qa7bjO8VxujJAaYdZEXhXT8CXyG09xsCi9Qw=;
        b=bh7AbqnSnaHPpjnf/WLCUXwSULoQLSQ+ntjWOuHzwUmwMQAq02wDvgakifAnkzrS3h
         W8bxp82nr+FKh5buagap6SrPHF8xuid0GevTnQsKRaCIuISBgWG11K7So6veGpumEdPj
         lexi5yNbgFcEjAbPA7X/Q59woW3JnwO6GfGa4lJBV/d0wZwrH6w6FT6mCBeibSWSspi5
         erQlVblyZrMoYKbhIyDseYzPyhlxfQZ0zhsMBr39btqv0wrDV9SCkGHJfWcU20EncF9G
         EgZx07kSe5FUZaKOTzvZ4gSueSxCmkM19qhrBcWg6qYixPj/uG1n96bnFFNWOnnZOwzI
         MrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALt1Hb7Qa7bjO8VxujJAaYdZEXhXT8CXyG09xsCi9Qw=;
        b=UUmUOMnZnZJRa/00ygtUR12M5vFeg59cRAhoLAxuoQWLtWjcgHhRGuliKlWyed3R5X
         N7Q3II6uUF7p64R132AR0ZrCsXpdcywT3bRBY5cf80TnNuwnws79Pn0h1JX7su7vsYV7
         8a45GLb3C8l3XJVqfwIEcP0snQPn1dnM/DJ2Ue0NoK5MF/kBrZ9dADr8yX7G8+FBoL2P
         pnDjwCGmMY177b2wilZ1v7fuU3QjTMm28gJvNdV3d/0V0fdpq1S8MdeoKcXO+iNf+9NP
         SxB9tnRzTEqj6mK10YHHt09AkUCDhGUQDyzuNd43SsiS5PQ7c26AMkArTS0hOwBb+1D4
         7rJQ==
X-Gm-Message-State: AOAM53383r80wGxZh5kTrH/6i2F4+G6JWkiZ/rZ6/jjl165sDGnNPuzn
        hjbHxVOPePk6vL9wxdOLfqg1rbxFY4uByVMVNoE=
X-Google-Smtp-Source: ABdhPJxqD+Nhmm12J7OXTI/Y1LUaWF3CPGlWViRj/0qe14AZpFR7CAHgeczUTYGOYv6Ye7JJeCCIXEnRZiv+Jkt2Y6o=
X-Received: by 2002:a05:6638:33a6:: with SMTP id h38mr6870660jav.188.1639598089336;
 Wed, 15 Dec 2021 11:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20211111173043.GB25491@quack2.suse.cz> <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
 <CANXojcy9JzXeLQ6bz9+UOekkpqo8NkgQbhugmGmPE+x3+_=h3Q@mail.gmail.com>
 <CAO17o21YVczE2-BTAVg-0HJU6gjSUkzUSqJVs9k-_t7mYFNHaA@mail.gmail.com>
 <CAOQ4uxjpGMYZrq74S=EaSO2nvss4hm1WZ_k+Xxgrj2k9pngJgg@mail.gmail.com>
 <YaZC+R7xpGimBrD1@redhat.com> <CAO17o21uh3fJHd0gMu-SmZei5et6HJo91DiLk_YyfUqrtHy2pQ@mail.gmail.com>
 <CAOQ4uxjfCs=+Of69U6moOJ9T6_zDb1wcrLXWu4DROVme1cNnfQ@mail.gmail.com>
 <YbobZMGEl6sl+gcX@redhat.com> <CAOQ4uxj9XZNhHB3y9LuGcUJYp-i4f-LXQa2tzX8AkZpRERH+8w@mail.gmail.com>
 <Ybo/5h9umGlinaM4@redhat.com>
In-Reply-To: <Ybo/5h9umGlinaM4@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Dec 2021 21:54:38 +0200
Message-ID: <CAOQ4uxheVq-YHkT9eOu3vUNt1RU4Wa6MkyzXXLboHE_Pj6-6tw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        Stef Bon <stefbon@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Nathan Youngman <git@nathany.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 15, 2021 at 9:20 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Dec 15, 2021 at 07:29:29PM +0200, Amir Goldstein wrote:
> > > >
> > > > The mistake in your premise at 1) is to state that "fuse does not
> > > > support persistent file handles"
> > > > without looking into what that statement means.
> > > > What it really means is that user cannot always open_by_handle_at()
> > > > from a previously
> > > > obtained file handle, which has obvious impact on exporting fuse to NFS (*).
> > >
> > > Hi Amir,
> > >
> > > What good is file handle if one can't use it for open_by_handle_at(). I
> > > mean, are there other use cases?
> >
> > commit 44d705b0:
> > "...There are several ways that an application can use this information:
> >
> >     1. When watching a single directory, the name is always relative to
> >     the watched directory, so application need to fstatat(2) the name
> >     relative to the watched directory.
> >
> >     2. When watching a set of directories, the application could keep a map
> >     of dirfd for all watched directories and hash the map by fid obtained
> >     with name_to_handle_at(2).  When getting a name event, the fid in the
> >     event info could be used to lookup the base dirfd in the map and then
> >     call fstatat(2) with that dirfd.
>
> Ok, so case 1 and 2 still might be doable.
>
> >
> >     3. When watching a filesystem (FAN_MARK_FILESYSTEM) or a large set of
> >     directories, the application could use open_by_handle_at(2) with the fid
> >     in event info to obtain dirfd for the directory where event happened and
> >     call fstatat(2) with this dirfd.
> >
> >     The last option scales better for a large number of watched directories.
> >     The first two options may be available in the future also for non
> >     privileged fanotify watchers, because open_by_handle_at(2) requires
> >     the CAP_DAC_READ_SEARCH capability.
> > "
>
> This is one is not possible as it needs open_by_handle_at().
>
> >
> > fsnotifywait [1] has an example of use case #2.
> > Essentially, when watching inodes, the fanotify file identifier is not very much
> > different from the inotify "watch descriptor" - it identifies the watched object
> > and the watched object is pinned to cache as long as the inode mark is set
> > so file handle would not change also in fuse.
>
> Ok, so if we are maintaining a hash map keyed by file handle, then first
> we need to pin down the inode and then call name_to_handle_at() for the
> watched object and add to hash table. Something like this.
>
> A. foo_fd = open(foo.txt)
> B. name_to_handle_at(.., foo.txt,...)
> C. Add info in hash table using foo_handle as key.
> D. Add watch on foo.txt (fanotify_mark()).
> E. close(foo_fd).
>
> One could probably skip step A and E. And do this instead.
>
> A. Add watch on foo.txt (fanotify_mark())
> B. name_to_handle_at(.., foo.txt,...)
> C. Add info in hash table using foo_handle as key.
>
> But this is little bit racy. You might start getting events with file
> handles of foo.txt before you could complete B or C.
>

I suppose you can also use O_PATH fd to name_to_handle_at()
with AT_EMPTY_PATH if you are concerned with races, but the
races of name_to_handle_at() vs read events are pretty easy to handle
in userspace.

> >
> > [1] https://github.com/inotify-tools/inotify-tools/pull/134
> >
> > >
> > > IIUC, file handle for the same object can change if inode had been flushed
> > > out of guest cache and brought back in later. So if application say
> > > generated file handle for an object and saved it and later put a watch
> > > on that object, by that time file handle of the object might have changed
> > > (as seen by fuse). So one can't even use to match it with previous saved
> > > file handle.
> > >
> >
> > The argument is not applicable for inode watches.
>
> Fair enough. I could see a very limited use case and thought that's not
> enough. But looks like you seem to be ok with that.
>
> > Filesystem and mount watches are not going to be supported with virtiofs
> > or any filesystem that does not support persistent file handles.
>
> Ok, so no filesystem and mount watches for virtiofs to begin with.
>

No, but I do expect the remote fsnotify vfs API design to take those
into account as future extensions.

> >
> > > So I can't use file handle for open_by_handle_at(). I can't use it to
> > > match it with previously saved file handle. So what can I use it for?
> > >
> > > IOW, I could not imagine supporting fanotify file handles without
> > > fixing the file handles properly in fuse. And it needs fixing in
> > > virtiofs as well as we can't trust random file handles from guest
> > > for regular files.
> > >
> >
> > Partly correct statements, but when looking at the details, they are
> > not relevant to the case of fanotify inode watch.
> >
> > Note that at the moment, fuse does not even support local fanotify
> > watch with file handles because of fanotify_test_fsid() - fuse does
> > not set f_fsid (not s_uuid), so it's not really about supporting fanotify
> > on fuse now.
>
> Hmm..., that means we first will have to look into supporting local
> fanotify events with file handles on fuse. Without that we can't even
> test our remote fsnotify changes looks like.
>
> This sounds like another blocker (or dependency project to complete first)
> before one can make progress with remote inotify/fanotify/fsnotify.
>

I am not saying you need to do any of those things, but you need to
take into account that someone else will want to implement them
in virtiofs, other fuse server or other remote fs.

All I am asking is that the vfs API and to some extent also the FUSE
fsnotify protocol extension will not be limited to inotify terminology.

> > It's about the vfs APIs for remote fsnotify that should not be inotify
> > specific.
>
> I understand that part. But at the same time, remote fsnotify API will
> probably evolve as you keep on adding more functionality. What if there
> is another notification mechanism tomorrow say newfancynotify(), we
> might have to modify remote fsnoitfy again to accomodate that.
>
> IOW, fsnotify seems to be just underlying plumbing and whatever you
> add today might not be enough to support tomorrow's features. That's
> why I wanted to start with a minimal set of functionality and add
> more to it later.
>

I do want to start with minimal functionality.
I did not request that you implement more functionality than what inotify
provides.

TBH, I can't even remember the specific details that made me say
"this is remote inotify not remote fsnotify", but there were such details.
I remember inotify rename cookie being one of them.

I guess this discussion is not very productive at this point as none of us
are saying anything very specific about what should and should not
be done, so let me try to suggest something -

Try to see if you could replace the server side implementation with
fanotify even if you use CAP_SYS_ADMIN for the experiment.
fanotify should be almost a drop-in replacement for inotify at this point
If you think that you cannot make this experiment with your current
protocol and vfs extensions then you must have done something wrong
and tied the protocol and/or the vfs API to inotify terminology.

Thanks,
Amir.
