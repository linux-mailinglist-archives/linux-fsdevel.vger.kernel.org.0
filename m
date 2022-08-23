Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB9A59D07C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 07:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiHWFd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 01:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiHWFdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:33:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5479862E7
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 22:33:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d71so11319057pgc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 22:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/GFR/eBHEhPX0G8BdA3Wshib8j1DCBk1nG3MDC50vbc=;
        b=tr24EbXeGwR5nsUyjC8VSTM6dVj8ql9kNWygHPAhDW+87f7YPTy35rl+Pafvt/b7Jv
         iZlXinH+lwkstOIUzdXEogEElQ8byslQuAbap6AXFiAVBx7t2XnzaILgs91HZ8TwZO0e
         f78++2T0IAQ1MnIjV9OT9Tack8qFfLwbmDiU+aqWljTNqLo3iCtLmrq2HvkyDYera8qx
         JIizu5ifVqWezQFiDdmHil0GI595Gv72ss6H2InWKa9wa9oCweU6/wSGSYPfX8u6F0Uq
         62HjHHNrkqMN4g72vEXYImkxddyZIGBAGy70yV8qpCYsh/me4b8BSkpts9xj+9t4xZhp
         9NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/GFR/eBHEhPX0G8BdA3Wshib8j1DCBk1nG3MDC50vbc=;
        b=6n0y9my8h8Z2sHL5qTlSneRkXMUxYThw6COJQC4tVOzaEn3cK4QhY3Tujr7ugXQttI
         uNFA22G3lbjVEMRFok5VaWHxufo6PicK8mS1ASqkHKRPPzIi7morRgyC+jnaCGMbFP5S
         XSu2EyNjtbdK0Nr9isVPF9fZVmfh9ME9ZrCaWcMvE7OYPIamGDuC5ZNjh39vBi+o/nb0
         Yxe+xmQLZkgtUYJ7HRL8ekXRXdR7DXAN+gAGKrg6knk8VeDv2gCTaxITLwNxvJn/6+ke
         loVZs1hLbrmvH+LhyhlHlwALD7TG8+zOAXRNKuIORnrEm3xEK4tEgdXvCorsp5O85GGX
         dF6g==
X-Gm-Message-State: ACgBeo1GkDMiyzzCU+++bJ79FdqWeNVjHgKHUUDNBC8apC8SidcokNu1
        Gw9Q5kJsiloVBzzT04riTUGRILh+Z/NXcw==
X-Google-Smtp-Source: AA6agR5ZDfL1Q7pmClsrDWZa1njQsLMpZdLUz7tKlcKdif0pifg20UDYa37a3lusGrLtIt0JUm8DDA==
X-Received: by 2002:a63:8b44:0:b0:41c:df4c:7275 with SMTP id j65-20020a638b44000000b0041cdf4c7275mr19999090pge.434.1661232802793;
        Mon, 22 Aug 2022 22:33:22 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b001714e7608fdsm9430886plh.256.2022.08.22.22.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 22:33:21 -0700 (PDT)
Message-ID: <04b8cfda-4017-a7dd-65e3-b6746d1898e6@bytedance.com>
Date:   Tue, 23 Aug 2022 13:33:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH 5/7] kernfs: Make kernfs_drain() skip draining more
 aggressively
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
References: <20220820000550.367085-1-tj@kernel.org>
 <20220820000550.367085-6-tj@kernel.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220820000550.367085-6-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/8/20 08:05, Tejun Heo wrote:
> kernfs_drain() is updated to handle whether draining is necessary or not
> rather than its caller. __kernfs_remove() now always calls kernfs_drain()
> instead of filtering based on KERNFS_ACTIVATED.
> 
> kernfs_drain() now tests kn->active and kernfs_should_drain_open_files() to
> determine whether draining is necessary at all. If not, it returns %false
> without doing anything. Otherwise, it unlocks kernfs_rwsem and drains as
> before and returns %true. The return value isn't used yet.
> 
> Using the precise conditions allows skipping more aggressively. This isn't a
> meaningful optimization on its own but will enable future stand-alone
> kernfs_deactivate() implementation.
> 
> While at it, make minor comment updates.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  fs/kernfs/dir.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 8ae44db920d4..f857731598cd 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -460,10 +460,14 @@ void kernfs_put_active(struct kernfs_node *kn)
>   * @kn: kernfs_node to drain
>   *
>   * Drain existing usages and nuke all existing mmaps of @kn.  Mutiple
> - * removers may invoke this function concurrently on @kn and all will
> + * callers may invoke this function concurrently on @kn and all will
>   * return after draining is complete.
> + *
> + * RETURNS:
> + * %false if nothing needed to be drained; otherwise, %true. On %true return,
> + * kernfs_rwsem has been released and re-acquired.
>   */
> -static void kernfs_drain(struct kernfs_node *kn)
> +static bool kernfs_drain(struct kernfs_node *kn)
>  	__releases(&kernfs_root(kn)->kernfs_rwsem)
>  	__acquires(&kernfs_root(kn)->kernfs_rwsem)
>  {
> @@ -472,6 +476,16 @@ static void kernfs_drain(struct kernfs_node *kn)
>  	lockdep_assert_held_write(&root->kernfs_rwsem);
>  	WARN_ON_ONCE(kernfs_active(kn));
>  
> +	/*
> +	 * Skip draining if already fully drained. This avoids draining and its
> +	 * lockdep annotations for nodes which have never been activated
> +	 * allowing embedding kernfs_remove() in create error paths without
> +	 * worrying about draining.
> +	 */
> +	if (atomic_read(&kn->active) == KN_DEACTIVATED_BIAS &&
> +	    kernfs_should_drain_open_files(kn))

Should be !kernfs_should_drain_open_files(kn)? I see that diff is put in patch 6/7.

Thanks.


> +		return false;
> +
>  	up_write(&root->kernfs_rwsem);
>  
>  	if (kernfs_lockdep(kn)) {
> @@ -480,7 +494,6 @@ static void kernfs_drain(struct kernfs_node *kn)
>  			lock_contended(&kn->dep_map, _RET_IP_);
>  	}
>  
> -	/* but everyone should wait for draining */
>  	wait_event(root->deactivate_waitq,
>  		   atomic_read(&kn->active) == KN_DEACTIVATED_BIAS);
>  
> @@ -493,6 +506,8 @@ static void kernfs_drain(struct kernfs_node *kn)
>  		kernfs_drain_open_files(kn);
>  
>  	down_write(&root->kernfs_rwsem);
> +
> +	return true;
>  }
>  
>  /**
> @@ -1370,23 +1385,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
>  		pos = kernfs_leftmost_descendant(kn);
>  
>  		/*
> -		 * kernfs_drain() drops kernfs_rwsem temporarily and @pos's
> +		 * kernfs_drain() may drop kernfs_rwsem temporarily and @pos's
>  		 * base ref could have been put by someone else by the time
>  		 * the function returns.  Make sure it doesn't go away
>  		 * underneath us.
>  		 */
>  		kernfs_get(pos);
>  
> -		/*
> -		 * Drain iff @kn was activated.  This avoids draining and
> -		 * its lockdep annotations for nodes which have never been
> -		 * activated and allows embedding kernfs_remove() in create
> -		 * error paths without worrying about draining.
> -		 */
> -		if (kn->flags & KERNFS_ACTIVATED)
> -			kernfs_drain(pos);
> -		else
> -			WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
> +		kernfs_drain(pos);
>  
>  		/*
>  		 * kernfs_unlink_sibling() succeeds once per node.  Use it
