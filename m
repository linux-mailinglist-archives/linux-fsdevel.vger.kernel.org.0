Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F3F7B1F54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjI1OS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 10:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjI1OS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:18:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC4619E
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 07:18:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c72e235debso4185085ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695910687; x=1696515487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YomJPH360iMASHFc0ge10/1k1MAdU+zIP9mG8pm9jOg=;
        b=Ib/xOqNx6VeSfqCCFt0LrDm9nl6OOLQ4lK9L9aX/D59mKYvdE6N8s3CbPKNcVX4cY/
         YJDVDp4KTLrEe62fQHIWYrJwbOvmNSWkdpo1yZeNnmNiwPCtnu9G4FWP2QlFFoO2IZZr
         nEq+uRv8xl5gGsGRTrH4EZFAqmb5EQmNoIVs9M9+rFW3TJOexksuI42enqBx/rR+Drpx
         lDmP4FTJXpdEjUhjZoEAPNNxX/iIIQL9iKuwTip+soJKKHriv7pIdlrMd/78QdG0pBbm
         3nonUlHIB9Ys9eQ2kp1jqFwV2MOeXpJtMgj6Bfx1IRLJkr7WWBpjboB/coX79q7dRa5z
         utiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695910687; x=1696515487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YomJPH360iMASHFc0ge10/1k1MAdU+zIP9mG8pm9jOg=;
        b=jiHOVw+2NlDMBJ+5FmwTg5lSR8SbSm4OvjTmPaymJB8SUUcBUtxiZZyYQhZ1mrmbxB
         qv2s05MqCUr9pI2OSb2wopzKZGzju8cN/9yuqQlUIp/cnFE7+YegFFgFijlnmul0eoan
         cB5ORi/XmxTja5zz99FyrWLNQZzxsZkGq91jk7gqJsB6cKTz6MO7fPhbQHYtPFyq366T
         blhrdlHSoOblwjTRm1y9y2iDJZZNaWZONHpJuh8JlXYRaMSsM4oYAtUk7wUGQhW6JU0u
         yEbhXTi/R7lYNwFtxDA+js7yqaWfqdDNgyZYqb6BW4Qmvg8EM9SLTCHRodv7yz/51Otn
         bvFA==
X-Gm-Message-State: AOJu0YwCbQAubmgFoxNRI1pRvZJ+LcCjKvl95CD20SrX5iB4ZtpO1xos
        nRS8iDoMYXg5IbdR9/7Qdl5MdQ==
X-Google-Smtp-Source: AGHT+IGVwWQyqO2wf9CGPxLwLdRj0KOPVDXo9mh85L/XiM+jqCiUhdBr4+xsXsLxYM46GOI3pLpmGg==
X-Received: by 2002:a17:902:e885:b0:1c0:bf60:ba4f with SMTP id w5-20020a170902e88500b001c0bf60ba4fmr1277405plg.4.1695910686732;
        Thu, 28 Sep 2023 07:18:06 -0700 (PDT)
Received: from [10.254.163.112] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001b9e86e05b7sm15058062pld.0.2023.09.28.07.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 07:18:06 -0700 (PDT)
Message-ID: <72d0e76f-2837-f2ca-6451-f8d808f3338a@bytedance.com>
Date:   Thu, 28 Sep 2023 22:17:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] fixup: mm: shrinker: add a secondary array for
 shrinker_info::{map, nr_deferred}
Content-Language: en-US
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.carpenter@linaro.org
References: <20230911094444.68966-41-zhengqi.arch@bytedance.com>
 <20230928141517.12164-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230928141517.12164-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

After applying this fix patch, the following modifications also need to
be applied to the "[PATCH v6 45/45] mm: shrinker: convert shrinker_rwsem
to mutex".

diff --git a/mm/shrinker.c b/mm/shrinker.c
index 6857cbb520ea..dd91eab43ed3 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -96,7 +96,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
         return ret;

  err:
-       up_write(&shrinker_rwsem);
+       mutex_unlock(&shrinker_mutex);
         free_shrinker_info(memcg);
         return -ENOMEM;
  }

Or do I need to resend the entire patch set? If yes please let me know.

Thanks,
Qi

On 2023/9/28 22:15, Qi Zheng wrote:
> Dan Carpenter reported the following bug:
> 
> ```
> The patch b6884b5f15cf: "mm: shrinker: add a secondary array for
> shrinker_info::{map, nr_deferred}" from Sep 11, 2023 (linux-next),
> leads to the following Smatch static checker warning:
> 
> 	mm/shrinker.c:100 alloc_shrinker_info()
> 	warn: inconsistent returns '&shrinker_mutex'.
> ```
> 
> To fix it, unlock the &shrinker_rwsem before the call to
> free_shrinker_info().
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-mm/f960ae49-078c-4c00-9516-da31fc1a17d6@moroto.mountain/
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/shrinker.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index 893079806553..e9644cda80b5 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -95,6 +95,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>   	return ret;
>   
>   err:
> +	up_write(&shrinker_rwsem);
>   	free_shrinker_info(memcg);
>   	return -ENOMEM;
>   }
