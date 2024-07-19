Return-Path: <linux-fsdevel+bounces-23984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8219371C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 03:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778CAB21864
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD19B65C;
	Fri, 19 Jul 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6/1oR+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD0553AC;
	Fri, 19 Jul 2024 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721351068; cv=none; b=XcNY5abfGTFoMPHW/dzrCopAAqzWN0Cgtchc/V3BJ3EfQAd8AQtyyrlu6dJjrwDBVHayS9405Ffbn2wXVX98+q9NErK9B6EJfVyEw+K0PAxMA8DmJ9JrXS0XTo/SeXs8zfxc0iQjBWnf2TZGruRweyY1BpRolPrRTUBfyqEWnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721351068; c=relaxed/simple;
	bh=TZnNF8PuTBEcwT5ZBxvoKRTQ/yEKMdxHZTlkbCQzXZY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K/8ek8ITtCOZPbcBwpwP+EUY5HKSi43kaM2JS2UhpK9j2Hb1ZRLP3z0fQHkegTMDXcd3ckto2/9JqVU0u+4TN8Bp4Eo36LdGFurZfbelGTZPzxyW6untXC2THYOprIV+5jo6QrI/CM+aZN63TTbgeWSc3GyGinAlFVsJfdkxr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6/1oR+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E85EC4AF0F;
	Fri, 19 Jul 2024 01:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721351068;
	bh=TZnNF8PuTBEcwT5ZBxvoKRTQ/yEKMdxHZTlkbCQzXZY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m6/1oR+8089lymCUq6c8w4rhh74srs16ildjKBtju1839/nbfDRn2eamyORt82O+x
	 WCIX2P1Ly+a/ItYrfMi22TMo7gNsCwGiUqEh/7SM3gbJH9GawPyp2ZsbinTRjrAbvy
	 MwG0q0yjg1NEWsCDUl/1dd8XlbyDLOrsMElMc+0txXaGmA0endEQEsQ6QHosLMdFP8
	 UHM6KlY8cJZS38d3nAStiJyaBNpbmMXs7herUS/Y9Q7FEpcPixXYRuO/NeOjjEoyQU
	 sld0lrwyL1oBP8lhKZMyAaMnyZ27LBhyVGMTZU0c5q7yQluiVpCGxJwpbWMhpOmIGt
	 INWFDpwSvDunA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 739E5C433E9;
	Fri, 19 Jul 2024 01:04:28 +0000 (UTC)
Subject: Re: Re: [GIT PULL] bcachefs changes for 6.11, v2
From: pr-tracker-bot@kernel.org
In-Reply-To: <k63qtejb5ufc52uvwpmqpjugnsjcta6ucyyn4lj6h3q2s3jvje@2oztma4odvn2>
References: <73rweeabpoypzqwyxa7hld7tnkskkaotuo3jjfxnpgn6gg47ly@admkywnz4fsp> <k63qtejb5ufc52uvwpmqpjugnsjcta6ucyyn4lj6h3q2s3jvje@2oztma4odvn2>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <k63qtejb5ufc52uvwpmqpjugnsjcta6ucyyn4lj6h3q2s3jvje@2oztma4odvn2>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-18.2
X-PR-Tracked-Commit-Id: a97b43fac5b9b3ffca71b8a917a249789902fce9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 720261cfc7329406a50c2a8536e0039b9dd9a4e5
Message-Id: <172135106846.16878.4455231067181663959.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 01:04:28 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jul 2024 18:39:20 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-18.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/720261cfc7329406a50c2a8536e0039b9dd9a4e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

