Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911AD4AC409
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 16:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiBGPkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 10:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242907AbiBGP2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:28:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A506C0401C1;
        Mon,  7 Feb 2022 07:28:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BCB4E1F380;
        Mon,  7 Feb 2022 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644247701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3xiAB7Mo6lVoFRC3DJUrL8QW3+mxBSV67aGhGzwkyY=;
        b=vQP2O2eTLzu3UbS+z24nWi7MMPHUkMgvOvTZRec7PK817zQ0tAwpSkkzeIH+Qy6phq7ZMb
        ef+g4TtwijF4R/WQTtueBPf3w1uAPgPmSquPJp3Hf+gttkhQDWTjNUBlWGOYoSp15jGXmQ
        cBS3918P+0zQJR8VRsZX9Z5MVPQaJAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644247701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3xiAB7Mo6lVoFRC3DJUrL8QW3+mxBSV67aGhGzwkyY=;
        b=/7HjnIJOGGflB/LKU/980wAt0HQ0a+1sRa3HVvqSpJ8xMReuPfAGI1K5CKoZOQo3WzbFUD
        w3f5lC1kmv/406BQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AD468A3B81;
        Mon,  7 Feb 2022 15:28:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EFC58A05BC; Mon,  7 Feb 2022 16:28:18 +0100 (CET)
Date:   Mon, 7 Feb 2022 16:28:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCHv1 1/9] ext4: Correct cluster len and clusters changed
 accounting in ext4_mb_mark_bb
Message-ID: <20220207152818.tsrqwe2hebyvr25e@quack3.lan>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
 <f2ab83d92010375afead88a8e41d7a0e1df94a10.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ab83d92010375afead88a8e41d7a0e1df94a10.1644062450.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 05-02-22 19:39:50, Ritesh Harjani wrote:
> ext4_mb_mark_bb() currently wrongly calculates cluster len (clen) and
> flex_group->free_clusters. This patch fixes that.
> 
> Identified based on code review of ext4_mb_mark_bb() function.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c781974df9d0..2f117ce3bb73 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3899,10 +3899,11 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	ext4_group_t group;
>  	ext4_grpblk_t blkoff;
> -	int i, clen, err;
> +	int i, err;
>  	int already;
> +	unsigned int clen, clen_changed;
>  
> -	clen = EXT4_B2C(sbi, len);
> +	clen = EXT4_NUM_B2C(sbi, len);
>  
>  	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
>  	bitmap_bh = ext4_read_block_bitmap(sb, group);
> @@ -3923,6 +3924,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
>  			already++;
>  
> +	clen_changed = clen - already;
>  	if (state)
>  		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
>  	else
> @@ -3935,9 +3937,9 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  						group, gdp));
>  	}
>  	if (state)
> -		clen = ext4_free_group_clusters(sb, gdp) - clen + already;
> +		clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
>  	else
> -		clen = ext4_free_group_clusters(sb, gdp) + clen - already;
> +		clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
>  
>  	ext4_free_group_clusters_set(sb, gdp, clen);
>  	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
> @@ -3947,10 +3949,13 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  
>  	if (sbi->s_log_groups_per_flex) {
>  		ext4_group_t flex_group = ext4_flex_group(sbi, group);
> +		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
> +					   s_flex_groups, flex_group);
>  
> -		atomic64_sub(len,
> -			     &sbi_array_rcu_deref(sbi, s_flex_groups,
> -						  flex_group)->free_clusters);
> +		if (state)
> +			atomic64_sub(clen_changed, &fg->free_clusters);
> +		else
> +			atomic64_add(clen_changed, &fg->free_clusters);
>  	}
>  
>  	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
