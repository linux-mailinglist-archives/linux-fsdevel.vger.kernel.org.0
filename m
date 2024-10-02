Return-Path: <linux-fsdevel+bounces-30779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3308A98E3BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80481F22712
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836D2216A0D;
	Wed,  2 Oct 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAV13c5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD8216A06
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898734; cv=none; b=YgwOr7ZoG3GFFlkNoKdF8SmYs7US7bG2F0EbudijAeWyCUzrThPMg6bn6+Z6Y7ghUWnHy8ukvKWRh74ZAp/lKc352Weut3RAG93k/kB0e8clzQWQTw2UTlG7eDpvQl1UfIxGg2++Zbe9c39zGf2FdmGuGcvgKlGT7PDjR6Tp1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898734; c=relaxed/simple;
	bh=/Y9INuztDywXtaxLrRZwOy3EGipeEoVYGjTRy49X2oc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jGttRsaq7ooqQW4qdrbzR69wG3BoLg+8H35ggm3cLFxG7yvHSD/dR2PsolKoXiJ5W40ylA/Hz9KsXB6Vvp+0/mP39JeUGdu9loDpilYTXxKZLUDzO/vHQqwCayA4AootsI0Mzacikoy0L54xRuVVpi9XdHUCkf0xb04NiRY59PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAV13c5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C74C4CEC2;
	Wed,  2 Oct 2024 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727898734;
	bh=/Y9INuztDywXtaxLrRZwOy3EGipeEoVYGjTRy49X2oc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cAV13c5KuYqV3fDYP0uSNM27mIJCJ3iM1xM5dXYhq0lum7chcmVPzmVsvimE8QPIQ
	 hpCcviIeMQURrJGK1Xc9c/RVoXKR45JFrFzsEmSSsAO0S2ozJZDvN8gNjFYYeF0cdo
	 veU1V6nCNmKK1QzsLXFbr3tCXwrY5zEekW8Me5t0rmxf7z1pu2R1vz8kwSvXc7SOFi
	 Bdr/OBlSlv6jRQumRmwyp+aDaKVArAez9JGnQFTFBejbXQmw2XjjN3LSIxThmcfdRC
	 f7O6V7qyoZrNw8+gXc7AjlLb3r4qtnMJBAyCdxX7ES8ReFMm2QmrEMN3L2Q50pgJv5
	 g06EUixnle2/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFF2380DBD1;
	Wed,  2 Oct 2024 19:52:18 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs changes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241001090537.81713-1-dlemoal@kernel.org>
References: <20241001090537.81713-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241001090537.81713-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.12-rc2
X-PR-Tracked-Commit-Id: c4b3c1332f55c48785e6661cebeb7269a92a45fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27af290f1636c9784dbbdd860677aaf57355ff90
Message-Id: <172789873750.1292614.9118714145511808302.pr-tracker-bot@kernel.org>
Date: Wed, 02 Oct 2024 19:52:17 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  1 Oct 2024 18:05:37 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27af290f1636c9784dbbdd860677aaf57355ff90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

