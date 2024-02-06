Return-Path: <linux-fsdevel+bounces-10498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D54A84BAA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045D5B258FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9464012D150;
	Tue,  6 Feb 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDk3vIB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F713474A;
	Tue,  6 Feb 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235844; cv=none; b=mAlIJRTVGYPHOjv5vbEdfWUljLCBkqAlPtCCuHy1Dtg676FWX1nX3AWxR83Z+x0tvaWO7G8m1qJtyPxsI+Uuk/DJPFTtFbjoHM1lHTFvxhPFpWzp/YIRctjaszS244i7aXbZetRueTQMOEItRWTNZd9KMLQybnKzp9gjDoszMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235844; c=relaxed/simple;
	bh=svFLsde3UYUrt8iQw5Ef9Io2tETFRZ7PlfNvSXEPWBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEhKIRgm+ZHXz4vlcgQAf52TuHM16+T6A6xZvU9WMVOXbDLO2K51R4w9AG8WsLjQ/nEsoWc5NG7RHUgnke/lQ9xL2iuCm5WOMj1WcQ8lVxqqCyDz3Rwo0ZIncHDqDKeJfhX8R5rmgeKTjgpA+slwqzDZmdhv2IQOtj6baTiRZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDk3vIB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9A1C433F1;
	Tue,  6 Feb 2024 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707235843;
	bh=svFLsde3UYUrt8iQw5Ef9Io2tETFRZ7PlfNvSXEPWBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDk3vIB8ahV+z7L0FNUSQO+DsEYQ5pYuIyN3d8Y/dIE+KTnJJYgf8nLufZLG4JbKc
	 L3+Psm3uvBHI6c79imL8QnaP3nyn+AebqnpXRR3jndMnw0pM6eXTL5mKQcvIEN0eQn
	 HSrB6WcC1/EWJm3bj81FAEit6frZF825m80+GqFs7cHMqLrUWWgS8f3QfxkCcDbXKl
	 9OYcFJxLKdCyI3AqRgDOWvmfRuIyrqEQOZE/ICKzNeoNjlVVCkLi343cAI3LiIbohG
	 y9g6fF6KOHF8aJu/Y/2tDQorK8fmDJyO0nqbI9/MFdlWEyEk9mgPySe4AbwbW3KSxN
	 /Xu/vQGsZLEmg==
Date: Tue, 6 Feb 2024 17:10:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <20240206-ausbilden-fahrschein-cb29f2a17beb@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240205-biotechnologie-korallen-d2b3a7138ec0@brauner>
 <20240205141911.vbuqvjdbjw5pq2wc@quack3>
 <20240206-zersplittern-unqualifiziert-c449ed7a4b5f@brauner>
 <20240206135841.jxusuos7pq52efik@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206135841.jxusuos7pq52efik@quack3>

> > Can you double-check what's in vfs.super right now? I thought I fixed
> > this up. I'll check too!
> 
> Well, you've fixed the "double allocation" issue but there's still a
> problem that you do:
> 
> int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
> 	      const struct blk_holder_ops *hops, struct file *bdev_file)
> {
> ...
> 	handle = kmalloc(sizeof(struct bdev_handle), GFP_KERNEL);
> 	if (!handle)
> 		return -ENOMEM;
>  	if (holder) {
>  		mode |= BLK_OPEN_EXCL;
>  		ret = bd_prepare_to_claim(bdev, holder, hops);
>  		if (ret)
> 			return ret;
>  	} else {
> ...
> 
> 
> So in case bd_prepare_to_claim() fails we forget to free the allocated
> handle.

Grumble grumble grumble, thank you! Fixing.

