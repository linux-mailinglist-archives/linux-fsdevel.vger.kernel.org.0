Return-Path: <linux-fsdevel+bounces-49871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06933AC43D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 20:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6361888202
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36C724679C;
	Mon, 26 May 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZscJKmo9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFE024678A;
	Mon, 26 May 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284531; cv=none; b=MlsQwzp6tfJTfocUXWPso8vf/W1dMfy6o7/jxcMlAUT5dEM/8zmxe7/dfHYJfuYRmnyW/AMMms7aXhLIvhpKEqLbrAeS9fIXOF6Frcj5F/LRyz+n8qivokGNe3GJBICB9vMLRXmva3VRc+qwdHpUp1zjL4ZxW9e6tmwaxDsflRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284531; c=relaxed/simple;
	bh=9Nqp8CzbUtvz3hTfh++nU8TGpR7XigksFgD90yhirvw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=livg4xSQjbIQ8OsAKS9SSyC2wZRMKCrE46wdc+thCphe7Ih8LuIIp5/b9UtsKiFwJ+z3QYOi2fWyhQFxwuJKrFhPnBtXtCetKRxqqzyNUGnfw3m2aVtSJtMNCiaU4RZbQ/f6lY9wV9nPGo/kRYqorBa1c4HdbBoA0RFFK6WfTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZscJKmo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425F5C4CEED;
	Mon, 26 May 2025 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748284531;
	bh=9Nqp8CzbUtvz3hTfh++nU8TGpR7XigksFgD90yhirvw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZscJKmo9mERKL1/gKlzPB3ihenNDNlJu5CvhTj5XUsfnK47xyPJx8ASK/d16AoWF1
	 5mL7DXc8ZUbwafUHKM3fV7QdVar6jP0BIGz99iaygrwi0ZZE+1magKyrJ8EBmWNEte
	 bj/lUM/IC8e0ynXUiHuVfFXzMIlb715vicnGQuvSxh7GL+0Fh8SLIt30Zjux5HIgio
	 qiGetbzSmJ6KmJdbUiMgGFs/UX6L51EQmw/8+t83NhKK80sPdg6zvU8Vf+po8aZYBO
	 eEGJyU1RfX6AeDwpVk54HYUUK09wk3Y0QS9wnKkbIR8GAcnjp2uo253oCCvWXWpCKL
	 MOncd628GHe8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC673805D8E;
	Mon, 26 May 2025 18:36:06 +0000 (UTC)
Subject: Re: [GIT PULL for v6.16] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523-vfs-iomap-e3468c51c620@brauner>
References: <20250523-vfs-iomap-e3468c51c620@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523-vfs-iomap-e3468c51c620@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.iomap
X-PR-Tracked-Commit-Id: 2cb0e96cb01b4d165d0cee4d26996bb2b02a5109
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2e43397e57e9451954b2a1d3bf4ac195ac185ad
Message-Id: <174828456561.1005018.18436508142088470348.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 18:36:05 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:49:22 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2e43397e57e9451954b2a1d3bf4ac195ac185ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

