Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0DB351D1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 20:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbhDASYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbhDASTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:19:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3A0C0617A9
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 04:24:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x16so1452728wrn.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uzuER9XggA/Xm395Jcfm7hXPCvj0tcp4BQB1DPPsWqk=;
        b=SG6xbMYAFAMzLUnkbQbcb8vCNm82fY5YFkUb4bfvv+dH4XpKA7O8HNsRF0zHuG2jmN
         HN5LjG1d19j0K9wuLhLSp5RmZCUteEt5UsTA6zsqiZnPI/PY6x4fcRqMpepymL+3QIom
         +5gRd9Dk/LHS8jpMrJxuP2AKUbUE1XVgi+SNLbCffLFV2Th9NGHICd/+anUM42krPwUd
         IbuUtyhrxEvrsx6RSYejW6a1iiDsBMIC6joh32sDh+p+fHFe03vymhIvxRUGGY8Gf5qB
         IKxpUxQM4/H9mP8OsBsQpJiriwx5/tY/0EvMPCq7doxD58DBySc2hwk7vlenq4eCUY3h
         lS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uzuER9XggA/Xm395Jcfm7hXPCvj0tcp4BQB1DPPsWqk=;
        b=BeD/PvC52k63F5tvACg6qi/4rfG8LBgQZdV1WOIoXWovR/mN2XyNZzVChPKTlzEylY
         d7Ak9rnSAzVLPSyN/HEJAiZolKqjx8+6dhc3nUYbTKyqQEyyH0BoKcKAuHWJ7td6aYrd
         5y5Uv37om0Qg+MnH/LJ6tD+u0HrS3qvsiHw9lNFunQUZANojVKvAYyNcda326WEgr7gJ
         7J/byYAUw7Vc5uKfKV/Azer+X1BQ1/O7l35Co5HKMNb7uy91yRLT7qbFS0uzsc1cvQZq
         4QtR2yAaT8VmSVh6WuoJD7bw/74gvqSFEqVcJc+Kc+yAhkbfXBr7UsX1iOiTZMPnNu7d
         dlZg==
X-Gm-Message-State: AOAM530FGmF0AfpHqc7j87RAyj6toB8ZKzPj2dxt2+V/P3L+eELKu+pX
        xfd0Fro9hUE9Nu6cnE1xN/t2Nw==
X-Google-Smtp-Source: ABdhPJx1VqcNYrWZdJ0X35Kyua62s3EHzvXwUtXZBoVK0FTVUTVXO74tmMIR+k+MZLDo/2y6Hlfp4w==
X-Received: by 2002:a05:6000:1acb:: with SMTP id i11mr9333662wry.68.1617276247503;
        Thu, 01 Apr 2021 04:24:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:3c81:8c37:b59c:f92e])
        by smtp.gmail.com with ESMTPSA id y205sm10407745wmc.18.2021.04.01.04.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 04:24:06 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:24:05 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V12 8/8] fuse: Introduce passthrough for mmap
Message-ID: <YGWtVXEkXrR2PR9+@google.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-9-balsini@android.com>
 <CAJfpegsphqg=AMDj37cMUobtCHu_-0EiHrEYvHZkE-RphRgWVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsphqg=AMDj37cMUobtCHu_-0EiHrEYvHZkE-RphRgWVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 03:05:07PM +0100, Miklos Szeredi wrote:
