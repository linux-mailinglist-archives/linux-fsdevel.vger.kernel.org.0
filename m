Return-Path: <linux-fsdevel+bounces-53710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F42AAF6142
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2704A3C28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E502E499E;
	Wed,  2 Jul 2025 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWdA/arS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037862E4982;
	Wed,  2 Jul 2025 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480836; cv=none; b=eevAqdjGR7tGakDWi6IdzBbngkml/AWvXubJy9SrSavdqRkfI7P90lkEDn0eQR7qs+B5sPG5Otlg6N+E3drqZRV1MD1hNcCrGAxAX9eJCMz9SU/n6hWXg3L7RWu2UxqBcWMA3+r8eNfNktxiBp0/Ce8q4STvTuawGrmVbHa75OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480836; c=relaxed/simple;
	bh=9EOuGlJmfyq7UTIfdMFkqaoJsj28hkoa5NhSMTJr7pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+8ebSxCqwPf9g9E21mMKP1JaBp531P5nkXzgYPIpK8/98CE5G+hnep48soAOXKn2IXNsv6FUWTJqIj8FkcjBz7EXZwPLx3R9nND0qqyjHHPdAk9IZuKhIp8DvccBxNIvCCe5HZquaMrsQt53txD52od/yn2yPKgQMtmJpKVNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWdA/arS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF0FC4CEEE;
	Wed,  2 Jul 2025 18:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480835;
	bh=9EOuGlJmfyq7UTIfdMFkqaoJsj28hkoa5NhSMTJr7pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWdA/arSOxswKzT23GnMBGiRPP+ER37jDCc79T/ybH9MQP2FX9xc1VIqy9D2L7wPv
	 69GKGn7Y+jynk3p+IwfQM6lBtI4Pg34I3p3fehJWWnDNLQ5quyojzEbS40vCqrNI3a
	 1DB/YOFkm/KA0NJmTJCuZsAU/97kTwn5P9qmG1iqVnSoOJgKMYlXtxnjW/ICAJRCbR
	 P1Qp6ddezbw1e7f2WJU3Td2FnOqPlFGOxmJ/i+a7vGDWKUTpVfA/Xtb2XIeuH4Dabx
	 gdqBzji3YS0lOKbH+UBTxva3yYObCcih7FheMIEVn6oBfpLExURfhuIzfkoLjhpTl3
	 +ZrzyCFkoi66g==
Date: Wed, 2 Jul 2025 11:27:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 09/12] iomap: export iomap_writeback_folio
Message-ID: <20250702182715.GU10009@frogsfrogsfrogs>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-10-hch@lst.de>

On Fri, Jun 27, 2025 at 09:02:42AM +0200, Christoph Hellwig wrote:
> Allow fuse to use iomap_writeback_folio for folio laundering.  Note
> that the caller needs to manually submit the pending writeback context.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Seems reasonable to me...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 4 ++--
>  include/linux/iomap.h  | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a1dccf4e7063..18ae896bcfcc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1638,8 +1638,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
>  	return true;
>  }
>  
> -static int iomap_writeback_folio(struct iomap_writeback_ctx *wpc,
> -		struct folio *folio)
> +int iomap_writeback_folio(struct iomap_writeback_ctx *wpc, struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	struct inode *inode = wpc->inode;
> @@ -1721,6 +1720,7 @@ static int iomap_writeback_folio(struct iomap_writeback_ctx *wpc,
>  	mapping_set_error(inode->i_mapping, error);
>  	return error;
>  }
> +EXPORT_SYMBOL_GPL(iomap_writeback_folio);
>  
>  int
>  iomap_writepages(struct iomap_writeback_ctx *wpc)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 1a07d8fa9459..568a246f949b 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -465,6 +465,7 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
>  		size_t len);
>  void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>  		size_t len);
> +int iomap_writeback_folio(struct iomap_writeback_ctx *wpc, struct folio *folio);
>  int iomap_writepages(struct iomap_writeback_ctx *wpc);
>  
>  /*
> -- 
> 2.47.2
> 
> 

