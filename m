Return-Path: <linux-fsdevel+bounces-14254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C76879E80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 23:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6CE2847C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 22:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B974145642;
	Tue, 12 Mar 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QK/g5/sJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75862144026;
	Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282250; cv=none; b=h0IZEqlNIMlitTDLzGw5pG4H7VNq1CLNvmoZimPZoU5bHLTi8GixHsRJWkLT9ii4HhONIBsu1KRwMV4mxaG5aiQJ/SqfFI4MLzvCTHwF11yC95zL5ngfWKOPxb+Xkxwo7daNfn/qMTE9Qjt5rY6Ej8Jwu3/US5VxcH5WZL/kks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282250; c=relaxed/simple;
	bh=LosuX9ZhvMA1WGl8nF/mPMs/U1juaFButJhICfa/CTw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cvKiV3Dm2lMPEyKJFOLzgg+Fa8AHiNKG3vtlmjdFNb8XIMiaLboS+IwSjBWeL9rOF/XzjjuDlWQvppyEJgaypORckJBDmKODV5DqM2/QcRHiVzcUB+HMDQqAJFpz7SLHcv4mGEcdB2cBBBfV/wL6+x+vUV6wxSucibjwb+Djt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QK/g5/sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56B81C43330;
	Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282250;
	bh=LosuX9ZhvMA1WGl8nF/mPMs/U1juaFButJhICfa/CTw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QK/g5/sJ3S7n1ts/rLgNE0CyO8CK2zcoeyXww5hktI+U+PH5C6Q03b+jmXT73kliW
	 S3H0FBQPaA8ct3aLct+9jUnuq2rPkw96OEUcyWMMtf1KJFmqbtuuC1TgOUEQ6kNydx
	 wjOySWs3TSx0reuFjBqh9t/JliPJAoMIEYlS4PYxDKA7G4nIIqnPAfdFwNChCUgGJi
	 VHXWJGz0vVvhf5kMUJz2mfHnfKv08h0d7rySj5C3XzCfSlpte2wtdZJoNbzGv8KMqm
	 mLbND4sBZkQ3jmailPS7f1p1JZwhEW7F8wRpBYTFc2L4gLTXQySUt0ATOM/EpzwI3p
	 gYuXC364JVVBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F4ADD95057;
	Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240312041729.GH1182@sol.localdomain>
References: <20240312041729.GH1182@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240312041729.GH1182@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 8c62f31eddb71c6f6878258579318c1156045247
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bf95d567d67f8d78d7d2c8553025eaa02e1d9c5
Message-Id: <171028225025.16151.14766188702593707563.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:10 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Luis Henriques <lhenriques@suse.de>, Xiubo Li <xiubli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 21:17:29 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bf95d567d67f8d78d7d2c8553025eaa02e1d9c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

