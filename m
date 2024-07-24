Return-Path: <linux-fsdevel+bounces-24171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE57593AB21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 04:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DACE2841E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 02:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257613B295;
	Wed, 24 Jul 2024 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nulDWwYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046A1C693;
	Wed, 24 Jul 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787407; cv=none; b=bEjI9BrbnnGqzMu/z3rWGctQ70vrQ2WIHdmKSVqNLlUgKNSqPvFCw0NgsCB2ig3lT8aM5b761zBFiGRU69PmHwyC7tYfk9GXYxuxNCJZDjNQ+8UmZbowc9SnA/x20V6VgAB6UUVUtlS8/ex1w4+PXfbq3RY16mf8ljGwsJJzlZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787407; c=relaxed/simple;
	bh=uOhx3iyOqZfaap9huG8iloFal4jT6CiWr3f80xG7QOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rm7ajWN6qSDs22la+V68Q6E/54jT/PkzJxWYXEM39qmMx8C3+OqPEGK+d6aY3tOree3D1wBDc8pAWJjiVZKZCMb5OoAh75WwWuQG9mFN5wLwco3ac6BeIQudnoVy2g+jfnlAF2kvPICgeI1wRSAouJmZ+jUE+cNGSv6rdpr726M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nulDWwYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5B70C4AF18;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721787406;
	bh=uOhx3iyOqZfaap9huG8iloFal4jT6CiWr3f80xG7QOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nulDWwYH8l0hWWUETLAk7bpiheKu7MESq9AbkM0cZFEpiJcsuolnCatCt6Rra2A1D
	 RHMwlVgK2bYwUwE3Sl50Xtnc9mqmaAWs1a9OSxLiYSHg4tjt2qNXA/YXqL4BHzj+uB
	 WgHhupyvP8VJYUPdFiKuKpuZmjAY6HYeRIsnlTu8vClXoTmjC2PEvoe0KY3/8/tQRQ
	 Vi5P15h1rm4ki+b+rztHNgxOMoOqLrZl4GQv4wsI14/Bj4i5Ijksd7FGX16XS2BKDm
	 yaReHS6UlSV24T7IpahVZ3w1rA2x0o6SthmQ3JMcCZcCeihP76AiKRPrjNvGKPHn43
	 itjEaaQpvr61A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5F6FC8E8DD;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [RESEND PATCH v9 0/3] Introduce case-insensitive string
 comparison helper
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172178740674.17759.3977282531593034304.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:16:46 +0000
References: <20240208064334.268216-1-eugen.hristev@collabora.com>
In-Reply-To: <20240208064334.268216-1-eugen.hristev@collabora.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, kernel@collabora.com, jack@suse.cz,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Thu,  8 Feb 2024 08:43:31 +0200 you wrote:
> Hello,
> 
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html
> 
> To make it easier to apply I split it into smaller chunks which address
> one single thing.
> This series is based on top of the first series here:
> https://marc.info/?l=linux-ext4&m=170728813912935&w=2
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,RESEND,v9,1/3] libfs: Introduce case-insensitive string comparison helper
    (no matching commit)
  - [f2fs-dev,RESEND,v9,2/3] ext4: Reuse generic_ci_match for ci comparisons
    (no matching commit)
  - [f2fs-dev,RESEND,v9,3/3] f2fs: Reuse generic_ci_match for ci comparisons
    https://git.kernel.org/jaegeuk/f2fs/c/d66858eb0c72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



