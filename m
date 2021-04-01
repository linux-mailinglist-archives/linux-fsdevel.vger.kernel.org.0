Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00603351792
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhDARmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhDARhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:37:39 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB09C00571B;
        Thu,  1 Apr 2021 07:18:16 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b10so2368555iot.4;
        Thu, 01 Apr 2021 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mldqE/kgF/xuPEJNzgfxkHWSmKHvrSTqgH5Vnt9YLQQ=;
        b=I2B/rnd8bulKxhOn5GMfWyf+cpW6YEZgSvnO1MJZus+3FBlytJZ+YVhfBN2rMlk4Bk
         NYK80NmDY1gM3YIwZd+bx8DWLGhKL5wNKcA6ZYLvdXwrVFWaX3Rc2rkYDnY+BErP79bU
         jYb4zCHZ3AszSMtUr4gi6FCvfCeQJg7GNbaXA4c5CAts2sLz6/Js/0hp1gvk/tADJqwH
         di5dYJpVy0HDOyzCGXRwjcDbOpwhGLyQs3t/4fa4vFrzXsEbNsEQH7ODNEyk/UWXhUBN
         B1forpSoaJMAo5BAaf/GnseuOdT+wpVkidtGwsPYtGPsYoA/QqdS+gE+EnusIaKQL8xy
         Kzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mldqE/kgF/xuPEJNzgfxkHWSmKHvrSTqgH5Vnt9YLQQ=;
        b=gatOd9rncRMpacCJ+0+10jxKk34qNcCqBeDOVZ/fFvzCdCwXzjiUx/KnZiUDE1zEtT
         GTM/Wwg5kjrbglbJrxzLIBHsbYyzWK7blCXC2/eNIQJWNatxvq9F1bSqv8MGcWG0eJoy
         1PMr/wR+gst+Ycri8cCpydlSnyNSpKIISRF1/g41STomL0eYw5wN04IP3pwCkDqSMdZt
         HJ2qOe36HLKDMMoyGR77GH5x2SyYUfw87sJPH8Nzh3QoY4V81y1NfveZpvmWHv5X3/I2
         skcWkZMqwa17LguXeYxwYYC4TSHMr8vIvub3OY1+Pee70aUR60cFRJ7VNoAZyEzClX3Y
         BToQ==
X-Gm-Message-State: AOAM5328+D1LvsehTDSHg8kGLVl5rp6KJiEE6+JwsQoaeJk4mXuMAuuY
        Xhf4bjELa4nymTHR4/Mf3KbmA5N4WQxDChRnAcg=
X-Google-Smtp-Source: ABdhPJyvbtU+vjO7tikuZwTBx94dv7e1uULrr/SB/fstLsJCe0piOu0PLxR0leenPXC5lBp2gMtOnAgtRBIH6OAjxVw=
X-Received: by 2002:a05:6602:2a4c:: with SMTP id k12mr6621121iov.64.1617286696311;
 Thu, 01 Apr 2021 07:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein> <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com> <20210401102947.GA29690@quack2.suse.cz>
