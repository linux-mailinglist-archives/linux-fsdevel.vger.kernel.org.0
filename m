Return-Path: <linux-fsdevel+bounces-77402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COz4A3falGlyIQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:15:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B7150A1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62CB0305E837
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92837BE97;
	Tue, 17 Feb 2026 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYDLMu4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D237BE81;
	Tue, 17 Feb 2026 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362880; cv=none; b=gN6Aax/TfZDbfMDdGh2w9TiYoHCLKDSrwtPVylpY7EGyb15L4yR0a73ku7kLCIifmjC1XKQBrmQwX5vSlgKhxQzb6Yo1y2zU/3Ga/TctSN5t4mwE0Y120y3iA6Ss9TMlY8SXPfd7YZUx1Bb/Gf8ukxqZfOycf++IMpEoeoHTg/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362880; c=relaxed/simple;
	bh=5PKRA6JisViHy/Wt+cxaLmoaEMt0eP0saSrcTq0zDDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s4c6R1RXfMrw6j8xL36caE97FZOcOWYBf1N49FLN7ZathaaJiWurbhxctj1Uw82tT6K1451+jP1L79T/SSYnvxTMzuO3aZ8A7sTdGTeFJZrZNyT+Tu12MlMT/6iBxL64SjrsqbB8eeFADrTgQKeBuIsPdkKUjGn4pENMuNDqIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYDLMu4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7486AC2BC86;
	Tue, 17 Feb 2026 21:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771362880;
	bh=5PKRA6JisViHy/Wt+cxaLmoaEMt0eP0saSrcTq0zDDI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nYDLMu4EsZ+ybxrnDEGJ0hhXnV3XzXDcAUNSHNW9WD1vmFRw7eK7sqfsOKZchNkdQ
	 iWsJ/BLiHUb1zxwbZEL53A4ROd5F5RqRP9DFRpxoPZxC1FyR+kM5x1EwCQVgd0y0uo
	 tspuUfkt+BOs6dctpP9v3K+aCf6rjdPBDyjEQQT9bBrqPfcwCo5B1KQWUmvdM4Lp0c
	 zidBp52jkgRn1EPdGPglSWNzNvdbSO+PMCdsh2+ny+JiD15l1swPfNY04ev2WRqD5o
	 BZwhk4buxzsV5HQ2f8JLto9W73xXwKDf1PPvdYpP9zuTIMFL0ZPl1XwUKdMii+xqQM
	 82YR0p6MUHM2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 84FE23806667;
	Tue, 17 Feb 2026 21:14:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 01/11] fsverity: don't issue readahead for
 non-ENOENT errors from __filemap_get_folio
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <177136287232.643511.13012047389860653614.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 21:14:32 +0000
References: <20260202060754.270269-2-hch@lst.de>
In-Reply-To: <20260202060754.270269-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: ebiggers@kernel.org, fsverity@lists.linux.dev, brauner@kernel.org,
 tytso@mit.edu, aalbersh@redhat.com, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, jaegeuk@kernel.org, dsterba@suse.com, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77402-lists,linux-fsdevel=lfdr.de,f2fs];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 810B7150A1F
X-Rspamd-Action: no action

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@kernel.org>:

On Mon,  2 Feb 2026 07:06:30 +0100 you wrote:
> Issuing more reads on errors is not a good idea, especially when the
> most common error here is -ENOMEM.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/verity/pagecache.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev,01/11] fsverity: don't issue readahead for non-ENOENT errors from __filemap_get_folio
    https://git.kernel.org/jaegeuk/f2fs/c/23eec9fd64b2
  - [f2fs-dev,02/11] readahead: push invalidate_lock out of page_cache_ra_unbounded
    (no matching commit)
  - [f2fs-dev,03/11] ext4: move ->read_folio and ->readahead to readahead.c
    (no matching commit)
  - [f2fs-dev,04/11] fsverity: kick off hash readahead at data I/O submission time
    (no matching commit)
  - [f2fs-dev,05/11] fsverity: deconstify the inode pointer in struct fsverity_info
    https://git.kernel.org/jaegeuk/f2fs/c/7e36e044958d
  - [f2fs-dev,06/11] fsverity: push out fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,07/11] fs: consolidate fsverity_info lookup in buffer.c
    https://git.kernel.org/jaegeuk/f2fs/c/f6ae956dfb34
  - [f2fs-dev,08/11] ext4: consolidate fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,09/11] f2fs: consolidate fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,10/11] btrfs: consolidate fsverity_info lookup
    https://git.kernel.org/jaegeuk/f2fs/c/b0160e4501bb
  - [f2fs-dev,11/11] fsverity: use a hashtable to find the fsverity_info
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



