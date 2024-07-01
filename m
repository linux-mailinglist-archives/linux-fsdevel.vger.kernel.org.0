Return-Path: <linux-fsdevel+bounces-22890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B33E91E5C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 18:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD661F253C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604B16EB65;
	Mon,  1 Jul 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQt36v2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE516EB4E;
	Mon,  1 Jul 2024 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852586; cv=none; b=fCNaEql0g+3XbQOKTBIJS2O5sROmvxK4xujyPpFRvcHY+ibHTHnV5LywJnk41fdXnQWv7Ze2Xp5XX7MHahGune2QIdcn4jRAhn3SlBZJEeZnTA4lMVZMHJ8MUxEH2C2laC/OCrB0Vg4fEEQTVdY+jCDgbnatD2kBqmQI1WsT56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852586; c=relaxed/simple;
	bh=GSXWVaI9I/Vuzy7mnZnWxnmKYTmqRFegrxRUG+PE22A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PFvXzshtPiTXC5Kg/wMMD/waDVBIsC3aTXj5MMLTI3VnU9631sckR++Q8F7VDWrZGoDbGKvBTVUMoU2dBvvXv6CKF49PmO8fyaUp/ZDQdAX3EbTlc2y9RL2k4EDx01jkjEMOeRs5IkMmamuIGZvDexjQnU2xquy/YxSu+jiPlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQt36v2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B0E0C4AF0D;
	Mon,  1 Jul 2024 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852586;
	bh=GSXWVaI9I/Vuzy7mnZnWxnmKYTmqRFegrxRUG+PE22A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NQt36v2JUX11YYrCl5M9N8fN5ofYT9hwp/HEakV43WYFUUM90M8xL5DZn/9ZCsf8s
	 n/10O3zidORwupgkJSg5I8I3YYlfyvPqbx7yDNuOywKZ1ZwipBmMgWGiAXyx8kr/3q
	 yMJZ8Z4tGP7xel/0aKcq5RHN0AVwJWLqM9SDdDJqkW1nF1mJLh5xazOfc+dEvL1olO
	 U6LtYBnojwmVEZksSH3Py7+b3nsKYHq+GbRZlUTzr5SFb3rpQS8ATSQHUa0PyjAAXd
	 TDi5GRlxLiI0BVE/dbZnvTMk74054qsZc4IkuXYhsbO+NOI8k1ozhe3Eg3Met5577b
	 n9tjoJHC4GhNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77486C43468;
	Mon,  1 Jul 2024 16:49:46 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240701-vfs-fixes-7af8db39cee3@brauner>
References: <20240701-vfs-fixes-7af8db39cee3@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240701-vfs-fixes-7af8db39cee3@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc7.fixes
X-PR-Tracked-Commit-Id: 9d66154f73b7c7007c3be1113dfb50b99b791f8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b458a260080961d5e766592b0394b08a12a0ba1
Message-Id: <171985258648.24381.16613700393184137146.pr-tracker-bot@kernel.org>
Date: Mon, 01 Jul 2024 16:49:46 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  1 Jul 2024 13:53:22 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b458a260080961d5e766592b0394b08a12a0ba1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

