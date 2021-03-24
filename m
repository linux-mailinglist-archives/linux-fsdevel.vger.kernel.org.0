Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE2347A21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 15:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhCXOCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbhCXOCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:02:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B37FC061763
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 07:02:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so24562293wrc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Srn0HCzRuEqmBIHGKCIDIj1QJnrtcGxEweWmfp41Hk=;
        b=blJB3/bFvQgdsZFjA+/2zACn4ORPdcyIG+PyUh7o/pVWFmLyVnFIRI0DJxPPn3na3g
         inpIOlx9DPXatv/jjh7lLKY/A2zld01pxkuerRfrZexXJsma2InqZjZL6YVamwojcRAb
         ua/kXomby2Ter8CUenDlr7Imi9TUivVVp3AcbN2yIDi4sGya76j/l2u800HBGEnUW9E1
         zIT3G5XkaT7Ir/8h7xHZ4levDa2Jym3IyRCiBSKR8cLWFLGGbAPwGAmbMpEZBzHZg76u
         nsmafsfP1hdOBT9U8iQaHt9XtmplU5xBcglj2JwAmNAw7qRdJToR8NEBMayYrsvIxUhN
         pogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Srn0HCzRuEqmBIHGKCIDIj1QJnrtcGxEweWmfp41Hk=;
        b=oU+QUilo5C+p3Ge2TWGPmC73y7T6aYCuvATJE+6nsriqnncA4OSCGDjl+WorIBS1Oq
         HgAeLEPrd5IIn/DTK1uIx1HqRI8Rmf8MMdL2Ft4ii4MV/AhHYkZwZXMMbpRSoNFMgq67
         pbaaSQXh9ZelFDtcgVPCjULMP48cG9KmDV7Rtrw+/lFDHVXUPZh/6bO58S6WiOWndLFs
         wSW6BilI9vEBhBXcxbJa8VxT8KbCkGLhVIqXDf+FA89Hb6B+FwZy8c/6vT3/QOwWdFlA
         UjWCHlBoWiBeKzfqv6r47NxMZcJefe+FeY6igF9mUhFV9HG6mcT839Dhe4FeReKhJFVu
         QDaw==
X-Gm-Message-State: AOAM533pvIU73uh4WE0BptbT4IclYATKC9kglKlzR+KXat0LYnqFlIVl
        v6sQJfdjV1fXPoT6pac9GeTY9Q==
X-Google-Smtp-Source: ABdhPJxXUx4T2aaNwAFsHs+0aPg0bqPsP3pOb4ZsustW1c+1HMynvIBq9hs4aHMZlVqiC73ovqvuGw==
X-Received: by 2002:adf:e508:: with SMTP id j8mr3686199wrm.141.1616594548397;
        Wed, 24 Mar 2021 07:02:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e547:d6b6:59e3:4a81])
        by smtp.gmail.com with ESMTPSA id b17sm3358310wrt.17.2021.03.24.07.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 07:02:27 -0700 (PDT)
Date:   Wed, 24 Mar 2021 14:02:26 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Rokudo Yan <wu-yan@tcl.com>
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
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V12 1/8] fs: Generic function to convert iocb to
 rw flags
Message-ID: <YFtGciOtz6ri9nYS@google.com>
References: <24bb27b5804fb64238f2f9c1f3c860d5@sslemail.net>
 <YA71ydLBbKmZg5/O@google.com>
 <d136923d-dd50-3cb4-7771-b3c0dceabd24@tcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d136923d-dd50-3cb4-7771-b3c0dceabd24@tcl.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 03:43:12PM +0800, Rokudo Yan wrote:
