Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747E669B1AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 18:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBQRSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 12:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQRSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:18:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7596E66A;
        Fri, 17 Feb 2023 09:18:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u14-20020a17090a4bce00b002341fadc370so1974365pjl.1;
        Fri, 17 Feb 2023 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lLoPiL+Bl5cJxv/Z23Pv5jjxu3Y23joxQvM0JTjE3HI=;
        b=JLrFL/3qJ9Q03JzZPOXVUyu8Hm50p6XEdl9X35oFQA5OIyZlpLsPaZQOO9q1cCItGq
         lnEk7CD1rkvtzlIm2I+OgjlowdG+0Zzg5NmRbJWTy+nNU26Xqd4l/erff4PKtEs863MS
         OQNvkV8CELyRfXwASoli076XpEGm0SwxMhj4jMp0xNQqw994sLXiU2veiVdPNaakrR2L
         AfK+Qv9qxw/U/u8PfIgaG7ZAYaRfq9fRQMck4HRyvBulGCLQCeeP8LsPVvGNmntHctiH
         RKKo2v+5zQW4lbcYe6hLUJg0Kt03SomKcMYI67Ai+GFg2d+UEquWXel1u99wmVv6ADw/
         Qgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLoPiL+Bl5cJxv/Z23Pv5jjxu3Y23joxQvM0JTjE3HI=;
        b=s/krIU0Se6exSc0fXsYUQgC7nnbkxHG7ZKhM736JPHhPX0lrVjly38wRED+S9j2bru
         07TBLwOAcHFRIoTegPSa1+tf+O/Q9r61TZpNoi9/oBmmWWLKhn4C/8lOzcPLx6eUsUA3
         XKuXGJyjTM53nvK2PlFqG/KjLMgEThG3myAtSD5+WQqvOtyXhMm+uw4MQLAx8NgOcArz
         oeXcWjaiRuOEJK0lDb/mCC5hjV8W3A3dg8/9Y7l8zvG5FyrQQexE78BdJ7zXBCXvN/6B
         +ParNHeTmb6w8kzRmrOQqYeZdyED3NYwhc+xtx3MQiJVzPI/xVbPtqT7Jl2qkdhURx5S
         tEQg==
X-Gm-Message-State: AO0yUKXJ3PNRKfAJ+M8ghO3nCwj0yjDa4nd3g+VssBw6V8TK+dwDN9Px
        20FezSdNT3+qdXWE8JP+MG8=
X-Google-Smtp-Source: AK7set/8AdalfE/tq+pq98wfMxdA2pZS+PRYmwKvvd6OMZFOpd47m0pSraqNvtpwD+0/Pjqb2eRIFA==
X-Received: by 2002:a17:903:41d0:b0:19a:a9dd:ed34 with SMTP id u16-20020a17090341d000b0019aa9dded34mr414969ple.59.1676654331767;
        Fri, 17 Feb 2023 09:18:51 -0800 (PST)
Received: from rh-tp ([2406:7400:63:5056:148f:873b:4bc8:1e77])
        by smtp.gmail.com with ESMTPSA id bi12-20020a170902bf0c00b0019a70a42b0asm3391832plb.169.2023.02.17.09.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 09:18:50 -0800 (PST)
Date:   Fri, 17 Feb 2023 22:48:31 +0530
Message-Id: <87y1ow6wig.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>
Subject: Re: [PATCH v4 6/9] ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()
In-Reply-To: <79b5240a6168171577b1bb9ef7a27c0c52676d37.1676634592.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> When the length of best extent found is less than the length of goal extent
> we need to make sure that the best extent atleast covers the start of the
> original request. This is done by adjusting the ac_b_ex.fe_logical (logical
> start) of the extent.
>
> While doing so, the current logic sometimes results in the best extent's logical
> range overflowing the goal extent. Since this best extent is later added to the
> inode preallocation list, we have a possibility of introducing overlapping
> preallocations. This is discussed in detail here [1].

So if the best extent range overflows the goal extent range, then it
causes the overlapping ranges to be added to the list is because at the
time of normalization of the request during allocation, we decide goal
start and end based on the existing PAs in the list. And if we end up
adding the best found extent range which overflows the goal range, then
that will add a PA whose logical start/end might overlap with an
existing PA range.

