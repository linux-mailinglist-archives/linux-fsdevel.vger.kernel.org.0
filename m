Return-Path: <linux-fsdevel+bounces-77642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B7hLFtFlmmYdAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:03:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C02B15AC45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33442300C032
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6633A039;
	Wed, 18 Feb 2026 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoVI7l5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2012773E4;
	Wed, 18 Feb 2026 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455829; cv=none; b=gmB0+vYSyFs7oA16ex2QhTdbnHoCl/VMEvDx9srzdFKDfCP8P3T3kloE7QJ0Exq4yJtJC/G6Mp/WaNrBgkdW4gtVpmsgPcxERQilPiqhGzJqvddXm0iT0CrYOMtCikTsNdiBBx6jfFohFjLIQL6pS2q+xrnzfmy5oPV/A2WCw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455829; c=relaxed/simple;
	bh=mDvKmWUDmMaYad1iBo+euIDXuxPgRsvnUqyWGfdnJS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaNkCSl3KePWg2deLjJ4/Zfup+bXPtMc9fco7rBwyn6kJ+s8Av+DTiiBxJpBBTkmN8knDis2k5XfWCWddLCgv+22k7WIXDCbAiFNcaax/Kvo2ayZAL20t8+d3NBOik3N3xAJBbxZVt7KqKAlU2uxTl2viykBm5wc26h2/CjgZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoVI7l5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D641CC116D0;
	Wed, 18 Feb 2026 23:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771455828;
	bh=mDvKmWUDmMaYad1iBo+euIDXuxPgRsvnUqyWGfdnJS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoVI7l5AZPJjp7DJDBqHHlJ4hEWFGLcDA0QNOgQNQ9y3HtWInBmG3s3qv/C9pMc67
	 tEq2zozDC0UFLUzyR51fLkNlgzNOQN03ebKyaXSUirGlQGyKUwPn2XGUN7rHggwtCc
	 k/J0b3nuVLFWVGO0vqDsCclYjobyFJVl2XxhjCL/3o19U2daf5p7cr9lKjGvi9sgkI
	 jWlz0aBRwA5mdND1JgZ84wQEEq4x5jHA2NrmjqKdwEC0neMfa01/FrghF8oGqPrI/5
	 T4Lw+RN1eGDOmxOdnc2hBG2tG7dHNs9MYsBGzea3ngZQ4JSzY+LVQiW1l0Zd6mNxLd
	 b2fnN6EIzsFaQ==
Date: Wed, 18 Feb 2026 15:03:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 07/35] iomap: introduce IOMAP_F_FSVERITY
Message-ID: <20260218230348.GF6467@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-8-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-8-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77642-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 4C02B15AC45
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:07AM +0100, Andrey Albershteyn wrote:
> Flag to indicate to iomap that write is happening beyond EOF and no
> isize checks/update is needed.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/iomap/buffered-io.c | 8 +++++---
>  fs/iomap/trace.h       | 3 ++-
>  include/linux/iomap.h  | 5 +++++
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ee7b845f5bc8..4cf9d0991dc1 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -533,7 +533,8 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  			return 0;
>  
>  		/* zero post-eof blocks as the page may be mapped */
> -		if (iomap_block_needs_zeroing(iter, pos)) {
> +		if (iomap_block_needs_zeroing(iter, pos) &&
> +		    !(iomap->flags & IOMAP_F_FSVERITY)) {
>  			folio_zero_range(folio, poff, plen);
>  			iomap_set_range_uptodate(folio, poff, plen);
>  		} else {
> @@ -1130,13 +1131,14 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
>  		 * unlock and release the folio.
>  		 */
>  		old_size = iter->inode->i_size;
> -		if (pos + written > old_size) {
> +		if (pos + written > old_size &&
> +		    !(iter->iomap.flags & IOMAP_F_FSVERITY)) {

I think this flag should be called IOMAP_F_POSTEOF since there's no
"fsverity" logic dependent on this flag; it merely allows read/write
access to folios beyond EOF without any of the usual clamping and
zeroing...

>  			i_size_write(iter->inode, pos + written);
>  			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>  		}
>  		__iomap_put_folio(iter, write_ops, written, folio);
>  
> -		if (old_size < pos)
> +		if (old_size < pos && !(iter->iomap.flags & IOMAP_F_FSVERITY))
>  			pagecache_isize_extended(iter->inode, old_size, pos);
>  
>  		cond_resched();
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 532787277b16..5252051cc137 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -118,7 +118,8 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
>  	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
>  	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
>  	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
> -	{ IOMAP_F_STALE,	"STALE" }
> +	{ IOMAP_F_STALE,	"STALE" }, \
> +	{ IOMAP_F_FSVERITY,	"FSVERITY" }
>  
>  
>  #define IOMAP_DIO_STRINGS \
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index f0e3ed8ad6a6..94cf6241b37f 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -87,6 +87,11 @@ struct vm_fault;
>  #define IOMAP_F_INTEGRITY	0
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  
> +/*
> + * IO happens beyound inode EOF, fsverity metadata is stored there

s/beyound/beyond/

--d

> + */
> +#define IOMAP_F_FSVERITY	(1U << 10)
> +
>  /*
>   * Flag reserved for file system specific usage
>   */
> -- 
> 2.51.2
> 
> 

