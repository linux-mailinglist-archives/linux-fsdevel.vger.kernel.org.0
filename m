Return-Path: <linux-fsdevel+bounces-42992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DAFA4CAAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7814B3B8350
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C1216395;
	Mon,  3 Mar 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMcLf9+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265442116F0;
	Mon,  3 Mar 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024612; cv=none; b=iRuoVE5S5a+n//cdvrOQm4ZQ7QZKMX3Q3UUKfJXlq9nybjyiPbJVHmg4O/U97E4puhvaIkqSUl/Hh7t7bSNarS3ofIFXbuwc5tZDuLRwoERNoeIPAgJawsBjHjJYmTGTT3Yf3AKVnKRo0Y9LfvmfmiPxSE6gybhDPwszWGGPhds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024612; c=relaxed/simple;
	bh=dAtXcjPUBNk/8FTDPtUji6RXOsMlD1jSSwkoMl4dQFE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KPp5jHQJrFSstGR8fZL2xVEmIOsr6JNbsptEFerZHqcH2h7bhAvt6YmR7GTXOUUoYW+uCgP+wltQe9+qqmzG7BSDuEBVV+UzW8ShMhE+ajjiyJa+BTNenoa6hbIrWtW6Az7StxS/SZA3WNbaYCQ7/0ruAMWzTqoVGPXExAhWW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMcLf9+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E7AC4CED6;
	Mon,  3 Mar 2025 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741024612;
	bh=dAtXcjPUBNk/8FTDPtUji6RXOsMlD1jSSwkoMl4dQFE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EMcLf9+pTMyomuOovIfhEdJcF+iRFhZdCux1Qmo+nhfa8ZOPySzbxpUEayyWsPZaA
	 QmAVa2NHdhLgCv1hYkXr218eSPAdWz+RTmEZrucLrB969Ku/SvOqwSz090WBBEJUBv
	 tFLqXomGmzEMmQh5rGDZkXgnnZsK2qp50KloYVaLCyIRjoFjalzvGXYgEa76e0q0wb
	 Sj/l4vfFXtsRRTsLwyxGw2Uzt0PLcJezLD02APjczoXGDy1S5P3pVexK60J0LFpL+Y
	 8CDu1Bu5Rm0BWHUle5IIS84FPwjcCs7GM5Cl0Qjn8HLdWQy7OVFjixhIJJxCLbmyj1
	 9+C6P4jVSLu7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5223809A8F;
	Mon,  3 Mar 2025 17:57:25 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS fixes for 6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1741016639.git.dsterba@suse.com>
References: <cover.1741016639.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1741016639.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-6.14-rc5-tag
X-PR-Tracked-Commit-Id: 011ea742a25a77bac3d995f457886a67d178c6f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99fa936e8e4f117d62f229003c9799686f74cebc
Message-Id: <174102464450.3669258.9153249325019167925.pr-tracker-bot@kernel.org>
Date: Mon, 03 Mar 2025 17:57:24 +0000
To: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  3 Mar 2025 17:08:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-6.14-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99fa936e8e4f117d62f229003c9799686f74cebc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

