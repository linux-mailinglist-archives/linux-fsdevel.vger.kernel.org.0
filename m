Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7084B710BF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbjEYMYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjEYMYg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 08:24:36 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE912E;
        Thu, 25 May 2023 05:24:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QRnL70h5tz4f3jYx;
        Thu, 25 May 2023 20:24:31 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgAX561+U29ktNS7KA--.10777S2;
        Thu, 25 May 2023 20:24:32 +0800 (CST)
Subject: Re: [PATCH 01/13] Revert "ext4: remove ac->ac_found >
 sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits"
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
 <cd639a08cc9824c927591d9de14049f2461e1923.1685009579.git.ojaswin@linux.ibm.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <dbc3516a-e5b9-646b-66ad-598b843ccba1@huaweicloud.com>
Date:   Thu, 25 May 2023 20:24:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <cd639a08cc9824c927591d9de14049f2461e1923.1685009579.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAX561+U29ktNS7KA--.10777S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryrZF4rtrW8JF1fWry3urg_yoW5trWkpF
        W3C3WUAr4jyr47CFsru3W8X3ZYkws3CFy2yrW3ur1ruF1aqF97Kr429ryjgF1xAr4kX3WS
        vF40qF17u3sYva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



on 5/25/2023 7:32 PM, Ojaswin Mujoo wrote:
> This reverts commit 32c0869370194ae5ac9f9f501953ef693040f6a1.
> 
> The reverted commit was intended to remove a dead check however it was observed
> that this check was actually being used to exit early instead of looping
> sbi->s_mb_max_to_scan times when we are able to find a free extent bigger than
> the goal extent. Due to this, a my performance tests (fsmark, parallel file
> writes in a highly fragmented FS) were seeing a 2x-3x regression.
> 
> Example, the default value of the following variables is:
> 
> sbi->s_mb_max_to_scan = 200
> sbi->s_mb_min_to_scan = 10
> 
> In ext4_mb_check_limits() if we find an extent smaller than goal, then we return
> early and try again. This loop will go on until we have processed
> sbi->s_mb_max_to_scan(=200) number of free extents at which point we exit and
> just use whatever we have even if it is smaller than goal extent.
> 
> Now, the regression comes when we find an extent bigger than goal. Earlier, in
> this case we would loop only sbi->s_mb_min_to_scan(=10) times and then just use
> the bigger extent. However with commit 32c08693 that check was removed and hence
> we would loop sbi->s_mb_max_to_scan(=200) times even though we have a big enough
> free extent to satisfy the request. The only time we would exit early would be
> when the free extent is *exactly* the size of our goal, which is pretty uncommon
> occurrence and so we would almost always end up looping 200 times.
> 
> Hence, revert the commit by adding the check back to fix the regression. Also
> add a comment to outline this policy.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/mballoc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9c7881a4ea75..2e1a5f001883 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2062,7 +2062,7 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
>  	if (bex->fe_len < gex->fe_len)
>  		return;
>  
> -	if (finish_group)
> +	if (finish_group || ac->ac_found > sbi->s_mb_min_to_scan)
>  		ext4_mb_use_best_found(ac, e4b);
>  }
>  
> @@ -2074,6 +2074,20 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
>   * in the context. Later, the best found extent will be used, if
>   * mballoc can't find good enough extent.
>   *
> + * The algorithm used is roughly as follows:
> + *
> + * * If free extent found is exactly as big as goal, then
> + *   stop the scan and use it immediately
> + *
> + * * If free extent found is smaller than goal, then keep retrying
> + *   upto a max of sbi->s_mb_max_to_scan times (default 200). After
> + *   that stop scanning and use whatever we have.
> + *
> + * * If free extent found is bigger than goal, then keep retrying
> + *   upto a max of sbi->s_mb_min_to_scan times (default 10) before
> + *   stopping the scan and using the extent.
> + *
> + *
>   * FIXME: real allocation policy is to be designed yet!
>   */
>  static void ext4_mb_measure_extent(struct ext4_allocation_context *ac,
> 

My bad, it seems that I mixed up with s_mb_min_to_scan and s_mb_max_to_scan
in previous patch which will make s_mb_min_to_scan not work. Thanks for the
fix. It looks goot to me. Feel free to add my first reviewed-by :)
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>

-- 
Best wishes
Kemeng Shi

