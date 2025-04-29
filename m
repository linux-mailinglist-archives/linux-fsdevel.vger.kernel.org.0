Return-Path: <linux-fsdevel+bounces-47648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9070AA3B93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 00:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169D67AD3D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4482A277013;
	Tue, 29 Apr 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTLqpQvh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F42741C2
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966145; cv=none; b=FfAkEKeg8lY4TtjstTxbJfb7QHnKi82E5fUtsdP5PoLsnBwXlh62nf+JujSezicDskDaWO9nHCD6QIMsbTXQ1h+pZOcg/m/J+8kcVd0Vspx3hj1ublbfrxbyMPxgTh44HNHyJIYNJ0YsigldhW7FM4cXT1Rc5uVSxaJVOn8TOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966145; c=relaxed/simple;
	bh=/UkGqdtBXcEaYD8nJD59emMywhRPDJmcUqd7ds38I5o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bPS71/u3cOAnq/hvP8b0BZXlFqhifLH5I3adFaWEZpYzSAZrP7sse9kKn0LJdy00da2v5CmfqzYRYaCjiW2xG7IkMvVr3RYN4kvpIXKOd1mom0jxBBfVX7VTZ3ntSh66U+ldIUUnKnRDT5Pf3qIQrCE7XFlBmKpe7iSWRWnQYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTLqpQvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C78BC4CEE3;
	Tue, 29 Apr 2025 22:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745966145;
	bh=/UkGqdtBXcEaYD8nJD59emMywhRPDJmcUqd7ds38I5o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VTLqpQvh+QNBjJwx46RK8QcqnUzC8H36qZK1GnVjb2l7u/7uJCZE6BVt07PIujwd5
	 TgMmQzpn+F1BnJPCS0ZluqXf7acfLZkvXKA7hUujOgSviUgUBvJfcn1vZw/j4f5llf
	 1wLG0q01RAGSAxno7EkviGgHE4qQCYuVf1ESYOGufF/5o7d4Gxw9b/5uT4AsbWJw4c
	 V6//OQGoV7d5ykxtmfZOn/SAZ1ETQ9xuF+8RtSCd/2Q9D7gqt3Cxn5+XMuP9y3qedc
	 NXv8tKDSpv2dTVgfoBsfzpiNFe2XlIV4CgQ8WeMiTLCKqETxD1JiiYidPFhj3MAucI
	 zlYfDEVccf+1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EA13822D4E;
	Tue, 29 Apr 2025 22:36:25 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify fixes for 6.15-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ft5yy3ybidt6qu6udj6votzl4danrptyfush55ylt5f6qu76pz@saecmj4jv7ez>
References: <ft5yy3ybidt6qu6udj6votzl4danrptyfush55ylt5f6qu76pz@saecmj4jv7ez>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ft5yy3ybidt6qu6udj6votzl4danrptyfush55ylt5f6qu76pz@saecmj4jv7ez>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.15-rc5
X-PR-Tracked-Commit-Id: cd188e9ef80fd005fd8c8de34ed649bd653d00e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fba784cc9e3d22a530211ef3ec60d04562349cb4
Message-Id: <174596618393.1816670.8798551625679112951.pr-tracker-bot@kernel.org>
Date: Tue, 29 Apr 2025 22:36:23 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Apr 2025 19:58:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fba784cc9e3d22a530211ef3ec60d04562349cb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

