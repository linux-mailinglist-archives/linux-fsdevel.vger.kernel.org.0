Return-Path: <linux-fsdevel+bounces-50702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C07CACE886
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 05:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5523AA349
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 03:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382C11F5617;
	Thu,  5 Jun 2025 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrOfvcg/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915151EEE6;
	Thu,  5 Jun 2025 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749092656; cv=none; b=QK8dM57zlskMXpTXNYukeSCamx88bcwfivliVuILoqW+AGPXLulw+O+KaM778262ttuUbOJ/XJUvmfQcUEbF9uhbVTP0dcOHxMwaOiKQk0uwHBO9V4lH3LvXJXAcs4b8z8rMwqVfSuTBvLSWLW/rO3fze0JFo5cu0MaP0smjqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749092656; c=relaxed/simple;
	bh=WtkDm5d2NT8dGTsNCqzoNNUL2xuXXF8++dgwNhnyBRs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GSy6PX4cWZHFDXe5XLzzT4ZCIzjeIG/TZ0Q8NlGlluKoZdqXNQuVHwH2KUuiIvPOuAPaivsZadtCbmkR8LitnL7HY/CleIZWPc6CjqsUBUT4CYQaJTTteEEmvepswYbXJAkaY4Nt8rfXRlMtgcBMAKqiM6QrZJrMhjkgIxBDBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrOfvcg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE99C4CEE4;
	Thu,  5 Jun 2025 03:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749092656;
	bh=WtkDm5d2NT8dGTsNCqzoNNUL2xuXXF8++dgwNhnyBRs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TrOfvcg/dRipROWdzIc1+Vgwo+eMOmZf4h/KcfVKInHN/teL8UI4E08k96KnU1ytb
	 Z6C9H9pwL8bfIqkAACHQas6fYsj7/xx+srYDGHcOFDRbA+7dQJB3mk0++VPzWWyj5H
	 rN0S0RcDq09cOF2Bhz/MGmfSWpwuGE1AVXjPr7aZPwEr6T2x0wLLtK72SOr8qjFhVs
	 2VG3sU01RmJ0boTfq1vxN24Xw41RqG3LR9Z5mtBjjl/p55mnwN1QdflN7y1Byt9+wK
	 gEh2NZvk1mr/P57/6jfgwzF5qwZdOqgrC5nXziegdOnShmaRukORkV6OTvrrvYu7Fu
	 Qa24ed9bxp6mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDA4380CED9;
	Thu,  5 Jun 2025 03:04:49 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs changes for 6.16, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <xtigikvqorbxtpy2rh52fobvunp7yrwkfpj4muwaogr4ijxl4j@s327kfvhpi3v>
References: <xtigikvqorbxtpy2rh52fobvunp7yrwkfpj4muwaogr4ijxl4j@s327kfvhpi3v>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <xtigikvqorbxtpy2rh52fobvunp7yrwkfpj4muwaogr4ijxl4j@s327kfvhpi3v>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-04
X-PR-Tracked-Commit-Id: 3d11125ff624b540334f7134d98b94f3b980e85d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff0905bbf991f4337b5ebc19c0d43525ebb0d96b
Message-Id: <174909268839.2554386.13230803597159202651.pr-tracker-bot@kernel.org>
Date: Thu, 05 Jun 2025 03:04:48 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 4 Jun 2025 17:23:13 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff0905bbf991f4337b5ebc19c0d43525ebb0d96b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

