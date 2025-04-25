Return-Path: <linux-fsdevel+bounces-47422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C517A9D644
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 01:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EDD4C6965
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 23:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2C4297A5E;
	Fri, 25 Apr 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEGIJO86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62570296175;
	Fri, 25 Apr 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745624096; cv=none; b=bKLqMG/q12wZIE0vhG8Er4FIbN++0OLYqRCEiaaABedNXIpV0CV0a5fpUzP/tSv2zzW5ZxnKnJn8hcQChfg9Wf6c1n+Ka0MVyITypsiiuSGPH6/unkXiuQtFq7CgKv3NGejI7yLPBrdSBHMZEUZjCsFYspDCHGqnEFQF03qX/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745624096; c=relaxed/simple;
	bh=CazE6Yt0BobYKcChm8Ix9TS+hLRlPKanHUQJdYTZIqI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bEhfeeWFyon9DSbGqk1CaDFsRIGiDuTl2O270TdVL/PS06Lyoq8aknsUvAJSc4fEmZ3n68Cd+Jnp/Z5L9HkVhz6r4+3aqO5w02/z+dkLFBcOQChaN/4LopXCbSuiJJiGROzpGVi7Tz3zzpYg+qVEoIQNSKG3odRuNW0B+PFa9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEGIJO86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431B7C4CEE9;
	Fri, 25 Apr 2025 23:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745624096;
	bh=CazE6Yt0BobYKcChm8Ix9TS+hLRlPKanHUQJdYTZIqI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FEGIJO86RG1aOI8rDVZU4X2WVKaB+43X+KNb5Bo0mXDRFA5MZTCkPFwzaQBQrf8AB
	 aZB69IR6liGh9kNoJPwoUYVA98Xvt9Us4S8gT9POGdKD/KzcL1FlCwgTbbf9nl+Noh
	 dR+I0JwjHREPolCtLaopApqtGvxSuIt76U3m88Dxn5KStYklq9feiWo6xlrVZauZdz
	 AT1pikwllytU3GUjW/GTOy4kkqc7nJ2OEHrEp3NStDUqohBWqDP2kVqOMK5M8dSBuY
	 +Bz+RDusbOaF/cs2AKSBd2aDWWpYxiV1nVoabZcwP1Cq7VSNSh7TyxDn7xarAuTL5+
	 GuOD/tCUJHWdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8F380CFD7;
	Fri, 25 Apr 2025 23:35:36 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250425-vfs-fixes-dc6a1661a28f@brauner>
References: <20250425-vfs-fixes-dc6a1661a28f@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250425-vfs-fixes-dc6a1661a28f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc4.fixes
X-PR-Tracked-Commit-Id: f520bed25d17bb31c2d2d72b0a785b593a4e3179
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb98f304420c95d1169cc8c73d5427ca9ee29833
Message-Id: <174562413494.3874874.13607195134554197433.pr-tracker-bot@kernel.org>
Date: Fri, 25 Apr 2025 23:35:34 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Apr 2025 23:22:54 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc4.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb98f304420c95d1169cc8c73d5427ca9ee29833

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

