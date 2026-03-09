Return-Path: <linux-fsdevel+bounces-79877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGOvHywxr2kYPgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 21:44:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAED24108C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 21:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A8863088604
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 20:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996AC36C5AD;
	Mon,  9 Mar 2026 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pECjVXrp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF8349AEA;
	Mon,  9 Mar 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088992; cv=none; b=fv/1ViK7NNx4olOiFD8j2K8sDch65FGmGz6SkVAJsrz4fDpfybqonE//jyXFZ+pCL5lhn70CHUBn/AukGlaaniTulvbMyxEkRl/g+nFifRlnBFFwuI5SH9SSFEj+kItENVw2P88XcIB0mfKpuhPZevW4x07NMiJzwzhS1X5VwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088992; c=relaxed/simple;
	bh=LgbkmLMqtuYdFY11z23RJwEuy3ulRqnM9TgZfuz+WJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUD8zGPwRuBf1OC/g05J6H5XwWa22i+4FfFcyS+rNuXPinWqBzfyaMO7M4ZPBSavIdFb/Sb+KtOBHTO4ZaATgHnyE4gGsWUnb1CKb6T5N94vRbZv0FpubrNdoOJqBR9rrLY7Je8DrvS5Mmd/A0jCNXXIw7Vtf2jaVK6iPRoa40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pECjVXrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EB9C2BC87;
	Mon,  9 Mar 2026 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773088991;
	bh=LgbkmLMqtuYdFY11z23RJwEuy3ulRqnM9TgZfuz+WJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pECjVXrpy9OUbNbNVsH0KaVo3LTgKu7FDofzwVvojZhIC+oT6MSC7DHR8ef/by7ob
	 6itzmOmMCDtY972OYbTjZloNCOdo12p/r7AZtpteRKJldBv5Y+dkbk0XAiZSauZaWk
	 Ry2KCfqFQjZQLW4k7GutSWPCjM9o/zS1hAdjswBVo+dSe9ObPKKDYWs1y1+2WcrNOk
	 1f0DEmAI22rCPgKEbpxbYJWLJWj/5Ivx/yvvdTN+kraZXbARq5F3NAo1aTaKxeBiux
	 X4cY4t6ohPYFgAmqCeHJEO1LYVn9h3S5DBWKYllkI67xDjgNSpHQLz/IaIjfboBojx
	 izjvSIggQsg4Q==
Date: Mon, 9 Mar 2026 13:43:09 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: fscrypt API cleanups v3
Message-ID: <20260309204309.GB2048@quark>
References: <20260302141922.370070-1-hch@lst.de>
 <20260303223507.GA56397@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303223507.GA56397@quark>
X-Rspamd-Queue-Id: DDAED24108C
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
	TAGGED_FROM(0.00)[bounces-79877-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 02:35:07PM -0800, Eric Biggers wrote:
> On Mon, Mar 02, 2026 at 06:18:05AM -0800, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series cleans up various fscrypt APIs to pass logical offsets in
> > and lengths in bytes, and on-disk sectors as 512-byte sector units,
> > like most of the VFS and block code.
> > 
> > Changes since v2:
> >  - use the local bio variable in io_submit_init_bio
> >  - use folio instead of io_folio (and actually test the noinline mode,
> >    which should have cought this for the last round)
> >  - add an extra IS_ENABLED(CONFIG_FS_ENCRYPTION) to safeguard
> >    against potentially stupid compilers
> >  - document the byte length needs to be a multiple of the block
> >    size
> >  - case to u64 when passing the byte length
> >  - move a hunk to an earlier patch
> > Changes since v1:
> >  - remove all buffer_head helpers, and do that before the API cleanups
> >    to simplify the series
> >  - fix a bisection hazard
> >  - spelling fixes in the commit logs
> >  - use "file position" to describe the byte offset into an inode
> >  - add another small ext4 cleanup at the end
> 
> This looks good now.  I'll plan to apply this to fscrypt.git#for-next in
> a bit.  Other reviews and acks appreciated.

Applied to https://git.kernel.org/pub/scm/fs/fscrypt/linux.git/log/?h=for-next

- Eric

