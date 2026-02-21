Return-Path: <linux-fsdevel+bounces-77859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE8MHRkLmmlmYAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 20:44:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BDF16DB4B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 20:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE83F302B817
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 19:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E330E84E;
	Sat, 21 Feb 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjRdJowU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468D246BC5;
	Sat, 21 Feb 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771703055; cv=none; b=FGFarW4HRxR8r3otAzk/pl8fpAWpwI8A+8hlhhBGWVpUyYNXTwSrepjOkjYZ5r7pr0TP9Kmbnh6zhlM4KqQ/4VrGFXR4sHTDblqv2ce5Gu+aFkHFk2zqKklWxhf6wN48LMFLCayKqGXDm579JanSu81F1z9BpSNxV/gaxgYdDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771703055; c=relaxed/simple;
	bh=Bz42mS4nINBFpY1zgbijQciA8eCm/Tci8KwUrRAfnlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlKFxrJcTtEtOu9GSCCS15WDEfnm+To60MKTiPqEWySsFTvUjWQ+8Ep3PYzCt89Ec0Dt2Qy5wiYUbEc1u01YyrYTDTXGrWVU6YH6kJ4FvZ5rkGPQYXDk+LjAGA8aVCDhyW0YWjwrtassqzVEMT9xtJf6DcyP05iaD4H3SPEV65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjRdJowU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7132C4CEF7;
	Sat, 21 Feb 2026 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771703055;
	bh=Bz42mS4nINBFpY1zgbijQciA8eCm/Tci8KwUrRAfnlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XjRdJowUeJujb+nzZjrFgTNx4IBh9BGCWdkMA/MqEkgwnPYHe4+yhcw7kBgiXuHXL
	 b+EhdyDouWWjazyhDJ1Q5O9wSzVSyicEBcxxuYYRLFD/28y6cJHtDMvyd7qK+3NMm/
	 AWPPKJnRFdybBakZcm7WVtdB5LvYT9ykfWWagf3zN8OeqLpvhccqcRAV8C9TINvTq8
	 /i1YCJUCI7lugGG75mltIL8L/RyUhUywbHHGx4+2msanggMZBFoe1VdBZY7fmiP4NW
	 kmQFclFS5So7WfVXGavsul7ECOQ5zVYH1xJ6nQij0MyQWwUXpIupJ7Z4EMdZRRddu6
	 9RBhEva+gcqkg==
Date: Sat, 21 Feb 2026 11:44:02 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] fscrypt: pass a byte offset to fscrypt_mergeable_bio
Message-ID: <20260221194402.GB2536@quark>
References: <20260218061531.3318130-1-hch@lst.de>
 <20260218061531.3318130-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218061531.3318130-3-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77859-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0BDF16DB4B
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 07:14:40AM +0100, Christoph Hellwig wrote:
> Logical offsets into an inode are usually expresssed as bytes in the VFS.

expresssed => expressed, in all the commit messages

> /**
> * fscrypt_mergeable_bio_bh() - test whether data can be added to a bio
> * @bio: the bio being built up
> * @next_bh: the next buffer_head for which I/O will be submitted
> *
> * Same as fscrypt_mergeable_bio(), except this takes a buffer_head instead of
> * an inode and block number directly.

Above comment needs "block number" => "file position".

(Or "file offset" if you want.  I think "file position" makes more
sense, given that the variable is called 'pos'.  Either way, "block
number" is definitely wrong.)

- Eric

