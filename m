Return-Path: <linux-fsdevel+bounces-8824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2EB83B456
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D87285F4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43969135A46;
	Wed, 24 Jan 2024 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5HpRSO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DCC135402;
	Wed, 24 Jan 2024 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133403; cv=none; b=peuMlaBN0uhGgXQp9sYWgUlWQOe2vErfieoXDhb5Gq2RjANDPLA5rTIDsQ7xoClv96vlR56ejGlmh2X57vAS0Xhv5z1zYWvmqKyI9dKMaqWwhR/DhWPRNzltyWR2cyWXvC1LYu+Z/PiofbUslaizRXFfq0rZftdP4yeF6qcFc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133403; c=relaxed/simple;
	bh=wQG4xwraoCjhF0quRyV8oHmweFc0fwtHDHi731kPghY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tfs0xoCajSJttH3mcTnhmOiuDToUdXyO8lP3hsYvQLeQAGNqc/k8dhxMscXN3DeitMU7xd2RXG3owtNtQQ146YVafZVvgTpDddbv34CMSOidqkoRS/t07tQdtFTESVJhw5EvVQ3bUW0V6h7PblNPaR+W3fjfmWky6CiewxpSgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5HpRSO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1885FC433C7;
	Wed, 24 Jan 2024 21:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706133403;
	bh=wQG4xwraoCjhF0quRyV8oHmweFc0fwtHDHi731kPghY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C5HpRSO/f0s8sQ/cLgCjpggeCI/1Bxs8Hy8MnP0rG9RWevTOTHFr5aPsq2KK4Mf3x
	 H2xQQ3Jrg+orDWJfDBElzS7yAVQkTXRTO/U7a4TlPjfACPXo4Qfj6iFKYCrLimGF1r
	 mHaip9T0tMIInC4hkPIQnXZVamPn6Dh12Slw88he/zSVjfEl+nrkIux75o4jWjkvUZ
	 cHw21nY34oQf/nARuZaLFwv+9MpUG6wbcfqiMEuS8TwVZF8jQiZOQMSTnNRT8VYSXo
	 dT52GnatHP19P6ow5ebfmXWjknKCnSMX1U06diyHX/brz+9J3zJQw9cKTNZuMgj89m
	 qQlgh6kpJQPEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05D31DFF767;
	Wed, 24 Jan 2024 21:56:43 +0000 (UTC)
Subject: Re: [GIT PULL] execve fixes for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <202401241201.A53405B0D1@keescook>
References: <202401241201.A53405B0D1@keescook>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202401241201.A53405B0D1@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.8-rc2
X-PR-Tracked-Commit-Id: 90383cc07895183c75a0db2460301c2ffd912359
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf10015a24f36a82370151a88cb8610c8779e927
Message-Id: <170613340301.16211.15912658472235455983.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jan 2024 21:56:43 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Askar Safin <safinaskar@zohomail.com>, Bernd Edlinger <bernd.edlinger@hotmail.de>, Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jan 2024 12:05:10 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf10015a24f36a82370151a88cb8610c8779e927

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

