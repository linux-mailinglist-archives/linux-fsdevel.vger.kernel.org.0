Return-Path: <linux-fsdevel+bounces-31003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51822990A67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1335C2817A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7171DAC8D;
	Fri,  4 Oct 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ176pIT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AA1D9A72
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064230; cv=none; b=C2+0ALoD5HCoGBinI7FZ+yhoP9tKP3aX6Lm6loTGKhnvipcOapxFkeobiuDXrlKArWoKWlyLQqsOCFvZYlqFOjp9f3pFNrPkT3bz+Do+lOjzVQIC0vEkCQ+Xzu8ib7LHXTHY29x4TJa52RBrlnjU9jK2wA+vjQZs8j/yWR4lHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064230; c=relaxed/simple;
	bh=l3XDXBqa9zccSBxXnbp5+k9Lwf14Qo0b3/jE/9yOanE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kRcq41BR66BYv5GUzKLjJzfxClX+QIFJKkSXO7MwobCMuUmo0VsQspUmEHH4pqrOw+PDCC4D56J3iOSpA1II7uAa609n4mqCsmKPc5gRNA4ZWBLewQf1SIevNsRzVZvsRgCnVdguprJrxxJ9TajuB7ePqcQ1BoRYjkJDAqmnUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ176pIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925C2C4CEC6;
	Fri,  4 Oct 2024 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728064230;
	bh=l3XDXBqa9zccSBxXnbp5+k9Lwf14Qo0b3/jE/9yOanE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iJ176pITaFvnFcNKuDlJAyM13gNGF5mDjU2naUQ/BwgJvcJQxo+q5xrXgmAAfN2MP
	 KiXbsaYtuzrGHmf3YI4OJ6gTQhupr3nHjb0b5KjEGVyIIRmY1N44jv4w4U+xwGBKyD
	 8pwVSTMsF9oP4ab7c/gfVjzqJ4zGJRrohlWLbutgqHM3IaXx8eA/A8YVm0fgOtEc4d
	 LUdI/iq6RqyhFKYvo680fFtiQpqSHjl5MvKvLcY+2a6+1EYCsc9oqt9wlFXBOz+ZWr
	 c07r3LlV7eXy4SfX3g2WR7wrWi4RNDPASEw9XwmHeQxOeuQn5DRaqW3SI5tBCoB9W7
	 quM2XLw3snuZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA139F76FF;
	Fri,  4 Oct 2024 17:50:35 +0000 (UTC)
Subject: Re: [GIT PULL] UDF fixes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241004144020.wqrt2gpjk5w6ed7g@quack3>
References: <20241004144020.wqrt2gpjk5w6ed7g@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241004144020.wqrt2gpjk5w6ed7g@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.12-rc2
X-PR-Tracked-Commit-Id: 264db9d666ad9a35075cc9ed9ec09d021580fbb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4770119d637c2cb55076811c79083d3ffb990665
Message-Id: <172806423397.2676932.13194956579495254392.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 17:50:33 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 16:40:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4770119d637c2cb55076811c79083d3ffb990665

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

