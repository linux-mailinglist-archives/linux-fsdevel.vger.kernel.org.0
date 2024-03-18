Return-Path: <linux-fsdevel+bounces-14771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F3087F17A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 21:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF17281A09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA65A4C2;
	Mon, 18 Mar 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfu+kooN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ECC59B63;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794733; cv=none; b=pF0+bktE2+c79G47o18xfHRXlJxYyp0WY2mHISGW3bBXzgr/uF4gHir7u7EdcjncNbHyQ1GRqLX8AFnDluMt6BcoGZwyZ1JvKy6nyFq7IWi54ATREoc7JQ0isT9Wr656GlOWvdKI1SiasFV8WPTSoHtwkv1ro0KEGubjXQBlVyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794733; c=relaxed/simple;
	bh=bXj+2bey1JiPSRUaDSpuXTcSqhoJrwse8pezMzX/3gg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QVHCq7Oipxwps6+bOhmS0X8YOsLdxouEdBTbdhzD+U4ekQYMBgI6tAXKHwHM+z0iCZg2Yzqn1k7tJJf0SX7vZZeSqRzs2Z5XRzU6BayF9sK3pNwA2E5mXcA7ydYesDjDCC8wfTZHi9Q9kBXh2h4qsySQHgzn4IwHLCFLSG69cIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfu+kooN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44582C433B1;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794733;
	bh=bXj+2bey1JiPSRUaDSpuXTcSqhoJrwse8pezMzX/3gg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cfu+kooNHzOc1lNH+Rcnj80CoPHosepEM3gStSIAr2M9EhZ7EX/ecdSQNpE7b8WkC
	 7mC/VlFf1yKgsuYcZdTeVIBGYs3Gv4LIl5G9QntKQNmWnxGqa18oyQX21dgPcd2q1u
	 Or0qOMRIehhparWC8j4jKCUu0z14KHeXlcAYGquu7Lm2LshxtFaJBdpZ4igdPP/3AB
	 8cffZy583pdgl9Z6nSIbVQP9vYJEBJGai9CtNtT0Gfj/X3jcLqiore3WFGhV6vUQlt
	 qo2MA+DxlUM5FQYXUHS3huMbYcleP4vPuIWxRiavwRe4XKplI5n4SfpcI4zki6ilxe
	 hQ71cuo3OC20w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3293517B6479;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v7 00/10] Set casefold/fscrypt dentry operations
 through sb->s_d_op
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171079473320.25373.14169884985890692398.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 20:45:33 +0000
References: <20240221171412.10710-1-krisman@suse.de>
In-Reply-To: <20240221171412.10710-1-krisman@suse.de>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: ebiggers@kernel.org, viro@zeniv.linux.org.uk, jaegeuk@kernel.org,
 brauner@kernel.org, tytso@mit.edu, amir73il@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Gabriel Krisman Bertazi <krisman@suse.de>:

On Wed, 21 Feb 2024 12:14:02 -0500 you wrote:
> Hi,
> 
> v7 of this patchset applying the comments from Eric. Thank you for your
> feedback.  Details in changelog of individual patches.
> 
> As usual, this survived fstests on ext4 and f2fs.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v7,01/10] ovl: Always reject mounting over case-insensitive directories
    https://git.kernel.org/jaegeuk/f2fs/c/2824083db76c
  - [f2fs-dev,v7,02/10] fscrypt: Factor out a helper to configure the lookup dentry
    https://git.kernel.org/jaegeuk/f2fs/c/8b6bb995d381
  - [f2fs-dev,v7,03/10] fscrypt: Drop d_revalidate for valid dentries during lookup
    https://git.kernel.org/jaegeuk/f2fs/c/e86e6638d117
  - [f2fs-dev,v7,04/10] fscrypt: Drop d_revalidate once the key is added
    https://git.kernel.org/jaegeuk/f2fs/c/e9b10713e82c
  - [f2fs-dev,v7,05/10] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
    https://git.kernel.org/jaegeuk/f2fs/c/e6ca2883d987
  - [f2fs-dev,v7,06/10] libfs: Add helper to choose dentry operations at mount-time
    https://git.kernel.org/jaegeuk/f2fs/c/70dfe3f0d239
  - [f2fs-dev,v7,07/10] ext4: Configure dentry operations at dentry-creation time
    https://git.kernel.org/jaegeuk/f2fs/c/04aa5f4eba49
  - [f2fs-dev,v7,08/10] f2fs: Configure dentry operations at dentry-creation time
    https://git.kernel.org/jaegeuk/f2fs/c/be2760a703e6
  - [f2fs-dev,v7,09/10] ubifs: Configure dentry operations at dentry-creation time
    https://git.kernel.org/jaegeuk/f2fs/c/bc401c2900c1
  - [f2fs-dev,v7,10/10] libfs: Drop generic_set_encrypted_ci_d_ops
    https://git.kernel.org/jaegeuk/f2fs/c/101c3fad29d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



