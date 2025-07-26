Return-Path: <linux-fsdevel+bounces-56090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB20B12BFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 21:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC404E50E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 19:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70990289367;
	Sat, 26 Jul 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG2Wqa4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192263CF;
	Sat, 26 Jul 2025 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753556991; cv=none; b=ngsBqtftwYNnL+MnsjVC9DonS+t3/Wy0kQWD3eEcE+cDSkw7gMyz4UF6Auc95h+0AcO2hoOPVMb/wNaCqrVsQfohD4OpDpg1rGx5J7+nXWNbSptBWpyHVkhchBUQYrE0hPaJXbEKzNXSHQ6T1EroWbCp1U6MjBqBvWo1A2wGBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753556991; c=relaxed/simple;
	bh=em1H+20/3NrGcJeuw0quGahnh/fyWgetY87ezgSJ6fA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lrm5+NEX55o6XofgEhn4J8MIWFnvf4z5oIzVH6nx6jsyZkXiFxeSqciwZR5SnGazFig3mudfsrwGFZKgLIxFOkgZ9rTrsbANsP6XEi2M9wYUvSUgH3NKOZTYRtPu5EKX731sQnQ+20VAfznkCA0Vnf5DJZyQ2RMiasTYJkggRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG2Wqa4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496C9C4CEED;
	Sat, 26 Jul 2025 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753556991;
	bh=em1H+20/3NrGcJeuw0quGahnh/fyWgetY87ezgSJ6fA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MG2Wqa4QTZemGTLnkK/mpXvprVu0w0Tg/M4kHIZU3IZjUcvGPXbCa2uPq8pDT9bwA
	 0Maz4d+V9ug65iUfQSuUc6rDIxOaKuRHNXdba1fLQdvfTYIOMDgLO7Wj1P2SUmY+Lc
	 RIjj4+gL8iSdkQb/FBg8E3sO44UB1sm2B/cIwlCVDMsGKnQA/EfQIPUvTCveAfQfwT
	 1RwKvdF/5mQ7d3dV2HWLXpHOnqANmRya5VYS/+93FlPMffWSbTKgI7JAbhzAzwJne1
	 G8l/Hh75y05xnm01r+cUnpI7UD+KhuI9sm10ULVdlbOdIY2RVymnhWSoSFS/V4t2oL
	 u5ggY0oJH/Rpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF91383BF4E;
	Sat, 26 Jul 2025 19:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] umd: Remove usermode driver framework
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355700852.3670812.12053972332203864390.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 19:10:08 +0000
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
In-Reply-To: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@codeaurora.org
Cc: viro@zeniv.linux.org.uk, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, ebiederm@xmission.com,
 hch@lst.de, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 21 Jul 2025 11:04:40 +0200 you wrote:
> The code is unused, remove it.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weißschuh (2):
>       bpf/preload: Don't select USERMODE_DRIVER
>       umd: Remove usermode driver framework
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf/preload: Don't select USERMODE_DRIVER
    https://git.kernel.org/bpf/bpf-next/c/2b03164eee20
  - [bpf-next,2/2] umd: Remove usermode driver framework
    https://git.kernel.org/bpf/bpf-next/c/b7b3500bd4ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



