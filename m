Return-Path: <linux-fsdevel+bounces-78795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJgxJH4KomngyQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:19:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA291BE237
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3C3B30AE087
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8A347A0B2;
	Fri, 27 Feb 2026 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJRc/doN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95038B7D6;
	Fri, 27 Feb 2026 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227189; cv=none; b=KMw8drzTMZ3vOH3ohpr8qcmKYPktLHblfZfjDmFKG/cNEQIxV/AMag9u/cFxveAL4BHDvjONNOaujfCmYD7ISU3GCsZ/qUwaeRtrjdeEBPxEg708iCyqCnM77S5RoszPJTLyMsvoOi8QnHwlUj62VjHnBMhAVjdJ/mf3oQEdBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227189; c=relaxed/simple;
	bh=Kvs5P33YIXdgJf3Lcw25vKTvkt/GPz9KIPs0Cf5crxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDFU9wD7anwXVKnwMKEy4rZJXN+lFEK+AwK/KvkDEJvipt4hec5QIU3Mtg/Gjyv0mFofqNAYDck6nVhTB1uu2Ffx6/61xtiDKpAr1fFD1IvkoPZLGY/TEeY9mm6eim06L1O3ut8VV2F9c0urnSPPcukMXVWVSoz+aQKjTFJkDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJRc/doN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC96C116C6;
	Fri, 27 Feb 2026 21:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772227188;
	bh=Kvs5P33YIXdgJf3Lcw25vKTvkt/GPz9KIPs0Cf5crxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJRc/doN6phbnIWDai/y3CWyvsokFyCaqcmB304gJoKtKbEBMJTOSWloHulmUadaG
	 fLkS9C7DmNUxzi9YYFLhkq0z+jaI0/sFQdNTuhcnTgofkE2qyp55hXJijxxSbeXZ+d
	 AMjSM27vZXcY4LpqpMQ0s57DKM0DvWbN8yq7uuX5guuZbul8IXxV2YKatUHDWxb9YO
	 9HDyVHdBXDmIJKwl75bWcT+diUka8bNAA4AZSGcQsnlGlNU28Eim1vGSQADYD8toBc
	 zg8PfPPBKREplTsXB1MHBW1rQRImel1oauXxCFiJ/RCxg2Jbej52BxvLPyo+n83Z9S
	 u7jQdu1AZTBhQ==
Date: Fri, 27 Feb 2026 13:19:46 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/14] ext4: open code fscrypt_set_bio_crypt_ctx_bh
Message-ID: <20260227211946.GB2659@quark>
References: <20260226144954.142278-1-hch@lst.de>
 <20260226144954.142278-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226144954.142278-3-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78795-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 2AA291BE237
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:49:22AM -0800, Christoph Hellwig wrote:
> io_submit_init_bio already has or can easily get at most information
> needed to set the crypto context.  Open code fscrypt_set_bio_crypt_ctx_bh
> based on that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ext4/page-io.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index a3644d6cb65f..851d1267054a 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -417,6 +417,7 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
>  
>  static void io_submit_init_bio(struct ext4_io_submit *io,
>  			       struct inode *inode,
> +			       struct folio *io_folio,
>  			       struct buffer_head *bh)
>  {
>  	struct bio *bio;
> @@ -426,7 +427,10 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
>  	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
>  	 */
>  	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
> -	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
> +	fscrypt_set_bio_crypt_ctx(bio, inode,
> +			(folio_pos(io_folio) + bh_offset(bh)) >>
> +				inode->i_blkbits,
> +			GFP_NOIO);
>  	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
>  	bio->bi_end_io = ext4_end_bio;
>  	bio->bi_private = ext4_get_io_end(io->io_end);
> @@ -448,7 +452,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
>  		ext4_io_submit(io);
>  	}
>  	if (io->io_bio == NULL)
> -		io_submit_init_bio(io, inode, bh);
> +		io_submit_init_bio(io, inode, io_folio, bh);
>  	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
>  		goto submit_and_retry;

This should use 'folio', not 'io_folio'.  folio_pos() works only for
pagecache folios.

- Eric

