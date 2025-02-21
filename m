Return-Path: <linux-fsdevel+bounces-42204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D761CA3EAC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 03:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07AF3A825A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF81BD9DD;
	Fri, 21 Feb 2025 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBZNAmwT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7B286298
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104841; cv=none; b=VDMpIZ/sCAP+GMlzxqPnyI5mo95FafUiHC865HT0axlsMQnGJISS+YrmZEsJRW9b4660QHVMkTIRHRFyJwUVEwzM80P1/Rm4MEvA39nPLoj6y7R//ZUbSGrMLDtUUy5Sl2qz9kWWyp7EDQeawKYJtFHuKsOgpMfpaBk0lH69ZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104841; c=relaxed/simple;
	bh=YACJFCQZcpbzU7cY+eClXPHJMTR8U233naDrGuxcIww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkysMNYafo7vhER8Id+48qF9UUW+afPwyZDjP39JPCQ7oupxM/6wILZ7aY2luXGZ/Y+Bkjn71Q4OYTm+yWPV/nDNNn8wIROOXpO356j6ce/pSmfAWuFSLwljoA9szMlMJYZxI+Qs4CFtp2fmPUeximoutSlx44mUYkKzzG68tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBZNAmwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D407DC4CED1;
	Fri, 21 Feb 2025 02:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740104841;
	bh=YACJFCQZcpbzU7cY+eClXPHJMTR8U233naDrGuxcIww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBZNAmwTWUTUIkYpaXujOlwaXCM8ed/w6KpkLIaRR2YoPNKMMpzC8Umuf2k1/UjR/
	 g1sD7XWQcy/BeEKWe2bym/+SpOrVFrN2Nio0WNEN+0wXnpStXLiSDzZ0shvYNfHxtl
	 u3q0MYJ2JNDbfXBAu2Z+qm8BV4TnQLHb32uHHQPHDPNCfYH48LPMw/bCP7ni6mkWIB
	 UXzr4QmlCByPWW8Vi1e29EsfH/FOgr2QftiWzX/Nvw1tIXk8jLVbFOs9NjgtxFEtQ5
	 98ibbyAUs/lM9tAcc1MdI0fjY6jTzFzu+p232QxonOuXIEsPDH0ToLAz8TdZVWQ2M9
	 UTzExxA6vgyZw==
Date: Fri, 21 Feb 2025 02:27:19 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/27] f2fs folio conversions for v6.15
Message-ID: <Z7fkhzKO_Upxyy0w@google.com>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>

Thank you for the patches. I queued them in dev-test and kicked off all my
tests.

Thanks,

On 02/18, Matthew Wilcox (Oracle) wrote:
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
>  fs/f2fs/checkpoint.c    |  26 ++--
>  fs/f2fs/data.c          | 130 ++++++++++---------
>  fs/f2fs/f2fs.h          |  90 +++++++++----
>  fs/f2fs/file.c          |  24 ++--
>  fs/f2fs/gc.c            |  42 +++---
>  fs/f2fs/node.c          | 279 ++++++++++++++++++++--------------------
>  fs/f2fs/node.h          |   6 +-
>  fs/f2fs/segment.c       |  26 ++--
>  include/linux/pagemap.h |   9 --
>  mm/filemap.c            |   2 +-
>  mm/folio-compat.c       |  14 --
>  11 files changed, 338 insertions(+), 310 deletions(-)
> 
> -- 
> 2.47.2

