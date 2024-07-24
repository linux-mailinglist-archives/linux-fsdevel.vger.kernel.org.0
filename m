Return-Path: <linux-fsdevel+bounces-24167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E593AB18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 04:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A88281351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 02:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD4200A0;
	Wed, 24 Jul 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMpDk9N7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020B1BC58;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787407; cv=none; b=FjaRJJQXq1Uq/a2MtBXylqkhzbudhBehNAplNxscd7rNk9PuSfTJ87fe4zg2cMnWuWnTmv0uF2SFttHsoV613s87WU/5xRhy8weni1bWvBydmflc2NfcpPGlctPi6BwQ90J0anXr2FQE3ddoF/lgmGR0yrgUlWk0C560aTbgF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787407; c=relaxed/simple;
	bh=e2dCHd3n8q25XhOxzHvJ6i3RPXn9LxCn1diONk3KotU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bhI5VAo13FR8tBFiYin2CP/N21ZjitTrsYGs8gIUmQr3dhRQ+7R8K4xWrdlB1sUlNBnOzFmXqyj7eIGXLlnLiQh/U5K5W0o13w310RVP14Y1hMyio7KhUmE48TdVMya7QeIhxtXrER61ScP+I3XNNLgzxHOrhvEcOE4j+DgGu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMpDk9N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0D85C4AF10;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721787406;
	bh=e2dCHd3n8q25XhOxzHvJ6i3RPXn9LxCn1diONk3KotU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bMpDk9N7EkOjwmpSIaAklT8hKeoG5hdBDnUji25xGqzIqXwl2rfjVmaQ/8qQ2+Yek
	 gOs+5otr1dYkrWn+WLf0ZC3HwosbZkdbdnUO0UGPhsVjWN98Q7xmyz2jNw6FzWgvOD
	 9ndEKbh0olHi7p2k64uy+qnGbLmH6t8j1sa6XUSiGnrh7bgv/HP5UQRGPMlsdtpHmK
	 qfGlbxz8w3UWIOg38XkCepKM8/51bHXqfVu1p7eW27zj2OOxvqss+E6rzPm4jCZyv6
	 Geo/fzyYTMac242CPAQTv+006yg3TOQ8zCnWl4VapNKMakux9lOgHLCrG2vPZuFVE2
	 akL++zdvOugdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94D30C43443;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v18 0/7] Case insensitive cleanup for ext4/f2fs
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172178740660.17759.10253649840019036127.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:16:46 +0000
References: <20240606073353.47130-1-eugen.hristev@collabora.com>
In-Reply-To: <20240606073353.47130-1-eugen.hristev@collabora.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, adilger.kernel@dilger.ca, tytso@mit.edu, krisman@suse.de,
 brauner@kernel.org, jack@suse.cz, ebiggers@google.com,
 viro@zeniv.linux.org.uk, kernel@collabora.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Thu,  6 Jun 2024 10:33:46 +0300 you wrote:
> Hello,
> 
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html
> 
> I resent some of the v9 patches and got some reviews from Gabriel,
> I did changes as requested and here is v18.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v18,1/7] ext4: Simplify the handling of cached casefolded names
    https://git.kernel.org/jaegeuk/f2fs/c/f776f02a2c96
  - [f2fs-dev,v18,2/7] f2fs: Simplify the handling of cached casefolded names
    https://git.kernel.org/jaegeuk/f2fs/c/632f4054b229
  - [f2fs-dev,v18,3/7] libfs: Introduce case-insensitive string comparison helper
    https://git.kernel.org/jaegeuk/f2fs/c/6a79a4e187bd
  - [f2fs-dev,v18,4/7] ext4: Reuse generic_ci_match for ci comparisons
    https://git.kernel.org/jaegeuk/f2fs/c/d76b92f61f3b
  - [f2fs-dev,v18,5/7] f2fs: Reuse generic_ci_match for ci comparisons
    https://git.kernel.org/jaegeuk/f2fs/c/d66858eb0c72
  - [f2fs-dev,v18,6/7] ext4: Move CONFIG_UNICODE defguards into the code flow
    https://git.kernel.org/jaegeuk/f2fs/c/d98c822232f8
  - [f2fs-dev,v18,7/7] f2fs: Move CONFIG_UNICODE defguards into the code flow
    https://git.kernel.org/jaegeuk/f2fs/c/28add38d545f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



