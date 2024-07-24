Return-Path: <linux-fsdevel+bounces-24168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD193AB19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 04:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7141C22DD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 02:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938B200B7;
	Wed, 24 Jul 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifdw7t/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023E1BF24;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787407; cv=none; b=KKOhowo6DhN12h49co8/qPDCPFz8yGNMk/o9OICmdbLmJiYfZLRj9HlKyDvjP55VdtZ1w8VShA+cV0O7BunjPIohhXrrGLk1MhXz9UGBJ79ZF/3u6SzOtIyUeEpq+7yUNJ3Ldm63lA13nqrrXy8SQ4mm6HU2M2dylzVEPxG2WMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787407; c=relaxed/simple;
	bh=Gh1D1UnAgqcuPvjNd5sl0dahB4BkzjzMp0gQGvNq83I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CAdZxP8XsesogIYXkHe5XL4vgmnO9it2b1cRi4gEi2rLNBzKrimtaLHgMqXTO57td3K+KMl5NDe24HpIU9tT38MNRE5jPnaazJekeQuupeyrzurM3YIscePoAaxaIpb9EQuMWZ7jPH/MRlJxJiIFta3T0Se1ZDJKcdE84p120OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifdw7t/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EA7FC4AF09;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721787406;
	bh=Gh1D1UnAgqcuPvjNd5sl0dahB4BkzjzMp0gQGvNq83I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ifdw7t/dPdOren4fjvvydJZbC5EB6RwCE4p+kutwUQcFegzzHZ1qd2S0ATKyTiyYv
	 3j933m0muzI3SDMeaEbG84eQ7p/VXbnM0I8JRsA5Hxjz83B+3uilJ9GRoNjrX/J5ei
	 FTmzznSVTd2YzF37ZcreaUM8D4G4Awlm2800PLn+LfQnq1ohKXUq9VNvxsx7TnYbtv
	 f5JDPXMweBtVys9tghSGWcHFNj2k5ShVzRvZrZrVHDQwsfgD8knyN+1OdnWuhbl9iz
	 3Q+JVpcnkCgJDEQ3oYEhcIfaBzj6HBQVFmzVZIApoK1/on0N3f/AAQYjkCqO91gJt9
	 rSflyAsS2zelg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B737C4332D;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v16 0/9] Cache insensitive cleanup for ext4/f2fs
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172178740656.17759.15510988511656413539.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:16:46 +0000
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
In-Reply-To: <20240405121332.689228-1-eugen.hristev@collabora.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, krisman@suse.de, brauner@kernel.org,
 jack@suse.cz, linux-kernel@vger.kernel.org, ebiggers@kernel.org,
 viro@zeniv.linux.org.uk, kernel@collabora.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Fri,  5 Apr 2024 15:13:23 +0300 you wrote:
> Hello,
> 
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html
> 
> I resent some of the v9 patches and got some reviews from Gabriel,
> I did changes as requested and here is v16.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v16,1/9] ext4: Simplify the handling of cached insensitive names
    https://git.kernel.org/jaegeuk/f2fs/c/f776f02a2c96
  - [f2fs-dev,v16,2/9] f2fs: Simplify the handling of cached insensitive names
    https://git.kernel.org/jaegeuk/f2fs/c/632f4054b229
  - [f2fs-dev,v16,3/9] libfs: Introduce case-insensitive string comparison helper
    (no matching commit)
  - [f2fs-dev,v16,4/9] ext4: Reuse generic_ci_match for ci comparisons
    (no matching commit)
  - [f2fs-dev,v16,5/9] f2fs: Reuse generic_ci_match for ci comparisons
    https://git.kernel.org/jaegeuk/f2fs/c/d66858eb0c72
  - [f2fs-dev,v16,6/9] ext4: Log error when lookup of encoded dentry fails
    (no matching commit)
  - [f2fs-dev,v16,7/9] f2fs: Log error when lookup of encoded dentry fails
    (no matching commit)
  - [f2fs-dev,v16,8/9] ext4: Move CONFIG_UNICODE defguards into the code flow
    https://git.kernel.org/jaegeuk/f2fs/c/d98c822232f8
  - [f2fs-dev,v16,9/9] f2fs: Move CONFIG_UNICODE defguards into the code flow
    https://git.kernel.org/jaegeuk/f2fs/c/28add38d545f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



