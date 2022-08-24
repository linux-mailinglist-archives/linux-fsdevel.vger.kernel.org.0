Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6C59FAD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 15:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiHXNCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiHXNCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:02:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C89497D77;
        Wed, 24 Aug 2022 06:02:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id io24so2321233plb.1;
        Wed, 24 Aug 2022 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XAUfWXnBLgZU1RF+IGZaqoW6ICyj5iA/u5hjNGQLXxI=;
        b=ml6sUCaOrs4Y85o8JF0FnzbqASxpqnG1xaur25bhRlu+8c14xl+WPd/ubvyTD3AbaN
         17lWfMoDrAaU8X9gjekNKYTMaq2Daz1G/0MjNxFYEVVHuzLxxfnm10/p0BmkC4h3D7hJ
         b+a42hRk7lo2lHHKkKKFnzU+26pTld7JervGIhLTiVgcC+kQLpa8RN+QbT7v2fWbfuHa
         JYdnHu70C2E7/ZToINbIG1KyI5eZ1ZwZPCFbtL4yFMnZ5E18fAaDWmO6pZ5ze08qyGY3
         IpbCtM+XPP5G8EkhYMMjmElKVwL0prPlMbV7GIRM4KTmQLdqlnh/xFIBPv52+37FQbjr
         ag7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XAUfWXnBLgZU1RF+IGZaqoW6ICyj5iA/u5hjNGQLXxI=;
        b=CNXnUz+mA0eF1ZzOU/mn4slkv8xRc6Z0mDGt8q9hwvKbRWFRkxwrseM/ZMn6FH9X/X
         lZM/9ggPMH3px0vXASgcD24eVuw3xVK7Jd84XQ4lJokvVFp+9KNp5O68rNmKn7AcJVnO
         S2rHBJU/u0KfPUqM5MHIyFjbtphgbegoq18etgj12hO52jYFuqUPXE5js7xyWlih5lAt
         +lMpYWYmZJ+kGqqCO7f4Nf/OZCNlo7RqyjrRkx4NL8jWTTwpIA23RLfLRQY4v3TR/BIU
         tnUchpxFZmmkaHOegpaMW3/9LWMQsdSLxguL2qhtMEU8pR7alLWj3okMcmYC6pqS1T4S
         hhrQ==
X-Gm-Message-State: ACgBeo15iT6W6vpRML4b6h0wHgePSNhWT2eG+lwdLjadHj/eJm4ZhbjZ
        maZw7+q/iEGpeXSi1lZSV0k=
X-Google-Smtp-Source: AA6agR7iSr6MO5nHFFkVW+VyeKCo9O5k5c+zoHN0cgAt3sWclsbmuR9+RmWuMfqngSjjYWHw0xFOPQ==
X-Received: by 2002:a17:90a:c78f:b0:1fa:e505:18e6 with SMTP id gn15-20020a17090ac78f00b001fae50518e6mr8465701pjb.23.1661346165672;
        Wed, 24 Aug 2022 06:02:45 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-16.three.co.id. [116.206.28.16])
        by smtp.gmail.com with ESMTPSA id c127-20020a621c85000000b0052ddaffbcc1sm12834062pfc.30.2022.08.24.06.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 06:02:45 -0700 (PDT)
Message-ID: <bd50d4d2-f3dc-4e66-1d82-5221dab8b456@gmail.com>
Date:   Wed, 24 Aug 2022 20:02:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 2/2] ksm: add profit monitoring documentation
Content-Language: en-US
To:     xu xin <cgel.zte@gmail.com>, akpm@linux-foundation.org,
        corbet@lwn.net
Cc:     adobriyan@gmail.com, willy@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
References: <20220824124512.223103-1-xu.xin16@zte.com.cn>
 <20220824124846.223217-1-xu.xin16@zte.com.cn>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220824124846.223217-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/24/22 19:48, xu xin wrote:
> +Monitoring KSM profit
> +=====================
> +
> +KSM can save memory by merging identical pages, but also can consume
> +additional memory, because it needs to generate a number of rmap_items to
> +save each scanned page's brief rmap information. Some of these pages may
> +be merged, but some may not be abled to be merged after being checked
> +several times, which are unprofitable memory consumed.
> +
> +1) How to determine whether KSM save memory or consume memory in system-wide
> +   range? Here is a simple approximate calculation for reference::
> +
> +	general_profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
> +			  sizeof(rmap_item);
> +
> +   where all_rmap_items can be easily obtained by summing ``pages_sharing``,
> +   ``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
> +
> +2) The KSM profit inner a single process can be similarly obtained by the
> +   following approximate calculation::
> +
> +	process_profit =~ ksm_merging_pages * sizeof(page) -
> +			  ksm_rmp_items * sizeof(rmap_item).
> +
> +   where both ksm_merging_pages and ksm_rmp_items are shown under the
> +   directory ``/proc/<pid>/``.
> +
> +From the perspective of application, a high ratio of ``ksm_rmp_items`` to
> +``ksm_merging_pages`` means a bad madvise-applied policy, so developers or
> +administrators have to rethink how to change madvise policy. Giving an example
> +for reference, a page's size is usually 4K, and the rmap_item's size is
> +separately 32B on 32-bit CPU architecture and 64B on 64-bit CPU architecture.
> +so if the ``ksm_rmp_items/ksm_merging_pages`` ratio exceeds 64 on 64-bit CPU
> +or exceeds 128 on 32-bit CPU, then the app's madvise policy should be dropped,
> +because the ksm profit is approximately zero or negative.
> +
>  Monitoring KSM events
>  =====================
>  

LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
