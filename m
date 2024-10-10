Return-Path: <linux-fsdevel+bounces-31618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095D998F79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 20:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD91288D46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EC51CEAAC;
	Thu, 10 Oct 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qKTsfTw2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EhLUcAjR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qKTsfTw2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EhLUcAjR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328D91CDA05;
	Thu, 10 Oct 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583835; cv=none; b=hIOI0H4cwjnwLCyFlASjM2vpzABrvMkb1lTr/ct0QTulqTiMLQO/b9G/PF0p4UD/RF6Cs/1D6JaLT9HrE8Edmms5G+eoJgAu+YYldOLTwZax9Uha3UHrCJD95kcFGok+Vg6GTjz1CS8KlJOIyoHeuJVfR3hVB2Sn5IHd9mxRyeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583835; c=relaxed/simple;
	bh=WScZ9gq/uZQUaKbsgB0PN31XOdwUs4XfUekePpZN2fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgbozSvMSJS4/jzXTUbMX37tQDZyAhr38FeQ8PQ4DZ0QsJEwpcsvjzYnLShgy+bKBQXcNDotL9IiTf++ls2fqKhKuNP9ZrOxh7DK4xkkdl5f9xlWU6ZNnUxF+533trLfe2K0DLIcRfnV9MDmoFpyl+BQ8rarTgnZWoHfDG251OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qKTsfTw2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EhLUcAjR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qKTsfTw2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EhLUcAjR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 412711F7CA;
	Thu, 10 Oct 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728583831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycKanNyFQrEkpBWNHjK8KxZCy6yCD8panKmPRnODdpI=;
	b=qKTsfTw2UaJ520My6r5itapGVInZVHvK+oVNFp8Zb8u3v8oMnYla61bDwT1QFqjHK6WXYB
	DDWlD1Tuq0/wDgZ5je0bT96exJRVtFXgJ2TssraeUS1Mxq75p8ljLtciHEUfkulI108WeG
	PjOzYSgbqPVXKzG6OrLYMJhID3AiOK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728583831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycKanNyFQrEkpBWNHjK8KxZCy6yCD8panKmPRnODdpI=;
	b=EhLUcAjRDuCDdHdeJBGdr/MNWvzfDvogbwbNVD+pItwHzw3FOO08IFQvasysE4TfaL8kLv
	IDov1PixDNtUu+Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728583831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycKanNyFQrEkpBWNHjK8KxZCy6yCD8panKmPRnODdpI=;
	b=qKTsfTw2UaJ520My6r5itapGVInZVHvK+oVNFp8Zb8u3v8oMnYla61bDwT1QFqjHK6WXYB
	DDWlD1Tuq0/wDgZ5je0bT96exJRVtFXgJ2TssraeUS1Mxq75p8ljLtciHEUfkulI108WeG
	PjOzYSgbqPVXKzG6OrLYMJhID3AiOK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728583831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycKanNyFQrEkpBWNHjK8KxZCy6yCD8panKmPRnODdpI=;
	b=EhLUcAjRDuCDdHdeJBGdr/MNWvzfDvogbwbNVD+pItwHzw3FOO08IFQvasysE4TfaL8kLv
	IDov1PixDNtUu+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 050A71370C;
	Thu, 10 Oct 2024 18:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J2PYNpYYCGdyLAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Thu, 10 Oct 2024 18:10:30 +0000
Date: Thu, 10 Oct 2024 14:10:25 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/12] iomap: Introduce read_inline() function hook
Message-ID: <kplkze6blu5pmojn6ikv65qdsccyuxg4yexgkrmldv5stn2mr4@w6zj7ug63f3f>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <8147ae0a45b9851eacad4e8f5a71b7997c23bdd0.1728071257.git.rgoldwyn@suse.com>
 <ZwCk3eROTMDsZql1@casper.infradead.org>
 <20241007174758.GE21836@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007174758.GE21836@frogsfrogsfrogs>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On 10:47 07/10, Darrick J. Wong wrote:
> On Sat, Oct 05, 2024 at 03:30:53AM +0100, Matthew Wilcox wrote:
> > On Fri, Oct 04, 2024 at 04:04:33PM -0400, Goldwyn Rodrigues wrote:
> > > Introduce read_inline() function hook for reading inline extents. This
> > > is performed for filesystems such as btrfs which may compress the data
> > > in the inline extents.
> 
> Why don't you set iomap->inline_data to the uncompressed buffer, let
> readahead copy it to the pagecache, and free it in ->iomap_end?

This will increase the number of copies. BTRFS uncompresses directly
into pagecache. Yes, this is an option but at the cost of efficiency.

> 
> > This feels like an attempt to work around "iomap doesn't support
> > compressed extents" by keeping the decompression in the filesystem,
> > instead of extending iomap to support compressed extents itself.
> > I'd certainly prefer iomap to support compressed extents, but maybe I'm
> > in a minority here.
> 
> I'm not an expert on fs compression, but I get the impression that most
> filesystems handle reads by allocating some folios, reading off the disk
> into those folios, and decompressing into the pagecache folios.  It
> might be kind of amusing to try to hoist that into the vfs/iomap at some
> point, but I think the next problem you'd run into is that fscrypt has
> similar requirements, since it's also a data transformation step.
> fsverity I think is less complicated because it only needs to read the
> pagecache contents at the very end to check it against the merkle tree.
> 
> That, I think, is why this btrfs iomap port want to override submit_bio,
> right?  So that it can allocate a separate set of folios, create a
> second bio around that, submit the second bio, decode what it read off
> the disk into the folios of the first bio, then "complete" the first bio
> so that iomap only has to update the pagecache state and doesn't have to
> know about the encoding magic?

Yes, but that is not the only reason. BTRFS also calculates and checks
block checksums for data read during bio completions.

> 
> And then, having established that beachhead, porting btrfs fscrypt is
> a simple matter of adding more transformation steps to the ioend
> processing of the second bio (aka the one that actually calls the disk),
> right?  And I think all that processing stuff is more or less already in
> place for the existing read path, so it should be trivial (ha!) to
> call it in an iomap context instead of straight from btrfs.
> iomap_folio_state notwithstanding, of course.
> 
> Hmm.  I'll have to give some thought to what would the ideal iomap data
> transformation pipeline look like?

The order of transformation would make all the difference, and I am not
sure if everyone involved can come to a conclusion that all
transformations should be done in a particular decided order.

FWIW, checksums are performed on what is read/written on disk. So
for writes, compression happens before checksums.

> 
> Though I already have a sneaking suspicion that will morph into "If I
> wanted to add {crypt,verity,compression} to xfs how would I do that?" ->
> "How would I design a pipeine to handle all three to avoid bouncing
> pages between workqueue threads like ext4 does?" -> "Oh gosh now I have
> a totally different design than any of the existing implementations." ->
> "Well, crumbs. :("
> 
> I'll start that by asking: Hey btrfs developers, what do you like and
> hate about the current way that btrfs handles fscrypt, compression, and
> fsverity?  Assuming that you can set all three on a file, right?

-- 
Goldwyn

