Return-Path: <linux-fsdevel+bounces-56193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12076B144C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB344E2CD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B68246BDE;
	Mon, 28 Jul 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gva6+w2G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC48246BB7;
	Mon, 28 Jul 2025 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753745987; cv=none; b=TX0u3TAnjovDbEwE0TGf1UfMheV/0ODOCU3n+1/jvO8meHLBGPsq8Dawel6M4OTgo9PiWE+Yoz9DqYKyGIJrk+yrpvnoIKJriJ+23qj/LwPnQ0mOmv+ochtqADwRa2aUgmXogO/mwWwzxrvHpAvPZfyYMcsx5cTk8B34fPHEzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753745987; c=relaxed/simple;
	bh=Wqwwp1KS61a+5+xVpr9URABZbG0MuraNFP6YIHYaU0M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZZ8imnvwZar5wOx9fd8PhKLZOyvN5mvsZGyXfAUvmoRDBz0Frh7/saxRQlCzLWBGbkmbzYrYys6Ry2sHz7S54lJEJbzV87auSl5GccOT5oi37H/ScEJ/r1qEZAXT7NcSMzSA05dj6mVMZqNk0JsXw52+dmnRYcIVm3qo5wViTN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gva6+w2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2003C4CEF6;
	Mon, 28 Jul 2025 23:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753745987;
	bh=Wqwwp1KS61a+5+xVpr9URABZbG0MuraNFP6YIHYaU0M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Gva6+w2G8OlkyKbdc9i5OHSDt6wRRACY5nL/T8OOqNK+AbqnE1GohXotzC6UGvIHs
	 eeLXMJegMdFZWwFU3ESxGjYmQI8QX5m0PiDssHhpmeZSFX6o8Qpl6BTa8bVZbo1T18
	 JbluD7HFjPjzkDzdVlqjVtQQaT8BZb221VKgVD0wO0JBuEhTYVcU1zl8MwYiUi5mvr
	 7drU1OKWERAQ36mcxDGnKeQAiWJivgcrdOWChDHQvpCRcm6U7CQG+mEBZ9TxKTxFcM
	 Tk/sI3znYAhS7lqCOIfTjqipGqbDYCvaSDM53X8L7SxZwHnKHj7+qBj/PJdBVjZU+O
	 z5FCjr07kk8Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711E7383BF60;
	Mon, 28 Jul 2025 23:40:05 +0000 (UTC)
Subject: Re: [GIT PULL] udf and ext2 changes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <j2lhfj46lqjwmykrdpt4qww6flkjajtsssfijvysorpiv7m2h2@ctod32kzsy5y>
References: <j2lhfj46lqjwmykrdpt4qww6flkjajtsssfijvysorpiv7m2h2@ctod32kzsy5y>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <j2lhfj46lqjwmykrdpt4qww6flkjajtsssfijvysorpiv7m2h2@ctod32kzsy5y>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.17-rc1
X-PR-Tracked-Commit-Id: 1a11201668e8635602577dcf06f2e96c591d8819
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7bfaff47a17ec01d9d8b648a7266103cb7a305b
Message-Id: <175374600432.885311.4120396109137669880.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:04 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 18:06:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7bfaff47a17ec01d9d8b648a7266103cb7a305b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

