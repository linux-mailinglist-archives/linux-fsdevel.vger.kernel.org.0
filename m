Return-Path: <linux-fsdevel+bounces-43139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC770A4E94A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B797A1713
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D3259CAF;
	Tue,  4 Mar 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBM2iqAQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803224C065
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108212; cv=none; b=OYkctfwUHhtXaO/2eJ7FHzwY6t0FTSRbU+nJq19tjin5eOmBF9KsGKXy/2IqkwE4FU/2Igv9rgwrD0/lMVoHGd5R5pT3B3qTJLH95lGwOeNaUOIYJ/2WPJ5pPFz+sm5utVRZ4v+yqmK0pHzSpF8R2vFIigVra8yC+FOdPBmDbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108212; c=relaxed/simple;
	bh=CXHGF5JE2IKfcCUn9rR5K/yFn0hXIzYaGLStVBBPqrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rrr8JCXgvTVPp5hjkBetS86lBCBle6p47bYwgb/GUzf7SUEdeua7CcWBg2SQAZN72677/o6ip6CGbHYGN/MX4D7z6Npoart11lREsU3ORl/F264tnBH6PVy8IrpGY9tmx3q043XEpFg4jZDcBRy7K7GPUyASeW2BGM2ES7iVCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBM2iqAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917C0C4CEE5;
	Tue,  4 Mar 2025 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741108211;
	bh=CXHGF5JE2IKfcCUn9rR5K/yFn0hXIzYaGLStVBBPqrg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nBM2iqAQwQlUhfxsD72F0/ft3h7w9FID3z/SRIwyS3T1CROHKkUnpP1Yxiw2DGPsn
	 Jb9Z3t2FaKI3wpnfFaxekphyvgbJCe2gF9ubIFjfGuKd7SzY9Snw2IkjSOOqts6BE9
	 A3g7HpUWdOdAfetMoRWpz0TmNWVnjLmiUJFcfngYYLS1TJ82BcIDHHcOK8TLbFM1PS
	 0lt9bLxNy09XVIPZeI/W7qZp+B2ipp8927EPekoFhvyBBAcurwnvC+f+Ac2RtEpScN
	 9qtyd45zAybQ707jRJZ78TrJk1UuR2HWhyfcZYxjIWUE8DkJMnsP1FW4V/YlGgpFqn
	 w90zhzwzuvImg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE027380AA7F;
	Tue,  4 Mar 2025 17:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 00/27] f2fs folio conversions for v6.15
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174110824448.224349.9741584954553856935.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 17:10:44 +0000
References: <20250218055203.591403-1-willy@infradead.org>
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
To: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 18 Feb 2025 05:51:34 +0000 you wrote:
> More f2fs folio conversions.  This time I'm focusing on removing
> accesses to page->mapping as well as getting rid of accesses to
> old APIs.  f2fs was the last user of wait_for_stable_page(),
> grab_cache_page_write_begin() and wait_on_page_locked(), so
> I've included those removals in this series too.
> 
> Matthew Wilcox (Oracle) (27):
>   f2fs: Add f2fs_folio_wait_writeback()
>   mm: Remove wait_for_stable_page()
>   f2fs: Add f2fs_folio_put()
>   f2fs: Convert f2fs_flush_inline_data() to use a folio
>   f2fs: Convert f2fs_sync_node_pages() to use a folio
>   f2fs: Pass a folio to flush_dirty_inode()
>   f2fs: Convert f2fs_fsync_node_pages() to use a folio
>   f2fs: Convert last_fsync_dnode() to use a folio
>   f2fs: Return a folio from last_fsync_dnode()
>   f2fs: Add f2fs_grab_cache_folio()
>   mm: Remove grab_cache_page_write_begin()
>   f2fs: Use a folio in __get_node_page()
>   f2fs: Use a folio in do_write_page()
>   f2fs: Convert f2fs_write_end_io() to use a folio_iter
>   f2fs: Mark some functions as taking a const page pointer
>   f2fs: Convert f2fs_in_warm_node_list() to take a folio
>   f2fs: Add f2fs_get_node_folio()
>   f2fs: Use a folio throughout f2fs_truncate_inode_blocks()
>   f2fs: Use a folio throughout __get_meta_page()
>   f2fs: Hoist the page_folio() call to the start of
>     f2fs_merge_page_bio()
>   f2fs: Add f2fs_get_read_data_folio()
>   f2fs: Add f2fs_get_lock_data_folio()
>   f2fs: Convert move_data_page() to use a folio
>   f2fs: Convert truncate_partial_data_page() to use a folio
>   f2fs: Convert gc_data_segment() to use a folio
>   f2fs: Add f2fs_find_data_folio()
>   mm: Remove wait_on_page_locked()
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,01/27] f2fs: Add f2fs_folio_wait_writeback()
    https://git.kernel.org/jaegeuk/f2fs/c/17683927d078
  - [f2fs-dev,02/27] mm: Remove wait_for_stable_page()
    https://git.kernel.org/jaegeuk/f2fs/c/36e1d6344aca
  - [f2fs-dev,03/27] f2fs: Add f2fs_folio_put()
    (no matching commit)
  - [f2fs-dev,04/27] f2fs: Convert f2fs_flush_inline_data() to use a folio
    https://git.kernel.org/jaegeuk/f2fs/c/015d9c56bd5e
  - [f2fs-dev,05/27] f2fs: Convert f2fs_sync_node_pages() to use a folio
    https://git.kernel.org/jaegeuk/f2fs/c/5d0a91284853
  - [f2fs-dev,06/27] f2fs: Pass a folio to flush_dirty_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/de90f7614424
  - [f2fs-dev,07/27] f2fs: Convert f2fs_fsync_node_pages() to use a folio
    https://git.kernel.org/jaegeuk/f2fs/c/e23bebc3c0d2
  - [f2fs-dev,08/27] f2fs: Convert last_fsync_dnode() to use a folio
    https://git.kernel.org/jaegeuk/f2fs/c/18f3814fa6a8
  - [f2fs-dev,09/27] f2fs: Return a folio from last_fsync_dnode()
    https://git.kernel.org/jaegeuk/f2fs/c/e11a31139517
  - [f2fs-dev,10/27] f2fs: Add f2fs_grab_cache_folio()
    https://git.kernel.org/jaegeuk/f2fs/c/8d77f68daeb1
  - [f2fs-dev,11/27] mm: Remove grab_cache_page_write_begin()
    https://git.kernel.org/jaegeuk/f2fs/c/e33ce6bd4ea2
  - [f2fs-dev,12/27] f2fs: Use a folio in __get_node_page()
    https://git.kernel.org/jaegeuk/f2fs/c/48a34c598103
  - [f2fs-dev,13/27] f2fs: Use a folio in do_write_page()
    https://git.kernel.org/jaegeuk/f2fs/c/cd8f95718c89
  - [f2fs-dev,14/27] f2fs: Convert f2fs_write_end_io() to use a folio_iter
    https://git.kernel.org/jaegeuk/f2fs/c/fb9660481e3c
  - [f2fs-dev,15/27] f2fs: Mark some functions as taking a const page pointer
    https://git.kernel.org/jaegeuk/f2fs/c/521a46848690
  - [f2fs-dev,16/27] f2fs: Convert f2fs_in_warm_node_list() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/1a58a41ccce6
  - [f2fs-dev,17/27] f2fs: Add f2fs_get_node_folio()
    https://git.kernel.org/jaegeuk/f2fs/c/4d417ae2bfce
  - [f2fs-dev,18/27] f2fs: Use a folio throughout f2fs_truncate_inode_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/520b17e093f4
  - [f2fs-dev,19/27] f2fs: Use a folio throughout __get_meta_page()
    https://git.kernel.org/jaegeuk/f2fs/c/922e24acb49e
  - [f2fs-dev,20/27] f2fs: Hoist the page_folio() call to the start of f2fs_merge_page_bio()
    https://git.kernel.org/jaegeuk/f2fs/c/b8fcb8423053
  - [f2fs-dev,21/27] f2fs: Add f2fs_get_read_data_folio()
    https://git.kernel.org/jaegeuk/f2fs/c/4ae71b1996ef
  - [f2fs-dev,22/27] f2fs: Add f2fs_get_lock_data_folio()
    https://git.kernel.org/jaegeuk/f2fs/c/20f974cd2124
  - [f2fs-dev,23/27] f2fs: Convert move_data_page() to use a folio
    https://git.kernel.org/jaegeuk/f2fs/c/6d1ba45c8db0
  - [f2fs-dev,24/27] f2fs: Convert truncate_partial_data_page() to use a folio
    https://git.kernel.org/jaegeuk/f2fs/c/ab907aa2a2f3
  - [f2fs-dev,25/27] f2fs: Convert gc_data_segment() to use a folio
    https://git.kernel.org/jaegeuk/f2fs/c/a86e109ee2c6
  - [f2fs-dev,26/27] f2fs: Add f2fs_find_data_folio()
    https://git.kernel.org/jaegeuk/f2fs/c/0cd402baa03b
  - [f2fs-dev,27/27] mm: Remove wait_on_page_locked()
    https://git.kernel.org/jaegeuk/f2fs/c/d96e2802a802

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



