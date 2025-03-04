Return-Path: <linux-fsdevel+bounces-43049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E33A9A4D5AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB08C7AA136
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D181F8BC6;
	Tue,  4 Mar 2025 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeErzgGe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674861F55ED
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075489; cv=none; b=f/gAmqT0C4muun2b6QJ8yDpHHFWBwoUyXnLM/A/vVodCsK+PqeUoiU0w8ip3PvJ572qH1YuwT5iEuO8aReYJnsMMJTpnA1Hw/yd0p0AH7s7+R4Ixvvt4bvuCG93W4xom6ZVnuflRVVNjKE1d/yW9LP200LeUTXeN65DmAfllqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075489; c=relaxed/simple;
	bh=jxzf9EMu80D/xw6wMny6zC+ffLHTA+eDbzGVqYf9o7E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iwJG+2Ur2UMJ+AvzV04h7zyWyfiL478RYTkhYE1IXd5OHciKWbtnXzlgrN2J81WNGXevcZcBYzNVoo3YAxMIp55ofbxy1eNAOlbEkTEQp4IKlP49LBIZZFJE1598STushvtQ5RV5V94x5udz1eDEJNw5S9EqRHcODkWkdYrWlT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeErzgGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5078C4CEE5;
	Tue,  4 Mar 2025 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741075488;
	bh=jxzf9EMu80D/xw6wMny6zC+ffLHTA+eDbzGVqYf9o7E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=NeErzgGelshQwygHqkAEWZ1D16syUHsOm2+EQfSFYYRSrprvFZ2GrIzxDp/V1weHf
	 4luPhTxsNb3FPr0J3AUX6Nj6G+WWSFkX1hSKIxPHzV7BHWEnbvZOW2nUTjKeUO/YEi
	 nm1wrK6DLDLRGpxSBB9Ne6uWjZ+Q9rXsQAIqNSmcx4IouWvg0M6mMgG/9g7XUa5qO6
	 aftzda6renm4px4yuhhltl2uQrV765hAxOHkN9JFANw014Zp2IqWPr6tCrqsPY6NjV
	 QoD9EXEtXkRdFhs9VkejsWEvUcrghvPKu5Jq/fij60Jqwy9wEifcJwTsDdzDv/ZK/w
	 RoCUeePKFXt/Q==
Message-ID: <57e98b92-56db-4217-b11c-b9b716f54de1@kernel.org>
Date: Tue, 4 Mar 2025 16:04:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/27] f2fs folio conversions for v6.15
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250218055203.591403-1-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 13:51, Matthew Wilcox (Oracle) wrote:
> More f2fs folio conversions.  This time I'm focusing on removing
> accesses to page->mapping as well as getting rid of accesses to
> old APIs.  f2fs was the last user of wait_for_stable_page(),
> grab_cache_page_write_begin() and wait_on_page_locked(), so
> I've included those removals in this series too.

After fixing f2fs_put_page(), whole patchset looks good to me.

Jaegeuk, feel free to add:

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

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


