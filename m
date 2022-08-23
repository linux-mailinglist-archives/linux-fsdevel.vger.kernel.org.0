Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B859D0AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 07:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbiHWFtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 01:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiHWFtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:49:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130745EDC8
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 22:49:16 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 202so11362069pgc.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 22:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nBQCK7s4P+8G2l7/O4mq0zwvV5D0rsozdPx4AKdfVp0=;
        b=X6FJ186xClxU/g1BeXVBDCh0LvHZNi1tam4jdWJp6WGc5kQKNcxLuhe6jqOsHk9VHN
         yaAwQ5XQSbCc0Gj3aeoAgYd6hekFOkHqZ9fFyrLQNIlqkqmJIJmdjHMg0xlGF9LXQ0NM
         ECSba6FhN5kDoFtmAmfxcfL5xLBKJI7SSSCgOpThr+D883tUV32xipM8i5g0qzad85Qa
         Tex288qZp4UtlLUEEGMezFKfSzKsaezaI7/kSKxo1FyJFUF8vLHvYKH3eLyKapYwnXPu
         2P6o1QAdDV6uZMM2tj8sNaQVry8TIyBbk6iph6WoLqJpDCUhgJlcTYcRULG3kT3WcrtH
         PoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nBQCK7s4P+8G2l7/O4mq0zwvV5D0rsozdPx4AKdfVp0=;
        b=kimbx+DQGctZfm1n0iajcVM9qiFKZKjEoUhc46Qr4hwlJE8eu2VG3kEH5ogypXeVTO
         4CJEAb4J2couLbF4NE8rdc5EohkkXhKvfzuYPOf4uKQweAB/XCZJh80iEU1lS8WpBktq
         9jjMXUR4R0SPWDKbJ34aVZ55HxedLorwuMyiUkiZlsauwhkR2uOM8dfx/spKbm0/CwzK
         BbqPgspsw8rSM+n3Hr3dqtwM4Fass29ydAMdubbv7kG31eCnyQsNDbS2MrnE9Z3ehggG
         3X1eLHLilhKT/vwjDVkUV4hakzay5t7hlTVkQN68/qJQRFDNQWLirp2wgnBoGHYuisPi
         K1KA==
X-Gm-Message-State: ACgBeo0fJNufrZGRaCWWDPFnDZVsfgBpM63U0H8eyYdT3WnvASV4/3dF
        IuQ0E4irAtyIsSmzJjT9YCoam8m05P9g9g==
X-Google-Smtp-Source: AA6agR5r3KdWUnPfi1I59uQpT6h5DPVD8k4UyU2EXI/nmMQ2j/tS7NJIW9+YaQ4HRpDrUzJUFqF9Cg==
X-Received: by 2002:a05:6a00:1da0:b0:536:f5c1:10df with SMTP id z32-20020a056a001da000b00536f5c110dfmr2036979pfw.73.1661233755475;
        Mon, 22 Aug 2022 22:49:15 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id n34-20020a635c62000000b0041c3ab14ca1sm8423471pgm.0.2022.08.22.22.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 22:49:15 -0700 (PDT)
Message-ID: <d918a1f5-40f4-c90c-a7f5-720dcfddb89b@bytedance.com>
Date:   Tue, 23 Aug 2022 13:49:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH 6/7] kernfs: Allow kernfs nodes to be deactivated and
 re-activated
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
References: <20220820000550.367085-1-tj@kernel.org>
 <20220820000550.367085-7-tj@kernel.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220820000550.367085-7-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/8/20 08:05, Tejun Heo wrote:
