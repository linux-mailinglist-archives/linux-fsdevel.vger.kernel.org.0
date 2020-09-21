Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C942721B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 13:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIULCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 07:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIULCA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:02:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855B5C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 04:02:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so12269510wrt.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 04:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I2g6nHcqI19kIT5tIQgr8kQYqLLNsw9T8aGQPx/UDYY=;
        b=O/Ilp751DXv34SsshlCLjnshPWfkVxwnEbLST5dlJPF4TAWjWg8eCuiQU7l6uFuQGb
         tWvWvVHRcPj09VcpcbVVLacGia9d1UvOcn+cpRsibcO2uUAyGotkuZPpsRzVkpUodyKp
         Bcxw2UBRduyRo7BMOWdsxBPYzBXVSVwFn9wvo02c1O4HdPs9423gpYSLwlratnxoFZo5
         qBUOjJ5nKS37Az3va9nfQnl82aTiZeHG9lWH4qsAjEU2u9oVLh0AhHQ6ugQ+A9VV3tub
         hyZov9EjMi6tvd+EfHFFm6funZ1QBFZvTb+OjeFO+eXfUn3uMtbSutpcjm8N9NDfWl8U
         IZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2g6nHcqI19kIT5tIQgr8kQYqLLNsw9T8aGQPx/UDYY=;
        b=tv/HDtIHRDXhmbGUVhoe3t5K5jSQ1jcRvM9ekaQ8Y1Urm4pgiFaY2AMdbQFyeuKoib
         c2BSzws2XUj5YEFb2v2L+HqkgB8XSwLopVvV6Ubg2edbhgrxnX3ua1PmvtUEfzuCfuaS
         I715jTvoy4tGluUY5kK+8EyQLXMVJJ34QAPbHgDSJC2gVa4fF40g72P2GBSh8YtI+Iov
         soMYOPRjM0CkIKEEQydZHDzfDSVLyePF/ET9pQcZtdQzfnrLAYgKrjpekiklEL1M+faO
         MtihFaTDLgg7Y2N1iTMOvn82IKFDmy7zvS666nh/FHDVyRDSwUaMobzIF2/2pi7S80V0
         mlyg==
X-Gm-Message-State: AOAM530oXPmk7ruK/EQWyZIsjP8cQqPwojATtM59X1me5QbTueK5xm1f
        jDdIzWM5NAsW76Wf4ftkPU5PgQ==
X-Google-Smtp-Source: ABdhPJyArzXDpKHdQtF3m0UMD5L20Nz+IAstHZks46FIF59pEIa2JiEJLF6ZXetylAsd+GLOgTXyAg==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr49500480wrw.4.1600686119059;
        Mon, 21 Sep 2020 04:01:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id c4sm20827689wrp.85.2020.09.21.04.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 04:01:58 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:01:56 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 2/3] fuse: Introduce synchronous read and write for
 passthrough
Message-ID: <20200921110156.GC3385065@google.com>
References: <20200911163403.79505-1-balsini@android.com>
 <20200911163403.79505-3-balsini@android.com>
 <CAOQ4uxhxiuZV3LVk=ihqt4S7ktNK=gZcyLh19iZ1+je0fhc3Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhxiuZV3LVk=ihqt4S7ktNK=gZcyLh19iZ1+je0fhc3Uw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

On Sat, Sep 12, 2020 at 12:55:35PM +0300, Amir Goldstein wrote:
> On Fri, Sep 11, 2020 at 7:34 PM Alessio Balsini <balsini@android.com> wrote:
> > +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> > +                                  struct iov_iter *iter)
> > +{
> > +       ssize_t ret;
> > +       struct file *fuse_filp = iocb_fuse->ki_filp;
> > +       struct fuse_file *ff = fuse_filp->private_data;
> > +       struct file *passthrough_filp = ff->passthrough_filp;
> > +
> > +       if (!iov_iter_count(iter))
> > +               return 0;
> > +
> > +       if (is_sync_kiocb(iocb_fuse)) {
> > +               struct kiocb iocb;
> > +
> > +               kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
> > +               ret = call_read_iter(passthrough_filp, &iocb, iter);
> > +               iocb_fuse->ki_pos = iocb.ki_pos;
> > +               if (ret >= 0)
> > +                       fuse_copyattr(fuse_filp, passthrough_filp, false);
> > +
> > +       } else {
> > +               ret = -EIO;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
> > +                                   struct iov_iter *iter)
> > +{
> > +       ssize_t ret;
> > +       struct file *fuse_filp = iocb_fuse->ki_filp;
> > +       struct fuse_file *ff = fuse_filp->private_data;
> > +       struct inode *fuse_inode = file_inode(fuse_filp);
> > +       struct file *passthrough_filp = ff->passthrough_filp;
> > +
> > +       if (!iov_iter_count(iter))
> > +               return 0;
> > +
> > +       inode_lock(fuse_inode);
> > +
> > +       if (is_sync_kiocb(iocb_fuse)) {
> > +               struct kiocb iocb;
> > +
> > +               kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
> > +
> > +               file_start_write(passthrough_filp);
> > +               ret = call_write_iter(passthrough_filp, &iocb, iter);
> 
> Why not vfs_iter_write()/vfs_iter_read()?
> 
> You are bypassing many internal VFS checks that seem pretty important.
> 

I've been thinking a lot about this and decided to go for the VFS bypassing
solution because:
1. it looked odd to me to perform VFS checks twice, both for FUSE and lower
   FS and it seemed to me that we found a tradeoff with Jann about doing
   this lower FS call, and
2. in our Android use case (I just saw you asking for more details about
   this in, I'll reply on the other thread), the user might have the right
   credentials to access the FUSE file system, but not to access the lower
   file system, so the VFS checkings would fail. So that would have created
   the need for a credential bypassing that looked hacky.

But I agree and I would probably sleep better knowing that VFS checks are
not skipped :) So I decided to implemented the vfs_iter_{read,write}()
variant.

I again picked a lot from the overlayfs solution. In a few words, I get the
FUSE daemon credential reference at FUSE FS creation time and, when
passthrough read/write operations are triggered, the kernel temporarily
overrides the requesting process' credentials with those of the FUSE
daemon. Credentials are reverted as soon as the operation completes.

I have a temporary development branch where I'm developing the V9 of this
patch, plus the VFS variant (git history may change):

https://github.com/balsini/linux/tree/fuse-passthrough-stable-v5.8-v9-vfs

For now, I'm happy to say that I like this VFS solution, it also simplified
the lower file system notifications, so I'll probably go with this in the
V9.

Thanks again Amir, much appreciated.
Alessio
