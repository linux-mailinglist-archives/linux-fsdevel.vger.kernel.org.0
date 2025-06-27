Return-Path: <linux-fsdevel+bounces-53130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA5AEAD54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 05:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D391BC7082
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 03:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37119D081;
	Fri, 27 Jun 2025 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxCvQDvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A83234;
	Fri, 27 Jun 2025 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995162; cv=none; b=JafYtz//dYm8LRnoDDEaEyH4f9ZCENhNeL1xg+4GXRBkjks8vYKYKwsRSxWUpV9lVmGDKrwRJL2oaqDewSwaN2TzVsRsJOYxuHLWY96dfc8iXlWEPdIVHYMfGqmO99piLWRImiLHKefIWraJEX+WFRFgRE+VexLKTn/P2C9X+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995162; c=relaxed/simple;
	bh=f+Ep3kutNMG2PpbfUMs0pen86/XG2xylXZu1k0JlGwY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BWdJ7xicleZby1MUgPXdJyviN2XDuRc1gC72j67Ltb79PF9p5aIgBcjmAlrNn6iGVVRZU1sU1NCKZG6ox/bPoBy0YdcKkwnVJy0hTItUm6lhbq1YlAA4VjFFRNGl+vcCxwh5uiBfSMj1UZRuylInhRwXcE9/cJM54/ktm18inLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxCvQDvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA92C4CEE3;
	Fri, 27 Jun 2025 03:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750995161;
	bh=f+Ep3kutNMG2PpbfUMs0pen86/XG2xylXZu1k0JlGwY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hxCvQDvdcYPzOVHv4UNRnJEPrrp9X3A+jCyQxSp/IlbjlZ3b+hfG5Lb68GhiBSKjy
	 Jg8y6+Xky0fKvMq3Fp8NLMDNy964z3Ml9rV4YlwvGIPEqctrQCsCakmwHVj1lk3e4C
	 HHh8DlZYcp0pe1XsOxCWAOMUXnP/obm3h4QTewlD4rnDSC46OdeVlasFWAg/yHNuVu
	 tlaFykNrBwR0UzO3iERfJBj/4c/7ULd0bu2gqyDAf7/5JKPVXWLwBjwrC06ZkbPZ3O
	 yOzg+PsNf4C1Ubspv31M4e6uF26XR9hhwJGTlpK5oKpTADe6TJ5n+Ri55ZRCvgkSlq
	 wDt+fOk/f9xAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340803A40FCB;
	Fri, 27 Jun 2025 03:33:09 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
References: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-19
X-PR-Tracked-Commit-Id: b2e2bed119809a5ca384241e0631f04c6142ae08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb378314ceee4d181e26bfe180deca852ae80c5c
Message-Id: <175099518784.1417711.8425160282050189315.pr-tracker-bot@kernel.org>
Date: Fri, 27 Jun 2025 03:33:07 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Jun 2025 19:06:01 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb378314ceee4d181e26bfe180deca852ae80c5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

