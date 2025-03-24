Return-Path: <linux-fsdevel+bounces-44906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95454A6E4ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDAB3A40AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2631B4248;
	Mon, 24 Mar 2025 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4Cr1h4I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDBE1F30DD;
	Mon, 24 Mar 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850032; cv=none; b=tNyRsklv2vpxbeDZArYA70MfzF2prClFdZK2fcfEDFCXSXYpPY44klKnaDYAiC+/Y9AX/45ae/gYM2HAfX6+52TJqWZw/4NIoZ9+hMn0aZGot3yRxeYJTc+LK2aUqJtHWfPw5F/uGRBfLm9S7bGKokserdorA6iBv5zbYXRfhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850032; c=relaxed/simple;
	bh=S0lmBrSU2uFPdrlTl/rvi7hwBlyc4Ejl7TITx4y/LuI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QnxA9i2sBOBudN1+KNCn2dX/kIkcesMwiHrObV2MM50gzIUUyC7quxsS9wYs05clC/+Hr4Fsfata0VWxAEWNtFWaiOto6JoYjFJ0fGQxqj07UZp0lqTolkI4vUskvoeRUCJNaxBtm2ZKGCKG4GF6+2JX2q87RbMVJ4q3qs4qqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4Cr1h4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE661C4CEE4;
	Mon, 24 Mar 2025 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850031;
	bh=S0lmBrSU2uFPdrlTl/rvi7hwBlyc4Ejl7TITx4y/LuI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K4Cr1h4IpSiHCTMCOP7hs8jtmadACgedAVRDskZ2e53YAGic7W/h9CESaTGWdXrhg
	 3NC4Zyz+nOW+lyWo36LtQxRIBUI8k4DX0SLJNXQItfhcR6u/rlw9LKmQIDXqadCr4s
	 yZW3VGyT3HW/3rtQ9/BFoxoBqG7+DCkAoYCs09pdrT6GYW9nwh70pcFM0byF8asSyu
	 ggkh7gyYosO6iRCsEc/1qHOUjW27ClT1B+Iw4450TryjXPEXYzj8D5LM7dnieWAYMx
	 r3lGWBpPYmlnYWem0LSZOdtGnJSPs2tWiGh1tbqFjmEC+lw3xOBqkLdMy1m7fVzCUU
	 5MmdJ/c8hlMfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 43F5B380664F;
	Mon, 24 Mar 2025 21:01:09 +0000 (UTC)
Subject: Re: [GIT PULL] vfs mkdir
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-mkdir-78768e0d8dee@brauner>
References: <20250322-vfs-mkdir-78768e0d8dee@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-mkdir-78768e0d8dee@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.async.dir
X-PR-Tracked-Commit-Id: be6690199719a2968628713a746002fda14bd595
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26d8e430796e7e110c656e87be8d9d3d3a90a305
Message-Id: <174285006806.4171303.3563903371331359098.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:08 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:15:02 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.async.dir

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26d8e430796e7e110c656e87be8d9d3d3a90a305

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

