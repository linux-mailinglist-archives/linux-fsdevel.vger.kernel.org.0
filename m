Return-Path: <linux-fsdevel+bounces-56440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4836AB175D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F841892233
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA9B291C19;
	Thu, 31 Jul 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6P2BKBF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1EA2BE65B
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984474; cv=none; b=h1OHK5egBGCqc/1C2QwafochORneazUwnLA+Mon8dttyw5TuHpoQuNYaQ0PqwlYC0m6NtBVtcsdeS41gHwZyaQiCctbMIrm0OwVoBtpBveWEtiTYPU2LQVbvNLAzpwPrSOmcjhim5NWuKfISpsMK50MifVEyPCxTa0tt2YDL1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984474; c=relaxed/simple;
	bh=andm51wZzD2al0mCMNAA7n0/O/EACnEOkj7Lfljfjd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CxelD6tP11s/F6+Zm5ctwsuqJ/eiv6vC+ycOPGyyyiNy/91OU+aXn96VaeR1vO4pXrLH0pzj6hfGAhkUxtgKufpYU6cGpCmdjjHRFaRzW788TTv3IDLsNgPwBipK57YxFO7Wg0LjwGGtOqqJkFLScR8bJclPSxTR+mEStAO0tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6P2BKBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FB3C4CEEF;
	Thu, 31 Jul 2025 17:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984473;
	bh=andm51wZzD2al0mCMNAA7n0/O/EACnEOkj7Lfljfjd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P6P2BKBFZkpi4HEPJrYS7hn3aWO6HfGLNE4unC0IBYuwNJyCwOyrsPzmuKu2H6i21
	 M1NJJ29TQhdlV1dShkiogSPk9UElJVbe9T7hc5d5X5Bmdi4y13DwW0qnJfUaXr/b2M
	 JxA2hWAG/kWs3zcb4f/edPeauV0fKeizZJONjaQkBfyVWFwZrtMXQx98+4J2LMwZT+
	 VrACn+ZAltbKdoDwJlh8Thx5EfjHgetZFYObKNdPHn0eKXBFE9hUtLL9/X2k9339Ac
	 pTOYAtW8gEpPA73i/e49oHujNdY5NpvpffzIg9NfjE4le9kGp1iS3MNHCUlW4pZz1I
	 YkOTWGgQhI9VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3B383BF51;
	Thu, 31 Jul 2025 17:54:50 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for
From: pr-tracker-bot@kernel.org
In-Reply-To: <cuham6fzykm3oqiribmsu7fllvyzdanyqhqel3hf4z2jl4klpi@toj7mqyg3qbe>
References: <cuham6fzykm3oqiribmsu7fllvyzdanyqhqel3hf4z2jl4klpi@toj7mqyg3qbe>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cuham6fzykm3oqiribmsu7fllvyzdanyqhqel3hf4z2jl4klpi@toj7mqyg3qbe>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.17-rc1
X-PR-Tracked-Commit-Id: 0d4c4d4ea443babab6ec1a79f481260963fc969a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6084bb815c453de27af8071a23163a711586a6c
Message-Id: <175398448928.3232013.9667614149594232497.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 17:54:49 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 17:08:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6084bb815c453de27af8071a23163a711586a6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

