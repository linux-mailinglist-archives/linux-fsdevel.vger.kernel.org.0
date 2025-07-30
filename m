Return-Path: <linux-fsdevel+bounces-56315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C570B1585E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 07:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081CE18A2E5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 05:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88D1E520A;
	Wed, 30 Jul 2025 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjzsGfFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E751487E9;
	Wed, 30 Jul 2025 05:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753851926; cv=none; b=l3LYKVL9pxZuIKXHwneCT44wE9BVCBn+k8Hjauxq5761pgLrQPf7W6f0DM0w8IVu1Sm29DtX+qtmQk2F0YCqUEeNjY6arfDCeHthOCYqVCqnhLK1gE4b+uTGZgoApO0hTGwMOMOkZ9bxqQc/vYrhl/VInfHu7ymFLqHvBIqj2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753851926; c=relaxed/simple;
	bh=QbSFUMqEqc98UfoAKp+aIkI5mvxyA2EyziYhRxWjtfY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SXAcClLkQxIxI17XyqChxN8kJe0YyRFI1o/mHfMbsn8YQNpqPf76/BYTFVrULceUwSVgAlIX3GwfSutU1IUrmul6HGDv4Ftf3QQyneywU7jrusRLfbqDjgD455gnDIEOH83g+plQHqm7jeOHrAzWeJeC8g2Vi+wPeeZmwEs19Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjzsGfFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF6BC4CEE7;
	Wed, 30 Jul 2025 05:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753851926;
	bh=QbSFUMqEqc98UfoAKp+aIkI5mvxyA2EyziYhRxWjtfY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VjzsGfFYj3jmz3ND6iGAcNkdMzvk43ZR/KGsRox4Q+dQ3Ln7wVKFSSLC2nU0Aq+ub
	 STaBKugndsw1MBaSP7P5VUGBXz4e6ul0Nizowog/pHRql8FvkW7RMMuenpX0XGdwr3
	 8SOm4VgHBnfAn/H/2EetEY+uv3Pg8+tPxZhfx3g6igV/jAv7vQMVUueimez5O7obYX
	 lffIhLMpRp1/K7EpL4+296gZ2Dx8iCj8hAKK9AhyL4wAm9YqLkHEkDeip4MN3jZb/R
	 XgotNi5QXNwPcNdiedYyx3kHGhUtnYyE95gul/IjYRiPYRmcRxg6mSVFPnMVCidsE7
	 ECVTLigJKVahA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04C383BF5F;
	Wed, 30 Jul 2025 05:05:43 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <fyahheosszjhz7aacxuctcxvkiket3vwfhsg35fbk4tzieojpo@s33wyvjykkc4>
References: <fyahheosszjhz7aacxuctcxvkiket3vwfhsg35fbk4tzieojpo@s33wyvjykkc4>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fyahheosszjhz7aacxuctcxvkiket3vwfhsg35fbk4tzieojpo@s33wyvjykkc4>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl.git sysctl-6.17-rc1
X-PR-Tracked-Commit-Id: ffc137c5c195a7c2a0f3bdefd9bafa639ba5a430
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b290aae788e06561754b28c6842e4080957d3f7
Message-Id: <175385194220.1779474.6032177668301256080.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 05:05:42 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Fernandes <joelagnelf@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 23 Jul 2025 13:34:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl.git sysctl-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b290aae788e06561754b28c6842e4080957d3f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

