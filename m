Return-Path: <linux-fsdevel+bounces-68978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7069C6A7A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F88B35C788
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF2C365A05;
	Tue, 18 Nov 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPtsI8po"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E812F39BF
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481476; cv=none; b=ZD+mNA6C0OFEttKhGVbstiauirE6tICV+y62nEm6/a1a44iKa6WAGLAQpwyxW13dyJRf4jG84sS/V0PBRMgulxooehMHQ1P4rBKFUETHa7ivf9hTF5mG/dulx9gj+0GDJdkclvI7w0+wJkDU2WEd+zssEdKoEubpxF/0MppcYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481476; c=relaxed/simple;
	bh=8sVYl4pC/X5livBGaJ2LiYLUoOSFKiZzZ0IqHOKEtq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXQl8F1bd6aS6Ggh7Wkn2lxghhZi4JehJIH/ka4rlbsq9DkrUIMa2I9gs9K77NcWHcozVcaspN6tU8Y/48U0W34vFZ5zzSuAJ1GISZkuLfiTC/Z9W9OlX9E31TV6Men5FnNDvb/O+34OS+5xZzG/EHwr5qkE/tYN0vCAYyekcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPtsI8po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2CCC2BCB0;
	Tue, 18 Nov 2025 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481475;
	bh=8sVYl4pC/X5livBGaJ2LiYLUoOSFKiZzZ0IqHOKEtq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPtsI8poe0HxfVHPV987Qg0XfP8kYrIFh8Nip1pBRr691Zpfujpq6zko8/AWZ0h6O
	 Jf4d4zNQ4i7SC7rd1OGbQ2ge0h/CM3AbVEgNZZ9sWBcX9TpIFR9LQkhXskcTwj9jZy
	 B4KdYd2IdHow5GOaw1aFFd97kl76mk10EdOjCaXUGqOx+nljGRYrb06iYv71bZC8Qh
	 GholQIPH9jOCVYla7nNAbaTJLoe2DtxRDyuRvRuYPpRva1k1LWpaXr5a9essHAaU9e
	 G8piMv/wjajR7i+Vfkiyf8oGFilr83+soHpcS4K+NAKhdzKpEUYYeSVWxwZulgpD7p
	 TuJyDsjM06zYQ==
Date: Tue, 18 Nov 2025 07:57:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Add uoff_t
Message-ID: <20251118155754.GC196362@frogsfrogsfrogs>
References: <20251118152935.3735484-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118152935.3735484-1-willy@infradead.org>

On Tue, Nov 18, 2025 at 03:29:33PM +0000, Matthew Wilcox (Oracle) wrote:
> In a recent commit, I inadvertently changed a comparison from being an
> unsigned comparison (on 64-bit systems) to being a signed comparison
> (which it had always been on 32-bit systems).  This led to a sporadic
> fstests failure.
> 
> To make sure this comparison is always unsigned, introduce a new type,
> uoff_t which is the unsigned version of loff_t.  Generally file sizes
> are restricted to being a signed integer, but in these two places it is
> convenient to pass -1 to indicate "up to the end of the file".

Soo... truncate_inode_pages passes 16EB as the lend parameter to
truncate_inode_pages_range now?  I suppose that makes sense, though the
casting to loff_t by that caller no longer does...

--D

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h                     | 8 ++++----
>  include/linux/shmem_fs.h               | 2 +-
>  include/linux/types.h                  | 1 +
>  include/uapi/asm-generic/posix_types.h | 1 +
>  mm/shmem.c                             | 4 ++--
>  mm/truncate.c                          | 2 +-
>  6 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fe995cc3ba5c..a69ab017c370 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3650,10 +3650,10 @@ struct vm_unmapped_area_info {
>  extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
>  
>  /* truncate.c */
> -extern void truncate_inode_pages(struct address_space *, loff_t);
> -extern void truncate_inode_pages_range(struct address_space *,
> -				       loff_t lstart, loff_t lend);
> -extern void truncate_inode_pages_final(struct address_space *);
> +void truncate_inode_pages(struct address_space *mapping, loff_t lstart);
> +void truncate_inode_pages_range(struct address_space *mapping, loff_t lstart,
> +		uoff_t lend);
> +void truncate_inode_pages_final(struct address_space *mapping);
>  
>  /* generic vm_area_ops exported for stackable file systems */
>  extern vm_fault_t filemap_fault(struct vm_fault *vmf);
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 08f497673b06..94c6237acdc9 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -126,7 +126,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>  					pgoff_t index, gfp_t gfp_mask);
>  int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
>  		struct list_head *folio_list);
> -void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
> +void shmem_truncate_range(struct inode *inode, loff_t start, uoff_t end);
>  int shmem_unuse(unsigned int type);
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 6dfdb8e8e4c3..d4437e9c452c 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -50,6 +50,7 @@ typedef __kernel_old_gid_t	old_gid_t;
>  
>  #if defined(__GNUC__)
>  typedef __kernel_loff_t		loff_t;
> +typedef __kernel_uoff_t		uoff_t;
>  #endif
>  
>  /*
> diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
> index b5f7594eee7a..0a90ad92dbf3 100644
> --- a/include/uapi/asm-generic/posix_types.h
> +++ b/include/uapi/asm-generic/posix_types.h
> @@ -86,6 +86,7 @@ typedef struct {
>   */
>  typedef __kernel_long_t	__kernel_off_t;
>  typedef long long	__kernel_loff_t;
> +typedef unsigned long long	__kernel_uoff_t;
>  typedef __kernel_long_t	__kernel_old_time_t;
>  #ifndef __KERNEL__
>  typedef __kernel_long_t	__kernel_time_t;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0a25ee095b86..728f2e04911e 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1105,7 +1105,7 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
>   * Remove range of pages and swap entries from page cache, and free them.
>   * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
>   */
> -static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> +static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>  								 bool unfalloc)
>  {
>  	struct address_space *mapping = inode->i_mapping;
> @@ -1256,7 +1256,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  	shmem_recalc_inode(inode, 0, -nr_swaps_freed);
>  }
>  
> -void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
> +void shmem_truncate_range(struct inode *inode, loff_t lstart, uoff_t lend)
>  {
>  	shmem_undo_range(inode, lstart, lend, false);
>  	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> diff --git a/mm/truncate.c b/mm/truncate.c
> index d08340afc768..12467c1bd711 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -364,7 +364,7 @@ long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
>   * page aligned properly.
>   */
>  void truncate_inode_pages_range(struct address_space *mapping,
> -				loff_t lstart, loff_t lend)
> +				loff_t lstart, uoff_t lend)
>  {
>  	pgoff_t		start;		/* inclusive */
>  	pgoff_t		end;		/* exclusive */
> -- 
> 2.47.2
> 
> 

