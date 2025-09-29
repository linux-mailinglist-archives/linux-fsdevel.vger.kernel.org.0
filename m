Return-Path: <linux-fsdevel+bounces-63059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736CBBAABED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 01:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC3897A5D7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 23:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0227A465;
	Mon, 29 Sep 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K59uWTLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87A2798EA;
	Mon, 29 Sep 2025 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188165; cv=none; b=h/ZxqUIGD0ePMMnAinqlVvufzZxKxp1fztRsM7Qp4RA2guI+fGgp7+8uKtjPot6UfBBHwh3vKi9xPmCRrGjXT8lzvD8Rc4oaSPp81gOLx73qX+4GPDlRb2ts+wWnIKNAX1W+HxrXp2zjc5b1QTxQeYg01ifdluUHYibdGWEMu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188165; c=relaxed/simple;
	bh=0CkCUb5AHrwCbhgs0TmfvUpsJAwk/C9c7DyoA3JVUnM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FmGwSyEp7y0LDIT0ROiV9H7B5Tx+AilIek6F6Euh6bHUPrSq2evfoQKw0uVWccFHWJbhkQSlsNXHqK4XKxDPCjXRRWVfQs6/c9b/BvQef/bEto27jQnvvwo3LO2FlSNrF86412E2cf983PrqKUZ/8qTkXahecDm5JLSOStgvLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K59uWTLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DAAC116D0;
	Mon, 29 Sep 2025 23:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759188165;
	bh=0CkCUb5AHrwCbhgs0TmfvUpsJAwk/C9c7DyoA3JVUnM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K59uWTLbr7ZLPvRG8+y/aDM38kVDVvLVdUd7N+hyR0NxhN3B6sScQlBsOygk1y5Gz
	 qQC7h12Mu0nsNhmUT5RELc7YIcKQLsumuEGYPbks37vXYHRYH9Yjrk3E4KUNbgG5v+
	 7O63LH1TCzLXdwvCyqyFTssZLtOgzdntJE1KmvYq41Ske+gK95J+cLCL+r36XIJW3y
	 VkToja4he4QrqcW9cBbzty9U6kBhmCPsYOHdS4OiboIQVAqdnorUlj5Ph3XHP4aftS
	 X39M/zgUe3Oey0kGlYZxlcxZ886O5kT4OBQCEfG2LcMLXgnn/NqsMNYafsmNo+KPMF
	 VZNCBxesad/zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBE39D0C1A;
	Mon, 29 Sep 2025 23:22:40 +0000 (UTC)
Subject: Re: [GIT PULL] Interleaved SHA-256 hashing support for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250927202410.GC9798@quark>
References: <20250927202410.GC9798@quark>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250927202410.GC9798@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: a1f692fd69ccdbe1e492d366788b63227d429753
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1896ce8eb6c61824f6c1125d69d8fda1f44a22f8
Message-Id: <175918815909.1748288.13275666248310794325.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 23:22:39 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, fsverity@lists.linux.dev, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Ard Biesheuvel <ardb@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Sep 2025 13:24:10 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1896ce8eb6c61824f6c1125d69d8fda1f44a22f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

