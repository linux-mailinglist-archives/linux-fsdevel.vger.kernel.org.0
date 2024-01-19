Return-Path: <linux-fsdevel+bounces-8326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ED4832E97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C95D288550
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0662A5645B;
	Fri, 19 Jan 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMkXJcbf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6C56450;
	Fri, 19 Jan 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687381; cv=none; b=o6WdDQK3AQAdui7zx0hw3ZXbLDW0xF/IvIcK/3kTgAga2RltKgDvSGIFBJWoRG99l3L83/aDSeR7HS8iwFG4SsNDzlAUvhklfjdv9AC21rErrfCM87jZad0Pmp49piI8ojCamTyt6BirO08z++0aQX/f/6KckGLvHy8uwTc07h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687381; c=relaxed/simple;
	bh=9RHZTvh1RQTSWTDXW7W3je0CjZPeuYybll0BNCxBnEc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GNRKf0ZjsorXpnJs9mKXjHq5gTH99qafYNp0mgBkSmjU2N4JkYC6GAC1cxuEt9uiCS6dwyXedwBHJayLGlh15LKGC05pEytrvziMPkbJWcFvM1q/lYm7k7CzEntKnwLzfz+jVULLBpxKh772rTzhK5h6oikRrHZwzBqg7W91gYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMkXJcbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42CAAC43394;
	Fri, 19 Jan 2024 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705687381;
	bh=9RHZTvh1RQTSWTDXW7W3je0CjZPeuYybll0BNCxBnEc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YMkXJcbf/eui82lIxTg9U7ltc5NmYaGtwO4DyOKO91UqSsbX4wAMhUUaNoqeEFFH2
	 6vsdMW2gWwHjTsI4UxZa0e3mSvg+e+AqHE/HYXoXw9aSHyofNPdJBph9iwIi04I8PH
	 IEHYBAPOw67ijnHbcZosTGzBKsTKVnaNkZT4SRinaNH5gdQNEDDRPyPzUiXhyREoau
	 FrDHJRS7TkxY8KpWQ1RoGO4r+TJax+MqTX2+3Sr2ta8eD4jp69l4xUcQifE5mazFCu
	 qwS+RAcNdz2SebFPIl/3P3fWOvUK1iqfajp32RQ0K4VNcBX9DXF9mHHw7m2c4vl1+c
	 SXb/BjQW7+OFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BD03D8C96C;
	Fri, 19 Jan 2024 18:03:01 +0000 (UTC)
Subject: Re: [GIT PULL] vfs netfs updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240118-vfs-netfs-cf05da67fbe0@brauner>
References: <20240118-vfs-netfs-cf05da67fbe0@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240118-vfs-netfs-cf05da67fbe0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.netfs
X-PR-Tracked-Commit-Id: 1d5911d43cab5fb99229b02bce173b0c6d9da7d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16df6e07d6a88dc3049a5674654ed44dfbc74d81
Message-Id: <170568738117.12972.16275937063591042156.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 18:03:01 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 13:35:52 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.netfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16df6e07d6a88dc3049a5674654ed44dfbc74d81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

