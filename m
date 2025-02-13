Return-Path: <linux-fsdevel+bounces-41686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B34A34F56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 21:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB0B3ACE1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F8026618D;
	Thu, 13 Feb 2025 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOwq+5x7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361F2222DE;
	Thu, 13 Feb 2025 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478478; cv=none; b=WjjYRZJEXFoVqeUnEToYxL5kYiGZxpSl2u5NEPG7pFAoJKKTUM/ymrYbwJUAyKNh7V58GRqd6Gue2TowVFXxPLsVR0M776npuHiHzN1X+fhaupn1oVUykwOkknDUFO/pY43uwwIXETSTIvQSgp00UMH79QRlH3/y6NeRL/BoEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478478; c=relaxed/simple;
	bh=drjTUzRI1FNr97RascA9DxGqfbrUTffJjAIEem3w2Pc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=evGfcVeVPz9fRt2lsBkEZwQsCByUHcMQk83o06NCJZ103WYHoiR9vFj2A5SOgLNbkH64KSI7V33+Cekrn3Y+6Qy1CMeDhNRvyfDAfWouJ8qQE/PgKiRZKccLYOdb7k6ZsTM8XSIgb7jZVG3ub/2rBsR33bKZ9JXjFxp47BCuEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOwq+5x7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745AEC4CED1;
	Thu, 13 Feb 2025 20:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739478478;
	bh=drjTUzRI1FNr97RascA9DxGqfbrUTffJjAIEem3w2Pc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lOwq+5x7GqDUTOjjJWG+xMr8Jc66nLn4WAd6YogG/X57txOTXUYErI9Mjx+WbkIpz
	 VljT8FRzB8Jr8pDXJRkzbUzL81rrGX9R2n1UveN61ASYGOsZSJQZRkFggAd4s+MseT
	 xylAmqf6fXmbSTvRz1YhkZnOSxi734cQD7O2E4M002I6EIEtgTQZ9Y2+SPnInR4gMV
	 dg1mCqfqO2br/L3IaWthXot1ebGSD3BGncerErRCEv6zOUhRCmfZk6BEB+ItTgWrN0
	 MfGsyVTYGtXK7VtfgoDOzurAGgjoDn4MRtvctdoiwrfTRHEVsbOB1ZYRV/M0w+p4dd
	 OAlm5gPxIG75A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4CC380CEF1;
	Thu, 13 Feb 2025 20:28:28 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <hodakekojuga62jmvqimb63dyyavx6jqdy7t67cltmha55fl5n@jl2guh3xzh4s>
References: <hodakekojuga62jmvqimb63dyyavx6jqdy7t67cltmha55fl5n@jl2guh3xzh4s>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <hodakekojuga62jmvqimb63dyyavx6jqdy7t67cltmha55fl5n@jl2guh3xzh4s>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-12
X-PR-Tracked-Commit-Id: 406e445b3c6be65ab0ee961145e74bfd7ef6c9e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1854c7f79dcaaba9f1c0b131445ace03f9fd532d
Message-Id: <173947850759.1363830.1068962873418535200.pr-tracker-bot@kernel.org>
Date: Thu, 13 Feb 2025 20:28:27 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Feb 2025 13:32:09 -0500:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1854c7f79dcaaba9f1c0b131445ace03f9fd532d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

