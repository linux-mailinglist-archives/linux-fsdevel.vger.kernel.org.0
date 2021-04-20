Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED37365842
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 13:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhDTL7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhDTL7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:59:35 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB9DC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 04:59:04 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l19so27916359ilk.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 04:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwUV1kKmA2NHVNHsjGntB5ouPN/Ib6TigxJgWukxqUc=;
        b=tAJtdw+YWqBWIcvKNzKxThlQtM9Jg+S8Ma5Ga3CKoWOTkr/hRcifPe/ZLaqUjiPXlm
         g3J9PqHj1UOY90wBWoGoF2nXB83k2qQ3c0dEgD3DT1Ve8qMmLsFfspa37QyYtAAWdT5b
         ahXSVWGH1uNp+f6eOlisssGDsX+MfrFZgomfOvED4LArkN/OjvFCT86FdRvJ1ParW0Nc
         gjQUkarjBhYW68Pxpm6AFQ5fAZVVglXVyaHf2OzOmec0PUHgLHVHDjYwJ7OuTzRim4o8
         GF348nah2bRikmSDSbZGf+GLMECmIplTLo6j5E0n4ixiwOKmYMqaa6kKWryV/dW5Fsrg
         9Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwUV1kKmA2NHVNHsjGntB5ouPN/Ib6TigxJgWukxqUc=;
        b=kDSmDh/TvGm67Ahgy2Uq+8UAjvX2szWboFX15OUdBr4x8KSRSyAK8Mf5hueNfNqthp
         KKMgLSesemiOmkLOygPqgeSfQsFYQxGn+OELXvalLm7MJHADt+6FrLVR16mnH4bDm6L+
         c3s+jXAxtEQr0KbTAkHq7i4BmtlwT8EZIR1jgzxtWXB18Mxdx5SDd6g1fOKCRbUo+Pwr
         pmlKZb/B5Kz8182GHPSXxtS8YGRTXYQYsXcmgXVW/O3+eFpEV7KPaorFy5gdx47EgBw6
         Kto84gqyb0zod+uN8OF8eBec8Qx9jp9GJbVQHxGxl6To97RwbvK8P2Nf3BaMj8EXKvoV
         DX3g==
X-Gm-Message-State: AOAM532Im2EdE2GGz75VRNSo8YBUQKjAF6UVT06SmcXg+j/kM6S0PU/o
        JJNPWJdYSgYXb4b2LGBby6P1ja5jfHA565n1aeYsgge9EeM=
X-Google-Smtp-Source: ABdhPJxFoVBthixgdAPXxeUTxfqAJfCPqZuc5ZRQwWxBQDxR4lZUiL1XuCllC1kePH7HLAKkTYMbA24WlzUBvoscIxY=
X-Received: by 2002:a92:de41:: with SMTP id e1mr22368386ilr.250.1618919943476;
 Tue, 20 Apr 2021 04:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz> <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz> <20210409104546.37i6h2i4ga2xakvp@wittgenstein>
 <CAOQ4uxi-BG9-XLmQ0uLp0vb_woF=M0EUasLDJG-zHd66PFuKGw@mail.gmail.com> <20210420114154.mwjj7reyntzjkvnw@wittgenstein>
In-Reply-To: <20210420114154.mwjj7reyntzjkvnw@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Apr 2021 14:58:52 +0300
Message-ID: <CAOQ4uxjFvOVpcdEHoeYxnaSbPNA9cmRiLChBPWUkGQKgh5U27A@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 2:41 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Apr 20, 2021 at 09:01:09AM +0300, Amir Goldstein wrote:
> > > One thing, whatever you end up passing to vfs_create() please make sure
> > > to retrieve mnt_userns once so permission checking and object creation
> > > line-up:
> > >
> > > int vfs_create(struct vfsmount *mnt, struct inode *dir,
> > >                struct dentry *dentry, umode_t mode, bool want_excl)
> > > {
> > >         struct user_namespace *mnt_userns;
> > >
> > >         mnt_userns = mnt_user_ns(mnt);
> > >
> > >         int error = may_create(mnt_userns, dir, dentry);
> > >         if (error)
> > >                 return error;
> > >
> > >         if (!dir->i_op->create)
> > >                 return -EACCES; /* shouldn't it be ENOSYS? */
> > >         mode &= S_IALLUGO;
> > >         mode |= S_IFREG;
> > >         error = security_inode_create(dir, dentry, mode);
> > >         if (error)
> > >                 return error;
> > >         error = dir->i_op->create(mnt_userns, dir, dentry, mode, want_excl);
> > >         if (!error)
> > >                 fsnotify_create(mnt, dir, dentry);
> > >         return error;
> > > }
> > >
> >
> > Christian,
> >
> > What is the concern here?
> > Can mnt_user_ns() change under us?
> > I am asking because Al doesn't like both mnt_userns AND path to
> > be passed to do_tuncate() => notify_change()
> > So I will need to retrieve mnt_userns again inside notify_change()
> > after it had been used for security checks in do_open().
> > Would that be acceptable to you?
>
> The mnt_userns can't change once a mnt has been idmapped and it can
> never change if the mount is visible in the filesystem already. The only
> case we've been worried about and why we did it this way is when you
> have a caller do fd = open_tree(OPEN_TREE_CLONE) and then share that
> unattached fd with multiple processes
> T1: mkdirat(fd, "dir1", 0755);
> T2: mount_setattr(fd, "",); /* changes idmapping */
> That case isn't a problem if the mnt_userns is only retrieved once for
> permission checking and operating on the inode. I think with your
> changes that still shouldn't be an issue though since the vfs_*()
> helpers encompass the permission checking anyway and for notify_change,
> we could simply add a mnt_userns field to struct iattr and pass it down.

I suppose that could work for notify_change().

Thanks,
Amir.
