Return-Path: <linux-fsdevel+bounces-35148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8459D19FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 22:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D661F226DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3671E8856;
	Mon, 18 Nov 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0p19KGk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F891E8834;
	Mon, 18 Nov 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963621; cv=none; b=oQ7JFfj24TKrB6+pDLMD7Czi2Xm/WfWPGjyfS6IPJviCIeCYlE9UoZ41lGYf4WOWNRfNrU/FlhGaeJkpgyyCChFYb8iq4dR0dsfylPotzhYYmJayoqil0CeAZ+VMlFWREAUfgLlqy5bjKAbYV897stPPkOQ7X2U3TlMwAuZTC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963621; c=relaxed/simple;
	bh=YXRpACQaSB3oWTMWZb3pKm4SdAbB/Oc5FEpN/XQRd+w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h22Os0Dl3yls6QgUjr5QXfsued8rHN5gx42p/h0Olr2YkTyCj1SxsHppzLWI0kbwAXPkG59mXXzGIusxjbT/cBBNrrhLJ0ed+JRisWAG3wELrYWM4Lx0jvEJwagaGkK02FEUNXo6mdn2LmRfdl7G4549tQ77v/RNO+3kvBgtL3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0p19KGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B73CC4CED8;
	Mon, 18 Nov 2024 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731963621;
	bh=YXRpACQaSB3oWTMWZb3pKm4SdAbB/Oc5FEpN/XQRd+w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B0p19KGkekT6HbgBzwcZNmI6VXLM+6LuhpjbpnLn8Otr1DnaOfbZ49Rarcyq3jwsV
	 4jZxirM2d/JNSmC/U0BF6NpQc6khJZ0uy9+zjkn8FaIaQ6CFdhh0oB5nH5gkFz552U
	 HOrpkKoTJQH7t3qTIksXxVS3zLeKf9Fhv5mXadaRgVaZURT0gbgDktWq0ASr1FWjZj
	 M3Lhz6oR8rC+xfn+kENTGQa7tmfYIGDWC9CPVtsO+sxJF99IPvBEYbbm9jBjwv+gCW
	 8wjq8KRxpmw9c4QbDbpFGlxQhiZW32QEi4/5iq4trHVXx2L6zHEUAloJRPhevqIHGk
	 hV8hwzvUbguYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B7CE3809A80;
	Mon, 18 Nov 2024 21:00:34 +0000 (UTC)
Subject: Re: [git pull] ufs stuff
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115151108.GV3387508@ZenIV>
References: <20241115151108.GV3387508@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115151108.GV3387508@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ufs
X-PR-Tracked-Commit-Id: 6cfe56fbad32c8c5b50e82d9109413566d691569
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fb2cfa4635ab7b3d44e88104666e599cd163692
Message-Id: <173196363281.4176861.13182013669506747520.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 21:00:32 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:11:08 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ufs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fb2cfa4635ab7b3d44e88104666e599cd163692

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

