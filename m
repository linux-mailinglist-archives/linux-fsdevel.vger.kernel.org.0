Return-Path: <linux-fsdevel+bounces-42842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D9A49854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BB17AA8D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0B923E333;
	Fri, 28 Feb 2025 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JG46NTIR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lGcBQ3u8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JG46NTIR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lGcBQ3u8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243011C3BE3
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740742264; cv=none; b=k3poyJnvbNl3PfkrmbTzcteqtzZkUZS55ldYutVCtCZ4MXTeDYvzbrmWt0XwKfwPTmjUn3t/fZNslCGRBMedABHPHhUBuVdr69TFPYAsKvyJna9LZ4Q4mVLG9tuyBbAVkB3QQv73rOypmtXApnuOa/+Xn8MHeLRuLmr0Zo1eLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740742264; c=relaxed/simple;
	bh=DwVlJ9j2Ziw99oqXwK4yyGMxKERwK5j/LpKtyTsEojc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mebdxnNJLqXiroYQ+Mt65j1k+uZOI/EK/unX2TAhfFBHmYiNXkxZH7FOyTG3UvciBIbcqIfyjvLT2v4IfHuYGADSxHpRGTLayZ933ce7JSYy3cqwcw4MJ331O/uRHnnUKBOlvjRyasezgYWCkBdLg6CVRA4pVXTMVrTqqlCua7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JG46NTIR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lGcBQ3u8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JG46NTIR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lGcBQ3u8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F51D1F37E;
	Fri, 28 Feb 2025 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740742259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFOAyPs8KJsMgBeOv5FpvM0b6wG7d3Dwofmw3MNakFs=;
	b=JG46NTIR2ip0Ac0NvGc1rshBtmqmIfz0UAjnzJyxVy5pjo+TMWtUbteBcVR+ynwgxcIfCD
	fz8e2W66fh9EuyqPBCE9maj2b3mFnyTHxNC5unmPS0GBDE7KVswFaVkEwnMoLp934VeHQI
	v+OqPGkvOqP7kKq7rt+cEBKT6axK9/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740742259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFOAyPs8KJsMgBeOv5FpvM0b6wG7d3Dwofmw3MNakFs=;
	b=lGcBQ3u8G/QkZf+705VGpcgLJl4/8vjcrmnT9uWXXjOV+mUhjHLq88VMj9ryab0kWGESfU
	By7Dfozq3TYIB/Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JG46NTIR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lGcBQ3u8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740742259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFOAyPs8KJsMgBeOv5FpvM0b6wG7d3Dwofmw3MNakFs=;
	b=JG46NTIR2ip0Ac0NvGc1rshBtmqmIfz0UAjnzJyxVy5pjo+TMWtUbteBcVR+ynwgxcIfCD
	fz8e2W66fh9EuyqPBCE9maj2b3mFnyTHxNC5unmPS0GBDE7KVswFaVkEwnMoLp934VeHQI
	v+OqPGkvOqP7kKq7rt+cEBKT6axK9/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740742259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFOAyPs8KJsMgBeOv5FpvM0b6wG7d3Dwofmw3MNakFs=;
	b=lGcBQ3u8G/QkZf+705VGpcgLJl4/8vjcrmnT9uWXXjOV+mUhjHLq88VMj9ryab0kWGESfU
	By7Dfozq3TYIB/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9FA31344A;
	Fri, 28 Feb 2025 11:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PA0rK3KewWeUdwAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 28 Feb 2025 11:30:58 +0000
Date: Fri, 28 Feb 2025 06:30:49 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] make sure IOMAP_F_BOUNDARY does not merge with next IO
Message-ID: <y6q34seo5spob2fc2swqtb4lfkasvnh6ku4hjjhxc5jxvsl4lp@k57svzmxmxb5>
References: <hgvgztw7ip3purcsaxxozt3qmxskgzadifahxxaj3nzilqqzcz@3h7bcaeoy6gl>
 <20250226181032.GB6225@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226181032.GB6225@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 0F51D1F37E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On 10:10 26/02, Darrick J. Wong wrote:
> On Wed, Feb 26, 2025 at 11:51:19AM -0500, Goldwyn Rodrigues wrote:
> > If the current ioend is built for iomap with flags set to
> > IOMAP_F_BOUNDARY and the next iomap does not have IOMAP_F_BOUNDARY set,
> > IOMAP_F_BOUNDARY will not be respected because the iomap structure has
> > been overwritten during the map_blocks call for the next iomap. Fix this
> > by checking both iomap.flags and ioend->io_flags for IOMAP_F_BOUNDARY.
> 
> Why is it necessary to avoid merging with an IOMAP_F_BOUNDARY ioend if
> this new mapping isn't IOMAP_F_BOUNDARY?  If the filesystem needs that,
> it can set BOUNDARY on both mappings, right?

Yes, you are right. Just that when filesystem wants to merge it would
have to keep a track. 

But that's fine. I have figured out to solve my problem another way.

-- 
Goldwyn

