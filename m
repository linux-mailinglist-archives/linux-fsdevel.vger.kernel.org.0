Return-Path: <linux-fsdevel+bounces-56214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4796EB144F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981897AEE3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801A289343;
	Mon, 28 Jul 2025 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbl+Nd2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B32459FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746051; cv=none; b=TdJMJ0p0xQR58U+FIXtiejl9v0iVhB7ek9SFX6LIw1lgGAVtGUlJyi2iAozVpT5u+xpDbjquXGCFv3zDKq7c4i34oWsVyAng+tw9eW82oQMGagQdRHEIQ2Zsb9X2KYuumJS7ituUmVoOUuCeFgV0qlEvWOsOjFbBtD2s73PGLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746051; c=relaxed/simple;
	bh=p5TwVD0zXaCNszE38IMV6Gly6Drm6MX4xhpkQMEf2jg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YDTjy8fFXgidaAfEysgM9Axhm2Oqjx3Mu4SXC4xqFm8ZfnlXMeIuQvr0IYAVkFhSNI+n/4B1dhG9y9AgcXbtr9murBULzzw6/AZC7XLbBk0PNUObhpPibzslomtmhD14mKicTXlU1tu0HMo/CXgBRwzGcdxTEPTJWq959vRw7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbl+Nd2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC7AC4CEF7;
	Mon, 28 Jul 2025 23:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746051;
	bh=p5TwVD0zXaCNszE38IMV6Gly6Drm6MX4xhpkQMEf2jg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wbl+Nd2jIaQ3R6/qSVuUpx9+TVtKqE2Cvh6mFt74Qq10S8FaFhWu4VNsH30sVZXs3
	 yeS7dLgtOm5Lcg6l+ZC0wVAc6O0smShP6K1x2kAi8+ayxKfbZZcfLagdQ8GZtYPEDN
	 +EZuBAJrgpsdeU1HAMWVzB57ibnPzT4ZL+qmaT6MFZit+MV6e0WXHttIGXufrgCF8z
	 bA/M8eYZ9VtU/Tm6niQ5ajnSOl+3Jq1I/9uF5NrDeRkQ2op4B6YhzrJhShF/XrCovg
	 msaF7sSB/6GaILhAbsgtJFaJ5DSreYCGNh3yTrYmSVqqIrs1nRfEaUqa6fQMcZOph+
	 sICC5KjfWAboA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5DFE3383BF60;
	Mon, 28 Jul 2025 23:41:09 +0000 (UTC)
Subject: Re: [git pull][6.17] vfs.git 6/9: misc pile
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250726080559.GE1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV> <20250726080559.GE1456602@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250726080559.GE1456602@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc
X-PR-Tracked-Commit-Id: 93c73ab1776fc06f3bee91e249026aad2975e8bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d9c1336edc7d8f8e058822e02c0ce4d126a298e
Message-Id: <175374606826.885311.16989837658245929106.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:08 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 09:05:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d9c1336edc7d8f8e058822e02c0ce4d126a298e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

