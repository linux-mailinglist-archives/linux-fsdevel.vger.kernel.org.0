Return-Path: <linux-fsdevel+bounces-11167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5E4851AA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1611C22377
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37323E468;
	Mon, 12 Feb 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCpVgUIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EAA3D39F;
	Mon, 12 Feb 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757387; cv=none; b=Qhm/Q05wBHedKMEu8TWr3DcLDZrRkFKZ8g9dmQzPIQ4BLanzurmhm8Wu5S1i4bgfLytNIA7hlS+BTYbT/E+rv/SzEJai5v998W7387kCC7mwaYg3UZ+d3Z9LpU2ka2vWl8LwvT1Ygx9WbZNKDFJLPIRh4U6BIjEeuJwpV+dtwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757387; c=relaxed/simple;
	bh=0AX7I1Qi4BI9CVQBM14Tc87BAvA/nfcgE9XC4EMIA74=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PvOJbHBFkKBZNQ8UVSYAuQGUJk8YdIUH6eMXxhGzjdzQdx4zhOmfQqCTRntUuBQmyJFVineBKL8AkZl305Y8tmc3n7G+VHl9K6PqvCSaXnhbePWynOVnRx9CAmJvY/sQrUsbAE1KQ9NCjuv2iYPdz3SitXakxPUazpAsBRpsydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCpVgUIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D36C8C433C7;
	Mon, 12 Feb 2024 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707757386;
	bh=0AX7I1Qi4BI9CVQBM14Tc87BAvA/nfcgE9XC4EMIA74=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NCpVgUIftFhcKQFWSsYP+l5OBK+XbpOY99he5a2Ss/3NKSLq0tXcKdUlDF+fPDCtR
	 ehlvumgoTgjSY/nue/jlPg0H1hWa/2LOpENOmm2Gc6Yal0mHDrBTZPmud4fhfjOZNV
	 Qs1IhB/5rInxtri7TOjXKNJbb7os3lxYF61XYa+5gGluC+taBsGLPSLGEf13kCxhaC
	 MKLeYRYurN4P/xey32Ni7kYAo0PL2rSf3OvmJ9Wy6/HO1XjQ+3HaYfEVms5bzE8G5/
	 2XZhRL4udDhYBSPmUTok169NlbvH1h8Qv7rcG2mljTv0JCIs1ZLJRU8f/qZ4pcoYmV
	 2sKS1Y3P4QyhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA46AD84BC3;
	Mon, 12 Feb 2024 17:03:06 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240212-vfs-fixes-bd692dfd338a@brauner>
References: <20240212-vfs-fixes-bd692dfd338a@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240212-vfs-fixes-bd692dfd338a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc5.fixes
X-PR-Tracked-Commit-Id: 46f5ab762d048dad224436978315cbc2fa79c630
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
Message-Id: <170775738675.17857.1070313995201408878.pr-tracker-bot@kernel.org>
Date: Mon, 12 Feb 2024 17:03:06 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 Feb 2024 14:00:11 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc5.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/716f4aaa7b48a55c73d632d0657b35342b1fefd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

