Return-Path: <linux-fsdevel+bounces-5040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651958077D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BBC282132
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02CD36F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gvei+Lpx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1F6E5AB;
	Wed,  6 Dec 2023 18:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D334CC433C9;
	Wed,  6 Dec 2023 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701886830;
	bh=Cnn+RvTtiAPa+LzA6NHBbTIY/A5CgVw7ZaZgTkksPhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gvei+LpxW2wFetBUTRFp1hqixYVQug8tQC5DOYjSqGRWR61CTaedeo0G7bDQvCTlk
	 ADbxSobnMGLKN8j629fvcXEQgHIegxtcPZwOtUC8L4vkaw7PfAumYFzvPEsK9+2jN8
	 2vZ3u5ZZK3D1EFZFddm6jx9JcNlHDpvq7EH1y3spoSugtyz0RC3BoNEhrdQEtLroNW
	 DwEmoNLf8jQrxlvRyCIok2btrlUdQfK2cYoLRCMEiYiALgB7ZF7yFsTuQgF9PgcCxg
	 fntz/Q+LpS/ZAIdQ+lJjJ8e8RcThFDpOMLBFOz/VsLnswKZmeRvYC454y86nub80IZ
	 sUcj4Jq/8w7LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7F86C00446;
	Wed,  6 Dec 2023 18:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 bpf-next 00/17] BPF token and BPF FS-based delegation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170188683075.21405.15376441127449245098.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 18:20:30 +0000
References: <20231130185229.2688956-1-andrii@kernel.org>
In-Reply-To: <20231130185229.2688956-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
 brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 kernel-team@meta.com, sargun@sargun.me

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 30 Nov 2023 10:52:12 -0800 you wrote:
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
  - [v12,bpf-next,01/17] bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
    https://git.kernel.org/bpf/bpf-next/c/909fa05dd3c1
  - [v12,bpf-next,02/17] bpf: add BPF token delegation mount options to BPF FS
    https://git.kernel.org/bpf/bpf-next/c/40bba140c60f
  - [v12,bpf-next,03/17] bpf: introduce BPF token object
    https://git.kernel.org/bpf/bpf-next/c/4527358b7686
  - [v12,bpf-next,04/17] bpf: add BPF token support to BPF_MAP_CREATE command
    https://git.kernel.org/bpf/bpf-next/c/688b7270b3cb
  - [v12,bpf-next,05/17] bpf: add BPF token support to BPF_BTF_LOAD command
    https://git.kernel.org/bpf/bpf-next/c/ee54b1a910e4
  - [v12,bpf-next,06/17] bpf: add BPF token support to BPF_PROG_LOAD command
    https://git.kernel.org/bpf/bpf-next/c/e1cef620f598
  - [v12,bpf-next,07/17] bpf: take into account BPF token when fetching helper protos
    https://git.kernel.org/bpf/bpf-next/c/4cbb270e115b
  - [v12,bpf-next,08/17] bpf: consistently use BPF token throughout BPF verifier logic
    https://git.kernel.org/bpf/bpf-next/c/8062fb12de99
  - [v12,bpf-next,09/17] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
    https://git.kernel.org/bpf/bpf-next/c/c3dd6e94df71
  - [v12,bpf-next,10/17] bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
    https://git.kernel.org/bpf/bpf-next/c/66d636d70a79
  - [v12,bpf-next,11/17] bpf,lsm: add BPF token LSM hooks
    https://git.kernel.org/bpf/bpf-next/c/d734ca7b33db
  - [v12,bpf-next,12/17] libbpf: add bpf_token_create() API
    https://git.kernel.org/bpf/bpf-next/c/ecd435143eb0
  - [v12,bpf-next,13/17] libbpf: add BPF token support to bpf_map_create() API
    https://git.kernel.org/bpf/bpf-next/c/37891cea6699
  - [v12,bpf-next,14/17] libbpf: add BPF token support to bpf_btf_load() API
    https://git.kernel.org/bpf/bpf-next/c/1a8df7fa00aa
  - [v12,bpf-next,15/17] libbpf: add BPF token support to bpf_prog_load() API
    https://git.kernel.org/bpf/bpf-next/c/1571740a9ba0
  - [v12,bpf-next,16/17] selftests/bpf: add BPF token-enabled tests
    https://git.kernel.org/bpf/bpf-next/c/dc5196fac40c
  - [v12,bpf-next,17/17] bpf,selinux: allocate bpf_security_struct per BPF token
    https://git.kernel.org/bpf/bpf-next/c/36fb94944b35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



