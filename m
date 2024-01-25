Return-Path: <linux-fsdevel+bounces-9003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F3E83CD07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 21:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F451F2583F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544E713A26A;
	Thu, 25 Jan 2024 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cliAdjJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1B1386CF;
	Thu, 25 Jan 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212813; cv=none; b=ukccVfw2FPLycmXU484A517HeD80yCshT7w9/ZY9djysA76MJkxW125toTmqE06QLkvxJ//bYl0hFZBzJtSL1jG+7du5iz8jnRBxQLTYCBn5CTkzXY5NMkvCG/+TSJbuza+c//4CWa5yE6IbwPCFkrJ9zTKpiu0iou3VIjxBl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212813; c=relaxed/simple;
	bh=wqaKa9JlxSSimN5+AMDBfd8gNzYaLyBWCZzFP2fzd9o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Kvn2sM7CaiDP8Qz73lYvFaDQ+nvdIDYLDD3ar9FRkPwm98v0u0lUQl4PPjioaZPlq1tno5zTOiOuOJoHaC1tqJcQ3atVYWnS1Nk67gGmNoqqc9wmLKM2KND6FmB04IaAHLRQ1d5AYlW/8RtuJYaqQxlpBRSch51LtnwXiJsot/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cliAdjJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83F79C43394;
	Thu, 25 Jan 2024 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706212813;
	bh=wqaKa9JlxSSimN5+AMDBfd8gNzYaLyBWCZzFP2fzd9o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cliAdjJWOxbJkjfAGh4CXXZrQAUAg7j4Jcu4xSp3oWkgcD23Z8I3idfbu+lYQ1ZPC
	 Hfu6XosuCSNbb7EiCp/jwXSh3sbVgerk835VBe/reiAz6e2ZRuGwSJhpxJ0xsOuZP6
	 X1GHZMWoJWSGgJy7oF/FETlBN9es40PyZ6nwuFpXvbqNKM0o8n5ovESuJXzA+Hsp0m
	 bWlY2XcWQovd6wkPpyvqJqgPfLqBo2cGeXGoRlOkZINNpc7lqrKos7BAUbHycx2Djx
	 nd6Q5HJUsl2gy88o4T7zk/FSnEsTGvU3U7/dVNvQdAXQEbslJ5zayYVuBUHC3B7n6e
	 UawM4TjdXIW8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70385DFF766;
	Thu, 25 Jan 2024 20:00:13 +0000 (UTC)
Subject: Re: [GIT PULL] netfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240124-vfs-netfs-fixes-b7ac507f03e9@brauner>
References: <20240124-vfs-netfs-fixes-b7ac507f03e9@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240124-vfs-netfs-fixes-b7ac507f03e9@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc2.netfs
X-PR-Tracked-Commit-Id: f13d8f28fe9fb0a4d0a6c21fb3c1577d0eda4ed8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a658e0e98688f4a41873fcf9b036a887a5be0de1
Message-Id: <170621281345.19358.9734609225850564350.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jan 2024 20:00:13 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jan 2024 11:13:00 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc2.netfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a658e0e98688f4a41873fcf9b036a887a5be0de1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

