Return-Path: <linux-fsdevel+bounces-7519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DC8267C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 06:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC2A1C20E85
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 05:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045128473;
	Mon,  8 Jan 2024 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="j2/melVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7379CD
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28be024282bso665442a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jan 2024 21:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704692272; x=1705297072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3O4WHGwG6ZPIr29rTx2TRQGekh8I//FNRPEnTrmWa+c=;
        b=j2/melVy9IEg1+9pCmQMvjKsQI4RnmxO9s6oMs6kIbZ1MwoJ9LlWkiArpm4gHnP1IC
         9Nn9yPz/dwmU+dpi4GrD56I8J8Gl9Pp2HQtPG5T9FKv4vm75/sgxo09xGzbYojLlO75q
         RUCAzxlYFFbGoYYK9xx9EP+Lhp/ka+qHmhxIgi69yWU4Oc+QBGiXcb33c0rPncWzfJjp
         vuiXLShy6FdUoXAURbMhMFjWS1FuRoxTwTMsF0RddsyhemIyvAQJefS7p5SCYpdsJbSp
         OZ+i0G13VK6z1Y6R+Vi20LyrfbSDYRxS2s+DEXAKxVWHTIFDrnP6wzVPvgglygOciwfi
         L9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704692272; x=1705297072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O4WHGwG6ZPIr29rTx2TRQGekh8I//FNRPEnTrmWa+c=;
        b=vZzYYiiwMFYV0gcOZdTZN+ll1WYm0Nz6CpP7FFBVQ8yI7DPz+Qu99jRoCEkFGkv3Bp
         jVkhzZocSwoLr2IuVGq9PSQij8xtvVFTa5kcGF2WQLNmxZBS2D1cCpP5CQERuzIWP7LR
         OlZkcuTS7ApMcVbhiD31CCsm4sYU+S4CgVp/H0z7N03KJgIpVN20n3F3DRuEeHmIf7Y5
         dcMpe4whrrAibbA4rUWTShq6nnzaBcp50fZ4MiJEXwNLBzFrZWgHEbVnOURifSdK4xxt
         L6jn6Alh1rA5NetX4Uyv3YUt9UDjuQYnn6b8BGx10vEfHYyHwHUDkvV16riUAllA8u8L
         xXkw==
X-Gm-Message-State: AOJu0Yxl9vVLETZ+Dn/HLjiWVHIkCrynbvg81SdsfpEWotNMgw6odHl0
	wODGtTGtthYEm7tLyUF5ZC4uDJpAijBUecwij/Lv28xup9k=
X-Google-Smtp-Source: AGHT+IGaBzF3KXZrJQgwwl1pkij7k2ARii/iQ2ROhQFs+q98FAa4BaSsDGvxEfFSmz0Nbs30f6UcOQ==
X-Received: by 2002:a17:90a:890d:b0:28c:91d5:c417 with SMTP id u13-20020a17090a890d00b0028c91d5c417mr633929pjn.65.1704692272568;
        Sun, 07 Jan 2024 21:37:52 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001d08e08003esm5312895plh.174.2024.01.07.21.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 21:37:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rMiKb-007VZm-2t;
	Mon, 08 Jan 2024 16:37:49 +1100
Date: Mon, 8 Jan 2024 16:37:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 01/34] bdev: open block device as files
Message-ID: <ZZuKLRpFr9pVZ2pa@dread.disaster.area>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-1-6c8ee55fb6ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-vfs-bdev-file-v1-1-6c8ee55fb6ef@kernel.org>

On Wed, Jan 03, 2024 at 01:54:59PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8e0d77f9464e..b0a5e94e8c3a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1227,8 +1227,8 @@ struct super_block {
>  #endif
>  	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
>  	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
> -	struct block_device	*s_bdev;
> -	struct bdev_handle	*s_bdev_handle;
> +	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_f_bdev */
> +	struct file		*s_f_bdev;

	struct file		*s_bdev_file;

Because then the reader knows exactly what the object type
and what it refers to is when they read "sb->s_bdev_file" in the
code.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

