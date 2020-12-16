Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F12DC48E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 17:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgLPQr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 11:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgLPQr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:47:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D35C0617A6
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 08:46:47 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g25so2299283wmh.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 08:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DE711iUDj9r5LMmWllbuVgtmMj+CPE2L8Ns11eJmqHM=;
        b=hJrLxEk5zcQ4Dd1ZG5IngV920AOieHzJKv03G1oBPwJtHu/1yKNG0R7lwXlvet9n3A
         16ZyuE9AMDOxTpoIL+xrUZHpGdl2ofX5l3DNGLWHtT7me3Te9BrbJCZGwi5g5EJJPvv5
         r4ViaNCL34MTuZWZ4VqAE7/aedSNpR1X4PU4GwkmoCbxzsoxMG4gPDBaH/MLtRA5j+Or
         oeeU//ShhJkajqHCmo0eHtarMZSXTAysYODkgcO6XZ3ra972OBLRmkQuXo6DQ/UocQq5
         Z8qQ080+00hxYMddmBS3YYS6+PAHENWdklFwZ9uskkuGzYvrxMSBueSz11yPgGN7tByM
         3LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DE711iUDj9r5LMmWllbuVgtmMj+CPE2L8Ns11eJmqHM=;
        b=X22FmybTAiLfcGesKiYhw5/n/LOAII8X9Svrt+/ovOTPphTgX8pP0jXlyJLz2ipZrY
         ZU34IXmBaplsRCQtVG653IkWisQmbH6opoX6kDRSl/Hagh9+waDLY04MN59CE3FD2tov
         rIqBxMg0uCRq6Plvwqj0vosr3OYZKI2np17u1Tcy1BOrHWbv/Raefu48aQZ1ReGALf1Q
         Qi607KdeM74xqRu3hpaJtFsM4FzTdll9Gc8A6IA670UwJtC7DacQ750BwKmNClz+yHQb
         y0wvEafq4zzO2ATE/H7Ydx8Sb3X+rW89rmtP9sp/dyaAxEBj2vHSfE1sUXCHtYwh0KmA
         BmaA==
X-Gm-Message-State: AOAM5317oSXwhu7nxANLZuapYwCYzpp6KRwbqQpX6j/Foh4MRhpMqPlh
        vWKxvDdg/Rtpx6dRLdCNcFIl/A==
X-Google-Smtp-Source: ABdhPJzg0UruXSDSKZSq8q0ji5v9rpPrtks4trvwJcLLm1WQ1N11oUSdunIzIr2q+W1rOQuRZFKT5Q==
X-Received: by 2002:a05:600c:218a:: with SMTP id e10mr4183217wme.27.1608137206467;
        Wed, 16 Dec 2020 08:46:46 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id f7sm6803639wmc.1.2020.12.16.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:46:45 -0800 (PST)
Date:   Wed, 16 Dec 2020 16:46:44 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V10 2/5] fuse: Passthrough initialization and release
Message-ID: <X9o59AFDwfBvVK4u@google.com>
References: <20201026125016.1905945-1-balsini@android.com>
 <20201026125016.1905945-3-balsini@android.com>
 <CA+a=Yy4bhC-432h8shxbsrY5vjTcRZopS-Ojo0924L49+Be3Cg@mail.gmail.com>
 <20201127134123.GA569154@google.com>
 <CA+a=Yy6S9spMLr9BqyO1qvU52iAAXU3i9eVtb81SnrzjkCwO5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+a=Yy6S9spMLr9BqyO1qvU52iAAXU3i9eVtb81SnrzjkCwO5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Tao,

