Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736D8355BB0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 20:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhDFStf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhDFSte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 14:49:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F5BC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Apr 2021 11:49:25 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r17so6292418ilt.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Apr 2021 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+PlYGLcAp8VuZHdWHQx5xSHKHYLfQ/Z4r2eH+UfroE=;
        b=aYWNKufNabuEF4L4/qK8ctGYUyqJu6Az5kHRlBuWUDaozh0ipANzpAhJEFydysWVw2
         LqWDNrf+sQQM1Eg8pAFXNGF2UqDyMx4shaekkp2/YFG3W2wv1ZfQR76RYlXb3ThcZ+pw
         aOGCCblhBU+wocIF/q7dy831XCUYzB+axBRBAC/gCjXXe/X8eSZqRSgyea7hlAoeX2DK
         ZBl8/agNJiLHoyv27eVmqIS0V7DE4Am4EaBLpA4Dsgf4fh9vhcVi+MUhDkcpwhJ20wXb
         DZp7obpjlyi+bAunIYIU/kIPJlXHfNaMD8DFV5cpzRiy/BK7yp7KdKWbmk3igtbpLnqX
         AXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+PlYGLcAp8VuZHdWHQx5xSHKHYLfQ/Z4r2eH+UfroE=;
        b=WiS4fvgCtt5IB702IbXcFJWxPifwZ8M8LSv3Elzf5JskjFwsiXGKhRdjCfYnSaHWOZ
         u4wkqXDSt8WMNCig/Qf2VNJb8U8NpA4+Nypf8JpbJomCfgTT/5Y3LzWJmUvCbvepEydV
         6u7V59yYv8dJdFqsTZ31TJacqYGKyd9nG0IiTpaxVqYAA1Q99Vxcg6KXV0aMwC5JABUW
         c5Wrrif2raK7GlX5GXRPsrkBCfPyqj11nG1M2viz72u3sPQikNJIBOzXL039T3KLmCgw
         coC1OsFHDsS8caPER6GVHYpm2+zLILw0arAkscvXVUnqE5s5NMJivGENq2pV068DYOMV
         u/Jw==
X-Gm-Message-State: AOAM532UVNyJ12faRtzSNrdPFC36NvpcTIUjZ/OFeNtupzHUzQuM9PSP
        8/fHopKzDpg4VUSU6aKHE22a5uArLv8HEVP+50bafNkpNfg=
X-Google-Smtp-Source: ABdhPJye2Ry1bTEzGzijVxGra4SCpLP7ioH0ErHofkdQYLjkXCDPccFV5FLRYa+/KbJimgCnejn/58PEJUQL+US/1xs=
X-Received: by 2002:a92:d44c:: with SMTP id r12mr14190350ilm.275.1617734965003;
 Tue, 06 Apr 2021 11:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein> <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 6 Apr 2021 21:49:13 +0300
Message-ID: <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[...]
> > > So yeh, I do think it is manageable. I think the best solution would be
> > > something along the lines of wrappers like the following:
> > >
> > > static inline int vfs_mkdir(...)
> > > {
> > >         int error = __vfs_mkdir_nonotify(...);
> > >         if (!error)
> > >                 fsnotify_mkdir(dir, dentry);
> > >         return error;
> > > }
> > >
> > > And then the few call sites that call the fsnotify_path_ hooks
> > > (i.e. in syscalls and perhaps later in nfsd) will call the
> > > __vfs_xxx_nonotify() variant.
> >
> > Yes, that is OK with me. Or we could have something like:
> >
> > static inline void fsnotify_dirent(struct vfsmount *mnt, struct inode *dir,
> >                                    struct dentry *dentry, __u32 mask)
> > {
> >         if (!mnt) {
> >                 fsnotify(mask, d_inode(dentry), FSNOTIFY_EVENT_INODE, dir,
> >                          &dentry->d_name, NULL, 0);
> >         } else {
> >                 struct path path = {
> >                         .mnt = mnt,
> >                         .dentry = d_find_any_alias(dir)
> >                 };
> >                 fsnotify(mask, d_inode(dentry), FSNOTIFY_EVENT_PATH, &path,
> >                          &dentry->d_name, NULL, 0);
> >         }
> > }
> >
> > static inline void fsnotify_mkdir(struct vfsmount *mnt, struct inode *inode,
> >                                   struct dentry *dentry)
> > {
> >         audit_inode_child(inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> >
> >         fsnotify_dirent(mnt, inode, dentry, FS_CREATE | FS_ISDIR);
> > }
> >
> > static inline int vfs_mkdir(mnt, ...)
> > {
> >         int error = __vfs_mkdir_nonotify(...);
> >         if (!error)
> >                 fsnotify_mkdir(mnt, dir, dentry);
> > }
> >
>
> I've done something similar to that. I think it's a bit cleaner,
> but we can debate on the details later.
> Pushed POC to branch fsnotify_path_hooks.

FYI, I tried your suggested approach above for fsnotify_xattr(),
but I think I prefer to use an explicit flavor fsnotify_xattr_mnt()
and a wrapper fsnotify_xattr().
Pushed WIP to fsnotify_path_hooks branch. It also contains
some unstashed "fix" patches to tidy up the previous hooks.

I ran into another hurdle with fsnotify_xattr() -
vfs_setxattr() is too large to duplicate a _nonotify() variant IMO.
OTOH, I cannot lift fsnotify_xattr() up to callers without moving
the fsnotify hook outside the inode lock.

This was not a problem with the directory entry path hooks.
This is also not going to be a problem with fsnotify_change(),
because notify_change() is called with inode locked.

Do you think that calling fsnotify_xattr() under inode lock is important?
Should I refactor a helper vfs_setxattr_notify() that takes a boolean
arg for optionally calling fsnotify_xattr()?
Do you have another idea how to deal with that hook?

With notify_change() I have a different silly problem with using the
refactoring method - the name notify_change_nonotify() is unacceptable.
We may consider __ATTR_NONOTIFY ia_valid flag as the method to
use instead of refactoring in this case, just because we can and
because it creates less clutter.

What do you think?

Thanks,
Amir.
