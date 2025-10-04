Return-Path: <linux-fsdevel+bounces-63420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C814BB8758
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 02:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9413A348AFF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 00:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170314F70;
	Sat,  4 Oct 2025 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL+zrO89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC532EEAB
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Oct 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759538649; cv=none; b=oZFeuHc3KtzP/Vaejg0szMFzePFbmufxDUKqmQiSrJYATSDL4kd8D2wdHQseFxIdf6/V2GOIl0gRhJeW0w+K62xeGMpAI65AmTTyR0RgE1kmQvMeiMi03e+O2FotyBo/zvrB93AEphO9cfDM03XswpVQZA8i3WJ6/hIHur5u7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759538649; c=relaxed/simple;
	bh=flVL6uTAhoY7Cv7M9eQ1yHEX2OqNrG7cuum3RxyZ0KI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NEIuxOr/7Gbhag6edeK8Dqb5HnCTuGR8s2N1uGg/cjgzAjPPossyCUziAGkB17zVt6rIdDBqfEWoifKNsCmol9qHAbzgliV6d1HF7lUqmXDUS1zyk7Vne4ocQWzpUbD0JNa+dsFVH8IWNxiLyeHdFaj2mg9eDrsTcUW4IV+9TVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL+zrO89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDADC4CEF5;
	Sat,  4 Oct 2025 00:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759538649;
	bh=flVL6uTAhoY7Cv7M9eQ1yHEX2OqNrG7cuum3RxyZ0KI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bL+zrO89dChXbFKAj+kib6Z/z/5jKFAQVF6Kl62k8SSU+SjWYNDRWORmdaaMR3JjN
	 c0UwOgek8lPw9EK1EGa1PeN3ihzUb1mqNkyGEepRnVwY1RxZrwbwQvO8tcyygpKRuy
	 0kV8Zzildw3mZ+UN4ksP6x4G4iGRvlqM/y+gHWQB/BUfKdOlcMzQTxAV1R0CBojFY0
	 PKOkY95EpZlsGOQw8aWB4/JILczjYs5DLukvbpQCeANp7IdYu2l7Y6M1RxZIjcfdV9
	 6330GIRbJjDSsC46G2q3/aj1/1OXsWXpnUyDhwdxVNqbmQ4OMlRY+dRaf9xMkEopdM
	 gLB1yxAfw3zlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0E439D0C1A;
	Sat,  4 Oct 2025 00:44:01 +0000 (UTC)
Subject: Re: [git pull] pile 6: f_path stuff
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251003221558.GA2441659@ZenIV>
References: <20251003221558.GA2441659@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251003221558.GA2441659@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git pull-f_path
X-PR-Tracked-Commit-Id: 2f7d98f10b8f64525b2c74cae7d70ae5278eb654
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50647a1176b7abd1b4ae55b491eb2fbbeef89db9
Message-Id: <175953864053.132476.13453428282617421391.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 00:44:00 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Oct 2025 23:15:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git pull-f_path

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50647a1176b7abd1b4ae55b491eb2fbbeef89db9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

