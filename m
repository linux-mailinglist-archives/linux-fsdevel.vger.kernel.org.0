Return-Path: <linux-fsdevel+bounces-77399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN0+HHnalGl7IQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:15:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B17B150A26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52511303FFEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B3237AA77;
	Tue, 17 Feb 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb1sDYwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9837A4BC;
	Tue, 17 Feb 2026 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362876; cv=none; b=kfpkWzynNHlvYsSZYKoVjYSfbukXAxKyaDm6WZuEyCOMvCqYcRFdwCzhs989TYWz2TxV2j72+mgLLB9OytpiMqNIIweITqKXAGvxU2xCkRVGqtHb8cqF34QrThFJNxh0LjrCvwhV8R/St+Cmuu3MnXFtvjCMSuzKC1MRfAy49s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362876; c=relaxed/simple;
	bh=IUmsV+ZW94HXGIdU1vo18SjFXSfXhU6JnfKGHOOTBlE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VtD6OHNAOR/Sya+eoo9JUFSlVoUw77i3mfd0khFQG3PPh27clDyukXn2zkUtrkVObCfUl/Y2L9+PbHb7/b6zwJzKe04vqYEx9pwB7Aoh3snM3bfVlwLTfGo/20GnohzTzVWqaiPGurEWnji6PDClbiXr4h9V+so0OH501wJrtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb1sDYwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BD9C4CEF7;
	Tue, 17 Feb 2026 21:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771362876;
	bh=IUmsV+ZW94HXGIdU1vo18SjFXSfXhU6JnfKGHOOTBlE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sb1sDYwJavRLaCVn88gyrDrXlCl0VDnAf62EpkDuPznZMYdbNVtd73gzpyyfSdJ/a
	 WqACZhS/EGrPNEG45ARHMKVSGdP4aeQlnn6gf3sjgM1aEN6XQUPh1tFIPxa/SFcDZV
	 zg+JLJ84QRyz9qMMJ6QRwLumUMlXlT/vueB7bcmbanb6s6FW/imJ3kiNi93Qoh9O4T
	 yvIJ/cNS+jpX41ID+1Kh3XhScgnFe76gfOndPmsMTOoFu0qovNOVXnWM1GF4epkhvw
	 mpLacztvHIMGsbHj6XNwKmeJ8uOk0LCt6hh+EbNCXNDb5hYrgzVZHIt+ZOM+kqd7aN
	 rIRQXaYrAalKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851203806667;
	Tue, 17 Feb 2026 21:14:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 01/15] fs,
 fsverity: reject size changes on fsverity files in setattr_prepare
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <177136286807.643511.1738733092656907396.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 21:14:28 +0000
References: <20260128152630.627409-2-hch@lst.de>
In-Reply-To: <20260128152630.627409-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: ebiggers@kernel.org, fsverity@lists.linux.dev, brauner@kernel.org,
 tytso@mit.edu, djwong@kernel.org, aalbersh@redhat.com, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, jaegeuk@kernel.org, dsterba@suse.com, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77399-lists,linux-fsdevel=lfdr.de,f2fs];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B17B150A26
X-Rspamd-Action: no action

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@kernel.org>:

On Wed, 28 Jan 2026 16:26:13 +0100 you wrote:
> Add the check to reject truncates of fsverity files directly to
> setattr_prepare instead of requiring the file system to handle it.
> Besides removing boilerplate code, this also fixes the complete lack of
> such check in btrfs.
> 
> Fixes: 146054090b08 ("btrfs: initial fsverity support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,01/15] fs, fsverity: reject size changes on fsverity files in setattr_prepare
    https://git.kernel.org/jaegeuk/f2fs/c/e9734653c523
  - [f2fs-dev,02/15] fs, fsverity: clear out fsverity_info from common code
    https://git.kernel.org/jaegeuk/f2fs/c/70098d932714
  - [f2fs-dev,03/15] ext4: don't build the fsverity work handler for !CONFIG_FS_VERITY
    https://git.kernel.org/jaegeuk/f2fs/c/fb2661645909
  - [f2fs-dev,04/15] f2fs: don't build the fsverity work handler for !CONFIG_FS_VERITY
    https://git.kernel.org/jaegeuk/f2fs/c/6f9fae2f738c
  - [f2fs-dev,05/15] fsverity: pass struct file to ->write_merkle_tree_block
    (no matching commit)
  - [f2fs-dev,06/15] fsverity: start consolidating pagecache code
    (no matching commit)
  - [f2fs-dev,07/15] fsverity: don't issue readahead for non-ENOENT errors from __filemap_get_folio
    (no matching commit)
  - [f2fs-dev,08/15] fsverity: kick off hash readahead at data I/O submission time
    (no matching commit)
  - [f2fs-dev,09/15] fsverity: deconstify the inode pointer in struct fsverity_info
    https://git.kernel.org/jaegeuk/f2fs/c/7e36e044958d
  - [f2fs-dev,10/15] fsverity: push out fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,11/15] fs: consolidate fsverity_info lookup in buffer.c
    https://git.kernel.org/jaegeuk/f2fs/c/f6ae956dfb34
  - [f2fs-dev,12/15] ext4: consolidate fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,13/15] f2fs: consolidate fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,14/15] btrfs: consolidate fsverity_info lookup
    https://git.kernel.org/jaegeuk/f2fs/c/b0160e4501bb
  - [f2fs-dev,15/15] fsverity: use a hashtable to find the fsverity_info
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



