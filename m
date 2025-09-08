Return-Path: <linux-fsdevel+bounces-60568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D71B49435
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6521F7AB732
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E2B30F922;
	Mon,  8 Sep 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZzjvnQ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1B30EF6D;
	Mon,  8 Sep 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346108; cv=none; b=BDVWweo8flH+nypAwblC/7ETyIV1cOUDJgSIsevVE6su94Rf+4XCWd6CdqeJsiqfG+/FU1Suc5+3cRY8+hdwm6I3F6uhRHiK/MGPCm6C2RYBft3f6dBisJMwa3KR8QL8X0Mjb3MYkSDsSyILXONhaeGQlUqs005c9q/qzDt7Irc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346108; c=relaxed/simple;
	bh=ForpFWjtRAYGgGTACotYuD7ZB4CewBGLyHMIVTfN4b8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=asgYM+PBwO2cijv8ZYzVQp8pMta1d1NQM4FHjFY0uLfj5LwhKpJgB/9hr2TleOrO/StpNEibQbGgtq+nA6zYgTvNktCPj3Bjqsc0Bjk0hbjPciBje5AI3rUZZi+psFPDYB9216bov9BS2e8s29nMV/gZIAlx2UTOxesJ178R67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZzjvnQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C7DC4CEF1;
	Mon,  8 Sep 2025 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346107;
	bh=ForpFWjtRAYGgGTACotYuD7ZB4CewBGLyHMIVTfN4b8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BZzjvnQ2jHd6Yap3kU11yHhKYHr313fyKx6kIpvfk85orBAHUBxCn/JjFi14TQ5XW
	 XUD9ewu/H4ScHX79lbChEoGv0nW6QR3rqxa+FKaVueKFaSNPJ5uwNgg7T2UkGnTp9z
	 m9FcU+7ZVlmrQxX34x4QtkQpovSosu6HbosXJolhJW1Z3+noVj0Yb4nd++j2DbBJhC
	 FLBqJin0LbE6HI2dpu66LeSXr86lUJ8QiSDg0poA3h1Kju0zajmvyOG5OF3eD608GU
	 /BVP/+y9/S+JQ8gDYdnKW0Q39NeUo/srjLHRjrYTC5NUc/JDT9yLgOE2tOKgo35Ibo
	 hkJVja0jI+HPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE331383BF69;
	Mon,  8 Sep 2025 15:41:52 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250908-vfs-fixes-0096f8ec89ff@brauner>
References: <20250908-vfs-fixes-0096f8ec89ff@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250908-vfs-fixes-0096f8ec89ff@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc6.fixes
X-PR-Tracked-Commit-Id: e1bf212d0604d2cbb5514e47ccec252b656071fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f777d1112ee597d7f7dd3ca232220873a34ad0c8
Message-Id: <175734611125.4149734.12476243780802666556.pr-tracker-bot@kernel.org>
Date: Mon, 08 Sep 2025 15:41:51 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Sep 2025 11:45:58 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc6.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f777d1112ee597d7f7dd3ca232220873a34ad0c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

