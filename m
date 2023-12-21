Return-Path: <linux-fsdevel+bounces-6737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6F81B898
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22D1B24625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C96768ED;
	Thu, 21 Dec 2023 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrXA1XjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9AE745D3;
	Thu, 21 Dec 2023 13:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86833C433C9;
	Thu, 21 Dec 2023 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703165424;
	bh=b9O0U6oNiM++fvQDjFqQVxcTKaq9uUhkH00iQIRnzoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GrXA1XjHhA5kIqh67AiYXjsBA1/kfDnc12S55pg03Xt5PBrlYmEJ2x59V+VtG2Uj3
	 v3Q4BHH9flTDsNeXUyrLx+PVJh27JE6HIZIPHoi04OvVrOYRfTMfVxOkqnJHLf/kWB
	 LzjHj4DSj8Yh7xaCxEQ8H87y1MGLW8x2SWGB1YUgkO1oez3M8FLJHi8a9XO8UqeWcB
	 azFIjsHHIAdv1/W+Y2FchzaoxydNtOIniearFUYlUvSrgnp6wmgNzK3+z+FxomCwva
	 yRyabZeXjmINTxiU4XxjKbLByt5TxqWLRQBEEKRbVD9GHG5xdIk2a/qevXlA91H2PY
	 dN/436e0bV+lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DB1FD8C98B;
	Thu, 21 Dec 2023 13:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Re-support uid and gid when mounting bpffs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170316542444.15316.13410322565647392236.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 13:30:24 +0000
References: <20231220133805.20953-1-daniel@iogearbox.net>
In-Reply-To: <20231220133805.20953-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, brauner@kernel.org, jiejiang@chromium.org,
 andrii@kernel.org, linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 20 Dec 2023 14:38:05 +0100 you wrote:
> For a clean, conflict-free revert of the token-related patches in commit
> d17aff807f84 ("Revert BPF token-related functionality"), the bpf fs commit
> 750e785796bb ("bpf: Support uid and gid when mounting bpffs") was undone
> temporarily as well.
> 
> This patch manually re-adds the functionality from the original one back
> in 750e785796bb, no other functional changes intended.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Re-support uid and gid when mounting bpffs
    https://git.kernel.org/bpf/bpf-next/c/b08c8fc0411d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



