Return-Path: <linux-fsdevel+bounces-46491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A6BA8A395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F66C443C1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C46919EED3;
	Tue, 15 Apr 2025 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhmw7Ba/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F98F5E
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732969; cv=none; b=bJWWmHFv0vIwS/8dPxzs39P+63pM0bAXZIPAXt8gItZun6kYlMsuaHQDML/GdrSsYyHOCIjE5DgzuLSnSRBBt/YsTbA23sry2blcDzFv/l4C/mvq0kdRP6a7gk/QAL1V9UrvBaqNrGIiXhLFOJOGGiQ6i1R4Kj0SG1X5+8QyI8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732969; c=relaxed/simple;
	bh=K+HbbkFfNcuRaox+P5C0nm2vWT15PWitPPwrQay4LoU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GPPbdYh4LltkSPQW3W/JugQTlqHp7GQ/eVOiONdLQEH/Wg8aH14ZtcKCm28kBj8IZsE4WklkQX2cRLJRpYWVFuOTsnsKzondJ4Y64k7ont0aTVPMusfE4n/50AmvGDuDwgCaSZ/KEocYNV0q7txOigDNX4uh3E6ptV+ijzqR8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhmw7Ba/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DE8C4CEEB;
	Tue, 15 Apr 2025 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744732969;
	bh=K+HbbkFfNcuRaox+P5C0nm2vWT15PWitPPwrQay4LoU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hhmw7Ba/qmDch0iE0Gv2DoWlkPP85OztSuN3uZnF+OUglCXqC5PmAduNjQWEs+iqL
	 ZWWMyCQdptJSMAj4yBmnR3N7HA0INqTSDkxV5d2wNgosdIwsO1TgfBKtlbK3bdpLkZ
	 QRAQYqgK+jmVKKnAZRaL11Uq0O3JqH2Mq3fl/6U7XPKOCuhZpoiqTbPm9VY4cpUjQn
	 rnNVRy6Fq7P/04Mw0Lrk+k3A/KUQ6AwyTy+NwyZy4pj9KslUhC+FZ/yfoNey5ZjF3c
	 BanhAdDMFq+bBifQB5EWWG0XY9zP8g+KMP7MfihdKz9/cpyAPamUwn8JrZE1EZsj1S
	 mvlNP9TiRHYIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC43822D55;
	Tue, 15 Apr 2025 16:03:28 +0000 (UTC)
Subject: Re: [GIT PULL] Isofs fix for file handle decoding
From: pr-tracker-bot@kernel.org
In-Reply-To: <6gy5exazfswgnjvssixrdn2mptbadyzaxydwdkwr6q2unmhe7t@cgdo6abwlfyb>
References: <6gy5exazfswgnjvssixrdn2mptbadyzaxydwdkwr6q2unmhe7t@cgdo6abwlfyb>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6gy5exazfswgnjvssixrdn2mptbadyzaxydwdkwr6q2unmhe7t@cgdo6abwlfyb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.15-rc3
X-PR-Tracked-Commit-Id: 0405d4b63d082861f4eaff9d39c78ee9dc34f845
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 065d49851e1a345faf112f12f96272e37ccd58ad
Message-Id: <174473300685.2689177.16996908634726394552.pr-tracker-bot@kernel.org>
Date: Tue, 15 Apr 2025 16:03:26 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 15 Apr 2025 11:55:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/065d49851e1a345faf112f12f96272e37ccd58ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

