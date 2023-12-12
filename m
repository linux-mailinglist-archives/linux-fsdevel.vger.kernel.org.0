Return-Path: <linux-fsdevel+bounces-5599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B5D80DFF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752952825AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 00:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECBF64F;
	Tue, 12 Dec 2023 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXPBgkvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C5621;
	Tue, 12 Dec 2023 00:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9598DC433C8;
	Tue, 12 Dec 2023 00:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702340369;
	bh=SZSje40HwYyKrUZgQ516yasD50Jors8YfDhYE+4NQL0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CXPBgkvQw+QkIhyttnSzHdhSNTpzk0EDWg8Wj4R+h1Hc1ghD8JQRkXoKEC/t3SuYw
	 Y0tI9g3Pp2zsskCeNrzhFJ0XzSs+1nYwNVZmDmGjgeuo+d0QpsVwd4AhARDIMMSaBZ
	 gfI1SG4rM1XNwKopcccvfr5oUswWIC5owH5D58/qIVLDoCcYAxA49DjmnDwLr8DhlG
	 rpYp49qjEtSMpt6Gjv3rae59u8fLLWO9BN65dypJLgRICQbXQWiro2sptzEtEyK7hf
	 aaNU0cbhqPVOXVyIPGnobwiGtmipwbgKgNIgrj7uTKuOcdIC/WBdbVXNT7x4wHbP1Q
	 gN/lJBYKWjqjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84030DFC908;
	Tue, 12 Dec 2023 00:19:29 +0000 (UTC)
Subject: Re: [GIT PULL] More bcachefs fixes for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231210235718.svy4bjxqqrtgkgoc@moria.home.lan>
References: <20231210235718.svy4bjxqqrtgkgoc@moria.home.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231210235718.svy4bjxqqrtgkgoc@moria.home.lan>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-10
X-PR-Tracked-Commit-Id: a66ff26b0f31189e413a87065c25949c359e4bef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26aff849438cebcd05f1a647390c4aa700d5c0f1
Message-Id: <170234036953.14986.4145817613405847373.pr-tracker-bot@kernel.org>
Date: Tue, 12 Dec 2023 00:19:29 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Dec 2023 18:57:18 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26aff849438cebcd05f1a647390c4aa700d5c0f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