In-Reply-To: <20210401102947.GA29690@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 1 Apr 2021 17:18:05 +0300
Message-ID: <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 1:29 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 31-03-21 23:59:27, Amir Goldstein wrote:
> > On Wed, Mar 31, 2021 at 5:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > > > As long as "exp_export: export of idmapped mounts not yet supported.\n"
> > > > > I don't think it matters much.
> > > > > It feels like adding idmapped mounts to nfsd is on your roadmap.
> > > > > When you get to that we can discuss adding fsnotify path hooks to nfsd
> > > > > if Jan agrees to the fsnotify path hooks concept.
> > > >
> > > > I was looking at the patch and thinking about it for a few days already. I
> > > > think that generating fsnotify event later (higher up the stack where we
> > > > have mount information) is fine and a neat idea. I just dislike the hackery
> > > > with dentry flags.
> > >
> > > Me as well. I used this hack for fast POC.
> > >
> > > If we stick with the dual hooks approach, we will have to either pass a new
> > > argument to vfs helpers or use another trick:
> > >
> > > Convert all the many calls sites that were converted by Christian to:
> > >    vfs_XXX(&init_user_ns, ...
> > > because they do not have mount context, to:
> > >    vfs_XXX(NULL, ...
> > >
> > > Inside the vfs helpers, use init_user_ns when mnt_userns is NULL,
> > > but pass the original mnt_userns argument to fsnotify_ns_XXX hooks.
> > > A non-NULL mnt_userns arg means "path_notify" context.
> > > I have already POC code for passing mnt_userns to fsnotify hooks [1].
> > >
> > > I did not check if this assumption always works, but there seems to
> > > be a large overlap between idmapped aware callers and use cases
> > > that will require sending events to a mount mark.
> > >
> >
> > The above "trick" is pretty silly as I believe Christian intends
> > to fix all those call sites that pass init_user_ns.
>
> If he does that we also should have the mountpoint there to use for
> fsnotify, shouldn't we? :)
>

Yes, but that's not going to be hard for us anyway.
nfsd has mount context available via fhp for any access
and for overlayfs/ecryptfs we don't want the mount mark event.
I will explain why...

> > > > Also I'm somewhat uneasy that it is random (from
> > > > userspace POV) when path event is generated and when not (at least that's
> > > > my impression from the patch - maybe I'm wrong). How difficult would it be
> > > > to get rid of it? I mean what if we just moved say fsnotify_create() call
> > > > wholly up the stack? It would mean more explicit calls to fsnotify_create()
> > > > from filesystems - as far as I'm looking nfsd, overlayfs, cachefiles,
> > > > ecryptfs. But that would seem to be manageable.  Also, to maintain sanity,
> > >
> > > 1. I don't think we can do that for all the fsnotify_create() hooks, such as
> > >     debugfs for example
> > > 2. It is useless to pass the mount from overlayfs to fsnotify, its a private
> > >     mount that users cannot set a mark on anyway and Christian has
> > >     promised to propose the same change for cachefiles and ecryptfs,
> > >     so I think it's not worth the churn in those call sites
> > > 3. I am uneasy with removing the fsnotify hooks from vfs helpers and
> > >     trusting that new callers of vfs_create() will remember to add the high
> > >     level hooks, so I prefer the existing behavior remains for such callers
> > >
> >
> > So I read your proposal the wrong way.
> > You meant move fsnotify_create() up *without* passing mount context
> > from overlayfs and friends.
>
> Well, I was thinking that we could find appropriate mount context for
> overlayfs or ecryptfs (which just shows how little I know about these
> filesystems ;) I didn't think of e.g. debugfs. Anyway, if we can make
> mountpoint marks work for directory events at least for most filesystems, I
> think that is OK as well. However it would be then needed to detect whether
> a given filesystem actually supports mount marks for dir events and if not,
> report error from fanotify_mark() instead of silently not generating
> events.
>

It's not about "filesystems that support mount marks".
mount marks will work perfectly well on overlayfs.

The thing is if you place a mount mark on the underlying store of
overlayfs (say xfs) and then files are created/deleted by the
overlayfs driver (in xfs) you wont get any events, because
overlayfs uses a private mount clone to perform underlying operations.

So while we CAN get the overlayfs underlying layer mount context
it is irrelevant because no user can setup a mount mark on that
private mount, so no need to bother calling the path hooks.

This is not the case with nfsd IMO.
With nfsd, when "exporting" a path to clients, nfsd is really exporting
a specific mount (and keeping that mount busy too).
It can even export whole mount topologies.

But then again, getting the mount context in every nfsd operation
is easy, there is an export context to client requests and the export
context has the exported path.

Therefore, nfsd is my only user using the vfs helpers that is expected
to call the fsnotify path hooks (other than syscalls).

> > So yeh, I do think it is manageable. I think the best solution would be
> > something along the lines of wrappers like the following:
> >
> > static inline int vfs_mkdir(...)
> > {
> >         int error = __vfs_mkdir_nonotify(...);
> >         if (!error)
> >                 fsnotify_mkdir(dir, dentry);
> >         return error;
> > }
> >
> > And then the few call sites that call the fsnotify_path_ hooks
> > (i.e. in syscalls and perhaps later in nfsd) will call the
> > __vfs_xxx_nonotify() variant.
>
> Yes, that is OK with me. Or we could have something like:
>
> static inline void fsnotify_dirent(struct vfsmount *mnt, struct inode *dir,
>                                    struct dentry *dentry, __u32 mask)
> {
>         if (!mnt) {
>                 fsnotify(mask, d_inode(dentry), FSNOTIFY_EVENT_INODE, dir,
>                          &dentry->d_name, NULL, 0);
>         } else {
>                 struct path path = {
>                         .mnt = mnt,
>                         .dentry = d_find_any_alias(dir)
>                 };
>                 fsnotify(mask, d_inode(dentry), FSNOTIFY_EVENT_PATH, &path,
>                          &dentry->d_name, NULL, 0);
>         }
> }
>
> static inline void fsnotify_mkdir(struct vfsmount *mnt, struct inode *inode,
>                                   struct dentry *dentry)
> {
>         audit_inode_child(inode, dentry, AUDIT_TYPE_CHILD_CREATE);
>
>         fsnotify_dirent(mnt, inode, dentry, FS_CREATE | FS_ISDIR);
> }
>
> static inline int vfs_mkdir(mnt, ...)
> {
>         int error = __vfs_mkdir_nonotify(...);
>         if (!error)
>                 fsnotify_mkdir(mnt, dir, dentry);
> }
>

I've done something similar to that. I think it's a bit cleaner,
but we can debate on the details later.
Pushed POC to branch fsnotify_path_hooks.

At the moment, create, delete, move and move_self are supported
for syscalls and helpers are ready for nfsd.

The method I used for rename hook is a bit different than
for other hooks, because other hooks are very easy to open code
while rename is complex so I create a helper for nfsd to call.

Thanks,
Amir.
