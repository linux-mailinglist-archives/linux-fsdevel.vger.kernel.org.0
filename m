Return-Path: <linux-fsdevel+bounces-7518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE708267C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 06:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26D21C2177F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 05:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727C79F4;
	Mon,  8 Jan 2024 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="yfRXjTXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6879D8
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9ac5bd128so506483b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jan 2024 21:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704692054; x=1705296854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qOtzhYdwVZ7R+yFBqwQdkSOpdtPSZj08aCA2o51PBLc=;
        b=yfRXjTXwLwLb9FVR7JjvAEoE7iO3dxBBlogY4O5Fq95Su7XK8blE7IzbD5R8GYYh22
         mErLUqcuEM9ECO0q3Navxr7JRhYPz4jvJSxC/eiThhxtgDDTL7n7eolEGd1AYS1lbkO3
         DKcAOszFnmneqZ7XPbwndEsfcZgfBBQg1fNFn+eVfy9ExHh93QnjRnizr+znM4tO0SlF
         yGpfpCyuLwji+YSEacpIFDdNs82wmwLlmFRWDNJnKcJZukHNFAEa2gWHRFvppQs1jt0p
         3bDy2fHSGOUeGMTFWuJR2tZlfnf1aeKYlb/heU5jxj/98c1I/CmwvhfZkDdz/BZZd/jG
         RHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704692054; x=1705296854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOtzhYdwVZ7R+yFBqwQdkSOpdtPSZj08aCA2o51PBLc=;
        b=ZqshyyBp7Q55ET1OsHTUQg3NF+KLpKFL5P42FMns6wJpaIxk8TwckHBbzzsp8IIAqC
         XEvWElDF+kbS3PGwXWaWrB67ZYuJGN+EKWlj6iVBQ0phs52DNJA0C/ijvQjx70aYSIK+
         DFtvWpiTD/0bt2eBlLo7SmCf6KudTwwZzBF7iq14wHOF99jwO9Go95+/hYBGgOZJk8Ro
         WOvUh3dl1bv4CgT+OQn5ZFFvmTi5veTXJU60q4rwMOW9kfte+op2YF/4xvMVth+gEDVj
         b2YbPm5wuwXEHTLIS66GHClC+5BJF/lgQ7nCSVYewWW9NYc96jQcKoqKb9Dokjm7Q76p
         VX1g==
X-Gm-Message-State: AOJu0Yw0ICh4D5OjkvkuLce91EmV1SZcLuUhG2edAuWosxAo/frFHQcz
	q/lsN7KF/Ijw8g7an6XbXTeRpT3DQCzuvXHIHLeH0hMqtAc=
X-Google-Smtp-Source: AGHT+IGdKSE2yXW9/DbGBRhARUQra+A15wgx9GxkF1s67oQRQDqNcnwEn6GzduLvwpSAhVSOZK5u/A==
X-Received: by 2002:a62:be03:0:b0:6d9:e3b1:b0fd with SMTP id l3-20020a62be03000000b006d9e3b1b0fdmr820405pff.8.1704692054520;
        Sun, 07 Jan 2024 21:34:14 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id l25-20020a62be19000000b006dae5e8a79asm2934230pff.33.2024.01.07.21.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 21:34:13 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rMiH4-007VXM-1j;
	Mon, 08 Jan 2024 16:34:10 +1100
Date: Mon, 8 Jan 2024 16:34:10 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 07/34] xfs: port block device access to files
Message-ID: <ZZuJUgOaYONI1fwZ@dread.disaster.area>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-7-6c8ee55fb6ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-vfs-bdev-file-v1-7-6c8ee55fb6ef@kernel.org>

On Wed, Jan 03, 2024 at 01:55:05PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/xfs/xfs_buf.c   | 10 +++++-----
>  fs/xfs/xfs_buf.h   |  4 ++--
>  fs/xfs/xfs_super.c | 43 +++++++++++++++++++++----------------------
>  3 files changed, 28 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 545c7991b9b5..685eb2a9f9d2 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1951,7 +1951,7 @@ xfs_free_buftarg(
>  	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
>  	/* the main block device is closed by kill_block_super */
>  	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
> -		bdev_release(btp->bt_bdev_handle);
> +		fput(btp->bt_f_bdev);

bt_bdev_file, please.

"_f_" is not a meaningful prefix, and if we fill the code up with
single letter prefixes is becomes completely unreadable. 

>  
>  	kmem_free(btp);
>  }
> @@ -1994,7 +1994,7 @@ xfs_setsize_buftarg_early(
>  struct xfs_buftarg *
>  xfs_alloc_buftarg(
>  	struct xfs_mount	*mp,
> -	struct bdev_handle	*bdev_handle)
> +	struct file		*f_bdev)

	struct file		*bdev_file)
>  {
>  	xfs_buftarg_t		*btp;
>  	const struct dax_holder_operations *ops = NULL;
> @@ -2005,9 +2005,9 @@ xfs_alloc_buftarg(
>  	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
>  
>  	btp->bt_mount = mp;
> -	btp->bt_bdev_handle = bdev_handle;
> -	btp->bt_dev = bdev_handle->bdev->bd_dev;
> -	btp->bt_bdev = bdev_handle->bdev;
> +	btp->bt_f_bdev = f_bdev;
> +	btp->bt_bdev = F_BDEV(f_bdev);

file_bdev(), please. i.e. similar to file_inode().


> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 0e64220bffdc..01ef0ef83c41 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -362,16 +362,16 @@ STATIC int
>  xfs_blkdev_get(
>  	xfs_mount_t		*mp,
>  	const char		*name,
> -	struct bdev_handle	**handlep)
> +	struct file		**f_bdevp)

	struct file		**filep

>  {
>  	int			error = 0;
>  
> -	*handlep = bdev_open_by_path(name,
> +	*f_bdevp = bdev_file_open_by_path(name,
>  		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
>  		mp->m_super, &fs_holder_ops);
> -	if (IS_ERR(*handlep)) {
> -		error = PTR_ERR(*handlep);
> -		*handlep = NULL;
> +	if (IS_ERR(*f_bdevp)) {
> +		error = PTR_ERR(*f_bdevp);
> +		*f_bdevp = NULL;
>  		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
>  	}
>  
> @@ -436,26 +436,25 @@ xfs_open_devices(
>  {
>  	struct super_block	*sb = mp->m_super;
>  	struct block_device	*ddev = sb->s_bdev;
> -	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
> +	struct file		*f_logdev = NULL, *f_rtdev = NULL;

	struct file		*logdev_file = NULL;
	struct file		*rtdev_file = NULL;
...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

