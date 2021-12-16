Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED28477B71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 19:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhLPSWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 13:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhLPSWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:22:33 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADDDC06173E
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 10:22:32 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y16so36411244ioc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 10:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpFnJW458oPiojCy+RpXuRM5XgKe2hnD2nDN8N/wGB4=;
        b=g1fe+xzVwh6JK+EgvqxN2eoOA2H7JfQj0P3z53z/+/eIK/FFpSIvdzArkJ4QP3+iZP
         u/yAkjqLbcE2HzCU9YcnO6b7U7IajfNvi7rkDMw9o98aTq5XUf11zkHsm8iQuYFLnwLw
         BPpVbr6s2i4ngWh4t5h5OT0J4v7QGzbxv2S5RQOKIFy2F3Wj4elgltiKImGLVLIJVWOd
         AWwNEeB0I2sGKU1te4B84Npkj5TpKHW9c/D9tOKcSQ//CuTYD12mEtSGA2VXY0fGw7Zy
         OlYbeghIm6XILjOtjIHv+TtLjI1baym9z19evs9ExL/l7Oc+xx/fr9LEVvzXJ/ojLg6K
         j9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpFnJW458oPiojCy+RpXuRM5XgKe2hnD2nDN8N/wGB4=;
        b=b/nj3E7FPt6Qc6B0fOYBYLe603gayQj23lVKv4VQyAi89hePuOFSW03N4pAg+dCW/Z
         9Cx0dWIn3fT+0MhCBYVsrDPj80fNTkGnEE04ehAE1zXDSwfhBpDaCwSZrdnBHXibcDg0
         QMOlNqY77GC+SuReQxSwnMdbKiQ6U8TLsi4K3byRiXcJWTDW3FYHL+Uazl17dwjsqZic
         SrWQZWhQ6pKnKJwEPcp8glpY9fPJu1OJivgLrEAd4VOcsxXlPpG54eljMhKAiy2uZ37N
         QEeXEsfBQW/AufOmvmMpaz+W8qFG6vawhG4f8iRN6/XdUGytBy7k1qrA/wshzPNaByty
         OGeA==
X-Gm-Message-State: AOAM532yNrasbF5Pk/3Pky15odqvvWCFFN1nWWh3sZILCNjBHr21O3a7
        aXrWDhASQUdGTDeoxhVWVlKzhEne611VHjti8/w=
X-Google-Smtp-Source: ABdhPJxmGIuTGB6dc5p84UQdjgYE6D6oOT9l09VcZ0xGU1/RTMbusWdrSKz27aR7r6uOBrJZHYlPWnQvtWJ4R2bC85o=
X-Received: by 2002:a05:6638:2043:: with SMTP id t3mr2139669jaj.1.1639678951191;
 Thu, 16 Dec 2021 10:22:31 -0800 (PST)
MIME-Version: 1.0
References: <CAO17o21YVczE2-BTAVg-0HJU6gjSUkzUSqJVs9k-_t7mYFNHaA@mail.gmail.com>
 <CAOQ4uxjpGMYZrq74S=EaSO2nvss4hm1WZ_k+Xxgrj2k9pngJgg@mail.gmail.com>
 <YaZC+R7xpGimBrD1@redhat.com> <CAO17o21uh3fJHd0gMu-SmZei5et6HJo91DiLk_YyfUqrtHy2pQ@mail.gmail.com>
 <CAOQ4uxjfCs=+Of69U6moOJ9T6_zDb1wcrLXWu4DROVme1cNnfQ@mail.gmail.com>
 <YbobZMGEl6sl+gcX@redhat.com> <CAOQ4uxj9XZNhHB3y9LuGcUJYp-i4f-LXQa2tzX8AkZpRERH+8w@mail.gmail.com>
 <Ybo/5h9umGlinaM4@redhat.com> <CAOQ4uxheVq-YHkT9eOu3vUNt1RU4Wa6MkyzXXLboHE_Pj6-6tw@mail.gmail.com>
 <CAOQ4uxjzW7mt0pqA+K_sEJokYcv_D3e7axAOWLXxQ84bZDnfcw@mail.gmail.com> <YbtoQGKflkChU8lZ@redhat.com>
