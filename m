Return-Path: <linux-fsdevel+bounces-25350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA65594AFEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A441F226D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9C01419A1;
	Wed,  7 Aug 2024 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C35JX/tl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD304653A;
	Wed,  7 Aug 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056031; cv=none; b=al30nEAEQpPXxWiaNan0da71/Jvo6s6NCAdW4MkLjiGyClSGuAf3X+AmK4CO7k9slJ9PG2hTmL9ZoE7DWQe2WYYCnCt0b/xkkh/hjryWxpU8494JiPnkUFM1r0n085mqqkRi6yngCiSBpvQoBtfTYL8eLlWIm6FHQ1yjd8MmR/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056031; c=relaxed/simple;
	bh=xKSP+Nl0MCi2j4+W3yaUvR8ZnvGtlHqTUIF0XcSiQz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I5YFDJ5AkviAUPSutedtQoiT5c1gDfyeLSZLAOpl25HBwJbkm4RjwVsrXtJL58yjfLyVnzPTnsY0u95FaPRZsdepy2E2BwNrvK087ChSEzsZ9CFeblFPOzmbEDlTaM4xMAlIAFmQq9bd5reYPAKkMIwWQKAERPx/0hWJrpdn/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C35JX/tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8326C32781;
	Wed,  7 Aug 2024 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723056029;
	bh=xKSP+Nl0MCi2j4+W3yaUvR8ZnvGtlHqTUIF0XcSiQz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C35JX/tlqJmu0CsH8ZvEsoOE8oSi95eNqjURkgvP8zXqEQik5g5h7OLPX//S7E/mK
	 VuMOLj/ClRJNisI2GP86N9qTSmcrYprmA0nxLnh5SrXD/1QY0abT0N+5cXFK2UHKrL
	 aMr5B1Kf9W4X5JCh3zfPwsBz5XwY6x0E3EUELQ0SZ6Kv1IeX2mryglQVkQ9+mxwjZp
	 TdK7G4+Zhx1+fh0MQjYfZXmr7d1CW1dnkCIWinhnhtZaBg8hmNi+G69iCgJ2an5A9L
	 iJOzGShGSTncAm5MZIwO0fzqsVQBVp/QsZXc3Drrvb02QyczEZYIcPpyEUrrLIdQHP
	 wc2GGoLnqfdhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0CF3822D3B;
	Wed,  7 Aug 2024 18:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/3] Add bpf_get_dentry_xattr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172305602851.2655981.17752310916593091167.git-patchwork-notify@kernel.org>
Date: Wed, 07 Aug 2024 18:40:28 +0000
References: <20240806230904.71194-1-song@kernel.org>
In-Reply-To: <20240806230904.71194-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, kpsingh@kernel.org, liamwisehart@meta.com, lltang@meta.com,
 shankaran@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  6 Aug 2024 16:09:01 -0700 you wrote:
> Add a kfunc to read xattr from dentry. Also add selftest for the new
> kfunc.
> 
> Changes v3 => v4:
> 1. Fix selftest build.
> 
> V3: https://lore.kernel.org/bpf/20240806203340.3503805-1-song@kernel.org/T/#u
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/3] bpf: Move bpf_get_file_xattr to fs/bpf_fs_kfuncs.c
    https://git.kernel.org/bpf/bpf-next/c/fa4e5afa9758
  - [v4,bpf-next,2/3] bpf: Add kfunc bpf_get_dentry_xattr() to read xattr from dentry
    https://git.kernel.org/bpf/bpf-next/c/ac13a4261afe
  - [v4,bpf-next,3/3] selftests/bpf: Add tests for bpf_get_dentry_xattr
    https://git.kernel.org/bpf/bpf-next/c/8681156c0939

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



