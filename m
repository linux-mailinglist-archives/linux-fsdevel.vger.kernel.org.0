Return-Path: <linux-fsdevel+bounces-63060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6373BAABF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 01:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D7919233B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 23:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0303F27B331;
	Mon, 29 Sep 2025 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ+BgYGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FF27A931;
	Mon, 29 Sep 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188167; cv=none; b=egxR5kKtp3m1lDgADNABWOuAqrYsn9+J1jnbU6OimxxfjYlROptALPSN8SCBDiycpCxREGy0kgFBKYbSzpkdquTq7yKKIpOs6evMtliEp4kCTZEmQaxksF7816y5BTVyA2F3ZR0t7uim3oMND4JDPzQH33k6jNGh5x3l1Yar6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188167; c=relaxed/simple;
	bh=o0ZGzI+g/wnKTHPMBTgAc8yEVs13ZfZTTxioj2gkq4k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oJvBFbUplnx68km0/Z6sfyCfBTJ2tJoUvzLQoJF537HskzFwYX+gsjMbzC2R8DoWignLuWg24T9BjNBMz3LWlzvz2++4IVIJBB7dspzjisk2NEYpQwUa5zGZSwbdfrpZVkyLL1fweWWITtbSNgQvxha2A296HSkaCeluVIAGQv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ+BgYGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F566C4CEF4;
	Mon, 29 Sep 2025 23:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759188167;
	bh=o0ZGzI+g/wnKTHPMBTgAc8yEVs13ZfZTTxioj2gkq4k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IZ+BgYGgHui8cXvTAsLJhgOlxG0lLBsEuueIgRPuyh45H8gCUPF3toCzIaA21anhv
	 8289DrRJqehGWpgaMVbO1ObDeagMQM07PQLBLL9Pff3PzahpYH+UuwoSBhaAoYsioj
	 o+jcHxDULmBgLvO3W0DoaPqTnCORLmBV6l7MHQGfkZVNpuGshEeG6H4GVaDp3X5gg7
	 9Uyf9teYSpGsnKZA3/95jhxNHI5J+yt3kJyMLEPZGE2fV6cmNfhsynAfLQLgws5ipv
	 yBMOc79mEvuKwnfmXKPiuUv6220KA6MlhScnvwR6ikC5mkxEhFiAh290HBJh+YUyJU
	 0Jdl3+Aj+heEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACBC39D0C1A;
	Mon, 29 Sep 2025 23:22:41 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250927194816.GA8682@quark>
References: <20250927194816.GA8682@quark>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250927194816.GA8682@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 19591f7e781fd1e68228f5b3bee60be6425af886
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d60ac92c105fd8c09224b92c3e34dd03327ba3f4
Message-Id: <175918816064.1748288.10365511471361491976.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 23:22:40 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Qianfeng Rong <rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Sep 2025 12:48:16 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d60ac92c105fd8c09224b92c3e34dd03327ba3f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

