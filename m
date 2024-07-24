Return-Path: <linux-fsdevel+bounces-24170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7204993AB1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 04:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573BB1C220B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 02:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B742A219E0;
	Wed, 24 Jul 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ4QsZZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AD1C2AD;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787407; cv=none; b=Cr2uBRKS2kWLVJnbMJoq1QanbtdFmrebGuukbfT/GJdD9Z9cs9MNeMoZDr/DfnHVZC23v7DQbIG8SHpzQ1sQkcnzgjZySa7YAVavg0n+9WJB3tiGW28Ac019goc3Uvq0Ar7KrG/EtaFWq+tUalH2bGAww++c6MaXrAlHEGOfRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787407; c=relaxed/simple;
	bh=wVZP89/f1/JAIb+Z2HEidee2DPntBYpLmcbeQk21SX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jvO2LO0EEFTddWYHizPFblCb39u/5Rh7kztWR2sVJFhwRu/A3i0Y2vq5rmRg2PYuluH20SCHiZm8EKh/lsyjpzPq9gu9YjF6KDgkU7jRjxCKjJB11mmTX4pquaurO8GedBY66bm53l9mP2PaTBb0Z4h7Pg9qmNmvDTut/oEFrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ4QsZZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B346EC4AF11;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721787406;
	bh=wVZP89/f1/JAIb+Z2HEidee2DPntBYpLmcbeQk21SX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CJ4QsZZS4c0KxUV+o+U0APhkzL22faQjGph3oMJbnNvtbQIOGhKnIQqz1mA5HCU17
	 kJgR8TPgd2MP5m9vUkXwFLMkIyK8QhatYgUtot9qnHpEYOkPnhOI1bS0pnYruY1uRD
	 xRKUxJ3t+wgKH/6HS2PKkc02VfuUDjnLqRL80l7HlfWGcmmwCTHfwmIoFEEu2UaazW
	 y0z0pzneeGThR5haCDDEECpDqZbWn1C9Ej5FJ6ln4Ov92veWDt1TIZkMICcxr5JnPe
	 jqB64rlRTSMW0y4wrGI1dRM3ndpazKRsSIga07JVzKJBSSfA/d+nFeOOoE4gQhT+El
	 /GbVoudYW0ewg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5A25C54BB2;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v10 0/8]
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172178740667.17759.13870069795977673400.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:16:46 +0000
References: <20240215042654.359210-1-eugen.hristev@collabora.com>
In-Reply-To: <20240215042654.359210-1-eugen.hristev@collabora.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, krisman@suse.de, brauner@kernel.org,
 jack@suse.cz, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 kernel@collabora.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Thu, 15 Feb 2024 06:26:46 +0200 you wrote:
> Hello,
> 
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html
> 
> I resent some of the v9 patches and got some reviews from Gabriel,
> I did changes as requesteid and here is v10.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v10,1/8] ext4: Simplify the handling of cached insensitive names
    https://git.kernel.org/jaegeuk/f2fs/c/f776f02a2c96
  - [f2fs-dev,v10,2/8] f2fs: Simplify the handling of cached insensitive names
    (no matching commit)
  - [f2fs-dev,v10,3/8] libfs: Introduce case-insensitive string comparison helper
    (no matching commit)
  - [f2fs-dev,v10,4/8] ext4: Reuse generic_ci_match for ci comparisons
    (no matching commit)
  - [f2fs-dev,v10,5/8] f2fs: Reuse generic_ci_match for ci comparisons
    https://git.kernel.org/jaegeuk/f2fs/c/d66858eb0c72
  - [f2fs-dev,v10,6/8] ext4: Log error when lookup of encoded dentry fails
    (no matching commit)
  - [f2fs-dev,v10,7/8] ext4: Move CONFIG_UNICODE defguards into the code flow
    (no matching commit)
  - [f2fs-dev,v10,8/8] f2fs: Move CONFIG_UNICODE defguards into the code flow
    https://git.kernel.org/jaegeuk/f2fs/c/28add38d545f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



