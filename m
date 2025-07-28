Return-Path: <linux-fsdevel+bounces-56208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC6B144E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D18168F51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461028850A;
	Mon, 28 Jul 2025 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQQ7en7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059B2882AB;
	Mon, 28 Jul 2025 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746043; cv=none; b=GgWxtNEcM4FFimkoZ1hzpjtubkeGfbHCZWbOM/pnJ7e2I2h0CwHuyHg3Sx549kZNm4/vx2pS1sCxBDRuXaPBmEBbu+0C3Lq+5IZK51epOz8+zXZm7mx6+dF0nc9Xovel3taaJpsEbU0QP4RMLhU09vim2gEpHTXNpwN/tHP8piA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746043; c=relaxed/simple;
	bh=XGMoesjtB1ZVhFK+o6wcHAoCoJpineOJeFa1aCdeGHE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k9vuOz8MMNVGIs3j1pL+cSRk3C25tcoCL/9fFCc1JgvUUD5C9/IpK4PcJibvhIv8sdfOELdgS6PSeOtaPz7cFyOWcbG4sUTKo8evCufa2iuiH/5GZbWKB+LytzW3lyeOA4GVrI6xzkG1osDvLFwkyBtQlXBp7BUuhtMsBbe1n4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQQ7en7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C65C4CEF6;
	Mon, 28 Jul 2025 23:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746043;
	bh=XGMoesjtB1ZVhFK+o6wcHAoCoJpineOJeFa1aCdeGHE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UQQ7en7do6HhYyLJM7VuQ1JUu4kNYVs2tnc4XIJNGHI0RAHdWFQr5YeBY5jIgGcxQ
	 eO8plCFzMpPqOGE5kd5myLk79Mw82/dmx0s2k+Mu2nLdms5QFt5Vpy2h/uVDd2i5Bp
	 mZ/l1ZPaxAygZiGxskGGQqpiUTVNOWr/x/lEMFSlSqRa6wDmL/z90eaZHolftfU0lx
	 p+1LWsN0HYmxF3PrK1e6Zs/EJtWlqRsb0ihGez3taemR0NhrEmiUmUDdqbHY3Sejw7
	 pQJQsBj1neXK2b99WaAwF/klymA/nXjIB32fEI2yC+jw2NXw0H/ZmzzqLnMtjpBBnN
	 n7sZoE5sTIDGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 865ED383BF60;
	Mon, 28 Jul 2025 23:41:01 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725135411.4064-1-almaz.alexandrovich@paragon-software.com>
References: <20250725135411.4064-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725135411.4064-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.17
X-PR-Tracked-Commit-Id: a49f0abd8959048af18c6c690b065eb0d65b2d21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a11b4fa602ed3b744aa075f34bee82c12aa3553a
Message-Id: <175374606037.885311.12880724332711455524.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:00 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 15:54:11 +0200:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a11b4fa602ed3b744aa075f34bee82c12aa3553a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

