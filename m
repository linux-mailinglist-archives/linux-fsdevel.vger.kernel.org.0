Return-Path: <linux-fsdevel+bounces-31473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA985997669
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C00283485
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D3E1E1C01;
	Wed,  9 Oct 2024 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOBnX/gk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AF5161313
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505495; cv=none; b=ocMgqHQJU5jYOgsqxI9IJBclN+O9/faINySQflvve7eG95xRbUbmiswWEMUvNMH7KPT/bKwMV8VHbgqZzaMEHXu3PvjvyQvZaG9oM2ejC/21xAATdMgAd8xFXBBhKfwHn2dHBBlRKftnuiTnzPKCnSTmOu/lMPmYQfFpC6RsfQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505495; c=relaxed/simple;
	bh=5Kk9rqvvw7Vk1Vs83UrcBXaOT37RxoyYwKzrk2jDrIU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qJECCPUSuBa/wB0FQOcekWg7wiBQZD04/SXWV/sGmZ69Aed6poy+Z2lYg8U4jmrbvD+8UNMjlvP+kBiXNCH6Rjn3k8iSjaZFxpCijLn/pPUoHVDuO15nTzOORO9t0mEJujbdvehdqfjBGbAHs+79RfXgbSYW7J43DHiF2dVpSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOBnX/gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6030C4CEC3;
	Wed,  9 Oct 2024 20:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728505494;
	bh=5Kk9rqvvw7Vk1Vs83UrcBXaOT37RxoyYwKzrk2jDrIU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nOBnX/gkKv66wygFy0qvrKoasOm/mf31JPeSL2AMblf1NJYnNQ25AOwSWmPPRmWfy
	 6pN3GWKhcOZtQLcR/nmj8EwyrAL4cCh99Ui9bh5niqG8+oJjpwHjHMOV+L2Bs+xPCz
	 D3e8r5KCr/WgfpqbhMBHODHQc8IF7QXDnPvTSfvuqhA/GYwCz+vyekbzoq5d8oBsFi
	 jQpKu4aZnfsd6bKZUF8zu86nPywgf6SVyCS7nb5brS++uhcbDfGB7T9LiS2ZXWQcsb
	 BlL515jeGPpE2e+m4gQh0LT4IG7/37S8msHxxh9/eXMbWe7gQCma0UxZCouQGPakOl
	 s4cQyVhS32l4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38D603806644;
	Wed,  9 Oct 2024 20:25:00 +0000 (UTC)
Subject: Re: [GIT PULL -rc3] unicode fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <8734l5rtzz.fsf@mailhost.krisman.be>
References: <8734l5rtzz.fsf@mailhost.krisman.be>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8734l5rtzz.fsf@mailhost.krisman.be>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-fixes-6.12-rc3
X-PR-Tracked-Commit-Id: 5c26d2f1d3f5e4be3e196526bead29ecb139cf91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff9d4099e6abe7062b1d81f003b1efce72da2fb3
Message-Id: <172850549907.1458852.18339007643668953897.pr-tracker-bot@kernel.org>
Date: Wed, 09 Oct 2024 20:24:59 +0000
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 09 Oct 2024 14:50:08 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-fixes-6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff9d4099e6abe7062b1d81f003b1efce72da2fb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

