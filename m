Return-Path: <linux-fsdevel+bounces-13335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C486EA62
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 21:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6501F2182B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 20:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75D3C49A;
	Fri,  1 Mar 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyrXKfCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00E3C499;
	Fri,  1 Mar 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325438; cv=none; b=VoB/p0bhwdpwbGxv6o1SVnwnPouSxw0w+SOIRz8U6pGash50/mN3ZGOUFn+gkx9lmaoQxUgYm3cY5LuAJolHcGp/udwgi79igDgd1xtQgVPJnZNoZtb0gr9yaPmAk8GLAaPeCOxHCLIMXm+Ffw7Wt6p9KPzAhOlu2CblXw199PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325438; c=relaxed/simple;
	bh=W3CiMhVi8+H9ThUMn3yTHTFiw8WZ3vk7xaIUcqJ41I4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EL5pFTkxrnzgS9qaLg1hT7odG/yAxKkfEDxGEzCoQNJqbVZghgzc50TlfzuCLczbBiO9IzXA2sgyj+SrM3QQdeMUz02vbBwsTexgmUib1VBlLJu6zTA6k2fZ7zArUxTtlo2Wg9K9Wv+NWk1reSGCMCSVB1uSIJ8JiNeggnsue60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyrXKfCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18CF3C433F1;
	Fri,  1 Mar 2024 20:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709325438;
	bh=W3CiMhVi8+H9ThUMn3yTHTFiw8WZ3vk7xaIUcqJ41I4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IyrXKfCQ4hd1xPC8r6OLPl3+jKsiCEBysL6LtI0M+BSqN8VwKPavySfl4YPVN2LaD
	 OtFSMjBIWfP7vfB7tfPmo4pMaXlnuPg/jsYpe4cmGTeL6gy3XPFamZrQ/n6GB+lcF7
	 u+REMoz/s4BKZv9jZ03U/CaGcKS9yZEU+FpfejYU0AtKcByND09YPyHx7K4fpQXWOY
	 5IkVrZdqJljTvlPI9ozt//unofA34YdxAd5oXLYPJhQXyoOcRk5YK5opSag0Zrka5L
	 w7YjLHhq4LLT2k12e0bXXI1NFsG43mW122uE7P9Gllh2C2NSf4NjT7c3+syzzjm2ri
	 Uz2uI84lCBlNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE185C595D1;
	Fri,  1 Mar 2024 20:37:17 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240301-vfs-fixes-1ca0ae9e33be@brauner>
References: <20240301-vfs-fixes-1ca0ae9e33be@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240301-vfs-fixes-1ca0ae9e33be@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc7.fixes
X-PR-Tracked-Commit-Id: 54cbc058d86beca3515c994039b5c0f0a34f53dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1678f8d85d906330479d9b03d461096d7b96b266
Message-Id: <170932543796.4935.2285853599471914370.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:37:17 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Mar 2024 13:45:45 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1678f8d85d906330479d9b03d461096d7b96b266

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

