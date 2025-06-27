Return-Path: <linux-fsdevel+bounces-53125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F206AEACC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 04:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13A93BED83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 02:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDF6194098;
	Fri, 27 Jun 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS/pSIfa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5871419A9;
	Fri, 27 Jun 2025 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990785; cv=none; b=ZWWZQyTTVAV6v/8rpQ+mB4uaGwKGDppmSwbqaSdwthguGBkZGweIyMk57tVOYNHCQFOm3yKVWv0NSUkCSWPaPgZrX+O4Yt1Uu65UocqKjljmRFspomtQBUt2YjnSrHi3vfYiMZDizuLlSJotwGz13nzigISWyNFn+vLwH6H9Lkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990785; c=relaxed/simple;
	bh=1TRTrlnEhv1auSlPFPXhRenrM0VKQnIvy72QHXbA4ro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T0kvPbU49qOTWxYVuO6x8RHdHMdxUZsEePFKEKWHL99F1+95ufdM8wGp6Ptw45ejKOf1d2pE+eGabtzWuZE81eyfaAq7fIvVZ5ovalc7keEPUxNB1Dr77P5Byeu1qPLpQhYo2EmJYVEW948wDU6pXV8h/vwZyoJPh7dKKov++fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS/pSIfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6C6C4CEEB;
	Fri, 27 Jun 2025 02:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750990784;
	bh=1TRTrlnEhv1auSlPFPXhRenrM0VKQnIvy72QHXbA4ro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aS/pSIfajx4zge7h/nw7AE72QVdxirPOR/T/sT2GtIZOgFQVMpAj8kPNtKNWNCsuo
	 oYkYDgQSmeqY47R1mSmRRqyG3Fh5ggU9LYP9Vchvq28yJFrFw0rZU3euBX4azFi+5d
	 Y2SoGmQGi0MK1+AIqxX4CUa3Xyp/hxB1BFxwZY9EcgF3O5G13JbC4sB9MPhAn8xyPB
	 WVTgPuHfDpr3syJnOdRmYqimH9B/wk5BkYatIrDs2bofksAKhK3PCIG6wD+UxVO0MO
	 b3Y1IXlhMBDic3Yr/FKX8jdm2tLO49wyfps8e6sVUgGgJ2J1zfrz9uzRGmHmanyZhO
	 80dYabyP2XXyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFEF3A40FCB;
	Fri, 27 Jun 2025 02:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175099081075.1402944.15924179208170467292.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 02:20:10 +0000
References: <20250623063854.1896364-1-song@kernel.org>
In-Reply-To: <20250623063854.1896364-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, gregkh@linuxfoundation.org,
 tj@kernel.org, daan.j.demeyer@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Christian Brauner <brauner@kernel.org>:

On Sun, 22 Jun 2025 23:38:50 -0700 you wrote:
> Introduce a new kfunc bpf_cgroup_read_xattr, which can read xattr from
> cgroupfs nodes. The primary users are LSMs, cgroup programs, and sched_ext.
> 
> ---
> 
> Changes v2 => v3:
> 1. Make bpf_cgroup_read_xattr available to all program types.
> 2. Fix gcc build warning on the selftests.
> 3. Add "ifdef CONFIG_CGROUPS" around bpf_cgroup_read_xattr.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/4] kernfs: remove iattr_mutex
    (no matching commit)
  - [v3,bpf-next,2/4] bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
    https://git.kernel.org/bpf/bpf-next/c/535b070f4a80
  - [v3,bpf-next,3/4] bpf: Mark cgroup_subsys_state->cgroup RCU safe
    https://git.kernel.org/bpf/bpf-next/c/1504d8c7c702
  - [v3,bpf-next,4/4] selftests/bpf: Add tests for bpf_cgroup_read_xattr
    https://git.kernel.org/bpf/bpf-next/c/f4fba2d6d282

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



