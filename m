Return-Path: <linux-fsdevel+bounces-8829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5183B5E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 01:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2132B239AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594871369;
	Thu, 25 Jan 2024 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuOvSBm7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC327F;
	Thu, 25 Jan 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141435; cv=none; b=sNcWajb/00H4FJ+vghEu6lfiMuX757VkVEu51GgMAEo1G3koGM8V/prAwseCz5UwqtnxFDhlAzqzyrcvIqJ3EKxXsV9U3E/NHdnmok2xfqwtiy0u4MHK+rTdy5mR0/1Ph6NkLsKIAqqvGSXWkIzObFheAKx/u3heFOI07sRA5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141435; c=relaxed/simple;
	bh=KfsJCFihgat+fHBz9kmkoUU7Cl7fXKrRxZVnIx/ceUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V885/MZQTtm8VLCKEIIPHODHxP3RF93DOxNxDm7bvAwn8yvfmbCjuCNpmTXnhRLgoP9ToJxGz3ZvddprmN8NufBRAgvF19xO5WIVzUWDbWBmEbjPQNZXcQhAmc8eUlCbJN2bFXM33d2xPmUXda+YPpfYspzrgI8iBCcVqk4OcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuOvSBm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2468BC433C7;
	Thu, 25 Jan 2024 00:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706141435;
	bh=KfsJCFihgat+fHBz9kmkoUU7Cl7fXKrRxZVnIx/ceUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cuOvSBm72sNf61zmLyzqiaquPTNavPhdhg/1Rft9wR1qb1Nd4+4Y8xafn3FLHYnh5
	 yIz1w1Jl/cS2gn0I65yCCqSRY4P3UBG7sS5jMR6V4O3dJ1Vy4Bld8fGvVAY8EjX9CM
	 kF2+RuXUEIfyu286h3uoLzel6Nw+QRR9UQTWAOdsCW+73BHzx2lnXqd3KqRhECtdP/
	 xdi3sbrUDxNfMoZnDtfJjnhSY9yV8UtBwF2nXZpjPXjO4lNXiPO4NiQmrH27aHlxyZ
	 omuEEWxJnP9RqvsmMyqDYZGAVPycfdsg7L6KA6M95Q9SBNCQ6w4/f5nYn73c2IrQ11
	 TgHhp7PB8VCVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0266AD8C966;
	Thu, 25 Jan 2024 00:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 00/30] BPF token
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170614143500.20623.3003025793272945482.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 00:10:35 +0000
References: <20240124022127.2379740-1-andrii@kernel.org>
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
 brauner@kernel.org, torvalds@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 23 Jan 2024 18:20:57 -0800 you wrote:
