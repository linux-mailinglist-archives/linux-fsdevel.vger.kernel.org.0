Return-Path: <linux-fsdevel+bounces-77627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFuaL5YylmktcAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:43:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD0415A59F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10A4B300D0CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 21:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14382F1FF1;
	Wed, 18 Feb 2026 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAV0VI9Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0B2ECEA3;
	Wed, 18 Feb 2026 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450920; cv=none; b=MGZHUdG2HPyp6LIul2WkU4oYu7oZ76YI2clt1QSqrr/LcNvtAuFl8plDFFskTYKWS0UUDMAfJSaDJWg+RTsTUzv0C0X++uzcrYbsqBsIvyU034PjjWrHXt6yzptgkUPZN2HnC3V6ccUbBbO/yhm+8OD/SWfep5Wy8JO+IU7gtCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450920; c=relaxed/simple;
	bh=ukY7bBo0chcEMVe4h46kGLrEvBD0TG31XgNzOAIIpjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr/fXh4QAmtYQOhVHOPdzPNHloRQVRwcGpUv0yN92aaPQ2smFM9RcW/1YwFJezv9XiotACnGJIok2s8h8hPBIqNEF54KdM5Pnk/m9QT6nEUf4sq2wUaPtQdIfVglo7R0xHEXD3dMjx+9JQ0kHVwrQ5jqp2zRKJlIi5Zh+jCqO9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAV0VI9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749DCC19421;
	Wed, 18 Feb 2026 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450919;
	bh=ukY7bBo0chcEMVe4h46kGLrEvBD0TG31XgNzOAIIpjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sAV0VI9YYrPVxmpE0YEZQDaiS/GThY+EiN9okF03OiSoQEFNDzSjQAVDJFHAR1Po8
	 2/cn6AMbnwiDQajsutF53HZLyIFt4f7wvBOVtxDbHCQIqV5j/Z6UjDr6VQL1YdLq10
	 2i6ShygnIT71xROjGChmEZ7j/DOhl0g6IWkB66DORzFTkykBO8q7WvbreR/zRsHa2O
	 69LLGSRZ8C72AFBWWUl692vOPh9Yfp6FrHTJ/zksKLGiEoSKr4SKALjUiMoTEBrnt5
	 smTET6azZvSaWLuaxGz/BV21YNL/zyDk+7wuu42SNtdWABgc6nFlFn8ktILAo6ypYb
	 M+WtGtnt9M/DQ==
Date: Wed, 18 Feb 2026 13:41:57 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 0/3] fsverity: remove fsverity_verify_page()
Message-ID: <20260218214157.GC2128@quark>
References: <20260218010630.7407-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218010630.7407-1-ebiggers@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77627-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DAD0415A59F
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 05:06:27PM -0800, Eric Biggers wrote:
> This series removes the non-large-folio-aware function
> fsverity_verify_page(), which is no longer needed.
> 
> Changed in v4:
>     - Split ClearPageUptodate removal into a separate patch
> 
> Changed in v3:
>     - Additional scope creep: verify the entire folio, switch to
>       several more folio functions, and stop clearing PG_uptodate
> 
> Changed in v2:
>     - Made one specific part of f2fs_verify_cluster() large-folio-aware
> 
> Eric Biggers (3):
>   f2fs: remove unnecessary ClearPageUptodate in f2fs_verify_cluster()
>   f2fs: make f2fs_verify_cluster() partially large-folio-aware
>   fsverity: remove fsverity_verify_page()
> 
>  fs/f2fs/compress.c       | 11 +++++------
>  fs/verity/verify.c       |  4 ++--
>  include/linux/fsverity.h |  6 ------
>  3 files changed, 7 insertions(+), 14 deletions(-)

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next

- Eric

