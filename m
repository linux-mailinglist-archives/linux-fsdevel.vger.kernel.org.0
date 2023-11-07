Return-Path: <linux-fsdevel+bounces-2311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39DB7E49E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3A8281394
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2091E37151;
	Tue,  7 Nov 2023 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp8P1K6Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D4B3714C;
	Tue,  7 Nov 2023 20:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B5B0C433C8;
	Tue,  7 Nov 2023 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699389271;
	bh=tgqm4KfTJ+1AnxH748pDSHWRDZYQ3XPVjrARixLc4ZE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rp8P1K6YkvOT2eikANZ1WLzSXVQUofRGnycUBRvU0+bXAcC8u+WPnz5mEGXGcAnoV
	 3B2UZZOTGEg0g2d2fLXpNw9xptFcSXUCoNwkNnja9kJxZ74w3SfXIwSmN/TT1P6BwX
	 qVocdm96mMMefBiDKBqrWrfUMYeQ4nLRARHKAAD/klfOLogwMJ4VmNMNmVanaweGH+
	 Q+EEcxZxwpmqKRvugwVnnOLBw25Nlbp9m5lznWSM8e6UYMHoJAw8uYMOyLq3PbXbrL
	 HFgbJblthOCTcM41B8xn5AnEpfe0dlLCmRVsgaCvSaLskazuguUOYLIb8ueV2S7GMP
	 8wFXrcADoRbKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18814E00083;
	Tue,  7 Nov 2023 20:34:31 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs for 6.7-rc1, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231106011240.26o5og36epek2ybj@moria.home.lan>
References: <20231106011240.26o5og36epek2ybj@moria.home.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231106011240.26o5og36epek2ybj@moria.home.lan>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-5
X-PR-Tracked-Commit-Id: c7046ed0cf9bb33599aa7e72e7b67bba4be42d64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9d01179e185f72b20af7e37aa4308f4c7ca7eeb
Message-Id: <169938927108.27832.2595634525004036653.pr-tracker-bot@kernel.org>
Date: Tue, 07 Nov 2023 20:34:31 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernell.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 5 Nov 2023 20:15:29 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9d01179e185f72b20af7e37aa4308f4c7ca7eeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