> On 1/26/21 12:46 AM, Alessio Balsini wrote:
> > On Mon, Jan 25, 2021 at 03:30:50PM +0000, Alessio Balsini wrote:
> > > OverlayFS implements its own function to translate iocb flags into rw
> > > flags, so that they can be passed into another vfs call.
> > > With commit ce71bfea207b4 ("fs: align IOCB_* flags with RWF_* flags")
> > > Jens created a 1:1 matching between the iocb flags and rw flags,
> > > simplifying the conversion.
> > > 
> > > Reduce the OverlayFS code by making the flag conversion function generic
> > > and reusable.
> > > 
> > > Signed-off-by: Alessio Balsini <balsini@android.com>
> > > ---
> > >   fs/overlayfs/file.c | 23 +++++------------------
> > >   include/linux/fs.h  |  5 +++++
> > >   2 files changed, 10 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > > index bd9dd38347ae..56be2ffc5a14 100644
> > > --- a/fs/overlayfs/file.c
> > > +++ b/fs/overlayfs/file.c
> > > @@ -15,6 +15,8 @@
> > >   #include <linux/fs.h>
> > >   #include "overlayfs.h"
> > > +#define OVL_IOCB_MASK (IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
> > > +
> > >   struct ovl_aio_req {
> > >   	struct kiocb iocb;
> > >   	struct kiocb *orig_iocb;
> > > @@ -236,22 +238,6 @@ static void ovl_file_accessed(struct file *file)
> > >   	touch_atime(&file->f_path);
> > >   }
> > > -static rwf_t ovl_iocb_to_rwf(int ifl)
> > > -{
> > > -	rwf_t flags = 0;
> > > -
> > > -	if (ifl & IOCB_NOWAIT)
> > > -		flags |= RWF_NOWAIT;
> > > -	if (ifl & IOCB_HIPRI)
> > > -		flags |= RWF_HIPRI;
> > > -	if (ifl & IOCB_DSYNC)
> > > -		flags |= RWF_DSYNC;
> > > -	if (ifl & IOCB_SYNC)
> > > -		flags |= RWF_SYNC;
> > > -
> > > -	return flags;
> > > -}
> > > -
> > >   static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
> > >   {
> > >   	struct kiocb *iocb = &aio_req->iocb;
> > > @@ -299,7 +285,8 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> > >   	old_cred = ovl_override_creds(file_inode(file)->i_sb);
> > >   	if (is_sync_kiocb(iocb)) {
> > >   		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
> > > -				    ovl_iocb_to_rwf(iocb->ki_flags));
> > > +				    iocb_to_rw_flags(iocb->ki_flags,
> > > +						     OVL_IOCB_MASK));
> > >   	} else {
> > >   		struct ovl_aio_req *aio_req;
> > > @@ -356,7 +343,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
> > >   	if (is_sync_kiocb(iocb)) {
> > >   		file_start_write(real.file);
> > >   		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
> > > -				     ovl_iocb_to_rwf(ifl));
> > > +				     iocb_to_rw_flags(ifl, OVL_IOCB_MASK));
> > >   		file_end_write(real.file);
> > >   		/* Update size */
> > >   		ovl_copyattr(ovl_inode_real(inode), inode);
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index fd47deea7c17..647c35423545 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -3275,6 +3275,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
> > >   	return 0;
> > >   }
> > > +static inline rwf_t iocb_to_rw_flags(int ifl, int iocb_mask)
> > > +{
> > > +	return ifl & iocb_mask;
> > > +}
> > > +
> > >   static inline ino_t parent_ino(struct dentry *dentry)
> > >   {
> > >   	ino_t res;
> > > -- 
> > > 2.30.0.280.ga3ce27912f-goog
> > > 
> > 
> > For some reason lkml.org and lore.kernel.org are not showing this change
> > as part of the thread.
> > Let's see if replying to the email fixes the indexing.
> > 
> > Regards,
> > Alessio
> > 
> 
> Hi, Alessio
> 
> This change imply IOCB_* and RWF_* flags are properly aligned, which is not
> true for kernel version 5.4/4.19/4.14. As the patch ("fs: align IOCB_* flags
> with RWF_* flags") is not back-ported to these stable kernel branches. The
> issue was found when applying these patches
> to kernel-5.4(files open with passthrough enabled can't do append write). I
> think the issue exists in AOSP common kernel too.
> Could you please fix this?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce71bfea207b4d7c21d36f24ec37618ffcea1da8
> 
> https://android-review.googlesource.com/c/kernel/common/+/1556243
> 
> Thanks
> yanwu

Hi yanwu,

Correct, this change depends on commit ce71bfea207b ("fs: align IOCB_*
flags with RWF_* flags"), and this dependency is satisfied upstream.
Being FUSE passthrough a new feature and not a bugfix, I'm not planning
to do any backporting to LTS kernels (and GregKH won't probably accept
it).

Android is a different story (and slightly out of topic here).
We are looking forward to have FUSE passthrough enabled on Android as
most of the user data is handled by FUSE. We liked the performance
improvements and non-intrusiveness of the change both for the kernel and
for userspace, so we started supporting this in android12-5.4+ kernel
branches. We are not planning to maintain the feature to older kernels
though (we can't add features to already released), and this is why FUSE
passthrough is not merged there.
To answer your question, in AOSP the officially supported kernels
already have the flags alignment change merged, and a not supported
backporting to older kernels (i.e., 4.14 and 4.19) is already available:

https://android-review.googlesource.com/q/%2522BACKPORT:+fs:+align+IOCB_*+flags+with+RWF_*+flags%2522+-status:abandoned

Thanks,
Alessio
