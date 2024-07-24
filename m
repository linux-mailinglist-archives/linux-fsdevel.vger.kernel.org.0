Return-Path: <linux-fsdevel+bounces-24169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C593AB1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 04:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE49F1F23692
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 02:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB26208D7;
	Wed, 24 Jul 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejlJSw/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083841C2A3;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787407; cv=none; b=l4G8HlbU8CpWVcVMl5mIsX21qt6/wKrKddn2Hi8zm6nIklyowBpXE4oOmCx/Ytj2SmSn+DhleHPEiVnWWtl+L52Dwz0vMVGbqL4rfL0t0YfKwLcWxRApmcbb8dfFxIRu9mbmMFHSMr6PzN1kuVpFbKghQ2a+01TYNpee3G3dww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787407; c=relaxed/simple;
	bh=YAphdt5cvZkMjOJF6eiFICf+SX4Aidz7t2RyuBYQf+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=borIsMocTPFLaQZ1NlzL/QwnyQyiMlwKnN6Z0Xvn/9gwyC/XRIgGb4NFUku4zzqirfwU35URgaQsQoXAGk+T0svFnAZQc/hDmLBIqcWEdb49uakvAwvpvM2FnylkgrCvDofviikT1yBac7Jv1lyTd83QOZM4B1V3p6hfGXtEsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejlJSw/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B947BC4AF12;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721787406;
	bh=YAphdt5cvZkMjOJF6eiFICf+SX4Aidz7t2RyuBYQf+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ejlJSw/BBlOT3plFizhSVD/QfSEYIOxm+xA20yjVToNpelN3ccHDJiFjjsvw660u9
	 hgUb3cqTdwNzn3jDVXwIPA1TJz0lV3bWJZqU6E1ly7Ff2VtWzFsrovmJLBNmXixz51
	 TPgZe9En+N9k7oFkEOoVFpbOIrCYfxeIs//V6iO9iJPZYzt5bRr4Oycx6OJNCP+RB4
	 zEL9kjHdGwvhNfuzwbBTQeELhw4VYjAoEcO0kqYxdAxSS+5DCCGKiEVupplMaEnmcP
	 548Vg/no29ytGYnXy0FfD23HAo9g3p39vaDDvwYIYg0/aJLoOJ4372O7ffu6FTXFdM
	 kEksppGOPM+Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADF8AC54BB5;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/6] Remove page_mapping()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172178740670.17759.14780959274097594461.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:16:46 +0000
References: <20240423225552.4113447-1-willy@infradead.org>
In-Reply-To: <20240423225552.4113447-1-willy@infradead.org>
To: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Andrew Morton <akpm@linux-foundation.org>:

On Tue, 23 Apr 2024 23:55:31 +0100 you wrote:
> There are only a few users left.  Convert them all to either call
> folio_mapping() or just use folio->mapping directly.
> 
> Matthew Wilcox (Oracle) (6):
>   fscrypt: Convert bh_get_inode_and_lblk_num to use a folio
>   f2fs: Convert f2fs_clear_page_cache_dirty_tag to use a folio
>   memory-failure: Remove calls to page_mapping()
>   migrate: Expand the use of folio in __migrate_device_pages()
>   userfault; Expand folio use in mfill_atomic_install_pte()
>   mm: Remove page_mapping()
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/6] fscrypt: Convert bh_get_inode_and_lblk_num to use a folio
    (no matching commit)
  - [f2fs-dev,2/6] f2fs: Convert f2fs_clear_page_cache_dirty_tag to use a folio
    (no matching commit)
  - [f2fs-dev,3/6] memory-failure: Remove calls to page_mapping()
    (no matching commit)
  - [f2fs-dev,4/6] migrate: Expand the use of folio in __migrate_device_pages()
    (no matching commit)
  - [f2fs-dev,5/6] userfault; Expand folio use in mfill_atomic_install_pte()
    (no matching commit)
  - [f2fs-dev,6/6] mm: Remove page_mapping()
    https://git.kernel.org/jaegeuk/f2fs/c/06668257a355

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