> Currently, kernfs nodes can be created deactivated and activated later to
> allow creation of multiple nodes to succeed or fail as a group. Extend this
> capability so that kernfs nodes can be deactivated and re-activated anytime
> and however many times. This can be used to toggle interface files for
> features which can be dynamically turned on and off.
> 
> kernfs_activate()'s skip conditions are updated so that it doesn't ignore
> re-activations and suppress re-activations of files which are being removed.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  fs/kernfs/dir.c        | 89 ++++++++++++++++++++++++++++++------------
>  include/linux/kernfs.h |  2 +
>  2 files changed, 65 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index f857731598cd..6db031362585 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -483,7 +483,7 @@ static bool kernfs_drain(struct kernfs_node *kn)
>  	 * worrying about draining.
>  	 */
>  	if (atomic_read(&kn->active) == KN_DEACTIVATED_BIAS &&
> -	    kernfs_should_drain_open_files(kn))
> +	    !kernfs_should_drain_open_files(kn))
>  		return false;
>  
>  	up_write(&root->kernfs_rwsem);
> @@ -1321,14 +1321,15 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
>  }
>  
>  /**
> - * kernfs_activate - activate a node which started deactivated
> + * kernfs_activate - activate a node's subtree
>   * @kn: kernfs_node whose subtree is to be activated
>   *
> - * If the root has KERNFS_ROOT_CREATE_DEACTIVATED set, a newly created node
> - * needs to be explicitly activated.  A node which hasn't been activated
> - * isn't visible to userland and deactivation is skipped during its
> - * removal.  This is useful to construct atomic init sequences where
> - * creation of multiple nodes should either succeed or fail atomically.
> + * If newly created on a root w/ %KERNFS_ROOT_CREATE_DEACTIVATED or after a
> + * kernfs_deactivate() call, @kn is deactivated and invisible to userland. This
> + * function activates all nodes in @kn's inclusive subtree making them visible.
> + *
> + * %KERNFS_ROOT_CREATE_DEACTIVATED is useful when constructing init sequences
> + * where creation of multiple nodes should either succeed or fail atomically.
>   *
>   * The caller is responsible for ensuring that this function is not called
>   * after kernfs_remove*() is invoked on @kn.
> @@ -1342,7 +1343,7 @@ void kernfs_activate(struct kernfs_node *kn)
>  
>  	pos = NULL;
>  	while ((pos = kernfs_next_descendant_post(pos, kn))) {
> -		if (pos->flags & KERNFS_ACTIVATED)
> +		if (kernfs_active(pos) || (kn->flags & KERNFS_REMOVING))

May I ask a question, what's the difference between kernfs_active() and KERNFS_ACTIVATED?

KERNFS_ACTIVATED is always set when kernfs_activate() and never clear, so I think it means:

1. !KERNFS_ACTIVATED : allocated but not activated
2. KERNFS_ACTIVATED && !kernfs_active() : make deactivated by kernfs_deactivate_locked()

I see most code check kernfs_active(), but two places check KERNFS_ACTIVATED, I'm not sure where
should check KERNFS_ACTIVATED, or is there any chance we can remove KERNFS_ACTIVATED?

Thanks!


>  			continue;
>  
>  		WARN_ON_ONCE(pos->parent && RB_EMPTY_NODE(&pos->rb));
> @@ -1355,6 +1356,58 @@ void kernfs_activate(struct kernfs_node *kn)
>  	up_write(&root->kernfs_rwsem);
>  }
>  
> +static void kernfs_deactivate_locked(struct kernfs_node *kn, bool removing)
> +{
> +	struct kernfs_root *root = kernfs_root(kn);
> +	struct kernfs_node *pos;
> +
> +	lockdep_assert_held_write(&root->kernfs_rwsem);
> +
> +	/* prevent any new usage under @kn by deactivating all nodes */
> +	pos = NULL;
> +	while ((pos = kernfs_next_descendant_post(pos, kn))) {
> +		if (kernfs_active(pos))
> +			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
> +		if (removing)
> +			pos->flags |= KERNFS_REMOVING;
> +	}
> +
> +	/*
> +	 * No new active usage can be created. Drain existing ones. As
> +	 * kernfs_drain() may drop kernfs_rwsem temporarily, pin @pos so that it
> +	 * doesn't go away underneath us.
> +	 *
> +	 * If kernfs_rwsem was released, restart from the beginning. Forward
> +	 * progress is guaranteed as a drained node is guaranteed to stay
> +	 * drained. In the unlikely case that the loop restart ever becomes a
> +	 * problem, we should be able to work around by batching up the
> +	 * draining.
> +	 */
> +	pos = NULL;
> +	while ((pos = kernfs_next_descendant_post(pos, kn))) {
> +		kernfs_get(pos);
> +		if (kernfs_drain(pos))
> +			pos = NULL;
> +		kernfs_put(pos);
> +	}
> +}
> +
> +/**
> + * kernfs_deactivate - deactivate a node's subtree
> + * @kn: kernfs_node whose subtree is to be deactivated
> + *
> + * Deactivate @kn's inclusive subtree. On return, the subtree is invisible to
> + * userland and there are no in-flight file operations.
> + */
> +void kernfs_deactivate(struct kernfs_node *kn)
> +{
> +	struct kernfs_root *root = kernfs_root(kn);
> +
> +	down_write(&root->kernfs_rwsem);
> +	kernfs_deactivate_locked(kn, false);
> +	up_write(&root->kernfs_rwsem);
> +}
> +
>  static void __kernfs_remove(struct kernfs_node *kn)
>  {
>  	struct kernfs_node *pos;
> @@ -1374,26 +1427,12 @@ static void __kernfs_remove(struct kernfs_node *kn)
>  
>  	pr_debug("kernfs %s: removing\n", kn->name);
>  
> -	/* prevent any new usage under @kn by deactivating all nodes */
> -	pos = NULL;
> -	while ((pos = kernfs_next_descendant_post(pos, kn)))
> -		if (kernfs_active(pos))
> -			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
> +	kernfs_deactivate_locked(kn, true);
>  
> -	/* deactivate and unlink the subtree node-by-node */
> +	/* unlink the subtree node-by-node */
>  	do {
>  		pos = kernfs_leftmost_descendant(kn);
>  
> -		/*
> -		 * kernfs_drain() may drop kernfs_rwsem temporarily and @pos's
> -		 * base ref could have been put by someone else by the time
> -		 * the function returns.  Make sure it doesn't go away
> -		 * underneath us.
> -		 */
> -		kernfs_get(pos);
> -
> -		kernfs_drain(pos);
> -
>  		/*
>  		 * kernfs_unlink_sibling() succeeds once per node.  Use it
>  		 * to decide who's responsible for cleanups.
> @@ -1410,8 +1449,6 @@ static void __kernfs_remove(struct kernfs_node *kn)
>  
>  			kernfs_put(pos);
>  		}
> -
> -		kernfs_put(pos);
>  	} while (pos != kn);
>  }
>  
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 367044d7708c..657eea1395b6 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -112,6 +112,7 @@ enum kernfs_node_flag {
>  	KERNFS_SUICIDED		= 0x0800,
>  	KERNFS_EMPTY_DIR	= 0x1000,
>  	KERNFS_HAS_RELEASE	= 0x2000,
> +	KERNFS_REMOVING		= 0x4000,
>  };
>  
>  /* @flags for kernfs_create_root() */
> @@ -429,6 +430,7 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
>  				       const char *name,
>  				       struct kernfs_node *target);
>  void kernfs_activate(struct kernfs_node *kn);
> +void kernfs_deactivate(struct kernfs_node *kn);
>  void kernfs_remove(struct kernfs_node *kn);
>  void kernfs_break_active_protection(struct kernfs_node *kn);
>  void kernfs_unbreak_active_protection(struct kernfs_node *kn);