> This patch set is a combination of three BPF token-related patch sets ([0],
> [1], [2]) with fixes ([3]) to kernel-side token_fd passing APIs incorporated
> into relevant patches, bpf_token_capable() changes requested by
> Christian Brauner, and necessary libbpf and BPF selftests side adjustments.
> 
> This patch set introduces an ability to delegate a subset of BPF subsystem
> functionality from privileged system-wide daemon (e.g., systemd or any other
> container manager) through special mount options for userns-bound BPF FS to
> a *trusted* unprivileged application. Trust is the key here. This
> functionality is not about allowing unconditional unprivileged BPF usage.
> Establishing trust, though, is completely up to the discretion of respective
> privileged application that would create and mount a BPF FS instance with
> delegation enabled, as different production setups can and do achieve it
> through a combination of different means (signing, LSM, code reviews, etc),
> and it's undesirable and infeasible for kernel to enforce any particular way
> of validating trustworthiness of particular process.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,01/30] bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
    https://git.kernel.org/bpf/bpf-next/c/1310957bfe65
  - [v2,bpf-next,02/30] bpf: add BPF token delegation mount options to BPF FS
    https://git.kernel.org/bpf/bpf-next/c/e43831fe57bb
  - [v2,bpf-next,03/30] bpf: introduce BPF token object
    https://git.kernel.org/bpf/bpf-next/c/5263a65a6ac2
  - [v2,bpf-next,04/30] bpf: add BPF token support to BPF_MAP_CREATE command
    https://git.kernel.org/bpf/bpf-next/c/18c9f8248366
  - [v2,bpf-next,05/30] bpf: add BPF token support to BPF_BTF_LOAD command
    https://git.kernel.org/bpf/bpf-next/c/6f19475e52cc
  - [v2,bpf-next,06/30] bpf: add BPF token support to BPF_PROG_LOAD command
    https://git.kernel.org/bpf/bpf-next/c/5880ef9dc52a
  - [v2,bpf-next,07/30] bpf: take into account BPF token when fetching helper protos
    https://git.kernel.org/bpf/bpf-next/c/b1099b53eee6
  - [v2,bpf-next,08/30] bpf: consistently use BPF token throughout BPF verifier logic
    https://git.kernel.org/bpf/bpf-next/c/3f042d22873b
  - [v2,bpf-next,09/30] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
    https://git.kernel.org/bpf/bpf-next/c/d2fd2efe9797
  - [v2,bpf-next,10/30] bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
    https://git.kernel.org/bpf/bpf-next/c/a60dd8f5232a
  - [v2,bpf-next,11/30] bpf,lsm: add BPF token LSM hooks
    https://git.kernel.org/bpf/bpf-next/c/736762bc089d
  - [v2,bpf-next,12/30] libbpf: add bpf_token_create() API
    https://git.kernel.org/bpf/bpf-next/c/aa6385965f34
  - [v2,bpf-next,13/30] libbpf: add BPF token support to bpf_map_create() API
    https://git.kernel.org/bpf/bpf-next/c/8b7971beaa5f
  - [v2,bpf-next,14/30] libbpf: add BPF token support to bpf_btf_load() API
    https://git.kernel.org/bpf/bpf-next/c/3f06a307a8ae
  - [v2,bpf-next,15/30] libbpf: add BPF token support to bpf_prog_load() API
    https://git.kernel.org/bpf/bpf-next/c/34ace19d6c52
  - [v2,bpf-next,16/30] selftests/bpf: add BPF token-enabled tests
    https://git.kernel.org/bpf/bpf-next/c/3d8da8a12fcd
  - [v2,bpf-next,17/30] bpf,selinux: allocate bpf_security_struct per BPF token
    https://git.kernel.org/bpf/bpf-next/c/f78006420686
  - [v2,bpf-next,18/30] bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
    https://git.kernel.org/bpf/bpf-next/c/ef4fc8918e7a
  - [v2,bpf-next,19/30] bpf: support symbolic BPF FS delegation mount options
    https://git.kernel.org/bpf/bpf-next/c/e45dac29dc87
  - [v2,bpf-next,20/30] selftests/bpf: utilize string values for delegate_xxx mount options
    https://git.kernel.org/bpf/bpf-next/c/9d4ebc33d665
  - [v2,bpf-next,21/30] libbpf: split feature detectors definitions from cached results
    https://git.kernel.org/bpf/bpf-next/c/05d51b9f2c99
  - [v2,bpf-next,22/30] libbpf: further decouple feature checking logic from bpf_object
    https://git.kernel.org/bpf/bpf-next/c/0c2bd7588e5d
  - [v2,bpf-next,23/30] libbpf: move feature detection code into its own file
    https://git.kernel.org/bpf/bpf-next/c/df7f8d83b298
  - [v2,bpf-next,24/30] libbpf: wire up token_fd into feature probing logic
    https://git.kernel.org/bpf/bpf-next/c/5955455b74bd
  - [v2,bpf-next,25/30] libbpf: wire up BPF token support at BPF object level
    https://git.kernel.org/bpf/bpf-next/c/4ba1dbeb6982
  - [v2,bpf-next,26/30] selftests/bpf: add BPF object loading tests with explicit token passing
    https://git.kernel.org/bpf/bpf-next/c/b2f72bbb2857
  - [v2,bpf-next,27/30] selftests/bpf: add tests for BPF object load with implicit token
    https://git.kernel.org/bpf/bpf-next/c/d4e4ea903a04
  - [v2,bpf-next,28/30] libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PATH envvar
    https://git.kernel.org/bpf/bpf-next/c/e296ff93f7e9
  - [v2,bpf-next,29/30] selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar
    https://git.kernel.org/bpf/bpf-next/c/d168bbfbf776
  - [v2,bpf-next,30/30] selftests/bpf: incorporate LSM policy to token-based tests
    https://git.kernel.org/bpf/bpf-next/c/6b9a115dbde0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