> On Mon, Jan 25, 2021 at 4:31 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > Enabling FUSE passthrough for mmap-ed operations not only affects
> > performance, but has also been shown as mandatory for the correct
> > functioning of FUSE passthrough.
> > yanwu noticed [1] that a FUSE file with passthrough enabled may suffer
> > data inconsistencies if the same file is also accessed with mmap. What
> > happens is that read/write operations are directly applied to the lower
> > file system (and its cache), while mmap-ed operations are affecting the
> > FUSE cache.
> >
> > Extend the FUSE passthrough implementation to also handle memory-mapped
> > FUSE file, to both fix the cache inconsistencies and extend the
> > passthrough performance benefits to mmap-ed operations.
> >
> > [1] https://lore.kernel.org/lkml/20210119110654.11817-1-wu-yan@tcl.com/
> >
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> > ---
> >  fs/fuse/file.c        |  3 +++
> >  fs/fuse/fuse_i.h      |  1 +
> >  fs/fuse/passthrough.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 45 insertions(+)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index cddada1e8bd9..e3741a94c1f9 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -2370,6 +2370,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
> >         if (FUSE_IS_DAX(file_inode(file)))
> >                 return fuse_dax_mmap(file, vma);
> >
> > +       if (ff->passthrough.filp)
> > +               return fuse_passthrough_mmap(file, vma);
> > +
> >         if (ff->open_flags & FOPEN_DIRECT_IO) {
> >                 /* Can't provide the coherency needed for MAP_SHARED */
> >                 if (vma->vm_flags & VM_MAYSHARE)
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 815af1845b16..7b0d65984608 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1244,5 +1244,6 @@ int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
> >  void fuse_passthrough_release(struct fuse_passthrough *passthrough);
> >  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
> >  ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
> > +ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
> >
> >  #endif /* _FS_FUSE_I_H */
> > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > index 24866c5fe7e2..284979f87747 100644
> > --- a/fs/fuse/passthrough.c
> > +++ b/fs/fuse/passthrough.c
> > @@ -135,6 +135,47 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
> >         return ret;
> >  }
> >
> > +ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +       int ret;
> > +       const struct cred *old_cred;
> > +       struct fuse_file *ff = file->private_data;
> > +       struct inode *fuse_inode = file_inode(file);
> > +       struct file *passthrough_filp = ff->passthrough.filp;
> > +       struct inode *passthrough_inode = file_inode(passthrough_filp);
> > +
> > +       if (!passthrough_filp->f_op->mmap)
> > +               return -ENODEV;
> > +
> > +       if (WARN_ON(file != vma->vm_file))
> > +               return -EIO;
> > +
> > +       vma->vm_file = get_file(passthrough_filp);
> > +
> > +       old_cred = override_creds(ff->passthrough.cred);
> > +       ret = call_mmap(vma->vm_file, vma);
> > +       revert_creds(old_cred);
> > +
> > +       if (ret)
> > +               fput(passthrough_filp);
> > +       else
> > +               fput(file);
> > +
> > +       if (file->f_flags & O_NOATIME)
> > +               return ret;
> > +
> > +       if ((!timespec64_equal(&fuse_inode->i_mtime,
> > +                              &passthrough_inode->i_mtime) ||
> > +            !timespec64_equal(&fuse_inode->i_ctime,
> > +                              &passthrough_inode->i_ctime))) {
> > +               fuse_inode->i_mtime = passthrough_inode->i_mtime;
> > +               fuse_inode->i_ctime = passthrough_inode->i_ctime;
> 
> Again, violation of rules.   Not sure why this is needed, mmap(2)
> isn't supposed to change mtime or ctime, AFAIK.
> 
> Thanks,
> Miklos

Hi Miklos,

I don't have a strong preference for this and will drop the ctime/atime
updates in v13.


For the records, here follows my reasoning for which I decided to update
atime/ctime here.

From the stats(2) man it just says that it's not guaranteed that atime
would be updated, as `Other routines, like mmap(2), may or may not
update st_atime.`

Something similar according to the inotify(7) man that warns not to trigger events
after mmap(2), msync(2), and munmap(2) operations.

The mmap(2) man mentions that st_ctime and st_mtime would be updated for
file mappings with PROT_WRITE and MAP_SHARED, before a msync(2) with
MS_SYNC or MS_ASYNC.
This passthrough scenario is slightly different from the standard mmap,
but it seems to me that we are kind of falling into a similar use case
for the atime/ctime update.
I would imagine this is why OverlayFS updates atime/ctime too in
ovl_mmap(), through ovl_copyattr().

Thanks,
Alessio
