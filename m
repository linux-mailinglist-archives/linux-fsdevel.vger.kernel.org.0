Return-Path: <linux-fsdevel+bounces-50887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C398AD0ACE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 03:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A6817553D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F28258CC1;
	Sat,  7 Jun 2025 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryJdpWF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62D44C94;
	Sat,  7 Jun 2025 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749259026; cv=none; b=H38uNf1fTXMTSJL0rY2K3M50F79JXAP/r+W0uEibA2+GNbIvwQxbQjLwnrBUZwKJywIQ09WLPg/MUaCw6j/aONTkxv/dQAILVNUS0mQOD/wmq4MH5EAlaQRXN+8YWZ6e5f1AWI09ydBd1lOkthlsDPB56BmBPv5/uz2iiUsp6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749259026; c=relaxed/simple;
	bh=CfXGrQYDLOmsZAQkoaghRfnFl/jjWo8ANCgUQ4EhtKM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HxxwjECk4MuHNuH8MIQ9HIYvGJYV7LcOVTbeyxa0g+jG3rX9CPNDZp/5H18cwgcMACz83G0/VX7g8MjoqK1Nk9pqxtpuT1Udz6uCIg8RGCHcYi/RhbTV99RyphAiIb91Ce2C9iwgtwshWdchtg46aiAAlfxukEATbVnaLhHTjcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryJdpWF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7AFC4CEEB;
	Sat,  7 Jun 2025 01:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749259026;
	bh=CfXGrQYDLOmsZAQkoaghRfnFl/jjWo8ANCgUQ4EhtKM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ryJdpWF5TYa4bG2DxF4wIBj84665dnpbcm213tCJCcZtoKcgDP1YoqagLSyEPAbln
	 /DGPgsbJGoDpe3jnCoVjEkrOp+znsbtewGtROX7fwf3NieLOaRrulqkHPo+m2Po4yF
	 SMdg7T7B7ks9XqOyRI5Ybe11oB++jEiO41bb+w2nod9KoxCRLA3Fip5M/GHZADuvRR
	 az7uIRkj1c8cxAaWfHGm7UD6+H1rh5mm6m7X/sjfZ/OXUVybRo3VusrxHmrOiwJzmX
	 BiPtfK5dMWBxJvTbFPGvM9Rs+qgcnvcjqi9bsHJA6ba7LuTF0cUHuiZVp0uPZS4egg
	 YGWaAarn4xu3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED53822E05;
	Sat,  7 Jun 2025 01:17:39 +0000 (UTC)
Subject: Re: [GIT PULL v2] overlayfs update for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegssS_nOs1T+LTZBY9afFcmvpQH3gaSEph0NDx4neXNGRA@mail.gmail.com>
References: <CAJfpegssS_nOs1T+LTZBY9afFcmvpQH3gaSEph0NDx4neXNGRA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegssS_nOs1T+LTZBY9afFcmvpQH3gaSEph0NDx4neXNGRA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-update-v2-6.16
X-PR-Tracked-Commit-Id: 6f9ccdad0feaef58b05f07e0fc9d31004147177c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28fb80f0891c01dc706a5f6cada94c9cf0f2b1c2
Message-Id: <174925905806.4051830.2114231702835187245.pr-tracker-bot@kernel.org>
Date: Sat, 07 Jun 2025 01:17:38 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, overlayfs <linux-unionfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Jun 2025 11:39:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-update-v2-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28fb80f0891c01dc706a5f6cada94c9cf0f2b1c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

