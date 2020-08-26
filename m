Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DE5252F57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 15:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgHZNH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 09:07:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:59220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgHZNH4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:07:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 265FDAF22;
        Wed, 26 Aug 2020 13:08:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 68C5A1E12AF; Wed, 26 Aug 2020 15:07:53 +0200 (CEST)
Date:   Wed, 26 Aug 2020 15:07:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: delete duplicated words + other fixes
Message-ID: <20200826130753.GC15126@quack2.suse.cz>
References: <20200805024850.12129-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805024850.12129-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 04-08-20 19:48:50, Randy Dunlap wrote:
> Delete repeated words in fs/ext4/.
> {the, this, of, we, after}
> 
> Also change spelling of "xttr" in inline.c to "xattr" in 2 places.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> To: linux-fsdevel@vger.kernel.org
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: linux-ext4@vger.kernel.org

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

Ted, I think this patch fell through the cracks while you were busy...

								Honza

> ---
>  fs/ext4/extents.c  |    2 +-
>  fs/ext4/indirect.c |    2 +-
>  fs/ext4/inline.c   |    4 ++--
>  fs/ext4/inode.c    |    2 +-
>  fs/ext4/mballoc.c  |    4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> --- linux-next-20200804.orig/fs/ext4/extents.c
> +++ linux-next-20200804/fs/ext4/extents.c
> @@ -4029,7 +4029,7 @@ static int get_implied_cluster_alloc(str
>   * down_read(&EXT4_I(inode)->i_data_sem) if not allocating file system block
>   * (ie, create is zero). Otherwise down_write(&EXT4_I(inode)->i_data_sem)
>   *
> - * return > 0, number of of blocks already mapped/allocated
> + * return > 0, number of blocks already mapped/allocated
>   *          if create == 0 and these are pre-allocated blocks
>   *          	buffer head is unmapped
>   *          otherwise blocks are mapped
> --- linux-next-20200804.orig/fs/ext4/indirect.c
> +++ linux-next-20200804/fs/ext4/indirect.c
> @@ -1035,7 +1035,7 @@ static void ext4_free_branches(handle_t
>  			brelse(bh);
>  
>  			/*
> -			 * Everything below this this pointer has been
> +			 * Everything below this pointer has been
>  			 * released.  Now let this top-of-subtree go.
>  			 *
>  			 * We want the freeing of this indirect block to be
> --- linux-next-20200804.orig/fs/ext4/inline.c
> +++ linux-next-20200804/fs/ext4/inline.c
> @@ -276,7 +276,7 @@ static int ext4_create_inline_data(handl
>  		len = 0;
>  	}
>  
> -	/* Insert the the xttr entry. */
> +	/* Insert the xattr entry. */
>  	i.value = value;
>  	i.value_len = len;
>  
> @@ -354,7 +354,7 @@ static int ext4_update_inline_data(handl
>  	if (error)
>  		goto out;
>  
> -	/* Update the xttr entry. */
> +	/* Update the xattr entry. */
>  	i.value = value;
>  	i.value_len = len;
>  
> --- linux-next-20200804.orig/fs/ext4/inode.c
> +++ linux-next-20200804/fs/ext4/inode.c
> @@ -2786,7 +2786,7 @@ retry:
>  		 * ext4_journal_stop() can wait for transaction commit
>  		 * to finish which may depend on writeback of pages to
>  		 * complete or on page lock to be released.  In that
> -		 * case, we have to wait until after after we have
> +		 * case, we have to wait until after we have
>  		 * submitted all the IO, released page locks we hold,
>  		 * and dropped io_end reference (for extent conversion
>  		 * to be able to complete) before stopping the handle.
> --- linux-next-20200804.orig/fs/ext4/mballoc.c
> +++ linux-next-20200804/fs/ext4/mballoc.c
> @@ -124,7 +124,7 @@
>   * /sys/fs/ext4/<partition>/mb_group_prealloc. The value is represented in
>   * terms of number of blocks. If we have mounted the file system with -O
>   * stripe=<value> option the group prealloc request is normalized to the
> - * the smallest multiple of the stripe value (sbi->s_stripe) which is
> + * smallest multiple of the stripe value (sbi->s_stripe) which is
>   * greater than the default mb_group_prealloc.
>   *
>   * The regular allocator (using the buddy cache) supports a few tunables.
> @@ -2026,7 +2026,7 @@ void ext4_mb_complex_scan_group(struct e
>  			/*
>  			 * IF we have corrupt bitmap, we won't find any
>  			 * free blocks even though group info says we
> -			 * we have free blocks
> +			 * have free blocks
>  			 */
>  			ext4_grp_locked_error(sb, e4b->bd_group, 0, 0,
>  					"%d free clusters as per "
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
