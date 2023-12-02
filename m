Return-Path: <linux-fsdevel+bounces-4672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 321E7801909
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 01:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5B7B210D0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D418323C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui97RVvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F3184C;
	Sat,  2 Dec 2023 00:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69DA7C433C9;
	Sat,  2 Dec 2023 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701477028;
	bh=3ICprJ3TFXtLAmaVlFtLTPb2DecozWP4JkU+7Qj6t9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ui97RVvl8y2bI7hVscQWlOaMyv+dVQwjZlcNd0Wn3AthNx25EITMr2LoV3pdhpljB
	 bbGHlvcPak3Z8Wu9LZZCWvLAvsm8CS651EkpTvAoFzXHbutn0vQBpKFHtdbtgv6jwH
	 lqb/x7BcpIS4eyQHtjYGDPoifk/IUIx1e+Vd/UYaR2qup8UT7WQ6yQKF5aJiBJoepR
	 efwrGtvxJ19Hi4SZOPJgm14FsdtBRazjTks3zLpRKrIXVJQqtuEfjcWa5krLx4SqCr
	 aXCaPBta2DFSzUQ7FM0Thm1RuICPEozBnVR1QZFGPiSn7h9yYTeJtsoOCu4t0bpX2z
	 GOnRCkGUbXzEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D512DFAA94;
	Sat,  2 Dec 2023 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v15 bpf-next 0/6] bpf: File verification with LSM and fsverity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170147702831.23135.7635663186480885379.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 00:30:28 +0000
References: <20231129234417.856536-1-song@kernel.org>
In-Reply-To: <20231129234417.856536-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev, ebiggers@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, brauner@kernel.org, viro@zeniv.linux.org.uk,
 casey@schaufler-ca.com, amir73il@gmail.com, kpsingh@kernel.org,
 roberto.sassu@huawei.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 29 Nov 2023 15:44:11 -0800 you wrote:
> Changes v14 => v15:
> 1. Fix selftest build without CONFIG_FS_VERITY. (Alexei)
> 2. Add Acked-by from KP.
> 
> Changes v13 => v14:
> 1. Add "static" for bpf_fs_kfunc_set.
> 2. Add Acked-by from Christian Brauner.
> 
> [...]

Here is the summary with links:
  - [v15,bpf-next,1/6] bpf: Add kfunc bpf_get_file_xattr
    https://git.kernel.org/bpf/bpf-next/c/ac9c05e0e453
  - [v15,bpf-next,2/6] bpf, fsverity: Add kfunc bpf_get_fsverity_digest
    https://git.kernel.org/bpf/bpf-next/c/67814c00de31
  - [v15,bpf-next,3/6] Documentation/bpf: Add documentation for filesystem kfuncs
    https://git.kernel.org/bpf/bpf-next/c/0de267d9ec65
  - [v15,bpf-next,4/6] selftests/bpf: Sort config in alphabetic order
    https://git.kernel.org/bpf/bpf-next/c/6b0ae4566aba
  - [v15,bpf-next,5/6] selftests/bpf: Add tests for filesystem kfuncs
    https://git.kernel.org/bpf/bpf-next/c/341f06fdddf7
  - [v15,bpf-next,6/6] selftests/bpf: Add test that uses fsverity and xattr to sign a file
    https://git.kernel.org/bpf/bpf-next/c/1030e9154258

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



