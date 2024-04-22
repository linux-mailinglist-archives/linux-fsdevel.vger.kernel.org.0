Return-Path: <linux-fsdevel+bounces-17441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D18D8AD64B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 23:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A257B1F217C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABAD1CABF;
	Mon, 22 Apr 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfCreGeQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F441BF24;
	Mon, 22 Apr 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819968; cv=none; b=qK1XSkMvqIBdyjJke2kM3uAqtdC2fEQwNDReM+TgYxhCNTgy2n7F6feU/yaPNtMtx+2IHhq8cbU4+g4AzEQKS3pomevIm3Zv3N6gpj+ftFapUltv/E7sxVvK7Y6P1lnW4RwCvo/R3Ecojn/CewJKxrqpQaT02Mba40sHuBkMMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819968; c=relaxed/simple;
	bh=nfHFn+fp0jJA9vJHQNg24nHe9qmEopBNGPoI8993+9A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ua636NtbYEK+gJXIVrlSKyOHob1Xs+2+xAjEJ4+WcEmuukxvLvDv29lF7MgS1CSNRJhr8zKMGJ0hFRfAneL6P1FGaPeiBcHIzuwdr3edv8/k+XiHq4Ttu5aIB8+147Rd4euWzMdA+jsC83gfJbY9oKtyjt0jsW/8s2vX8Pwh84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfCreGeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27FEEC3277B;
	Mon, 22 Apr 2024 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713819968;
	bh=nfHFn+fp0jJA9vJHQNg24nHe9qmEopBNGPoI8993+9A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rfCreGeQhW31EY1YVnbOQqmWxkYguAdNvpZjQ9rAWGhPSzSa1b30PkcIBCMnA+WCX
	 YNwBUZLhVhDLuL7O7YDiCc39CUJcpKRCRj7IYHbK7qOav8RFhQTiBttgb/Dwd62idM
	 0EwJ+W78BgXdbgOuKzrxBVsdAsOBPXyNN9+YQ7P3xxi4gEAZv/sNVWp9DoBlJoBWDe
	 55xTS1u8MNIOB5uEUUAIRtYcW2f0DIezxhl9UrYjTbwbbDM1i/yAmvBsCxztv57PfC
	 NtyvEAo2EgxgO6FU0PhKAzmFwyf6OfLI1HxHSFMdf0LSAuTLkX69ceMeh+aZCAf8Q5
	 wMvzJkS266Z6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B3AEC43440;
	Mon, 22 Apr 2024 21:06:08 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes fro 6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <fwtvoxp2ktrhst5rm2yk4uk5atjuvnfpg7wjrozg2zd5p7tqzo@mca5izehz5fx>
References: <fwtvoxp2ktrhst5rm2yk4uk5atjuvnfpg7wjrozg2zd5p7tqzo@mca5izehz5fx>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fwtvoxp2ktrhst5rm2yk4uk5atjuvnfpg7wjrozg2zd5p7tqzo@mca5izehz5fx>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-22
X-PR-Tracked-Commit-Id: e858beeddfa3a400844c0e22d2118b3b52f1ea5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2c63a3f3d687ac4f63bf4ffa04d7458a2db350b
Message-Id: <171381996810.20649.10594661367668434204.pr-tracker-bot@kernel.org>
Date: Mon, 22 Apr 2024 21:06:08 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Apr 2024 15:52:06 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2c63a3f3d687ac4f63bf4ffa04d7458a2db350b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

