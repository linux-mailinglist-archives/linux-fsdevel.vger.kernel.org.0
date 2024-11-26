Return-Path: <linux-fsdevel+bounces-35937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B849D9EF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 22:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC7A1662D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF591DFD9E;
	Tue, 26 Nov 2024 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkAN+we7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF681DDA24;
	Tue, 26 Nov 2024 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657354; cv=none; b=TQf7L5zsD2y6ATxwMcsOt1wQ5gepAGXSnixCMQpG01DrUzl9aAUmP96Vc9j5A0VQFEpExTxvDGuh9NBhi4fZFIH5FzV9r/gu0UcYAZt4gjOvVIcTsgjKceZna/o7YXdqK0fbfQ+WxXcW65GtjPArHnQX6YUSty89NHI0RLykRzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657354; c=relaxed/simple;
	bh=tqm+x/BfPTba6dFivgaDZmr2zjOA4O7OOY9ZbZ+fLxA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tZScb+vWjdGK2R+Nnvfob9yQGuao0fPuPr7HgdKOU2wwQXJ/qkIkqcHPAMRmJWgh4tICZvmac8m8vuLoCnKTwsSe8rvYA+tDLqE3BO5u/PmKybFlBSFJVqAp8kTU+IJ+S6oeUiwSKCL5SAjzAiR48pC8dF/pH5kB58kg8viMqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkAN+we7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBB2C4CECF;
	Tue, 26 Nov 2024 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732657353;
	bh=tqm+x/BfPTba6dFivgaDZmr2zjOA4O7OOY9ZbZ+fLxA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kkAN+we7HzKn+8Agd6qVrXhRcJKe14yfypWgeKvBBkvaoFA65AojQvg6ZUduvUVDv
	 DGRpKdw7GJI5qBope94Y289lURMMU140lrTyShSJ+CWjihyfvMrQx/lK1DyCUTb9zL
	 Y0yYXo49bf55osuFOlEPZtlm7xjrNkCo6tde8XH7n4q+Tgf0oOQb5sacsi9FXoGvpc
	 wjjlaWLai9CAjX6HxnDLwnn3wKdtTyRa2k8plieedsRblrIQeyVamfyDq1w5PdQqhk
	 DR8BkTVTm+fLBA9RlALkiogG5h+kbUhiD1DqPFDDqI9wVw2xL1S7IqokM7NA8Duuy5
	 75EqzLFtWCP6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2033809A00;
	Tue, 26 Nov 2024 21:42:47 +0000 (UTC)
Subject: Re: [GIT PULL] Rust bindings for pid namespaces
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241126-vfs-rust-3af24a3dd7c0@brauner>
References: <20241126-vfs-rust-3af24a3dd7c0@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241126-vfs-rust-3af24a3dd7c0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.rust.pid_namespace
X-PR-Tracked-Commit-Id: e0020ba6cbcbfbaaa50c3d4b610c7caa36459624
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ad8d22f2f3fad7a366c9772362795ef6d6a2d51
Message-Id: <173265736642.550402.8141463972505864591.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 21:42:46 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Nov 2024 12:08:27 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.rust.pid_namespace

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ad8d22f2f3fad7a366c9772362795ef6d6a2d51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