In-Reply-To: <YbtoQGKflkChU8lZ@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Dec 2021 20:22:19 +0200
Message-ID: <CAOQ4uxhucsMYO1YdHdLDPBJEaoOOyXb57wFJgijQznis2feE1A@mail.gmail.com>
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

On Thu, Dec 16, 2021 at 6:24 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Dec 16, 2021 at 01:03:00PM +0200, Amir Goldstein wrote:
> > > > I understand that part. But at the same time, remote fsnotify API will
> > > > probably evolve as you keep on adding more functionality. What if there
> > > > is another notification mechanism tomorrow say newfancynotify(), we
> > > > might have to modify remote fsnoitfy again to accomodate that.
> > > >
> > > > IOW, fsnotify seems to be just underlying plumbing and whatever you
> > > > add today might not be enough to support tomorrow's features. That's
> > > > why I wanted to start with a minimal set of functionality and add
> > > > more to it later.
> > > >
> > >
> > > I do want to start with minimal functionality.
> > > I did not request that you implement more functionality than what inotify
> > > provides.
> > >
> > > TBH, I can't even remember the specific details that made me say
> > > "this is remote inotify not remote fsnotify", but there were such details.
> > > I remember inotify rename cookie being one of them.
> > >
> >
> > Let me repeat my concern about the rename cookie API.
> >
> > As Jan has convinced me to create a new event FS_RENAME
> > for fanotify, there is no harm in FUSE passing the rename cookie
> > along with FS_MOVE events, but the FUSE out args:
> >
> > struct fuse_notify_fsnotify_out {
> >  uint64_t inode;
> >  uint64_t mask;
> >  uint32_t namelen;
> >  uint32_t cookie;
> > };
> >
> > How do you expect to extend it when somebody wants to implement
> > the FS_RENAME event that carries two names and two dir inodes
> > (and no cookie)?
> > Will they need to use a new out struct? a union?
>
> I was thinking of defining a new struct say "fuse_notify_fsnotify_out_ext"
> when one reached to a state where fanotify can be supported. Because
> fanotify seems much more rich as compared to inotify and more data
> needs to be transferred in fuse events. Without being able to test
> fanotify, its little hard to design and test this struct to meet
> fanotify needs as well.
>
> >
> > Unlike inotify, fanotify can sometimes report the inode of the child
> > along with inode of the parent in events (e.g. FS_OPEN) when watching
> > a parent directory.
> >
> > How will this out args struct be extended if we would want to pass that
> > information?
>
> I was thinking of a new struct which takes care of all of fanotify needs.
>
> >
> > There is no need to address this now. I just want to know that the
> > design you suggest is extendable to future needs and if it is not,
> > I would prefer to reserve enough fields in the FUSE event
> > struct for the common needs of all current fsnotify backends,
> > just as we pass all the relevant info to the fsnotify_XXX() hooks.
>
> So there are two ways.
>
> - Either we now define a struct which meeds the needs of inotify only.
>   And make remote inotify work.
>
> - Or we try to make it generic enough so that both inotify and fanotify
>   can be supported. Given local fanotify does not work on fuse yet,

It's a one liner patch to make it work on fuse.
Just need to set f_fsid. that's all.
So testing is not really a problem.
Mind you the event FS_RENAME I mentioned has only now
queued for-next, so you can leave it out of scope for testing.
I can still discuss the extendability of the design w.r.t that event...

>   it will be hard to test it. And without testing it will be hard to
>   ascertain, have we met all the needs of fanotify. It will be just
>   sort of a guess.
>

I think the info I listed above is all there is to it and it is not that much,
so I think it is not a good choice to extend the struct later.

