Return-Path: <linux-fsdevel+bounces-28595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3296C460
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6151F21716
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59031E1321;
	Wed,  4 Sep 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBmeV5xy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2151E00B9;
	Wed,  4 Sep 2024 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468399; cv=none; b=nucPKPEjKgvfi1c9kSBV9L+Xz1aaLhge4j8Ottnqgms1bVzozUJVgmBaEcz9B55OAD9IvfOjssG/fFwzIlqqEIRwSMD4jUwJQx74mUHJfpuVfyobfunrbMEaxG51BDhGUonnAPQutiCRin8GQQ+alP/vFAEm5Dhk/3QU6PnSiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468399; c=relaxed/simple;
	bh=Rby7SagpjwhJNMI/8JrRzaYEcT2SlcCxDGx6GVPucDQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JkNAo3MH/QWO4FhkoBgi+ugVYAKbQj0/peCPK7zVcHrW3N4PY4aYJ8P/vC8WB5VRHYzOO6SL6lVMImW9CjCQtg19YrtYYWhif3qAGYdlRjukEOgCgeorVYL2Rj7qLLRPlimyJ00u3Eda4h1N8I3ue5IVugc8YcgdGX27ajCd/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBmeV5xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E26C4CEC2;
	Wed,  4 Sep 2024 16:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725468398;
	bh=Rby7SagpjwhJNMI/8JrRzaYEcT2SlcCxDGx6GVPucDQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NBmeV5xy9CxjKDEA3Gom9oePAz1yyMsY7QyWqrs5KDHFLRu6pNmipItXeQUSvNk/a
	 pYn3qGxI3gK9qaytPTCJrnXvwMdt8zB1ga1MaaD5lGf1sN1V+zDpHPTNI4KcomHiR9
	 dBwFDJ/j+5dheDJ23TofTZBruwfUCsj+7z0s71YsG7uEwUPazUZtobVD48nkXEOZ/h
	 IPoe3JwsW0oaqCgqv9iePmUPsY1wqqSIohfs6oQPZ242Qzmd+cjeVoz4sagXQ8rZtA
	 09l9drujtCqjOxC5+8GLnVak8Q8qC5wLsXjt8z2UF3YTPH8H9X3+1DYzXYW5oMsiQ1
	 iHlZqGhYPoxYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714FB3822D30;
	Wed,  4 Sep 2024 16:46:40 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240904-vfs-fixes-65728c7717d0@brauner>
References: <20240904-vfs-fixes-65728c7717d0@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240904-vfs-fixes-65728c7717d0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc7.fixes
X-PR-Tracked-Commit-Id: 72a6e22c604c95ddb3b10b5d3bb85b6ff4dbc34f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4356ab331c8f0dbed0f683abde345cd5503db1e4
Message-Id: <172546839901.1094870.9064596228620265886.pr-tracker-bot@kernel.org>
Date: Wed, 04 Sep 2024 16:46:39 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  4 Sep 2024 14:03:36 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4356ab331c8f0dbed0f683abde345cd5503db1e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

