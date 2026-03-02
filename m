Return-Path: <linux-fsdevel+bounces-79078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG+2F5UQpmlRJwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:35:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B881E5A10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 426B532A705E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904F1367F20;
	Mon,  2 Mar 2026 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY1V/9ui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376335839C;
	Mon,  2 Mar 2026 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486558; cv=none; b=r1eJa7GXC748sYAsm6MWvKt8BmyYbLBcku9+oKMEZqMp7BBE1vAbX9OwRZGZhQkA5efzPAsz8WlwBXRJOgtdXMQ2sduVkhskXctviQsGO04ho9aQLziYidLQn/GlTwL01Ux8AsoM4NNK0nU715/0E1hCUVnIOIvlWiIhyHqkEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486558; c=relaxed/simple;
	bh=Pn1jPGIRlVHAju0AHvthXcgYRhzb038ksmWizmribQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCz+a9kL4uPd2Hw4QbxLlQm6RzqtPQe8EoG6UT51Kqn9xEVSNBJaB9fTC0JEjX11ePCUrHoqYyV9cX/6b6WVkrpR/dawHjd6Q9KBM3dcXMdnO4d52VRL67CNRK0gPAG5irMnoT/Z173MtkygwELz4dsaxzLKKoghZn1aliBhnoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY1V/9ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EB3C2BC87;
	Mon,  2 Mar 2026 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772486557;
	bh=Pn1jPGIRlVHAju0AHvthXcgYRhzb038ksmWizmribQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LY1V/9uil18+NICv26w5dG7rNXEyvH9CWx0Jh1wiee3o4y8py5BphImQVthyWfFn/
	 NUYJGS/nscwFRvzP11D0+4YFHsOf2iAisCh8tpCxVx3ys8w6Tps/EwXihKOF14jpgl
	 S4bWVsjtVQFzW/8YdbULURlgA903eugBsTH89mo6pbvpcEWG2G/jzY8abUutx5ie2x
	 sZ+coF8cNJ5XKdlsp2HW5+wmFKj2wza17yywli6dIq5LB8g5GX05W+WtDPROLtdsNb
	 KyEBpzdbqLFQEO9ORqo+QAq+Ve5z+36XvEXBL5DSsnyKt+0rm7wYjeTd4tJ5SK5+hJ
	 gZGw3ABi1B7wQ==
Date: Mon, 2 Mar 2026 13:22:36 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: dropping the non-inline mode for fscrypt?
Message-ID: <20260302212236.GA2143@quark>
References: <20260302142718.GA25174@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302142718.GA25174@lst.de>
X-Rspamd-Queue-Id: 63B881E5A10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79078-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 03:27:18PM +0100, Christoph Hellwig wrote:
> After just having run into another issue with missing testing for one of
> the path, I'd like to ask if we should look into dropping the non-inline
> mode for block based fscrypt?

Yes, I think that's the way to go now.

I do think the default should continue to be to use the well-tested
CPU-based encryption code (just accessed via blk-crypto-fallback
instead).  Inline encryption hardware should continue to be opt-in via
the inlinecrypt mount option, rather than used unconditionally.  To
allow this, we'll need to add a field 'allow_hardware' or similar to
struct bio_crypt_ctx.  Should be fairly straightforward though.

> I did a few simple fio based benchmarks, and writes are a minimal amount
> fast for the inline mode, while the reverse is true for reads.
> 
> The big blocker seems to be this comment in fscrypt_select_encryption_impl:
> 
>         /*
>          * When a page contains multiple logically contiguous filesystem blocks,
>          * some filesystem code only calls fscrypt_mergeable_bio() for the first
>          * block in the page. This is fine for most of fscrypt's IV generation
>          * strategies, where contiguous blocks imply contiguous IVs. But it
>          * doesn't work with IV_INO_LBLK_32. For now, simply exclude
>          * IV_INO_LBLK_32 with blocksize != PAGE_SIZE from inline encryption.
>          */

I think it would be pretty safe to drop support for IV_INO_LBLK_32 with
blocksize != PAGE_SIZE entirely, given that that case already doesn't
work with inlinecrypt.  The whole point of IV_INO_LBLK_32 is to be able
to use eMMC inline encryption hardware that support only 32-bit IVs.

I should have put in this restriction from the beginning, but I don't
anyone will care if it's added now.

> from touching the file system callers lately, the only obvious place
> for this is fscrypt_zeroout_range_inline_crypt helper, or did I miss
> anything else?

ext4_mpage_readpages() for example seems to call it only once per folio.
It was cited in the original discussion that resulted in this code:
https://lore.kernel.org/linux-fscrypt/20200629182250.GD20492@sol.localdomain/

> Does anyone have a good xfstests setup for the IV_INO_LBLK_32 mode?

Unfortunately not.  generic/369 does use IV_INO_LBLK_32 and verifies
that data is being encrypted correctly, but it's very unlikely to
exercise the DUN wraparound case.

The test_dummy_encryption mount option could be extended to allow
something like "test_dummy_encryption=v2,iv_ino_lblk_32", to cause the
test_dummy_encryption policy to use IV_INO_LBLK_32.

- Eric