> IMHO, first choice also seems reasonable. This is small enough to make
> progress and take care of other pending issues like events coming after
> inode unlink etc.
>
> >
> > > I guess this discussion is not very productive at this point as none of us
> > > are saying anything very specific about what should and should not
> > > be done, so let me try to suggest something -
> > >
> > > Try to see if you could replace the server side implementation with
> > > fanotify even if you use CAP_SYS_ADMIN for the experiment.
> > > fanotify should be almost a drop-in replacement for inotify at this point
> > > If you think that you cannot make this experiment with your current
> > > protocol and vfs extensions then you must have done something wrong
> > > and tied the protocol and/or the vfs API to inotify terminology.
> > >
> >
> > So I did this thought experiment myself.
> > I did not find any obvious issues with implementing the backend as
> > fanotify. If anything, mapping fhandle to inode is even a bit easier
> > than mapping wd to inode if you know the fhandle encoding.
>
> Fair enough. I think Ioannis is trying to replace inotify backend
> with fanotify backend. If we run into issues with this, we will
> let you know.
>

You will have a problem placing a value in the rename cookie
because fanotify does not provide one.

> >
> > For event reporting, besides generalizing the out args, implementation
> > would be similar. Since FUSE uses nodeid to identify the object in
> > events, there is no problem for fanotify to report fhandle and inotify
> > to report wd.
>
> I think hardes part is generalizing out_args. One thing I am not sure
> about is, will we be carrying file handles in this struct? I thought

No.

> that we will be sending nodeid to refer to inodes because that seems
> to be the fuse interface. And if fanotify requires file handles, they
> will use fuse interface to convert nodeid/generation into a file
> handle and report to user space. Is that a reasonable thing to do.

It is the right thing to do.

>
> So how much information we need to carry which covers all the existing
> events. So for the case of rename, looks
>
> For the case of rename, it sounds like we will need to report
> "node ids" of two directories and two names. Once we have space
> to report two "node ids", this could also be used to report
> node ids of parent dir as well as node id of file in question (if needed).
> So will this be good enough.
>
> Carrying names will be little tricky I guess because namelen will be
> variable. Until and unless we reserve some fixed amount of space for
> each name say PATH_MAX. But that sounds like a lot of space.
>

I thought you passed the name as buffer in iov array.
Or maybe that's not how it works?

My suggestion:
1. Reserve a zero padded 64bit member for future child nodeid
    in struct fuse_notify_fsnotify_out
2. For FS_RENAME, will we be able to pass 4 buffers in iov?
    src_fuse_notify_fsnotify_out, src_name,
    dst_fuse_notify_fsnotify_out, dst_name

> >
> > For setting watches, protocol seems generic enough, although
> > I dislike how fuse_fsnotify_update_mark() masks out inotify
> > specific flags.
> >
> > inotify back should mask out its own private flags when calling
> > into a generic vfs API for registering remote watches.
> > Also, masking out FS_EVENT_ON_CHILD is pretty weird, because
> > requesting a watch on children is functionally completely different
> > than requesting to watch the directory itself.
>
> I will look into above two points. I need to familiarize myself with
> the code better before I can understand the issue.
>
> >
> > I think I gave you enough comments already for a new revision.
> > Are there any open questions left unanswered?
>
> Thank you. After initial round of review, one of our biggest take
> away was that try to make basic fanotify work in V2 of the posting
> and Ioannis started looking into it and ran into various issues.
>
> And that's why we opened this conversation again mentioning the
> issues we are facing with fanotify and trying to figure out if
> supporting fanotify is a basic requirement for this implementation.
> We personally are happy to even support remote inotify only in
> first round of implementation.
>
> So looks like supporting fanotify is not a strict requirement. Though
> you will perfer that fuse notification message is generic enough
> so that it carries enough information to support fanotify. We can
> try that, but I am not 100% sure. Maybe two node ids and two names
> are generic enough to support fanotify rename and other cases were
> two file handles can be reported.
>
> >
> > And please grep your kernel patches for "inotify" and "remote inotify"
> > in particular. When this term is used in comments and commit messages,
> > it is very likely that either the code or documentation is inaccurate.
>
> IIUC, you want all the comments to call it "remote fsnotify" and not
> "remote inotify", right? Will do.
>

Yes and for the code to match that description ;)

Thanks,
Amir.
