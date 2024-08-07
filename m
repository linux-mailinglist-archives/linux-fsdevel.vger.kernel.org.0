Return-Path: <linux-fsdevel+bounces-25307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0390794AA0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EFB1C20DB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FB37605E;
	Wed,  7 Aug 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP+0A7zi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522826AFC;
	Wed,  7 Aug 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040712; cv=none; b=ZFqozKLZkS2sOVwQNzn/3PCcTV+uvN+UPKKXnOIz3hnoFotRNQEvROZWQYjDK29DaNvk5cdCwMqznAZyotB4cgj8oaY3oItYptYuKUZ1ucbwc7+cwUolXaOt2VgVnFLIDtZrpC6d5Hja4QvlW2KXHN50Od2gV8ht7TbQ/Gd7jW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040712; c=relaxed/simple;
	bh=n6XVS07ndS40DP9OxE/y50yjhtV3uJr1TXgJWuJ8r6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSA5s6u04v3kNV3Ca+p+8Sy8tYLdZOSSQe7SCxkH3ESRqumlFeDmKL51ntOh6+fydVC9dsVfFRbzgNEYw5WtWxV/AmPr34BtA9gE07HnzP9HASx5DTQKaER1H5CVHJ8J4ZqnZg2MwECGlAHBuJsw1XV5TTlHqxXQaAPruK4EVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP+0A7zi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6BBC32781;
	Wed,  7 Aug 2024 14:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723040711;
	bh=n6XVS07ndS40DP9OxE/y50yjhtV3uJr1TXgJWuJ8r6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CP+0A7ziRu8Y9ntOIbZRm0SZ4bCaRgggNRqlK7yg6UCBezLxOpOBcnDQslH/VU3dz
	 fA24TdTbo1mQWeFKD/k/uD+vgGawB0URbe3C2wsoby3yEL/utEbJfoNDnvuPh6/5XS
	 J+8qr5EFv0+VGWgGy8KwfUFh9CHrRLQg5Iqy4I4OILlmno6dq5aZYXPn5AERRwxTqn
	 e0CNBbXt17S3Oh6Tlyi03OsI+hSR1kdNO91gZm01FSbubdQpqVGUFFtV9fOfdNsjLH
	 kugxlg0F7+Jq3DIz6/DlsS7tB3VObo38Sm8IPzPOl/oP2CwcGAojzoT8/UE3ki003f
	 ybmXV4aORoFTw==
Date: Wed, 7 Aug 2024 07:25:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Xiaxi Shen <shenxiaxi26@gmail.com>
Cc: brauner@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix spelling and gramatical errors
Message-ID: <20240807142511.GA6051@frogsfrogsfrogs>
References: <20240807070536.14536-1-shenxiaxi26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807070536.14536-1-shenxiaxi26@gmail.com>

On Wed, Aug 07, 2024 at 12:05:36AM -0700, Xiaxi Shen wrote:
> Fixed 3 typos in design.rst
> 
> Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>

Thanks for the fixes,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/iomap/design.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
> index f8ee3427bc1a..37594e1c5914 100644
> --- a/Documentation/filesystems/iomap/design.rst
> +++ b/Documentation/filesystems/iomap/design.rst
> @@ -142,9 +142,9 @@ Definitions
>   * **pure overwrite**: A write operation that does not require any
>     metadata or zeroing operations to perform during either submission
>     or completion.
> -   This implies that the fileystem must have already allocated space
> +   This implies that the filesystem must have already allocated space
>     on disk as ``IOMAP_MAPPED`` and the filesystem must not place any
> -   constaints on IO alignment or size.
> +   constraints on IO alignment or size.
>     The only constraints on I/O alignment are device level (minimum I/O
>     size and alignment, typically sector size).
>  
> @@ -394,7 +394,7 @@ iomap is concerned:
>  
>   * The **upper** level primitive is provided by the filesystem to
>     coordinate access to different iomap operations.
> -   The exact primitive is specifc to the filesystem and operation,
> +   The exact primitive is specific to the filesystem and operation,
>     but is often a VFS inode, pagecache invalidation, or folio lock.
>     For example, a filesystem might take ``i_rwsem`` before calling
>     ``iomap_file_buffered_write`` and ``iomap_file_unshare`` to prevent
> -- 
> 2.34.1
> 
> 

