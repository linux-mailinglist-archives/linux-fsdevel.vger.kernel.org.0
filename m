Return-Path: <linux-fsdevel+bounces-35049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421209D0756
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 01:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A83B21967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 00:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43979282FE;
	Mon, 18 Nov 2024 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef20KjDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00F1DFD1;
	Mon, 18 Nov 2024 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731891276; cv=none; b=Emok2r48gJOmIgPt1K4GhcKORqJrlGclFVRaxEmIykfJyTNG2+SudkW55YUpHECYlUIfDbSZdlR1I+AvKyQlkIBkMgK6o9wuLPXrm9RIvABGRUTLQI3xCRyt/LVgGGu2yya98sP21SNcjp30QSiYmKvYT52IRxKLqpAmUFACpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731891276; c=relaxed/simple;
	bh=+mfZEmfDpvilp55+DEhzjae1Q5MvdDNXhWMFri7nCfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAjnxJ/8uSRoTuvQQYnAB2PpZ5pq7Y0vqc84VTCxaUQ/sEgHQW4waFPN9e6P7HcoIYKB+oLS2G1ec6DQFKlJq4WRvU35z2nN4EeyG3qAuPmAQ9nt2eI+EL2N8Xu0jwea5OVcK9SLIWUIGSlSCDhchlL4girQRkmBPN4ilpTwL5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef20KjDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1228C4CED8;
	Mon, 18 Nov 2024 00:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731891276;
	bh=+mfZEmfDpvilp55+DEhzjae1Q5MvdDNXhWMFri7nCfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ef20KjDDzJmoSAWjpsrqZzRdA8n08YSRc2YvAVXGCyyyG/0seVPqe4HOInWRbtbhL
	 MkxgD6XrPQxHFWA3kMQaSJOx86PfoUJYgnK15G3CuekybX7di7E5+X4ZelP57JdAbf
	 gA6SIbc1p9f2Qz7K+Xu/IlCpsJzOXzpbiRPBnCnz/UYjW1wDhXWAT5aZIV9TE/i6Nx
	 KOlv0SVg/5pCK27f3az6nhLzAVg720xy0qHhFl1A6sNZf7mFRUAbhf1EOdME0YdwOQ
	 zfZJQYuI8lorofif1FyoCf6CJqtSZZ185diu+Qni86brDkneB8rQ5rFbsmOklM5Cuy
	 kOGsUsRc9npZw==
Date: Sun, 17 Nov 2024 17:54:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20241118005434.GA3588455@thelio-3990X>
References: <e7xjq5qdnmh2rga5aymowasfe32harb3wqrpktisy3ynikaqyo@xtawzmqxidif>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7xjq5qdnmh2rga5aymowasfe32harb3wqrpktisy3ynikaqyo@xtawzmqxidif>

Hi Kent,

On Fri, Nov 15, 2024 at 03:35:16PM -0500, Kent Overstreet wrote:
>       bcachefs: Kill bch2_get_next_backpointer()

As pointed out by the kbuild test robot [1], this change introduces several
-Wuninitialized warnings:

  fs/bcachefs/move.c:814:36: error: variable 'dirty_sectors' is uninitialized when used here [-Werror,-Wuninitialized]
    814 |         trace_evacuate_bucket(c, &bucket, dirty_sectors, bucket_size, fragmentation, ret);
        |                                           ^~~~~~~~~~~~~
  fs/bcachefs/move.c:677:24: note: initialize the variable 'dirty_sectors' to silence this warning
    677 |         unsigned dirty_sectors, bucket_size;
        |                               ^
        |                                = 0
  fs/bcachefs/move.c:814:51: error: variable 'bucket_size' is uninitialized when used here [-Werror,-Wuninitialized]
    814 |         trace_evacuate_bucket(c, &bucket, dirty_sectors, bucket_size, fragmentation, ret);
        |                                                          ^~~~~~~~~~~
  fs/bcachefs/move.c:677:37: note: initialize the variable 'bucket_size' to silence this warning
    677 |         unsigned dirty_sectors, bucket_size;
        |                                            ^
        |                                             = 0
  fs/bcachefs/move.c:814:64: error: variable 'fragmentation' is uninitialized when used here [-Werror,-Wuninitialized]
    814 |         trace_evacuate_bucket(c, &bucket, dirty_sectors, bucket_size, fragmentation, ret);
        |                                                                       ^~~~~~~~~~~~~
  fs/bcachefs/move.c:678:19: note: initialize the variable 'fragmentation' to silence this warning
    678 |         u64 fragmentation;
        |                          ^
        |                           = 0
  3 errors generated.

I see you were already sent a change [2] to fix this but the fix should
go with the problematic change atomically. Build failures during the
merge window suck because they potentially hide other issues. I have a
further comment on that patch that I will send shortly.

[1]: https://lore.kernel.org/202411171154.RatlgkMz-lkp@intel.com/
[2]: https://lore.kernel.org/20241117234334.722730-4-pZ010001011111@proton.me/

Cheers,
Nathan

