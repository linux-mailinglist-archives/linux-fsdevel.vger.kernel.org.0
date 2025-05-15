Return-Path: <linux-fsdevel+bounces-49201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59B2AB91D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 23:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7110D4E8019
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777D6289E0E;
	Thu, 15 May 2025 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K31KdXOY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81E4288C87;
	Thu, 15 May 2025 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345098; cv=none; b=CyEHXKlva07kpfT2BrdvKHsdXBvF54gV3Yd0VNmMaCz5VYezw1sLnDqTbSEhlW5TnEeOaDoa9j5RPjadrvlkFUw54XPwJQbcSz8CXUVgK1ck1HWh9YjojivLsBOVzaC44bZTqXXQX8tVoG7B6LkOnx7pVwxiH41r5bTSIUEyFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345098; c=relaxed/simple;
	bh=I0VJ54g+rCd2LeWV16KeN3C0m8XxrIxWPhYbD+tiPTI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H0cDLwEwK+olShg2Az0vmj+phVMWkaG0ONygIPJoS3s2btbi7jci8c3YCwt3rwmxjfscSgWlnT8bVIoQBkFZolwazUnOLvAbjCds/VDjNaqIQ5g5ryhHgZCoqoGMIWzSVmu1e57xw99GqCHyIprbn6fgTrZt98WRdVfQVvxiuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K31KdXOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6718C4CEF0;
	Thu, 15 May 2025 21:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747345098;
	bh=I0VJ54g+rCd2LeWV16KeN3C0m8XxrIxWPhYbD+tiPTI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K31KdXOY9RGZE7gtMzjyCOgAk0HjJEIJ/BYdiXq8lMjdRO1yIJQIKK8GNIswnN0j4
	 OOMAvz5bKka1nLSUh5jSAA7cBkZsR1HPcq0pFzfekxQayue1Yl9QyZMz6s8l1jdD1s
	 lJLKPD66ZoZsXU98frq5ocdeRQkncZFhcyi7sHXny0OGqWYxy/wMMxkvsJxMABdH3Q
	 gc9dud+leSpWh2gYlEc71/j8GZkUg3eUHIQUMvlV3Fdk85pR8O/zOuVNd4qxQBC9/s
	 hLMpgamgUKxPEUtudsq/3/IrdX0kd3QXr/Kg5iPXYU2LcNvYmgxa0nfeXuBq6b8t0H
	 3DJD+ijoUCi8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC93D3806659;
	Thu, 15 May 2025 21:38:56 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <2xklzlq5qc54lhpq7qnp5p6ou4kc56mglrvwg6omwd4gsz4mjg@da4pvcv3v5aj>
References: <2xklzlq5qc54lhpq7qnp5p6ou4kc56mglrvwg6omwd4gsz4mjg@da4pvcv3v5aj>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <2xklzlq5qc54lhpq7qnp5p6ou4kc56mglrvwg6omwd4gsz4mjg@da4pvcv3v5aj>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-15
X-PR-Tracked-Commit-Id: 9c09e59cc55cdf7feb29971fd792fc1947010b79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fee3e843b309444f48157e2188efa6818bae85cf
Message-Id: <174734513568.3255917.15437071296478822391.pr-tracker-bot@kernel.org>
Date: Thu, 15 May 2025 21:38:55 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 May 2025 17:00:09 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fee3e843b309444f48157e2188efa6818bae85cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