>
> To fix this, replace the existing logic with the below logic for adjusting best
> extent as it keeps fragmentation in check while ensuring logical range of best
> extent doesn't overflow out of goal extent:
>
> 1. Check if best extent can be kept at end of goal range and still cover
>    original start.
> 2. Else, check if best extent can be kept at start of goal range and still cover
>    original start.
> 3. Else, keep the best extent at start of original request.
>
> Also, add a few extra BUG_ONs that might help catch errors faster.

Thanks for the detailed explaination. I think it makes sense.

>
> [1] https://lore.kernel.org/r/Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com

Yes, the example in the above link was helpful.

>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/mballoc.c | 49 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 18 deletions(-)

Also this looks like, it was not a problem till now because while finding a
right PA with existing list implementation, we adjust our allocation
window based on all the elements in the inode PA list (full scan of
inode PAs)

But in case of rbtree, we try to do a log(n) search and if we have an
overlapping range, then we might end up missing a subtree and calculate
a wrong allocation request range.

So the only problem in the current code would be that we might
have some overlapping ranges in the inode PAs which means we have some
extra reservations done for the same logical file ranges. But other than
that I guess we don't have any other issue.

Is that also the reason why we are not adding any fixes tag and cc'ing
it to stable?

I have reviewed the patch along with my understanding above.
Looks good to me. So please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index fdb9d0a8f35d..ba9d26e2f2aa 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4330,6 +4330,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
>  	BUG_ON(start < pa->pa_pstart);
>  	BUG_ON(end > pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len));
>  	BUG_ON(pa->pa_free < len);
> +	BUG_ON(ac->ac_b_ex.fe_len <= 0);
>  	pa->pa_free -= len;
>
>  	mb_debug(ac->ac_sb, "use %llu/%d from inode pa %p\n", start, len, pa);
> @@ -4668,10 +4669,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  	pa = ac->ac_pa;
>
>  	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len) {
> -		int winl;
> -		int wins;
> -		int win;
> -		int offs;
> +		int new_bex_start;
> +		int new_bex_end;
>
>  		/* we can't allocate as much as normalizer wants.
>  		 * so, found space must get proper lstart
> @@ -4679,26 +4678,40 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  		BUG_ON(ac->ac_g_ex.fe_logical > ac->ac_o_ex.fe_logical);
>  		BUG_ON(ac->ac_g_ex.fe_len < ac->ac_o_ex.fe_len);
>
> -		/* we're limited by original request in that
> -		 * logical block must be covered any way
> -		 * winl is window we can move our chunk within */
> -		winl = ac->ac_o_ex.fe_logical - ac->ac_g_ex.fe_logical;
> +		/*
> +		 * Use the below logic for adjusting best extent as it keeps
> +		 * fragmentation in check while ensuring logical range of best
> +		 * extent doesn't overflow out of goal extent:
> +		 *
> +		 * 1. Check if best ex can be kept at end of goal and still
> +		 *    cover original start
> +		 * 2. Else, check if best ex can be kept at start of goal and
> +		 *    still cover original start
> +		 * 3. Else, keep the best ex at start of original request.
> +		 */
> +		new_bex_end = ac->ac_g_ex.fe_logical +
> +			EXT4_C2B(sbi, ac->ac_g_ex.fe_len);
> +		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> +		if (ac->ac_o_ex.fe_logical >= new_bex_start)
> +				goto adjust_bex;
>
> -		/* also, we should cover whole original request */
> -		wins = EXT4_C2B(sbi, ac->ac_b_ex.fe_len - ac->ac_o_ex.fe_len);
> +		new_bex_start = ac->ac_g_ex.fe_logical;
> +		new_bex_end =
> +			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> +		if (ac->ac_o_ex.fe_logical < new_bex_end)
> +			goto adjust_bex;
>
> -		/* the smallest one defines real window */
> -		win = min(winl, wins);
> +		new_bex_start = ac->ac_o_ex.fe_logical;
> +		new_bex_end =
> +			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>
> -		offs = ac->ac_o_ex.fe_logical %
> -			EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> -		if (offs && offs < win)
> -			win = offs;
> +adjust_bex:
> +		ac->ac_b_ex.fe_logical = new_bex_start;
>
> -		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical -
> -			EXT4_NUM_B2C(sbi, win);
>  		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>  		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
> +		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
> +				      EXT4_C2B(sbi, ac->ac_g_ex.fe_len)));
>  	}
>
>  	/* preallocation can change ac_b_ex, thus we store actually
> --
> 2.31.1
