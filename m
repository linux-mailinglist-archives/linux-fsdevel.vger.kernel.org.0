Return-Path: <linux-fsdevel+bounces-32259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AFB9A2DF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C08283D2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3942281DC;
	Thu, 17 Oct 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv7Pu+CY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9322738B;
	Thu, 17 Oct 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194023; cv=none; b=Z1ECXWUeK4TW18ts9/hlJ9ErHcQDnpIxdskbHUidtL58WBXSvbQFPVb+y6hseTujUIBQzuYzOQBDND23tnWFqlH/YCLFSAnsFFgkAPF3ht8UpP2IQrTylF89JHoIz691+SJZFAjF8hRMk7w6/tq8jOkdnP8YBT3hDzBtASJlUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194023; c=relaxed/simple;
	bh=iH5RiH1vuDk1iDeH/6hgf5SGk7IQ7OCmR7HIM2uyw2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ijhagHnEoCAhK4ft+rt0narDLXci3gVI2wf4vhfUvS0dk3pQveHFd4BULqFJnyjitHKVYJXZsaKQ+T4hqCBWAycvPpCbelXx+L4DV/EGx/eWAXVSFW9vig48dSRDC/5zgP8REA0nYbzT4PgDLV1ymQjrWsyPfhP5kn+cgnYUeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv7Pu+CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C21C4CED1;
	Thu, 17 Oct 2024 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729194022;
	bh=iH5RiH1vuDk1iDeH/6hgf5SGk7IQ7OCmR7HIM2uyw2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mv7Pu+CYhdP+0ujlYoD0t4QMFBdm1eHZtrZmYJ77Ed+OaAiJUq7/T2a7HWb6uVBt3
	 pDGs4hi3Nmyz/a7se+PazJUS3hqdEanSawzYPoLYaLXgAH9l7SooNFP/RY4juiNt10
	 ftfQMVJjS7ZDUkVfhWaehsRBidH6Vxx4qCS4bEVg2kZoGyiTEuVb8xpmU5ZPDFkoAF
	 mrZY5ZrLPvo9vBpoMpl6yQr1kb429OQVhWZyZo0t2EputFL94avtBt0EwIwLD6M1SL
	 q44dOPWncYVK/8/F/JYe7RdmPkF0KfkwJZeEvgRzlFloBSwDIMRU0Li5uLUPh/mv0k
	 yCOHTiD0GGAyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710543809A8A;
	Thu, 17 Oct 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172919402828.2588042.15937382646203304211.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 19:40:28 +0000
References: <20241017174713.2157873-1-andrii@kernel.org>
In-Reply-To: <20241017174713.2157873-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, rppt@kernel.org, david@redhat.com,
 yosryahmed@google.com, shakeel.butt@linux.dev, yi1.lai@intel.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 17 Oct 2024 10:47:13 -0700 you wrote:
> From memfd_secret(2) manpage:
> 
>   The memory areas backing the file created with memfd_secret(2) are
>   visible only to the processes that have access to the file descriptor.
>   The memory region is removed from the kernel page tables and only the
>   page tables of the processes holding the file descriptor map the
>   corresponding physical memory. (Thus, the pages in the region can't be
>   accessed by the kernel itself, so that, for example, pointers to the
>   region can't be passed to system calls.)
> 
> [...]

Here is the summary with links:
  - [v3,bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
    https://git.kernel.org/bpf/bpf/c/5ac9b4e935df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



