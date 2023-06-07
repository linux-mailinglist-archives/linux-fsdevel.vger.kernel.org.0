Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FFC725BB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 12:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbjFGKjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 06:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjFGKjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:39:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0D51712;
        Wed,  7 Jun 2023 03:39:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54467219B2;
        Wed,  7 Jun 2023 10:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686134377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dtu+iDNn3kxs5lrIgaQjjH8mSs0Yu/BpJe+X9Y0Ut9k=;
        b=xR6uTh8iSzcYV7OUUQs02PQcqVO5ZsQTY8AEkTpbsgRFkjj74fB7bMT0BGWC3jjKc04hL4
        fG06l4VLQ+DwhAHyUr30Po9Yhd5QRVpG8W37KLLKRoimvm2l3V+CB97P3GeBbVI2AG2+P/
        EMhpkERIjQYZUSB4hR6HwWbv0N/P8Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686134377;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dtu+iDNn3kxs5lrIgaQjjH8mSs0Yu/BpJe+X9Y0Ut9k=;
        b=C5zvnyuXKL7Iyb5uKWatXVj8n/Nm/PA3fV8VLZ8+uJDLoxBJUqGPbJNvXdp1a7ZsVGfUdX
        qt7kLJiNfYlDWcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44BD11346D;
        Wed,  7 Jun 2023 10:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id koLAEGlegGTqBwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 07 Jun 2023 10:39:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BC7A3A0749; Wed,  7 Jun 2023 12:39:36 +0200 (CEST)
Date:   Wed, 7 Jun 2023 12:39:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>
Subject: Re: [PATCH v2 12/12] ext4: Give symbolic names to mballoc criterias
Message-ID: <20230607103936.wqtcrc76tqpbc2ya@quack3>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <a2dc6ec5aea5e5e68cf8e788c2a964ffead9c8b0.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2dc6ec5aea5e5e68cf8e788c2a964ffead9c8b0.1685449706.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-05-23 18:03:50, Ojaswin Mujoo wrote:
> mballoc criterias have historically been called by numbers
> like CR0, CR1... however this makes it confusing to understand
> what each criteria is about.
> 
> Change these criterias from numbers to symbolic names and add
> relevant comments. While we are at it, also reformat and add some
> comments to ext4_seq_mb_stats_show() for better readability.
> 
> Additionally, define CR_FAST which signifies the criteria
> below which we can make quicker decisions like:
>   * quitting early if (free block < requested len)
>   * avoiding to scan free extents smaller than required len.
>   * avoiding to initialize buddy cache and work with existing cache
>   * limiting prefetches
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks for doing this!

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 942e97026a60..c29a4e1fcd5d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -135,16 +135,45 @@ enum SHIFT_DIRECTION {
>   */
>  #define EXT4_MB_NUM_CRS 5
>  /*
> - * All possible allocation criterias for mballoc
> + * All possible allocation criterias for mballoc. Lower are faster.
>   */
>  enum criteria {
> -	CR0,
> -	CR1,
> -	CR1_5,
> -	CR2,
> -	CR3,
> +	/*
> +	 * Used when number of blocks needed is a power of 2. This doesn't
> +	 * trigger any disk IO except prefetch and is the fastest criteria.
> +	 */
> +	CR_POWER2_ALIGNED,
> +
> +	/*
> +	 * Tries to lookup in-memory data structures to find the most suitable
> +	 * group that satisfies goal request. No disk IO except block prefetch.
> +	 */
> +	CR_GOAL_LEN_FAST,
> +
> +        /*
> +	 * Same as CR_GOAL_LEN_FAST but is allowed to reduce the goal length to
> +         * the best available length for faster allocation.

Some whitespace damage here...

> +	 */
> +	CR_BEST_AVAIL_LEN,
> +
> +	/*
> +	 * Reads each block group sequentially, performing disk IO if necessary, to
> +	 * find find_suitable block group. Tries to allocate goal length but might trim

Too long line here.

> +	 * the request if nothing is found after enough tries.
> +	 */
> +	CR_GOAL_LEN_SLOW,
> +
> +	/*
> +	 * Finds the first free set of blocks and allocates those. This is only
> +	 * used in rare cases when CR_GOAL_LEN_SLOW also fails to allocate
> +	 * anything.
> +	 */
> +	CR_ANY_FREE,
>  };
>  
> +/* criteria below which we use fast block scanning and avoid unnecessary IO */
> +#define CR_FAST CR_GOAL_LEN_SLOW
> +

Maybe instead of defining CR_FAST value we could define

static inline bool mballoc_cr_expensive(enum criteria cr)
{
	return cr >= CR_GOAL_LEN_SLOW;
}

And use this. I think it will make the conditions more understandable.

...

> @@ -1064,7 +1068,7 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
>  {
>  	if (unlikely(!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN)))
>  		return 0;
> -	if (ac->ac_criteria >= CR2)
> +	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)

Maybe we should use CR_FAST (or the new function) here?

Otherwise the patch looks good!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
