Return-Path: <linux-fsdevel+bounces-29777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF4397DB7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 04:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74A1283D63
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09741CD2B;
	Sat, 21 Sep 2024 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw+LoXuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4718EAD
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2024 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726886223; cv=none; b=RroJwcJChtF1uOSt6eY5af9SpxHYsOncx1aUrbqXwRHxvimFw084xB5LmIWQX4yF8HJLQ6oCw4a2TpnuPbEGWrM/f0Zwj61u4JDwWYELBXCx3jxILzc8BqB9UTc2uBUY+Nf0xJcMLqEjf6202DWGQuLsuwLwfSSA1qRUAO4bVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726886223; c=relaxed/simple;
	bh=CklYXK6/zCsGuHKlZ9ADjAdv2PKr7SxWEDBX06edZD4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r0AVtdg2FJydu8miuHYJNLz4vofjm/k+EWNr49Q0MckBdymyzRzlqj2OzWA1gBcvFR92h+/FD5uAPYN7+xTKuuUZ0PcNsmDfYdBysnaKba1M63XoapxzWrft/7e0/5ft7WuNGOrv27vFOfOMgN2PGrh10idS7ehl349mPgNCpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw+LoXuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CD0C4CEC3;
	Sat, 21 Sep 2024 02:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726886223;
	bh=CklYXK6/zCsGuHKlZ9ADjAdv2PKr7SxWEDBX06edZD4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bw+LoXuF3wFfHbAVsqc3NVCFaIzsW7KRMBqoX6+oJgtm8qdL8IwX1O1p8yuHp7Z/x
	 4kUGYGf+DtYe/ikYymS6yNLLxs8OlspDTZR8LxMCLU0W9ugdLGoNqq6UdkmBuLIraX
	 6z+c6I5x6lJ2unXDyGA4Dn6OaPle2o0MHUfSrfkfkzFInnK13EPXQkd04Cw/tqcdkk
	 UHCwFzH0NEed5Bl3AxFOJ3yQMSOd6DX/sZu2DLe6QFkFwyIy5J6fB4RloY+2GpeAxa
	 nFEUid40WgCzDTShI8leQ6PgIDdZaJ2DMzWC/GDMLHNzC+p50VZZN8e0hjNflIqOQP
	 WR3RkaLlO8T4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712983806655;
	Sat, 21 Sep 2024 02:37:06 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs changes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSSU61P0en4i0aLF=+CiTXkV7LzkB9XGuJ3FTQBrq52BQA@mail.gmail.com>
References: <CAOg9mSSU61P0en4i0aLF=+CiTXkV7LzkB9XGuJ3FTQBrq52BQA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSSU61P0en4i0aLF=+CiTXkV7LzkB9XGuJ3FTQBrq52BQA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linux-6.12-ofs1
X-PR-Tracked-Commit-Id: 96319dacaf15f666bcba7275953d780e23fe9e75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1868f9d0260e9afaf7c6436d14923ae12eaea465
Message-Id: <172688622503.2370754.4924969308309612539.pr-tracker-bot@kernel.org>
Date: Sat, 21 Sep 2024 02:37:05 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, devel@lists.orangefs.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Sep 2024 19:41:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linux-6.12-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1868f9d0260e9afaf7c6436d14923ae12eaea465

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

