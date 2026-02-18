Return-Path: <linux-fsdevel+bounces-77647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEmBL5lGlmmCdQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:09:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150415ACD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F042301950E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6133A9E2;
	Wed, 18 Feb 2026 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvxW55Ai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DEB2E7BB5;
	Wed, 18 Feb 2026 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456144; cv=none; b=Mw2QAmsMJm3Aig3Or48f5OFjn+9O27mx8Ba9SpCFQ2tpbLFt09kgPtGD8dkrTevHES0L+YDfvLiN6D8DIfKVQHPtG3spO1UTYMdlvTkjlqRQn7ihg3gz6lL+I0cm7jnIavCAU9+4zO9eL4BSH1VPLro/WCjRlzU2eDRc7bop3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456144; c=relaxed/simple;
	bh=lIAwfCZUgUFQ4ZP0wYTP/JTYYcDcflajnJ8sL2vuASA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQDyFhM98EVniMoDvbYcDjQGsX+F2Gnf9R+WCljqpiuYBVgzaRbS9tFn95xx/j0/YGgiD4qAngVY9Xct098Dlz/8LsKn4YzILGMCPa+6T/YkktZoTovzMAOeHN6+zjrRfASgvD7E/UIJA7fR2I4E0la/mdUtyz03IWuHMqkf+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvxW55Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B253C116D0;
	Wed, 18 Feb 2026 23:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771456144;
	bh=lIAwfCZUgUFQ4ZP0wYTP/JTYYcDcflajnJ8sL2vuASA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvxW55Aisy3/R/MfrqbSy9id5PHs9fmxia18gTTj+QfSUCz+WbAh3ofI4BHqdPZjV
	 Mu3iFhEhLdEsazVF3IYjQA4MhtqkTIsIzywpSuljfYcbUY8DGy3PurmYRWw3CwJwC/
	 TBuJDl+vLivdhC7cPzCIgxZ2aU3GOxfRt4xLSgYeIpNU3kYRy6HSbgBpgE0/jQSf0O
	 p1lM6XsmYbR2L1DWGyEqE0/4rig/ViW2PuIwbmhYcaMFoyNQoCfYIZdQCjTnUhlzLz
	 GvA5Kn7HInCLAbbVXINXRtASclYNLG8Pi4jEAsVTipFe3iwZrBckS4WXaxDVThZTO7
	 h2vdODJETJK3g==
Date: Wed, 18 Feb 2026 15:09:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 12/35] iomap: let fsverity verify holes
Message-ID: <20260218230903.GI6467@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-13-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-13-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77647-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6150415ACD0
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:12AM +0100, Andrey Albershteyn wrote:
> fsverity needs to verify consistency of the files against the root hash,
> the holes are also hashed in the tree.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6ebf68fdc386..9468c5d60b23 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -553,6 +553,9 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  		if (iomap_block_needs_zeroing(iter, pos) &&
>  		    !(iomap->flags & IOMAP_F_FSVERITY)) {
>  			folio_zero_range(folio, poff, plen);
> +			if (fsverity_active(iter->inode) &&
> +			    !fsverity_verify_blocks(ctx->vi, folio, plen, poff))
> +				return -EIO;

Assuming that EIO really is the error code for "data doesn't match
merkle tree") then this is ok.  Too bad the function returns a bool
and makes the filesystems come up with their own error code... :(

--D

>  			iomap_set_range_uptodate(folio, poff, plen);
>  		} else {
>  			/*
> -- 
> 2.51.2
> 
> 

