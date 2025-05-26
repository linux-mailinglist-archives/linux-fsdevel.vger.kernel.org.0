Return-Path: <linux-fsdevel+bounces-49873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CB8AC44B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 23:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2902017B845
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 21:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9924291B;
	Mon, 26 May 2025 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rp7RU9Vt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26423FC74;
	Mon, 26 May 2025 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748294377; cv=none; b=A/iWCmwEbUBsFXQzR3+sJgvN15uj7rdZCW8dunWn7qCxEgC+C3pWV9uLGLLJodEhPP2kpcQps/kEuSHuB5rYKUcT7LaJMiiUaz0OrGO9D2oGcCq91UZ7+MXMIvMF5aV9A3GkEYsSEwZsrqFiO8WDf8mp9kuisZUnGgJUKkFzghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748294377; c=relaxed/simple;
	bh=55RHTqjxFPps4bWXmQvG/ltqDhb9qkxLQ2n7TN75cJw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U35OtScw/rY5xtCWP+hkS3H4mTVu+z0csaGEJL+sQw9eSGi+qWt2JjMPtjU58I0IQzdI+pVlSkD34tgPaOTJx5uPPFuhtQlPKMZvlfbgBIOwcYYDee/Cyr6EbxRMi+4JFxLclTYMW31gcMbEpoo5fmRDBswMeozj5KBNHFKmJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rp7RU9Vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AE4C4CEEE;
	Mon, 26 May 2025 21:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748294376;
	bh=55RHTqjxFPps4bWXmQvG/ltqDhb9qkxLQ2n7TN75cJw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rp7RU9VtXlusRahdYSksxE9lLtV9HOJr42BezDr9peiaiZnBSY6kyMiNy9HcVtbno
	 GHPXBqRDPy/VnxYpvZzH1hu+O8Ns7Qtm/cY5tthKpTaa1Nx+fMGXv+e8x6A/PbBbdv
	 QMpGIKEn7mRJHI/Sp6QiorBuBAYgRQ9L1M9l4mAL9M9TrIDIFRJPgJn3mCYHgaqbJ0
	 WMfn311LS2+2SjNkyNWqCU/NrgPSdoGBeKQOImmXh5zc+8rjR6zDwrTvmr6K5DChGP
	 chafSzXsKq6cbk9BVRAirpq/TcqnkmfA5WXK2jy/+YXNbjnrzF//rpzTpK6pRjoIXj
	 TJh+vKC8R63Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9F0DD380AAE2;
	Mon, 26 May 2025 21:20:12 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt update for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250526011159.GA23241@sol>
References: <20250526011159.GA23241@sol>
X-PR-Tracked-List-Id: <linux-fscrypt.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250526011159.GA23241@sol>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: c07d3aede2b26830ee63f64d8326f6a87dee3a6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14f19dc6440f23f417c83207c117b54698aa3934
Message-Id: <174829441147.1051981.9323787415682692074.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 21:20:11 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 May 2025 18:11:59 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14f19dc6440f23f417c83207c117b54698aa3934

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

