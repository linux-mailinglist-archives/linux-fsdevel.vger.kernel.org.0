Return-Path: <linux-fsdevel+bounces-63453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C4BBD079
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 06:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C14218927FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 04:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CA71C3C1F;
	Mon,  6 Oct 2025 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANF/kjmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E343595C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759723838; cv=none; b=FNsSz0AQBf8YNoENljIbF9ZT8EhEFB0wPJ+Wj2DfUw826HQT2PpBVyk+fL8iLVGwmMxhPjQaNvMo3Q1rCoWD9dlyu68Eca6rAfi4f02dvJd3U/SuSyd2aoyZWUWN7W8q5Gp10PH00jVSKLJToZZi/86qzExfREmETQ1m8NshbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759723838; c=relaxed/simple;
	bh=6ajGqv7AyRpZeFGSx/wH10c3N0GXWi0C9UHzf5TtCd8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iLHkcOETLyolQqlo7UfjtlQZRQGUiiyPwurhNiMIOKeuFpMYDg7fLefBScAUFVtgkxlWk32a97rWizc8pHKbkL6HPOM+POb7Fxgt9lXrEgw+anXn+ExweVQm1oE06m/23aezX9fdQW70vdoqAVvjK98hGGImYMGaeojsjllXXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANF/kjmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46499C4CEF5;
	Mon,  6 Oct 2025 04:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759723838;
	bh=6ajGqv7AyRpZeFGSx/wH10c3N0GXWi0C9UHzf5TtCd8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ANF/kjmgYv3bW0XRbS6c4qsH/sf1KpB5X6faFav2aDGfV43U8wFVu7UzyVv0kkbA9
	 kkxtbg1EhNXMCD3LxsdDCzyNcjAHUamnKH/VU/DuRtGOXvgMWNwMhOhjCHK2T5CzjJ
	 5YPKdbAgRgO+i1lbLT/nOhiQ2T099XF85R8zh0CUCJxTDukcAPvdUQR7iWwMeZdPTl
	 mH1+xDzCXtK+rsN7BrU+0dRAS86nS0dAxKcnb5rQcu1maMBkWZZi0jV/o+ZSFkossM
	 +6CFLVPpnDfwBWfqFCS1ndmtk2p1ztIW1BOhrZ0yVmZMJkVniR6j8EYr7p3q8PvHoN
	 F+k68ynwyDcnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D3739D0C1A;
	Mon,  6 Oct 2025 04:10:29 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs changes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251006023826.272105-1-dlemoal@kernel.org>
References: <20251006023826.272105-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251006023826.272105-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.18-rc1
X-PR-Tracked-Commit-Id: a42938e80357a13f8b8592111e63f2e33a919863
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd94619c43360eb44d28bd3ef326a4f85c600a07
Message-Id: <175972382811.830166.11871042542404900894.pr-tracker-bot@kernel.org>
Date: Mon, 06 Oct 2025 04:10:28 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  6 Oct 2025 11:38:26 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd94619c43360eb44d28bd3ef326a4f85c600a07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

