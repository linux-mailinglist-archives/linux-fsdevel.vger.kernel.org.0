Return-Path: <linux-fsdevel+bounces-54674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E74DB021D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265EF1CC123C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CFB2EF65B;
	Fri, 11 Jul 2025 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOlH7JWn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C942EF641
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251391; cv=none; b=lzY/GLlPVYInnrxKUZV/GcP6g8LzShycWMPBgfjbq1F0zMNEA6EKEX5A6b1HTPr4MsKpP8gmnzCP/e97gP7XtxNww1E/9jiyP9FHoSamV2V/PrxGBPJnNMKk3tHL1Q5Suq1Koge0/KHCt8rO9DGkDjF0F8AZ8p5+FA9zjdnsUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251391; c=relaxed/simple;
	bh=ARXXPEvWggOQbL5AW5/qAs8S07zuEFx1XkITdnx9C7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gj0haXIY5CpdZsWy2G7FIUu26LlqHRH1NADoYDOGvuJrRoLSXsjEWp2Vl4JVc6MshLe799xuKh/TE329TnhigNhVESI+WVqJK4IFC517QTSrC+EE9fPI0UhlUoYUcFqACegXdKsc9CU2gB/271fqc3yD4fP6uYi9cfTcNQCHEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOlH7JWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D273C4CEEF;
	Fri, 11 Jul 2025 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752251390;
	bh=ARXXPEvWggOQbL5AW5/qAs8S07zuEFx1XkITdnx9C7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pOlH7JWn9OF4JXsHjXXgypMcgXPieO9WWiBtoHYLbUe+wl6eoCkhtfUw/VpZ/pLgP
	 UVD9j2Wp43vIxcIew7ysyG9Ee23mzSJZvFXCx+IIcKzhp25tGO1dw0U+l8v67VYKMN
	 dR7yADCQm4SYZCe2E3hUXpgXh3eXzmSzZV7r0hK2feZcob8JCKo9nWSFaIfBJ1cuPL
	 zAKXYYAYTI8sOrHn+SSx6o24nJyWjuo6vlYKi/dGzt+69PL7lEAPzQU6mhh61JLMtU
	 5xzVUPlVVXgEDw5xoTuDlr76cFPt87D4BoNVA2jpWMuiNDsyIw88Un8Y8eBsI6n3y2
	 LPfy0GpTl7taQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC0F383B275;
	Fri, 11 Jul 2025 16:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V3 1/7] f2fs: Add fs parameter specifications
 for
 mount options
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175225141224.2328592.8724744355283588501.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 16:30:12 +0000
References: <20250423170926.76007-2-sandeen@redhat.com>
In-Reply-To: <20250423170926.76007-2-sandeen@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, lihongbo22@huawei.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 23 Apr 2025 12:08:45 -0500 you wrote:
> From: Hongbo Li <lihongbo22@huawei.com>
> 
> Use an array of `fs_parameter_spec` called f2fs_param_specs to
> hold the mount option specifications for the new mount api.
> 
> Add constant_table structures for several options to facilitate
> parsing.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V3,1/7] f2fs: Add fs parameter specifications for mount options
    https://git.kernel.org/jaegeuk/f2fs/c/a3277c98b64f
  - [f2fs-dev,V3,2/7] f2fs: move the option parser into handle_mount_opt
    (no matching commit)
  - [f2fs-dev,V3,3/7] f2fs: Allow sbi to be NULL in f2fs_printk
    https://git.kernel.org/jaegeuk/f2fs/c/405e5e00bfee
  - [f2fs-dev,V3,4/7] f2fs: Add f2fs_fs_context to record the mount options
    (no matching commit)
  - [f2fs-dev,V3,5/7] f2fs: separate the options parsing and options checking
    (no matching commit)
  - [f2fs-dev,V3,6/7] f2fs: introduce fs_context_operation structure
    https://git.kernel.org/jaegeuk/f2fs/c/54e12a4e0209
  - [f2fs-dev,V3,7/7] f2fs: switch to the new mount api
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



