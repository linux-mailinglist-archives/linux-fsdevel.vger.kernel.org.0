Return-Path: <linux-fsdevel+bounces-58335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FC7B2CAA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 19:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979AC681CB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F2B30C35E;
	Tue, 19 Aug 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWSB696w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA9305046
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624822; cv=none; b=QTGPYXeAG2Eg2FiiBnPxi3q5ZuFX6ydyZDX7AzKXeaV+1jpDSvgXMEHmo40s9oh+9Y/bmdDYfUruod/8OhXWzbRbDyW4WDUBXtY2NigT4jrCSvSboY6FbCyFzMHT6YaCR/DKRy3s1UzqxDYqgpVqnWVmGlB475UACCFWmUSLCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624822; c=relaxed/simple;
	bh=5mL0R5N8QYp3ugyZLe98mIcCHeT1fHy//Aa2IezF990=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H2QzxtEuAJ480uJASyIryzjDmD4fVL6H1hkG9Z1UhuKaW7M/UG0MqvCIp3dGjqBktk5j5kakVaBghv3lugGOhNPsD4KpXpRVT+ut245lajQMA1EqL8g2xc9T22Uz2d3niVwvBngL0q56VGHR3BHLmrDAP5StcczxmOhUc7XzkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWSB696w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93277C4AF0C;
	Tue, 19 Aug 2025 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755624821;
	bh=5mL0R5N8QYp3ugyZLe98mIcCHeT1fHy//Aa2IezF990=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qWSB696wBqWBVcBY4F/pttL4wZll18RSekfUqRQC9OKHpjGYNwHmyXXc6W+xz+VUz
	 t2vahBYvt6UM3jdzF8xCtqiL5OEzWj49XmrTXbKgMiErB9AXpp4q5fkrn7EKi1Cx2N
	 V+ERP0WEtN3omglPMLv+utAbJHqwH3oNDOW4iIY+SXbZqwI7aOlnZQIXCsZTK0u5yf
	 1cQd7X7e72FP7tY2FpBRTUIaWDbVk2rTXoAzu/hcydsKUGcjft/hHx4qT/T76oH3D6
	 6ZnwN0DlhT9MO1I6uhP0FPQEUtjTw+MQ/BNBqe4JGqbc1FboKjVldKfdQmY0DWV7v/
	 rZJhNBnAGwUJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE015383BF58;
	Tue, 19 Aug 2025 17:33:52 +0000 (UTC)
Subject: Re: [git pull] mount fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250819161228.GH222315@ZenIV>
References: <20250815233316.GS222315@ZenIV> <20250819161228.GH222315@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250819161228.GH222315@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: fb924b7b8669503582e003dd7b7340ee49029801
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b19a97d57c15643494ac8bfaaa35e3ee472d41da
Message-Id: <175562483118.3631675.13347498102734609674.pr-tracker-bot@kernel.org>
Date: Tue, 19 Aug 2025 17:33:51 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Lai, Yi" <yi1.lai@linux.intel.com>, Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>, Pavel Tikhomirov <snorcht@gmail.com>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Aug 2025 17:12:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b19a97d57c15643494ac8bfaaa35e3ee472d41da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

