Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD6B1C1D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 20:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgEASkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 14:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729721AbgEASkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 14:40:09 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAADC061A0C;
        Fri,  1 May 2020 11:40:09 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z25so3232581otq.13;
        Fri, 01 May 2020 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/Ppj60kuZ2ZpuqWrosQVWEvZ1D0lkPFEQQWaaxkXt4=;
        b=qEwBWDyyUgOn70Xm+NeoHAspBfDw9y9+VenmlNk5gNJtnjSmyUlq8oDGc+xLNkbUdQ
         kT6baTis4PAQiJg91VzBTJaQ0wzX9anPziPEkntVgOkq3y95z/H5Yoxvtq9m87AcPT9j
         +YTTpJ2HvxggSm4NpIpFdhM4Ao3OWTr2b5lyWTd4AM7KWiw8Zr8yTCKTFPqvobNkfqzs
         LS8r6M7vliTYJxZwkKWyD2keEQpe+rWrIEMpfARrCt8mBQBEFDo8xc/ZeMpDVkQNKewF
         7G/1fIgrXyVmNadvr+Uu15YcPjjgWjTKiZ91/+NSh6S0p/GveNclr0WFfuK42NRUC/oS
         T5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/Ppj60kuZ2ZpuqWrosQVWEvZ1D0lkPFEQQWaaxkXt4=;
        b=GvTjs2FaLLSWARDqqMQ2veiNzH1Q4bdGXrx85f0/JnFAEm7apDHpBl8kx4MizRQNNi
         pyTSwzb2lLunmpNgqRCnLjJYup3rRkczhgcp9P9bu6P4p4aXii416Bz+5VTaMGyjNAmC
         6up/Sia8oYyqtxQlXm5O3auWzVPQnhWin9TKeOyEEhFAnb4wSRZv9+l0BJdFZQfm+6BG
         GsIPBOL7uMwHSMti1gRNTqh3iHjJ5t55wIeoZziU6nyrYejeZKnrKZfXJjsh4AVEYIrn
         +c2UC/V0xkzjbo8M7gyu9rizhBOqOTD129vWhxT1Dz+Ainuooo56bjXw28cPiBUKZQKW
         ++Zg==
X-Gm-Message-State: AGi0PuYyIF0kwT4VGb9t9Fe9v+fx3ZJLM7f+qNXjZXGqk7L4R00nPvs7
        6fIl0WH9g2BsvraeIgkLnDP4bJUOzaOGLGur8Qc=
X-Google-Smtp-Source: APiQypJ9vrnfSBB0zVYRQ8oxqhztZhQ44vEcMfYoIaY5B5aPXzyA+82HJYqJU83kvnK8uo7xdzH2BHW79j4CG9YfR/w=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr4766098otb.162.1588358408442;
 Fri, 01 May 2020 11:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
 <20200501041444.GJ23230@ZenIV.linux.org.uk> <20200501073127.GB13131@miu.piliscsaba.redhat.com>
In-Reply-To: <20200501073127.GB13131@miu.piliscsaba.redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 1 May 2020 14:39:56 -0400
Message-ID: <CAEjxPJ6Tr-MD85yh-zRcCKwMTZ7bcw4vAXQ2=CjScG71ac4Vzw@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 1, 2020 at 3:34 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, May 01, 2020 at 05:14:44AM +0100, Al Viro wrote:
> > On Thu, Apr 09, 2020 at 11:28:59PM +0200, Miklos Szeredi wrote:
> > > From: Miklos Szeredi <mszeredi@redhat.com>
> > >
> > > Whiteouts, unlike real device node should not require privileges to create.
> > >
> > > The general concern with device nodes is that opening them can have side
> > > effects.  The kernel already avoids zero major (see
> > > Documentation/admin-guide/devices.txt).  To be on the safe side the patch
> > > explicitly forbids registering a char device with 0/0 number (see
> > > cdev_add()).
> > >
> > > This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
> > > i.e. it won't have any side effect.
> >
> > >  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> > >  {
> > > +   bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
> > >     int error = may_create(dir, dentry);
> > >
> > >     if (error)
> > >             return error;
> > >
> > > -   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> > > +   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> > > +       !is_whiteout)
> > >             return -EPERM;
> >
> > Hmm...  That exposes vfs_whiteout() to LSM; are you sure that you won't
> > end up with regressions for overlayfs on sufficiently weird setups?
>
> You're right.  OTOH, what can we do?  We can't fix the weird setups, only the
> distros/admins can.
>
> Can we just try this, and revert to calling ->mknod directly from overlayfs if
> it turns out to be a problem that people can't fix easily?
>
> I guess we could add a new ->whiteout security hook as well, but I'm not sure
> it's worth it.  Cc: LMS mailing list; patch re-added for context.

I feel like I am still missing context but IIUC this change is
allowing unprivileged userspace to explicitly call mknod(2) with the
whiteout device number and skip all permission checks (except the LSM
one). And then you are switching vfs_whiteout() over to using
vfs_mknod() internally since it no longer does permission checking and
that was why vfs_whiteout() was separate originally to avoid imposing
any checks on overlayfs-internal creation of whiteouts?

If that's correct, then it seems problematic since we have no way in
the LSM hook to distinguish the two cases (userspace invocation of
mknod(2) versus overlayfs-internal operation).  Don't know offhand
what credential is in effect in the overlayfs case (mounter or
current) but regardless Android seems to use current regardless, and
that could easily fail.
