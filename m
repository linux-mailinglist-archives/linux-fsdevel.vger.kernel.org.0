Return-Path: <linux-fsdevel+bounces-23720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8418B931BF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C252819EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4913DBBD;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/C9IlUk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894613C80A;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075684; cv=none; b=Zd1050nBSHMEkGywo3Vgt1Ugrbpmvjw9vzu0JWIwy5LJtQMGCL6DPzxkpHoZ6MWj9B/zfF/zoAxZFFBna2+8u2rYRyuEQjMvN9RruntzxZgJ9nntr1oLCWuPZ40U1T2wVY5aNm0ryW6QqC8hY0wvWqh11abJzpExo3cjJKq7+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075684; c=relaxed/simple;
	bh=ynoCB7ouCf9XwC442bweXzKZ5vMEso3uq4/8aKHYoDs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rH2+kCei4mib0B8//iqI6Bf5pMdyJzw1sK9CtNEGIDnbe1PCDu64nTbwu9CQ8on++ab2IQ9iS9FKfGjc3m27PQ/TcwYIm7opFum1JgTcVf01Weq5qvpwrNSJCju4VA2R9K8XUjMKI2HXQ536wBRym4ig2wmPNqwFFJjbFVfCDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/C9IlUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5B43C4AF10;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075683;
	bh=ynoCB7ouCf9XwC442bweXzKZ5vMEso3uq4/8aKHYoDs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d/C9IlUkKIn0fWGBMKJngtO2TIqbhPbLoaFy+ib3UJ1m4xBnjhCCg9V/XCkrykY7c
	 RJss/ZHFzKAxBmnEfRCE+fHuV9akRYI0J59rGKgPLzn2bsTOLW+HCX2/CxFYenGXt4
	 nZq+u21bEoCmmCI2jOQKEFA/qqmoGRksQAcg4b0vhUdDHxW74d+HC2GJdjok3YvEmf
	 QWZq5UVav5R8tViZAwN1JHLfjH3DAva18nxUdfnzrykRgTSAYQYzmtiNjlk2TyIiiB
	 J6grBtFTk/TvMRROYeydGH8edBtvIkggvP8CnrXnwMopW74cdI4DDfNGh6guuBR5Rw
	 Wu0pKjziuzn2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F92EC43443;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Subject: Re: [GIT PULL for v6.11] vfs mount api
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712-vfs-mount-42ac86732006@brauner>
References: <20240712-vfs-mount-42ac86732006@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712-vfs-mount-42ac86732006@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.mount.api
X-PR-Tracked-Commit-Id: eea6a8322efd3982e59c41a5b61948a0b043ca58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8fc1bd73a5a12e48f9fd2e7ccea60cadf718c93
Message-Id: <172107568364.4128.10209636346857284233.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 20:34:43 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 15:55:41 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.mount.api

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8fc1bd73a5a12e48f9fd2e7ccea60cadf718c93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

