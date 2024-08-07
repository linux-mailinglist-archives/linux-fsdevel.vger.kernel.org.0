Return-Path: <linux-fsdevel+bounces-25234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BD94A1BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D280F1F21B74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00D1C7B7C;
	Wed,  7 Aug 2024 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH8Z5H+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B75464E;
	Wed,  7 Aug 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015874; cv=none; b=FxPut1EY6cmC+oio35bS4zr8A91EwAkSJ1VnlNMevxuHOagQ03z9/PSqecRepy/QuC6769QpzllGoIevsCcBrU8rda5UAJ+XYAcT09ELAPABamqgTZAE2KwsBzw5wY2EKQfYUYjmvRpmNvTwuA8IHd4v6N1CtqtqsSg6dijaxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015874; c=relaxed/simple;
	bh=kjmVOn4W7d36TIXcdoDz7P/vSXeDDFbK30LfaqjgzDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGOJ5pYSgWjr8TMV5y8luQE31OHxZ+iieDk+sGOROS0IEF7PAYUEmpuLyDGMHdnFUhBwcSiGoC857OPNIYpUbkSnAiHMZaN6yTs7HxREHv77V9zfa+uAm/tpFi0kyjIau5gpzSpB2e0Eu2nG8kfbVyqKHwzdsQBWNLadLnhPHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH8Z5H+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8A1C32782;
	Wed,  7 Aug 2024 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723015874;
	bh=kjmVOn4W7d36TIXcdoDz7P/vSXeDDFbK30LfaqjgzDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RH8Z5H+8V7TFOJlsd4oC3v7Hn+HaGpVBNcToCLve1FzIpnWlXplMnmrcYsOktA+o8
	 ZXqmcpM6c3VHc+kS7GQsBGwI5DA+0jLYvIqP2/1csuMEZHjw3AELs5BVdySIFPMayc
	 GOA3ihKX1MeSc6Z45wsO+XtHNwCV2G+cpxsUBsqrP5Fh+v7CbLKDOkZ8vH4VS018+V
	 Q6RMqBEL3NM5LFLT7kQ9a1zpTVh+5AKXwFDQKuFpJzUgVLFHprIrT4t3dos2POYndo
	 cUVaSYer8iuu9gMWa7n/fzTwBHJqUTwKLggS+SsGUiYeFsBwM2LjedKh/o8i34XWB7
	 pe8OXO6FUOg5g==
Date: Wed, 7 Aug 2024 09:31:08 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Xiaxi Shen <shenxiaxi26@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix spelling and gramatical errors
Message-ID: <gav3pjazwfsvbvboz42hlf7srbxpfwjt4zaz5uagq4jvoumiru@6r27sngjhias>
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

On Wed, Aug 07, 2024 at 12:05:36AM GMT, Xiaxi Shen wrote:
> Fixed 3 typos in design.rst
> 
> Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
> ---
>  Documentation/filesystems/iomap/design.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

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

