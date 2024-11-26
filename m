Return-Path: <linux-fsdevel+bounces-35938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8C29D9EF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 22:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3467F284E2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 21:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87EC1DFE0B;
	Tue, 26 Nov 2024 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeJevYT4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7B1DFE03;
	Tue, 26 Nov 2024 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657356; cv=none; b=Xqhu8CcwG03BtbiWwrxPs+QYF/viKp605cenKYo0oTXtBZuY/VvqGuINeZ094t/nRzxz8INd2dffJwggEBAbM6mCGNFUbLlmPOuG1KHzlQ/rqHcchKGYg+jhJWy7IHDea5LpNlzJpL6A6I5CAvbfnsS20J03MPuyyiSn78IPZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657356; c=relaxed/simple;
	bh=Ax8vplevdOKghmnNhG7m9IquXS4aZMK1CkCSs7D5Un0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=azSUbmm9Sk7QXUi9c/Ru0Fu4dQ5NAz/9piLCSFcDafEPYPjhjyBt3dp81GPxsiTBhEwg2CNI2Xq1YiUWm/fi5avpyLTI05koFnN3mAYS6hywXxnFdEEukTLscDPqG9ySIIMrMEMrqLtn1+Tclgh67fjOUl2Jc8oGLw0TGnuX6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeJevYT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D609DC4CED3;
	Tue, 26 Nov 2024 21:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732657355;
	bh=Ax8vplevdOKghmnNhG7m9IquXS4aZMK1CkCSs7D5Un0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CeJevYT49s1+hhOitON6liNsXmHUo12vAhyiJWnT6LP8S0CoXLUndaaxdwdkhDic+
	 7VcRvF/qKUFOM+wnq7HwToxl33VdVUFX75iNF9qKzvlsSRycLD7B1Jhea+BktT0QIf
	 yAP57CkvfY+cI26V7cYletPUMOgUq0i37SlbNRjzhC3YRo1ci3OdKNLv+FmMbwsKQr
	 YupMLg6YrbnsdFH2s15C3Lw0l6qrRjS6GjTtluGKbSrnA4C6ZNp7EwD49v2FjFrJRW
	 Y4TwC32xGau6WbQzP9Bqr5T1MZaxK2nRnAdl3M/SQfo3AfnhE7m9qrgUq9wOBfnZaM
	 L1TsleIOXH/Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8233809A00;
	Tue, 26 Nov 2024 21:42:49 +0000 (UTC)
Subject: Re: [GIT PULL] vfs exportfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241126-vfs-exportfs-e57e12e4b3cf@brauner>
References: <20241126-vfs-exportfs-e57e12e4b3cf@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241126-vfs-exportfs-e57e12e4b3cf@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.exportfs
X-PR-Tracked-Commit-Id: a312c10c0186b3fa6e6f9d4ca696913372804fae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1675db5c42b780f8a6d45d080d5ac037d9714f7a
Message-Id: <173265736858.550402.16282479598567184525.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 21:42:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Nov 2024 12:19:34 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.exportfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1675db5c42b780f8a6d45d080d5ac037d9714f7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

