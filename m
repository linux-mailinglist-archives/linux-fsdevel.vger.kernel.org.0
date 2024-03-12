Return-Path: <linux-fsdevel+bounces-14253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C0879E7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 23:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52D028409D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 22:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3594143C6F;
	Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6K69teL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5FE145347;
	Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282250; cv=none; b=hlbTDJQuBWM+sYQ4CY1oYrj5DOiUbZrme6hFyt0qRLSEOYJkL/fUz9pilllloJHX80vDMqYoWwjMhepKYU9EIv4c7mx9hEYg05473lxBtwdu9UG35vBgSiZGyOxQQCbJuOypx7IGsdqPzQa/D0Pl05nuRlQmFM7MzzLOzgkK/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282250; c=relaxed/simple;
	bh=t2gtJ1X5W1oOMAxCU6NeaLoCupy/l54YCrvf/09xULU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fet3T4fzMaQIKL2W9/kXaaWri026g6943eC27O4+5hbSUCadm7WqvENfhmk+laNWiJa5AgO/h1sPM7Hu38mX7T0ncN5OvIrUt2Py5DwnxozoSaW4Hs624mh0pT7zsVytHmwC08vqeS/ZrVB1BBNjbt0W22JCFi4+Ajq9NH09OuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6K69teL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12F73C43390;
	Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282250;
	bh=t2gtJ1X5W1oOMAxCU6NeaLoCupy/l54YCrvf/09xULU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D6K69teLlbTVJPlbz4cWnLlG2NInFt+tGHWaCO1jPuPVQHaGIlPQiOWExo4L5k0bT
	 JEoVdOjT4km7BGXs31tu3SaJGeATM1Pqjem50KSs7t78xP5ZAcZfWqh1m0IYTvPsub
	 VZhScT5LmsmbJOIKlmWFJ6wIc+fKAAw1yU32b5igM5Hwn5svbqLIWOqNR/O4OrA6pG
	 rmaqCQ2I0MaiU3jyhurso+rmbhsfJYNHoALveoXo95Muvp+YERM/G3Cr8rvf2aCrKa
	 Rs5EVCYoxQrxi8Boe3T9QBX19rcAxGIDPNo4y9ulH2qtZjthwPXVm+u2pcDe0IBSl8
	 8+mt5LHbIHLRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00CD0D95053;
	Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202403111637.203A9187C7@keescook>
References: <202403111637.203A9187C7@keescook>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202403111637.203A9187C7@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.9-rc1
X-PR-Tracked-Commit-Id: 725d50261285ccf02501f2a1a6d10b31ce014597
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b32273ee89a866b01b316b9a8de407efde01090c
Message-Id: <171028224999.16151.4935834546999328523.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:09 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, Li kunyu <kunyu@nfschina.com>, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, Mark Brown <broonie@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan <shuah@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 16:37:31 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b32273ee89a866b01b316b9a8de407efde01090c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

