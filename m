Return-Path: <linux-fsdevel+bounces-39720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8FBA172E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078263AA29F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1891F0E29;
	Mon, 20 Jan 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leQhekTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265301F03F9;
	Mon, 20 Jan 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399570; cv=none; b=dc/d7r9bpfv6eqwTKQbcb94aTPLKWmmsrUryhcOMKqr7tCQyw5Ls3ngffOqYAE4GRwXX8UhRacyUabAfLoSzWW8/TX2YbywxZJ5nX/bDOMDrLYdYFFLnRaxTHo85+2PETHGlufE3TStEy1+/bOXi2gNcYXoQGalhkfbPuTP1pBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399570; c=relaxed/simple;
	bh=KMYCZMlQa+X+3zoE1TrS9O3X4MDwo1W0AXEk+dpU9jY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mxFZK0oFPCQYcYXF9pVrKhEly8LmgE3xIEDDIW7VOwPni5yIaEoLWT/cIEkASXj20pLGsvEXTLMdBS4PgmHbiGaMBPPH5WrUuO4jO8K5wo515GC6DPLFBDOOoD1w5/ZChskw0MM3v8+JvafdpsfINQiD4+SdRK2mnUHM+O+Q+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leQhekTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CBFC4CEE3;
	Mon, 20 Jan 2025 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737399570;
	bh=KMYCZMlQa+X+3zoE1TrS9O3X4MDwo1W0AXEk+dpU9jY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=leQhekTWk7PZp5VWdgLjjEOjXqW0XQ03IdsPt4iHIzv3ptGEm7a0WDOrKqF7DXtIC
	 10YxZDNYFTiN6RA/5ZniCa3N5JZaLkNgcK6dakUQjD/28Jqqgf5U8WXu900HIgIQcB
	 XqOiatr+jnqIlYcIFBcsYWqelLqxgQW55pvmWGBP665oKPvm5Q6cMiFvfII2KNzn0g
	 44PYC7tgrvZtgk0XCpVsVK1UK9C3oPYcNxk1LQDu67JgyHHXEJgswpuP1MLARZ/ryI
	 9iCG4sDXWQXfdhANmhFSvWvMpnaDvVRXXMnZT6wSG4JEaI1+zecRDR45EFO28mTYgz
	 2kiQAm/1skNFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 351B5380AA62;
	Mon, 20 Jan 2025 18:59:55 +0000 (UTC)
Subject: Re: [GIT PULL] vfs pidfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118-vfs-pidfs-5921bfa5632a@brauner>
References: <20250118-vfs-pidfs-5921bfa5632a@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118-vfs-pidfs-5921bfa5632a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.pidfs
X-PR-Tracked-Commit-Id: 3781680fba3eab0b34b071cb9443fd5ad92d23cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f85bd6aeceaecd0ff3a5ee827bf75eb6141ad55
Message-Id: <173739959379.3620259.13577008659444735633.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 18:59:53 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 14:00:30 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.pidfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f85bd6aeceaecd0ff3a5ee827bf75eb6141ad55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

