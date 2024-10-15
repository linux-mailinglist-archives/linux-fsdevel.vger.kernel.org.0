Return-Path: <linux-fsdevel+bounces-32031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE11899F6C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 21:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F851F241AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39FE1F80DD;
	Tue, 15 Oct 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Beldt+GH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803A1F80C3;
	Tue, 15 Oct 2024 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019402; cv=none; b=MCAF70Wo9neLS+kbZs5Exc9ZzuffOd8f3VjoJA4CNW+cTUa5I7skj+K5/v6iE5Kst884oYxoiu5igx4+tWHEZ46ls+ujjOGbo1UCWfSQ1l0N9c9eavlwILvph0ttPMl29bGmtai5lQT51N8pa3TycBeCoMQox1eOa9HlgjzAPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019402; c=relaxed/simple;
	bh=Y1BKoOUsMPJcPccv05l6GZagN+jxFoMXfh5o+m24KCo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Di7lU7+XsPaALVAvKh9v93bN8cAoT4JnZ+eIKBNxBMiNwHkDMD4dRc2df/oPOwgWFVNmNoxK2PPc6413WCMsJiEx8YMLmaymK61d7JfBlg7FWetR6gPsiEhoO/qlg8JBcHY9llNO51JuaGYTLMlaabm142V5qMZuL++piz+Rrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Beldt+GH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5236C4CECF;
	Tue, 15 Oct 2024 19:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729019401;
	bh=Y1BKoOUsMPJcPccv05l6GZagN+jxFoMXfh5o+m24KCo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Beldt+GHZk8VnRwIHNC0tnDoixLYIdqJVky2Yox3W6bDnpqriYutfxxBqsvv8b++J
	 NSoF45di1f0qdXz+tPOpUO7DWd6mXul9J1+hBBOLckml1CsmVOO9hRjEE4zTgY9eFZ
	 wa1Wz+NJvrlaOM7nRsckbG+MlefYP3Ja0jLtymKOYz0v3OrEpIe7q7gLJ13l9onGjd
	 3WZsXz1BzEe4oK12HPc9jkIVBZ4qSqn/8kKUR777VVJIEvtQW6dF1Uho9aMvwSjbs5
	 k7Pa7FisprVmWoycjfQoGCJNi+zcVfEIm1T2fPcSiHCNZEGGH/5nDOR23ZxRtYBuh7
	 ecLgTeFvwgP/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 36A673809A8B;
	Tue, 15 Oct 2024 19:10:08 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <lazo4f4eueknrlk5odp37fboznvfxnizhdeqttnmxkbgp7szjj@m3sjqp7mxm5d>
References: <lazo4f4eueknrlk5odp37fboznvfxnizhdeqttnmxkbgp7szjj@m3sjqp7mxm5d>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <lazo4f4eueknrlk5odp37fboznvfxnizhdeqttnmxkbgp7szjj@m3sjqp7mxm5d>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-14
X-PR-Tracked-Commit-Id: 5e3b72324d32629fa013f86657308f3dbc1115e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdc72765122356796aa72f6e99142cdf24254ce5
Message-Id: <172901940773.1265868.14491597116643106826.pr-tracker-bot@kernel.org>
Date: Tue, 15 Oct 2024 19:10:07 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 14 Oct 2024 21:27:51 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdc72765122356796aa72f6e99142cdf24254ce5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

