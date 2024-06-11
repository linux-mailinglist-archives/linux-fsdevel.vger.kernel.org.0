Return-Path: <linux-fsdevel+bounces-21486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B731F9047BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5F31C21E02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5EC156225;
	Tue, 11 Jun 2024 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f78v4c+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06B5B5B6;
	Tue, 11 Jun 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718149352; cv=none; b=EnpmXxKKXIavpMQfrK7c+JBQGyA14utYxBdfuz6CIhUTizIFX5Q5gvsalG2eNCdeTHrqWqAKXAInDC6iLb8mmHpagwPfmONK9kH5Jfw7v+ECYf8CpwocViSi7Iu3/e2tAeRI1scjU7fQNkNIlJPQYUqaUQ/IwkCyUbHW0PJrrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718149352; c=relaxed/simple;
	bh=BdsqP4hRlq4wHQ5MVvxWPIDWPoTsMNYWiF5//TjJ9Yg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YWgbXbbQeiElNC7JpeIz4rx/klpH6Vq9YQavIfJkfl4VLQxKAPcUaO4uGINW5eudKvWvSPMx76A5GOZ/PSN5vd49UdCVDz6UfjUObUi/Tu2WhQGNWRu7xrFT/5aLoTmcZbMM0ByWxsplEw/IDilwMjko6Mb++NdqSrBTjT9MWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f78v4c+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EDECC2BD10;
	Tue, 11 Jun 2024 23:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718149352;
	bh=BdsqP4hRlq4wHQ5MVvxWPIDWPoTsMNYWiF5//TjJ9Yg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f78v4c+4mFWbygiSeNUzvhvF+HLvTHaHpCvsCbdT2rAMiyAvc3Nn/5PoqiZSK1V6s
	 m3z6h+nKVnxkBZQcxhw8hSRgCxavzEYrUdPtSgv8NzY8/y/MN/FZQXjhQq2SXIYbr8
	 MecvxJ1BlywyEfilfJgVq1vC5jgf7ngos9kPS+71TQAMb8hxcNwu2vL0uFe0+2t7No
	 GQyumVadCKbEfgaujQg1qCHZLOstzJBw7Tmq6PGf6Byo4NPluu8NhJ5vOIN2wtXB7o
	 MCObVM/8Yw/QEiV9iQuW7CKVPiXFeQaIrAsqQnrIUOuRPEd4DC4zdXlak1fiUbs3iN
	 JmnXrXt8h+49w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4546DC4332D;
	Tue, 11 Jun 2024 23:42:32 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240610-vfs-fixes-a84527e50cdb@brauner>
References: <20240610-vfs-fixes-a84527e50cdb@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240610-vfs-fixes-a84527e50cdb@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc4.fixes
X-PR-Tracked-Commit-Id: f5ceb1bbc98c69536d4673a97315e8427e67de1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ef5971ff345d3c000873725db555085e0131961
Message-Id: <171814935227.9933.7533365838358490163.pr-tracker-bot@kernel.org>
Date: Tue, 11 Jun 2024 23:42:32 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 10 Jun 2024 16:09:10 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc4.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ef5971ff345d3c000873725db555085e0131961

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

