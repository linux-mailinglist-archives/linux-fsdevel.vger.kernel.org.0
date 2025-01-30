Return-Path: <linux-fsdevel+bounces-40419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12195A23353
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855FA1888503
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DAC1F0E40;
	Thu, 30 Jan 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeeQhTRf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070A1F0E31;
	Thu, 30 Jan 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259150; cv=none; b=AiRWOa+v1sl103LLeSD7x5Ab0zZeLgwSUYI7CuNifiNX7x/573el1RByeCdzRUXzsiijsbMpWCQNBKKxKVoL3Xo+1yRY6wnCj3PiGjlGTJJQ14I/I6c04Yw4PW0GGvTSnLlrvMC65p56Et1ZT/d9DJgPO7TXbMyOL+bpFryM9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259150; c=relaxed/simple;
	bh=s2OBeiZujWWUgPNB9aPHcwdSwEWlBL1DSkfno/NCmes=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PP/2/61c/MFocbv+cFHyzLqfZIWKy+eoicpM4Hie3WC4JowJOZwauvh96s7WkDoEX8aPHO7maog5I22toW3c2MoRjJ1UF8fzwo10HLrTssjmmo3l6Wgj/cLNq1SjgSHWRFnOEIB2P1CX/hb8MQsPmsi4VuWcci9NFX3yG+8UVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeeQhTRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6434C4CEE0;
	Thu, 30 Jan 2025 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738259149;
	bh=s2OBeiZujWWUgPNB9aPHcwdSwEWlBL1DSkfno/NCmes=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SeeQhTRf1nDh1JEXRRbqEBKf+wS8paIUn7NJUQNVIPAfcYcB7ASywecDZNi9Y7KEW
	 mpniVWznyriNWit7ezAbifzCQC1CdcQeJ2JxzUKpgtLzdaf2FVZDiX+5VdfuCCKasz
	 nP08Fcv8So0sd9O0XqYyUQHMXHJDZs4QMVzsdYZVUSXcGnAGIk2/oLTWkM7R98a6WJ
	 xUkbMgCeOzo+5elVVsbmYCmBaGKeSMaVTXuxkeh2EqjHkBcsC5StvjViAlsdZoaAKU
	 0R7d6CE0xf6R9otsJaH/1F2gipv4g+C31EoYy3UnJ6UfSPYjcCBZBiodvaF7V3nZ2B
	 Zc6tCkyDBX/hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA5380AA66;
	Thu, 30 Jan 2025 17:46:17 +0000 (UTC)
Subject: Re: [git pull] d_revalidate pile (v2)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250130043707.GT1977892@ZenIV>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
 <Z5fyAPnvtNPPF5L3@lappy>
 <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV>
 <Z5gWQnUDMyE5sniC@lappy>
 <20250128002659.GJ1977892@ZenIV>
 <20250128003155.GK1977892@ZenIV> <20250130043707.GT1977892@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250130043707.GT1977892@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-revalidate
X-PR-Tracked-Commit-Id: 30d61efe118cad1a73ad2ad66a3298e4abdf9f41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3d90cc2891c9cf4ecba7b85c0af716ab755c7e5
Message-Id: <173825917616.1032810.9371704000303851400.pr-tracker-bot@kernel.org>
Date: Thu, 30 Jan 2025 17:46:16 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jan 2025 04:37:07 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-revalidate

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3d90cc2891c9cf4ecba7b85c0af716ab755c7e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

