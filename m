Return-Path: <linux-fsdevel+bounces-77728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPDfN3VIl2m2wQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 18:29:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CF616132A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C0B73009388
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1893134F478;
	Thu, 19 Feb 2026 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3IskOq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094333F362;
	Thu, 19 Feb 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522158; cv=none; b=VA4aKX2sZrP9ZOH0/zTdMAowbGzf2qzgNQgKptzvJ0WZHKqb3fFAqB3Mmj5wdad/y4YPNpJR7hwsZVfvP4FZG/rxh7Sj2uKdcRiEtCBtJiLTuLUj2hCzqopP9wg4ty2tGlAd5AYaqaKG5a8NgSkoQTEOhzxfTxngWBGGKOaUjvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522158; c=relaxed/simple;
	bh=ZADYZEQfj8dgTYlVrDHxhrHdWGrFkudu/fkmKboGSK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEPins7luwkZA+BXDqOzjlD+Ob7LBZVoH4ZpSPhjH3Y3XUQTwB1haD5tAT4WNefXkJeurGahgRMMxmxvq7G9N38gsH3XGuA+NcxW8kT4efjb1uYpZ4TaG6SYt+lOMPl2orjvJGbIi1tq5AUgxZk6DbHDfRlgHKxb8695i8tvWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3IskOq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB90C4CEF7;
	Thu, 19 Feb 2026 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771522157;
	bh=ZADYZEQfj8dgTYlVrDHxhrHdWGrFkudu/fkmKboGSK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3IskOq9EP6/Kvby1zWfI/k9AnNJw8BMlKIihFQuNzZin/+vFtTK8V3l58B9a2sVl
	 DBUGsISiyoVTcTQtjwrFm1k+8AjFLehjxjFcIx6U8oZjwWEiikTWe6gXX13aiP5Rma
	 m3hoCv8F2IRoUyvoLJNd8I2Z5uRUYmeKnKNYtmVyU3N2DnGUYSmG3zVgf1YggsxSpR
	 mwazNGif4lg3mYBaV70zj4Ml0f5m9L+nEMXFZjF2xfHv+CUGimxdSAMcPnKxdfjL5M
	 kYcQXC7Orpl2n9OZZiKjfmwch8OThPPVvxZxqnxNnCl+5dAeROdmk8hBXNELpMP6o4
	 Fz+e8aUG9HqXA==
Date: Thu, 19 Feb 2026 09:29:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Subject: Re: [PATCH v3 28/35] xfs: add fs-verity support
Message-ID: <20260219172917.GK6490@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-29-aalbersh@kernel.org>
 <20260218064429.GC8768@lst.de>
 <mtnj4ahovgefkl4pexgwkxrreq6fm7hwpk5lgeaihxg7z5zdlz@tpzevymml5qx>
 <20260219061122.GA4091@lst.de>
 <4cmnh4lgygm4fj3fixsgy3b7xp2ayo3jirvspoma6qxusdgluu@nyamffhaurej>
 <20260219134101.GA12139@lst.de>
 <5ueyigipyfwqvysmx6ejqxpclu3oiy7wwpftnfsnyanu7z2abq@dnceynnumjh3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ueyigipyfwqvysmx6ejqxpclu3oiy7wwpftnfsnyanu7z2abq@dnceynnumjh3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77728-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03CF616132A
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 03:38:57PM +0100, Andrey Albershteyn wrote:
> On 2026-02-19 14:41:01, Christoph Hellwig wrote:
> > On Thu, Feb 19, 2026 at 10:51:14AM +0100, Andrey Albershteyn wrote:
> > > > > fs block size < PAGE_SIZE when these tree holes are in one folio
> > > > > with descriptor. Iomap can not fill them without getting descriptor
> > > > > first.
> > > > 
> > > > Should we just simply not create tree holes for that case?  Anything
> > > > involving page cache validation is a pain, so if we have an easy
> > > > enough way to avoid it I'd rather do that.
> > > 
> > > I don't think we can. Any hole at the tree tail which gets into the
> > > same folio with descriptor need to be skipped. If we write out
> > > hashes instead of the holes for the 4k page then other holes at
> > > lower offsets of the tree still can have holes on bigger page
> > > system.
> > 
> > Ok.
> > 
> > > Adding a bit of space between tree tail and descriptor would
> > > probably work but that's also dependent on the page size.
> > 
> > Well, I guess then the only thing we can do is writes very detailed
> > comments explaining all this.
> > 
> 
> I have a comment right above this function:
> 
> +/*
> + * In cases when merkle tree block (1k) == fs block size (1k) and less than
> + * PAGE_SIZE (4k) we can get the following layout in the file:
> + *
> + * [ merkle block | 1k hole | 1k hole | fsverity descriptor]
> + *
> + * These holes are merkle tree blocks which are filled by iomap with hashes of
> + * zeroed data blocks.
> + *
> + * Anything in fsverity starts with reading a descriptor. When iomap reads this
> + * page for the descriptor it doesn't know how to synthesize those merkle tree
> + * blocks. So, those are left with random data and marked uptodate.
> + *
> + * After we're done with reading the descriptor we invalidate the page
> + * containing descriptor. As a descriptor for this inode is already searchable
> + * in the hashtable, iomap can synthesize these blocks when requested again.
> + */
> +static int
> +xfs_fsverity_drop_descriptor_page(
> +	struct inode	*inode,
> +	u64		offset)
> 
> I will rephrase the first sentence to make it clear that this could
> happen for larger page sizes too.

I wonder if you could rearrange the layout to put the fsverity
descriptor first and start the merkle tree at the next
fsverity-blocksize-aligned offset past the descriptor?  Then you
wouldn't have to care with a sparse tail.

OTOH it's been so long since I fiddled with fsverity that I don't
remember if there's a Much Better Reason not to do that. <shrug>

--D


> -- 
> - Andrey
> 
> 

