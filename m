Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8443364D77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 00:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhDSWFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 18:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhDSWFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:05:13 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF2DC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 15:04:42 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id p15so19518454iln.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZdzOMSBDjT7a79mDiWwTHeWFxZw9xfnkqZBlQGysLQ=;
        b=EnmVA36DrWaH33Aee/iK3B1wF8zVklS3rJSmB9tE3hrJu57P40yNvGapq+6oApebcI
         6I8fflor63qeXr/6UkgBSLi2kbXiOocYFb/58usFtu3pODKYe6nzif2VAhc499GMtKlO
         kYDnOwcAYuZKCBimTsmT3V6BEC+Yghj0tiUP4axoHs/jwlMQMHy4jb7s6Td8zasyRaMY
         jy2BHZcDba9X9T6Kmb0plGqBhKfR06ff9ger7x7GJK8Rz1QMEcm00JTk+ZetviasuX0Z
         lf9D7fbzwrOlinJ9hIqVV1TsRi0+oRxIsdPbBP/772KCnVf0c+TazWq/J2m2kJhHMwPD
         zwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZdzOMSBDjT7a79mDiWwTHeWFxZw9xfnkqZBlQGysLQ=;
        b=m824tPWkVnhGlVC0y0fUr5yyl/149R80Q+WxxGsN0AWEOVCOkAtP0zwpEbFJmtSR4T
         vbTFpds6BR4VDpT1SK4k7Nu+bTbJeZ7Qr8Czorftlxbldg3ZCZjLh6+vWcTsd8hnXpXJ
         PQwY4Mx/ID9b+yRJktSpqJ24nvDm3m96mvSuoWzJQDFP2Z7G4dnxGrlRfmiv0+sDMKXh
         NWWFVuUFEXW0gC1JSoqPfGabbqqS03knbRvFJXMpa/Jei1YZAz4sQFwD8H87gVJ8lKYp
         3t8fKYuS5eV3GE1pHblHSO0jN28DFfUxEAEDwcD6Lqrxd59sZpFPeMU8kKvjzk9letbU
         tOLA==
X-Gm-Message-State: AOAM5335uyd93lFOQUTjnz8gFCZkbMRECOc6k8wKQijr72fdzK/A8TI6
        PHV6d+lBAtWj9WGe0uUjJMahYe8+sJfp85Dvkdw=
X-Google-Smtp-Source: ABdhPJxC3dAemHLJ82FyECgaSS2AXxijWNvMBghcY9vwWJDh03AFI0K+r3pHN5I7BwBQY5JL1AtCqoEqdEPk1OpPcQE=
X-Received: by 2002:a92:c548:: with SMTP id a8mr19049663ilj.137.1618869881243;
 Mon, 19 Apr 2021 15:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz> <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <CAOQ4uxi3c2xg9eiL41xv51JoGKn0E2KZuK07na0uSNCxU54OMQ@mail.gmail.com> <YH23mMawq2nZeBhk@zeniv-ca.linux.org.uk>
In-Reply-To: <YH23mMawq2nZeBhk@zeniv-ca.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Apr 2021 01:04:29 +0300
Message-ID: <CAOQ4uxhXXLwUBr01zuU=Uo9rzEg4JQ2w_zEejdRRU8FSJsJg0w@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 8:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Apr 19, 2021 at 07:41:51PM +0300, Amir Goldstein wrote:
>
> > Would you be willing to make an exception for notify_change()
> > and pass mnt arg to the helper? and if so, which of the following
> > is the lesser evil in your opinion:
> >
> > 1. Optional mnt arg
> > --------------------------
> > int notify_change(struct vfsmount *mnt,
> >                  struct user_namespace *mnt_userns,
> >                  struct dentry *dentry, struct iattr *attr,
> >                  struct inode **delegated_inode)
> >
> > @mnt is non-NULL from syscalls and nfsd and NULL from other callers.
> >
> > 2. path instead of dentry
> > --------------------------------
> > int notify_change(struct user_namespace *mnt_userns,
> >                  struct path *path, struct iattr *attr,
> >                  struct inode **delegated_inode)
> >
> > This is symmetric with vfs_getattr().
> > syscalls and nfsd use the actual path.
> > overlayfs, ecryptfs, cachefiles compose a path from the private mount
> > (Christian posted patches to make ecryptfs, cachefiles mount private).
> >
> > 3. Mandatory mnt arg
> > -----------------------------
> > Like #1, but use some private mount instead of NULL, similar to the
> > mnt_userns arg.
> >
> > Any of the above acceptable?
> >
> > Pushed option #1 (along with rest of the work) to:
> > https://github.com/amir73il/linux/commits/fsnotify_path_hooks
> >
> > It's only sanity tested.
>
>         Out of that bunch only #2 is more or less tolerable.

Tolerable works for me.

> HOWEVER, if we go that way, mnt_user_ns crap must go, and

Christian requested that I refrain from re-acquiring mnt_user_ns
from mnt after it had already been used for security checks,
for example:
 do_open()
    may_create_in_sticky(mnt_userns,...)
    may_open(mnt_userns,...)
    handle_truncate(mnt_userns,...
        do_truncate(mnt_userns,...
              notify_change(mnt_userns,...

Although, I am not sure exactly why.
Isn't mnt_userns supposed to be stable after the mount is
connected to the namespace?
What is the concern from re-quiring mnt_userns from path->mnt
inside notify_change()?

> I really want to see details on all callers - which mount are
> you going to use in each case.

The callers are:
cachefiles, ecryptfs, nfsd, devtmpfs,
do_truncate(), vfs_utimes() and file_remove_privs()

* cachefiles, ecryptfs, nfsd compose paths from stashed
mount like this all the time (e.g. for vfs_truncate(), vf_getattr()).

* devtmpfs has the parent path from and also uses it to
compose child path for vfs_getattr().

* vfs_utimes() and all callers of do_truncate() already have the
path, just need to pass it through to notify_change()

>
>         The thing that is not going to be acceptable is
> a combination of mount from one filesystem and dentry from
> another.  In particular, file_remove_privs() is going to be
> interesting.
>
>         Note, BTW, that ftruncate() and file_remove_privs()
> are different in that respect - the latter hits d_real()
> (by way of file_dentry()), the former does not.  Which one
> is correct and if both are, why are their needs different?

Nowadays (>= v4.19) I think the only files whose file_inode() and
f_path do not agree are the overlayfs "real.file" that can find their
way to f_mapping and to some vfs helpers and from there to
filesystem ops and to file_modified() or generic_file_write_iter()
and to file_remove_privs().

Contrary to that, overlayfs does not call any vfs truncate()
helper, it calls notify_change() directly (with a composed path).

So what should we do about file_remove_privs()?
Since I don't think we really need to care about generating an
event on file_remove_privs(), perhaps it could call __notify_change()
that does not generate an event and the rest of the callers call this wrapper:

int notify_change(struct path *path, struct iattr *attr,
                            struct inode **delegated_inode)
{
        unsigned int ia_valid;
        int error = __notify_change(mnt_user_ns(path->mnt), path->dentry,
                                                    attr, &ia_valid,
delegated_inode);

        if (!error)
                fsnotify_change(path, ia_valid);
        return error;
}

Does this make sense?

Thanks,
Amir.
