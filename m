Return-Path: <linux-fsdevel+bounces-53709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D36AF613E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D664E4A1783
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9232E499B;
	Wed,  2 Jul 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMgTCFss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC282E4982;
	Wed,  2 Jul 2025 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480797; cv=none; b=r5ydT62C/G8WPtln+s1Vsr7O/bcBiKyP4fCcPm1Fi8f9IK2K++gGarGGF3IuqtS4FGi42OV8bMS+Qsomu9ubIPWlByiyxTqf4pwspoN5L+Fn0mEeAIoQM5XBO3RueP9H1hFQLvDKwtIDcQm7FAsBiKUUmLYNpSJyOCmShd2BRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480797; c=relaxed/simple;
	bh=DjyyUrB1uuWt2NftxEo7KeNO0Rg1dgvvKWSIs2nQaJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm7mU5oevhIIWw4Qj77L4ign/3awCKnJncfChmb6LxEyGATskNIs1CHHn6W/TNb1hnnfM8Ay7ZCMrBDm21bW/Fhq/A5A9cWMhl4xFEhMC8M4/m7IqhJ4+GzVIfxbPwsyCULSZJjVdgNaji/KtRjXFVXU06CdQuiN1qyRRiiV2uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMgTCFss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9ECC4CEEE;
	Wed,  2 Jul 2025 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480796;
	bh=DjyyUrB1uuWt2NftxEo7KeNO0Rg1dgvvKWSIs2nQaJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMgTCFss6tJ7KHTPymVo549BS4X2VWSL/GLcXEiRXGr2aCpbR+lHWU2q9VHjV7S3+
	 YUYuM+Eto6NPM6Pc2v0obtMl47AJPOUB03r2tEqOgeO8UobBoWcUUute9j4gEaHIQA
	 uonDCQHXjd4zy5aPOyFvWdXLX4hpjp0h/XJkJUBIkkiySrpnizXalxG8oPe1WO362t
	 de7t2pPALRszuEz5XiXbNIFIdvJduu6fIPQhvonaSpokg7FgqJMdtgKKroglaqbRcu
	 xXh23a3KHMBGUo+PZ9d2brIOf7n57fv/vLkBfApYBHFkJMue1XuUZ4BweTypklwJFE
	 Sg2qUoVJu3OoQ==
Date: Wed, 2 Jul 2025 11:26:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 07/12] iomap: rename iomap_writepage_map to
 iomap_writeback_folio
Message-ID: <20250702182636.GT10009@frogsfrogsfrogs>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-8-hch@lst.de>

On Fri, Jun 27, 2025 at 09:02:40AM +0200, Christoph Hellwig wrote:
> ->writepage is gone, and our naming wasn't always that great to start
> with.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yesssssss (and fixes the trace problems too)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 10 +++++-----
>  fs/iomap/trace.h       |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3e0ce6f42df5..c28eb6a6eee4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1586,7 +1586,7 @@ static int iomap_writeback_range(struct iomap_writeback_ctx *wpc,
>   * If the folio is entirely beyond i_size, return false.  If it straddles
>   * i_size, adjust end_pos and zero all data beyond i_size.
>   */
> -static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
> +static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
>  		u64 *end_pos)
>  {
>  	u64 isize = i_size_read(inode);
> @@ -1638,7 +1638,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
>  	return true;
>  }
>  
> -static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
> +static int iomap_writeback_folio(struct iomap_writeback_ctx *wpc,
>  		struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
> @@ -1654,9 +1654,9 @@ static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
>  	WARN_ON_ONCE(folio_test_dirty(folio));
>  	WARN_ON_ONCE(folio_test_writeback(folio));
>  
> -	trace_iomap_writepage(inode, pos, folio_size(folio));
> +	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
>  
> -	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> +	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
>  		folio_unlock(folio);
>  		return 0;
>  	}
> @@ -1741,7 +1741,7 @@ iomap_writepages(struct iomap_writeback_ctx *wpc)
>  		return -EIO;
>  
>  	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
> -		error = iomap_writepage_map(wpc, folio);
> +		error = iomap_writeback_folio(wpc, folio);
>  
>  	/*
>  	 * If @error is non-zero, it means that we have a situation where some
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index aaea02c9560a..6ad66e6ba653 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -79,7 +79,7 @@ DECLARE_EVENT_CLASS(iomap_range_class,
>  DEFINE_EVENT(iomap_range_class, name,	\
>  	TP_PROTO(struct inode *inode, loff_t off, u64 len),\
>  	TP_ARGS(inode, off, len))
> -DEFINE_RANGE_EVENT(iomap_writepage);
> +DEFINE_RANGE_EVENT(iomap_writeback_folio);
>  DEFINE_RANGE_EVENT(iomap_release_folio);
>  DEFINE_RANGE_EVENT(iomap_invalidate_folio);
>  DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
> -- 
> 2.47.2
> 
> 