On Sat, Nov 28, 2020 at 09:57:31AM +0800, Peng Tao wrote:
> On Fri, Nov 27, 2020 at 9:41 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > Hi Peng,
> >
> > Thanks for the heads up!
> >
> > On Thu, Nov 26, 2020 at 09:33:34PM +0800, Peng Tao wrote:
> > > On Tue, Oct 27, 2020 at 12:19 AM Alessio Balsini <balsini@android.com> wrote:
> > > > [...]
> > > >  int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
> > > >                            struct fuse_open_out *openarg)
> > > >  {
> > > > -       return -EINVAL;
> > > > +       struct inode *passthrough_inode;
> > > > +       struct super_block *passthrough_sb;
> > > > +       struct fuse_passthrough *passthrough;
> > > > +       int passthrough_fh = openarg->passthrough_fh;
> > > > +
> > > > +       if (!fc->passthrough)
> > > > +               return -EPERM;
> > > > +
> > > > +       /* Default case, passthrough is not requested */
> > > > +       if (passthrough_fh <= 0)
> > > > +               return -EINVAL;
> > > > +
> > > > +       spin_lock(&fc->passthrough_req_lock);
> > > > +       passthrough = idr_remove(&fc->passthrough_req, passthrough_fh);
> > > > +       spin_unlock(&fc->passthrough_req_lock);
> > > > +
> > > > +       if (!passthrough)
> > > > +               return -EINVAL;
> > > > +
> > > > +       passthrough_inode = file_inode(passthrough->filp);
> > > > +       passthrough_sb = passthrough_inode->i_sb;
> > > > +       if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH) {
> > > Hi Alessio,
> > >
> > > passthrough_sb is the underlying filesystem superblock, right? It
> > > seems to prevent fuse passthrough fs from stacking on another fully
> > > stacked file system, instead of preventing other file systems from
> > > stacking on this fuse passthrough file system. Am I misunderstanding
> > > it?
> >
> > Correct, this checks the stacking depth on the lower filesystem.
> > This is an intended behavior to avoid the stacking of multiple FUSE
> > passthrough filesystems, and works because when a FUSE connection has
> > the passthrough feature activated, the file system updates its
> > s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH in process_init_reply()
> > (PATCH 1/5), avoiding further stacking.
> >
> > Do you see issues with that?
> I'm considering a use case where a fuse passthrough file system is
> stacked on top of an overlayfs and/or an ecryptfs. The underlying
> s_stack_depth FILESYSTEM_MAX_STACK_DEPTH is rejected here so it is
> possible to have an overlayfs or an ecryptfs underneath but not both
> (with current FILESYSTEM_MAX_STACK_DEPTH being 2). How about changing
> passthrough fuse sb s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH + 1 in
> PATCH 1/5, and allow passthrough_sb->s_stack_depth to be
> FILESYSTEM_MAX_STACK_DEPTH here? So that existing kernel stacking file
> system setups can all work as the underlying file system, while the
> stacking of multiple FUSE passthrough filesystems is still blocked.
> 


Sounds like a good idea, I'll think about it a bit more and if
everything's all right I'll post the new patchset.


> >
> > What I'm now thinking is that fuse_passthrough_open would probably be a
> > better place for this check, so that the ioctl() would fail and the user
> > space daemon may decide to skip passthrough and use legacy FUSE access
> > for that file (or, at least, be aware that something went wrong).
> >
> +1, fuse_passthrough_open seems to be a better place for the check.
> 
> > A more aggressive approach would be instead to move the stacking depth
> > check to fuse_fill_super_common, where we can update s_stack_depth to
> > lower-fs depth+1 and fail if passthrough is active and s_stack_depth is
> > greater than FILESYSTEM_MAX_STACK_DEPTH.
> >
> The lower layer files/directories might actually spread on different
> file systems. I'm not sure if s_stack_depth check is still possible at
> mount time. Even if we can calculate the substree s_stack_depth, it is
> still more flexible to determine on a per inode basis, right?
> 
> Cheers,
> Tao
> --
> Into Sth. Rich & Strange


Fair enough. The per-inode check is definitely the right way to proceed.

Thanks a lot for you feedback!
Alessio

