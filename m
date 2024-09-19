Return-Path: <linux-fsdevel+bounces-29684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825197C3D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 07:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1096F1F238F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 05:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B241C287;
	Thu, 19 Sep 2024 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9dDXTa9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FE1B7FD;
	Thu, 19 Sep 2024 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726723203; cv=none; b=XQcw+KHrUlh4rO73yVDrWRtUOZjIffozxp8muIuKp0gXTr/AZIR1ov7SH//KeX7qkYrVyY0wluSQfyemPQ2wfVrAwpSmy0qd1QZ72uNIT6cm9sqq5cCUv372u96BZbYM8Hwogc5z0wTtl0l5Ci3wAr8PR8gRLgqmm2FVGVLj3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726723203; c=relaxed/simple;
	bh=7RqVKMk0WfcP4nYm/q6eOJ2l9Eqfw6FNLGdK/zKZv74=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jXvXkmSpZ1mRnoLf9iTpUnQYgL52FCdKUrLBUqwDJo7q1MvSzGDgKYBmVAGqM/18booe7sc5uLYPpPcg/m0KVEOUs2FKMGjet+gvyLrfVI4RW32NtLKjA7EXIm6kxdeDG00tYHpAB2JVNQQcUXfpY0a0yMNZR/TY77mV40yGAq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9dDXTa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C5EC4CEC7;
	Thu, 19 Sep 2024 05:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726723203;
	bh=7RqVKMk0WfcP4nYm/q6eOJ2l9Eqfw6FNLGdK/zKZv74=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G9dDXTa9IAWrSiz0HND2ycJXyja5zh4tLRRtxS/Cg9Hy/ornmp8Xbey74+OkLEWPm
	 kUYnHe4S9M9xnd1fdbxAln05S/POUzGR+2JFIHJ6y8+CK7VDdz6UA+dX5UlWHV7u8T
	 3ayFMdyd4ExsqFVrh7nivcdDGztge2YhNUmqDNwenXtCNgvLqWLk7p/c6iZJE81e0O
	 JlJ7GWaw/AtrVniflKMRXUL5S1aiwCOYvFUGdYpNlH5so+VWeEaNbWJW3aFNigTti3
	 rb4nxAIjuWkj3fycHOPLrTlZJB6783vebPeFTBJFcSP2nCDSWv9lcdqo9YZbppj4h2
	 2uMwlz2c1H4nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1828F3806651;
	Thu, 19 Sep 2024 05:20:06 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <87jzf9w34x.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87jzf9w34x.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87jzf9w34x.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git or
X-PR-Tracked-Commit-Id: 90fa22da6d6b41dc17435aff7b800f9ca3c00401
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8751b21ad9dc33f31dff20297dcae2063cbbcfc9
Message-Id: <172672320483.1036593.10886085851542621957.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 05:20:04 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Sep 2024 17:47:54 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git or

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8751b21ad9dc33f31dff20297dcae2063cbbcfc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

