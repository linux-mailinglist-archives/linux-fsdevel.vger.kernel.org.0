Return-Path: <linux-fsdevel+bounces-9883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA20845AF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933F61C2A4FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAB162178;
	Thu,  1 Feb 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucKFvXVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8B62169;
	Thu,  1 Feb 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800084; cv=none; b=JEqITx2MBeDQqr0xnSL/vewM8UQXfGUd21m+XF+PlNb+IXrautqVPXio+rg+1xTyX75o9U+bBFyCNpJ1WTg3mFbvfrR+7KUSUwv2MGBluJLvJuXBTjQIuUFniCsehQpjatbTGXi32++u2sbqWNR7fS393eRLjVjJsETYDRCOz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800084; c=relaxed/simple;
	bh=L+LqnUZTobivGbVdiB5RldNsIeUBCujnnbGz8u6647M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF/pptOElUxG3qaMH5kQtuJG9kcw3ffFBfwqgcy0JA3vT1BdQ7jD24Oj7Fkq3JmIiOpEISePSJ3sil6PSi7TxfCSpbbYDlSz/kekxS9YBFqL2hCyZh1ZzkcfJsDCIyL4K5GENX0kaj+s8Yh09ifWq6eqBAHAKW9xP7aUohjXo7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucKFvXVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7FEC433F1;
	Thu,  1 Feb 2024 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706800083;
	bh=L+LqnUZTobivGbVdiB5RldNsIeUBCujnnbGz8u6647M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ucKFvXVw8b9n/q7zo1vyOEKTjACgk3wXtQzmTKR1N9je6cEEOfGi3r0WdAxGKCZE8
	 IHKO+DnsATD0M0Kc5SONO2CGS1N/xAvk6noIxL7/DDEa4yfgHfVrHsCuCSys36rRjD
	 dbv13tjb4HKaWwK/j1MiiHgqy/3SA0+V8FolYtHe75IGjsDRX6UsqS91YvyN81Q27M
	 ukVgBZBtpRlrrx9EKNqZIaRkwfY3xlHG7VcZgbXCIFous+3yjEytyZPnRLIQaWItlI
	 MfuRIiGAkYXjM4uY56Nj+Ko/B5sjtK4MsdDxNDB6KHvPbBpoiNqdRvX+lEztehQr2U
	 +Fz8fy6q7MuUg==
Date: Thu, 1 Feb 2024 16:07:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 29/34] bdev: make struct bdev_handle private to the
 block layer
Message-ID: <20240201-enzianblau-wohlgefallen-ece64eb96719@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
 <20240201105422.3wuw332vh4tusbzp@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201105422.3wuw332vh4tusbzp@quack3>

> >   * Use this interface ONLY if you really do not have anything better - i.e. when
> >   * you are behind a truly sucky interface and all you are given is a device
>       ^^^
> I guess this part of comment is stale now?

Indeed, I removed that.

> 
> > @@ -902,7 +897,22 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> >  	handle->bdev = bdev;
> >  	handle->holder = holder;
> >  	handle->mode = mode;
> > -	return handle;
> > +
> > +	/*
> > +	 * Preserve backwards compatibility and allow large file access
> > +	 * even if userspace doesn't ask for it explicitly. Some mkfs
> > +	 * binary needs it. We might want to drop this workaround
> > +	 * during an unstable branch.
> > +	 */
> 
> Heh, I think the sentense "We might want to drop this workaround during an
> unstable branch." does not need to be moved as well :)

Dropped.

> > -	handle = bdev_open_by_dev(dev, mode, holder, hops);
> > -	if (IS_ERR(handle))
> > -		return ERR_CAST(handle);
> > +	ret = bdev_permission(dev, 0, holder);
> 				   ^^ Maybe I'm missing something but why
> do you pass 0 mode here?

Lack of caffeine? Fixed. Thanks for catching that.

> 
> 
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	bdev = blkdev_get_no_open(dev);
> > +	if (!bdev)
> > +		return ERR_PTR(-ENXIO);
> >  
> >  	flags = blk_to_file_flags(mode);
> > -	bdev_file = alloc_file_pseudo_noaccount(handle->bdev->bd_inode,
> > +	bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
> >  			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
> >  	if (IS_ERR(bdev_file)) {
> > -		bdev_release(handle);
> > +		blkdev_put_no_open(bdev);
> >  		return bdev_file;
> >  	}
> > -	ihold(handle->bdev->bd_inode);
> > +	bdev_file->f_mode &= ~FMODE_OPENED;
> 
> Hum, why do you need these games with FMODE_OPENED? I suspect you want to
> influence fput() behavior but then AFAICT we will leak dentry, mnt, etc. on
> error? If this is indeed needed, it deserves a comment...

I rewrote this.

Total diff I applied is:

diff --git a/block/bdev.c b/block/bdev.c
index 0e8984884236..ba9dfa4648ca 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -893,12 +893,6 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
        handle->holder = holder;
        handle->mode = mode;

-       /*
-        * Preserve backwards compatibility and allow large file access
-        * even if userspace doesn't ask for it explicitly. Some mkfs
-        * binary needs it. We might want to drop this workaround
-        * during an unstable branch.
-        */
        bdev_file->f_flags |= O_LARGEFILE;
        bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
        if (bdev_nowait(bdev))
@@ -960,7 +954,7 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
        unsigned int flags;
        int ret;

-       ret = bdev_permission(dev, 0, holder);
+       ret = bdev_permission(dev, mode, holder);
        if (ret)
                return ERR_PTR(ret);

@@ -975,16 +969,14 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
                blkdev_put_no_open(bdev);
                return bdev_file;
        }
-       bdev_file->f_mode &= ~FMODE_OPENED;
-
        ihold(bdev->bd_inode);
+
        ret = bdev_open(bdev, mode, holder, hops, bdev_file);
        if (ret) {
+               blkdev_put_no_open(bdev);
                fput(bdev_file);
                return ERR_PTR(ret);
        }
-       /* Now that thing is opened. */
-       bdev_file->f_mode |= FMODE_OPENED;
        return bdev_file;
 }
 EXPORT_SYMBOL(bdev_file_open_by_dev);
diff --git a/block/fops.c b/block/fops.c
index 81ff8c0ce32f..a1ba1a50ae77 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -622,7 +622,8 @@ static int blkdev_open(struct inode *inode, struct file *filp)

 static int blkdev_release(struct inode *inode, struct file *filp)
 {
-       bdev_release(filp->private_data);
+       if (filp->private_data)
+               bdev_release(filp->private_data);
        return 0;
 }

