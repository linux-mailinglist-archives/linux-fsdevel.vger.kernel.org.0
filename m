Return-Path: <linux-fsdevel+bounces-52135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308B7ADF8DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 23:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF69B7A4C4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E127E05D;
	Wed, 18 Jun 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJhzb4Xv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A327D77A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282778; cv=none; b=c0Wxu7cdzT8PE9fZ4VDw65P70nDK7TzCbCbHRcvkCCvIVz93WZcjLumi5yKUSJEJtEOgs48RY14djE9dh4N7bYvG0gzOy5u+cprWppZ0wnrv3yoUR6fW67DLd3+SecPXtK1iOWkQBEyvLVqoMmPhffygYT2IUlsCH1MiwaW97pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282778; c=relaxed/simple;
	bh=hY/QMmnFyygQgDp6Hym88UYb9L8M8LHxSoMzGuUR88Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O4vxENK3OkSG66xpQVHocQuLoDnUDA5FZRn/aUPpL5awgqGfGDt6eCiTvGRibQUiLSId7HC/Xt7VuFrXdOJuJ0ZtJop0biNwUtZCNob+tD+z/ogZTiWKNFldNl1BSmfdtPERUsUlPvgPl8KTKNww80zLnnUbQln6OYUeS8dvLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJhzb4Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B182DC4CEE7;
	Wed, 18 Jun 2025 21:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750282777;
	bh=hY/QMmnFyygQgDp6Hym88UYb9L8M8LHxSoMzGuUR88Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EJhzb4XvKjDMpaOigxAtiMHwKC+kHZtGPgvRhkQcD+J05GiqY4OGb3CFNazA+mvai
	 Z43iAHg2Lkhf7QOEDG3W3DKAITpsKv1COPxVWIKqjExLrHvjZqlSi6ojC/G3qjnhep
	 k0ryuM2Bg2LQjIZN2GjW6/Wpq83457FbmqlkQiymAbOXKnWX5nHmQniAxABT/oNGpb
	 mhvVOK62csmQd/WjLiSvSF8/L9z6SMpomLsoN4+r7PhqVAEyW8zcDn5bwr2pI3YtDy
	 J17G0jY6UJ8vfT3q9tJ43Jdz90IIP0LcrzNnOm3uyct1Qflrw/6iE7JG5NTihMloxu
	 ACFRx0dBr76zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AD93806649;
	Wed, 18 Jun 2025 21:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix __write_node_folio() conversion
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175028280599.266369.3803881518609217106.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 21:40:05 +0000
References: <20250601002709.4094344-1-willy@infradead.org>
In-Reply-To: <20250601002709.4094344-1-willy@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, hch@lst.de,
 syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun,  1 Jun 2025 01:26:54 +0100 you wrote:
> This conversion moved the folio_unlock() to inside __write_node_folio(),
> but missed one caller so we had a double-unlock on this path.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Chao Yu <chao@kernel.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Reported-by: syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com
> Fixes: 80f31d2a7e5f (f2fs: return bool from __write_node_folio)
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Fix __write_node_folio() conversion
    https://git.kernel.org/jaegeuk/f2fs/c/6dea74e454c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



