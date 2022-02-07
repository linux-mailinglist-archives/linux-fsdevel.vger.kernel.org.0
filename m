Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7262F4AC673
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 17:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiBGQwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 11:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357959AbiBGQia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:38:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94BEC0401D6;
        Mon,  7 Feb 2022 08:38:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 745381F37E;
        Mon,  7 Feb 2022 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644251907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/420w16nsE6lWgjgD88rElcSZES7Jd8PA84QTQiG/Y=;
        b=B18jtoZPQZY0cIuIkAJNpEw57lGfW/7NDSivAgEyimeBXgBew51XvCIxsF3ecCgss2tmLj
        0vIudERPDOfdyBZiRoNFBL+oirkTOVXgiy9hfi1EnFJa41cDNGt2XzcQJDMpXDx+wxrNtU
        nBK1loiN0SBXVNXoAiyVIu09Qknho98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644251907;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/420w16nsE6lWgjgD88rElcSZES7Jd8PA84QTQiG/Y=;
        b=1fxgZWgZ17xgSkoXsmDxWqQ2Lkpl14VXCsaYJzCoAwIJgHYpNM530mFJjQoRtz7aTrq6Mt
        ElznV8UhG2lMAvAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F955A3B83;
        Mon,  7 Feb 2022 16:38:27 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0D69CA05BB; Mon,  7 Feb 2022 17:38:27 +0100 (CET)
Date:   Mon, 7 Feb 2022 17:38:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCHv1 5/9] ext4: Rename ext4_set_bits to mb_set_bits
Message-ID: <20220207163827.rxz3x37d73nqqufk@quack3.lan>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
 <2751fcbeb66524472f33828d01a296191daa8fc6.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2751fcbeb66524472f33828d01a296191daa8fc6.1644062450.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 05-02-22 19:39:54, Ritesh Harjani wrote:
> ext4_set_bits() should actually be mb_set_bits() for uniform API naming
> convention.
> This is via below cmd -
> 
> grep -nr "ext4_set_bits" fs/ext4/ | cut -d ":" -f 1 | xargs sed -i 's/ext4_set_bits/mb_set_bits/g'
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    |  2 +-
>  fs/ext4/mballoc.c | 14 +++++++-------
>  fs/ext4/resize.c  |  4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 09d8f60ebf0f..8c1d0e352f47 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1279,7 +1279,7 @@ struct ext4_inode_info {
>  #define ext4_find_next_zero_bit		find_next_zero_bit_le
>  #define ext4_find_next_bit		find_next_bit_le
> 
> -extern void ext4_set_bits(void *bm, int cur, int len);
> +extern void mb_set_bits(void *bm, int cur, int len);
> 
>  /*
>   * Maximal mount counts between two filesystem checks
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 91058f81a0c6..f80af108d05e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1689,7 +1689,7 @@ static int mb_test_and_clear_bits(void *bm, int cur, int len)
>  	return zero_bit;
>  }
> 
> -void ext4_set_bits(void *bm, int cur, int len)
> +void mb_set_bits(void *bm, int cur, int len)
>  {
>  	__u32 *addr;
> 
> @@ -1996,7 +1996,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
>  	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
> 
>  	mb_update_avg_fragment_size(e4b->bd_sb, e4b->bd_info);
> -	ext4_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
> +	mb_set_bits(e4b->bd_bitmap, ex->fe_start, len0);
>  	mb_check_buddy(e4b);
> 
>  	return ret;
> @@ -3825,7 +3825,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  		 * We leak some of the blocks here.
>  		 */
>  		ext4_lock_group(sb, ac->ac_b_ex.fe_group);
> -		ext4_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
> +		mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
>  			      ac->ac_b_ex.fe_len);
>  		ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
>  		err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
> @@ -3844,7 +3844,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  		}
>  	}
>  #endif
> -	ext4_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
> +	mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
>  		      ac->ac_b_ex.fe_len);
>  	if (ext4_has_group_desc_csum(sb) &&
>  	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> @@ -3939,7 +3939,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
> 
>  		clen_changed = clen - already;
>  		if (state)
> -			ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
> +			mb_set_bits(bitmap_bh->b_data, blkoff, clen);
>  		else
>  			mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
>  		if (ext4_has_group_desc_csum(sb) &&
> @@ -4459,7 +4459,7 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
> 
>  	while (n) {
>  		entry = rb_entry(n, struct ext4_free_data, efd_node);
> -		ext4_set_bits(bitmap, entry->efd_start_cluster, entry->efd_count);
> +		mb_set_bits(bitmap, entry->efd_start_cluster, entry->efd_count);
>  		n = rb_next(n);
>  	}
>  	return;
> @@ -4500,7 +4500,7 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
>  		if (unlikely(len == 0))
>  			continue;
>  		BUG_ON(groupnr != group);
> -		ext4_set_bits(bitmap, start, len);
> +		mb_set_bits(bitmap, start, len);
>  		preallocated += len;
>  	}
>  	mb_debug(sb, "preallocated %d for group %u\n", preallocated, group);
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index ee8f02f406cb..f507f34be602 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -483,7 +483,7 @@ static int set_flexbg_block_bitmap(struct super_block *sb, handle_t *handle,
>  		}
>  		ext4_debug("mark block bitmap %#04llx (+%llu/%u)\n",
>  			   first_cluster, first_cluster - start, count2);
> -		ext4_set_bits(bh->b_data, first_cluster - start, count2);
> +		mb_set_bits(bh->b_data, first_cluster - start, count2);
> 
>  		err = ext4_handle_dirty_metadata(handle, NULL, bh);
>  		brelse(bh);
> @@ -632,7 +632,7 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
>  		if (overhead != 0) {
>  			ext4_debug("mark backup superblock %#04llx (+0)\n",
>  				   start);
> -			ext4_set_bits(bh->b_data, 0,
> +			mb_set_bits(bh->b_data, 0,
>  				      EXT4_NUM_B2C(sbi, overhead));
>  		}
>  		ext4_mark_bitmap_end(EXT4_B2C(sbi, group_data[i].blocks_count),
> --
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
