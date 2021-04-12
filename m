Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D742A35D050
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 20:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244901AbhDLS0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 14:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbhDLS0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:26:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16ACC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 11:26:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 10so856509pfl.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=04YF3M1vfRP/894Mkgtm7cFlhBMi621lrF3NTwGcvuo=;
        b=BwVBTRBsJxDqmmlOtB8bmKlBhQXbtnALtN8305m2UQPPu7O8SOqsfety1GQWN46GdQ
         Mk199hVidSasf6I9HMs7rUz40Jhhrnlca20rU38slO3ihLmxc0yUwI5l3Bo4WtT35NxC
         ggJ56+58XC1xnByQLAY087TVb4iG7ep1bHi+ZAwHlBUSEiexv9COfEJDIybuRifwqc0h
         vPfZqT4DFdjV6LTSrPvKzvDzN/LYaLY7NtvzBFLqS4zvKwlDoCUWPcBWEfSgQdUuoFYz
         QgoVVY5nnFStxxLDQN29Yc84m/Il7lckWG30UR70JawzZ0SlKX1qPWjzIyUxOzbBII7p
         FJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=04YF3M1vfRP/894Mkgtm7cFlhBMi621lrF3NTwGcvuo=;
        b=IwgIqi7+C1gypkGN1iMF/2dOFQfT3V/vcPato3uEHvpboHg/nHv6UsmSKbnYahFkDL
         nSorrlZe4jfFD4vdrCHFfFz02lbwZl1q7BU81VoDZe8KHu4UO2rdQJA9HskKL1EA/Hcg
         AQp2VU1gy05LrCBjNXeLaEAOHGPNnib5OhE8ejhRvrz+6pyRz0x7ovVaCNbXARXx5YQb
         Vyme9kqc2CDu1qtQGLhS0FzsyFe7RcnSQWz3cMdFVzz01ASdQ1UxEchYXiW6wUyOrwIm
         DDEk9WsueX+54AiaSRZMjE8do84/LqvazNTlcuNsvCjVNEWb7Gv+x/DbJ0uXFHiOb91z
         uDtw==
X-Gm-Message-State: AOAM530P2SvyeURfguogeiUkBsK5GkyNPWS7NeSnX1fZN8y/Y1zpEN8w
        I3lVLdQOF6dVr75qk3aCgW3/ssdZRl7ziA==
X-Google-Smtp-Source: ABdhPJwHnUtr4YGb6WMKANB8mpeGESvy7nopkF745LSGgBg5SipI+mqZd1NXLZQTEZYkbp3D1i+FlQ==
X-Received: by 2002:aa7:8389:0:b029:209:da1c:17b5 with SMTP id u9-20020aa783890000b0290209da1c17b5mr26072167pfm.29.1618251989325;
        Mon, 12 Apr 2021 11:26:29 -0700 (PDT)
Received: from [2620:15c:17:3:7835:226e:b31b:6f48] ([2620:15c:17:3:7835:226e:b31b:6f48])
        by smtp.gmail.com with ESMTPSA id n4sm10676856pfu.45.2021.04.12.11.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 11:26:28 -0700 (PDT)
Date:   Mon, 12 Apr 2021 11:26:27 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     chukaiping <chukaiping@baidu.com>
cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/compaction:let proactive compaction order
 configurable
In-Reply-To: <1618218330-50591-1-git-send-email-chukaiping@baidu.com>
Message-ID: <e57c2db3-11f-4d1b-b5cc-8a9e112af34@google.com>
References: <1618218330-50591-1-git-send-email-chukaiping@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Apr 2021, chukaiping wrote:

> Currently the proactive compaction order is fixed to
> COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
> normal 4KB memory, but it's too high for the machines with small
> normal memory, for example the machines with most memory configured
> as 1GB hugetlbfs huge pages. In these machines the max order of
> free pages is often below 9, and it's always below 9 even with hard
> compaction. This will lead to proactive compaction be triggered very
> frequently. In these machines we only care about order of 3 or 4.
> This patch export the oder to proc and let it configurable
> by user, and the default value is still COMPACTION_HPAGE_ORDER.
> 

I'm curious why you have proactive compaction enabled at all in this case?

The order-9 threshold is likely to optimize for hugepage availability, but 
in your setup it appears that's not a goal.

So what benefit does proactive compaction provide if only done for order-3 
or order-4?

> Signed-off-by: chukaiping <chukaiping@baidu.com>
> ---
>  include/linux/compaction.h |    1 +
>  kernel/sysctl.c            |   10 ++++++++++
>  mm/compaction.c            |    7 ++++---
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index ed4070e..151ccd1 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int order)
>  #ifdef CONFIG_COMPACTION
>  extern int sysctl_compact_memory;
>  extern unsigned int sysctl_compaction_proactiveness;
> +extern unsigned int sysctl_compaction_order;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_extfrag_threshold;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 62fbd09..277df31 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -114,6 +114,7 @@
>  static int __maybe_unused neg_one = -1;
>  static int __maybe_unused two = 2;
>  static int __maybe_unused four = 4;
> +static int __maybe_unused ten = 10;
>  static unsigned long zero_ul;
>  static unsigned long one_ul = 1;
>  static unsigned long long_max = LONG_MAX;
> @@ -2871,6 +2872,15 @@ int proc_do_static_key(struct ctl_table *table, int write,
>  		.extra2		= &one_hundred,
>  	},
>  	{
> +		.procname       = "compaction_order",
> +		.data           = &sysctl_compaction_order,
> +		.maxlen         = sizeof(sysctl_compaction_order),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec_minmax,
> +		.extra1         = SYSCTL_ZERO,
> +		.extra2         = &ten,
> +	},
> +	{
>  		.procname	= "extfrag_threshold",
>  		.data		= &sysctl_extfrag_threshold,
>  		.maxlen		= sizeof(int),
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f447..a192996 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1925,16 +1925,16 @@ static bool kswapd_is_running(pg_data_t *pgdat)
>  
>  /*
>   * A zone's fragmentation score is the external fragmentation wrt to the
> - * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
> + * sysctl_compaction_order. It returns a value in the range [0, 100].
>   */
>  static unsigned int fragmentation_score_zone(struct zone *zone)
>  {
> -	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> +	return extfrag_for_order(zone, sysctl_compaction_order);
>  }
>  
>  /*
>   * A weighted zone's fragmentation score is the external fragmentation
> - * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
> + * wrt to the sysctl_compaction_order scaled by the zone's size. It
>   * returns a value in the range [0, 100].
>   *
>   * The scaling factor ensures that proactive compaction focuses on larger
> @@ -2666,6 +2666,7 @@ static void compact_nodes(void)
>   * background. It takes values in the range [0, 100].
>   */
>  unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
> +unsigned int __read_mostly sysctl_compaction_order = COMPACTION_HPAGE_ORDER;
>  
>  /*
>   * This is the entry point for compacting all nodes via
> -- 
> 1.7.1
> 
> 
