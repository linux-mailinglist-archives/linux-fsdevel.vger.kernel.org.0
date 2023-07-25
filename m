Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576EE760FD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjGYJ4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 05:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjGYJ4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:56:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF13F1992
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 02:56:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2659b1113c2so706739a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690279003; x=1690883803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/casiWQBa8FLPDyI/Gjog1Q/iFy65e/7JWaM5Gwrppw=;
        b=kzP9jxhdW7EUIP2JpY6nQ4V3KB8KzHZHwXd+bJOEeLU9gCN3lvtKTIOyV+D6pg6POw
         Q2+Agk0fHs6Wf0nJIf8rf8T9VZNFr/hsapg2zga11FSk7AOs0JkWfaLjemq0FDeG0Uw5
         HhEk2mitTuKDolaaQqjf+O9IL+c+U5F1pPsQI+4eucs75jhsRhGM9fqq3uQDPTEvroq0
         /U4/CVAvtL3Xk0W286vaVtW9MXQ1p85A5kNQw+kxMFfLtXWo8Tn1go6QyxS1jqmnrw9a
         uFzHc2WhcIqVkW0xdKzdkJ+42hQ6tNSe2IXCsgIEyfURXIjl60ODrk022w8+JVfo8hQI
         ne/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690279003; x=1690883803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/casiWQBa8FLPDyI/Gjog1Q/iFy65e/7JWaM5Gwrppw=;
        b=RvTRI9MN2FAzzAH+j+rhODJDw9cs46eHM5ZypOEb+Fh1O69vpkqYVxUCHvCc+/w8WP
         fpBVpYUckSYM4PVYPzewTJl1x8FdxEKm22yUtKYf6sisncl4RLV+v59gF8i193ntKHK5
         A0cvmvTMZz0N7OxPgd8cDcqjBrZ0KULR/E/JGWOSJhNbo78V+/czJTAkVVSPLuOZg5ep
         ydTT9BtbfLk9D9rF9cX6ZpHGteYUhytx/bzgzMS1WTzzJ/injwQtfHV5OVOoxh+jIwuk
         ImF+kzu8ayHbGr5ZLjzLDz7W0lBHj0xwpB9YUWwuEiuyYrDSJQ+rRi1ywyD8GdX1Rnkr
         ac7A==
X-Gm-Message-State: ABy/qLYHDb97I3xVIoTxeXcMg8n8Lszl7nneUWN+pLeZTq+I+BsiIpch
        ZCaLld2x3A1sVIEHOMzlL4C90g==
X-Google-Smtp-Source: APBJJlE4g3zxacKAsn4H4YysRKAp71VN9gqUpsqodFXfAXxBRsoAel6FjePiWo+WkUy1agkNvA6LJQ==
X-Received: by 2002:a17:90a:74cf:b0:268:196f:9656 with SMTP id p15-20020a17090a74cf00b00268196f9656mr4627258pjl.1.1690279003192;
        Tue, 25 Jul 2023 02:56:43 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b001b39ffff838sm10605398plx.25.2023.07.25.02.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 02:56:42 -0700 (PDT)
Message-ID: <c1a1952f-0c3e-2fa1-fdf9-8b3b8a592b23@bytedance.com>
Date:   Tue, 25 Jul 2023 17:56:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/47] mm: shrinker: add infrastructure for dynamically
 allocating shrinker
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-4-zhengqi.arch@bytedance.com>
 <3648ca69-d65e-8431-135a-a5738586bc25@linux.dev>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <3648ca69-d65e-8431-135a-a5738586bc25@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muchun,

On 2023/7/25 17:02, Muchun Song wrote:
> 
> 
> On 2023/7/24 17:43, Qi Zheng wrote:
>> Currently, the shrinker instances can be divided into the following three
>> types:
>>
>> a) global shrinker instance statically defined in the kernel, such as
>>     workingset_shadow_shrinker.
>>
>> b) global shrinker instance statically defined in the kernel modules, 
>> such
>>     as mmu_shrinker in x86.
>>
>> c) shrinker instance embedded in other structures.
>>
>> For case a, the memory of shrinker instance is never freed. For case b,
>> the memory of shrinker instance will be freed after synchronize_rcu() 
>> when
>> the module is unloaded. For case c, the memory of shrinker instance will
>> be freed along with the structure it is embedded in.
>>
>> In preparation for implementing lockless slab shrink, we need to
>> dynamically allocate those shrinker instances in case c, then the memory
>> can be dynamically freed alone by calling kfree_rcu().
>>
>> So this commit adds the following new APIs for dynamically allocating
>> shrinker, and add a private_data field to struct shrinker to record and
>> get the original embedded structure.
>>
>> 1. shrinker_alloc()
>>
>> Used to allocate shrinker instance itself and related memory, it will
>> return a pointer to the shrinker instance on success and NULL on failure.
>>
>> 2. shrinker_free_non_registered()
>>
>> Used to destroy the non-registered shrinker instance.
> 
> At least I don't like this name. I know you want to tell others
> this function only should be called when shrinker has not been
> registed but allocated. Maybe shrinker_free() is more simple.
> And and a comment to tell the users when to use it.

OK, if no one else objects, I will change it to shrinker_free() in
the next version.

> 
>>
>> 3. shrinker_register()
>>
>> Used to register the shrinker instance, which is same as the current
>> register_shrinker_prepared().
>>
>> 4. shrinker_unregister()
>>
>> Used to unregister and free the shrinker instance.
>>
>> In order to simplify shrinker-related APIs and make shrinker more
>> independent of other kernel mechanisms, subsequent submissions will use
>> the above API to convert all shrinkers (including case a and b) to
>> dynamically allocated, and then remove all existing APIs.
>>
>> This will also have another advantage mentioned by Dave Chinner:
>>
>> ```
>> The other advantage of this is that it will break all the existing
>> out of tree code and third party modules using the old API and will
>> no longer work with a kernel using lockless slab shrinkers. They
>> need to break (both at the source and binary levels) to stop bad
>> things from happening due to using uncoverted shrinkers in the new
>> setup.
>> ```
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/shrinker.h |   6 +++
>>   mm/shrinker.c            | 113 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 119 insertions(+)
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index 961cb84e51f5..296f5e163861 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -70,6 +70,8 @@ struct shrinker {
>>       int seeks;    /* seeks to recreate an obj */
>>       unsigned flags;
>> +    void *private_data;
>> +
>>       /* These are for internal use */
>>       struct list_head list;
>>   #ifdef CONFIG_MEMCG
>> @@ -98,6 +100,10 @@ struct shrinker {
>>   unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup 
>> *memcg,
>>                 int priority);
>> +struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, 
>> ...);
>> +void shrinker_free_non_registered(struct shrinker *shrinker);
>> +void shrinker_register(struct shrinker *shrinker);
>> +void shrinker_unregister(struct shrinker *shrinker);
>>   extern int __printf(2, 3) prealloc_shrinker(struct shrinker *shrinker,
>>                           const char *fmt, ...);
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index 0a32ef42f2a7..d820e4cc5806 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -548,6 +548,119 @@ unsigned long shrink_slab(gfp_t gfp_mask, int 
>> nid, struct mem_cgroup *memcg,
>>       return freed;
>>   }
>> +struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, 
>> ...)
>> +{
>> +    struct shrinker *shrinker;
>> +    unsigned int size;
>> +    va_list __maybe_unused ap;
>> +    int err;
>> +
>> +    shrinker = kzalloc(sizeof(struct shrinker), GFP_KERNEL);
>> +    if (!shrinker)
>> +        return NULL;
>> +
>> +#ifdef CONFIG_SHRINKER_DEBUG
>> +    va_start(ap, fmt);
>> +    shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
>> +    va_end(ap);
>> +    if (!shrinker->name)
>> +        goto err_name;
>> +#endif
> 
> So why not introduce another helper to handle this and declare it
> as a void function when !CONFIG_SHRINKER_DEBUG? Something like the
> following:
> 
> #ifdef CONFIG_SHRINKER_DEBUG
> static int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const 
> char *fmt,
>                                         va_list vargs)
> 
> {
>      shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, vargs);
>      return shrinker->name ? 0 : -ENOMEM;
> }
> #else
> static int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const 
> char *fmt,
>                                         va_list vargs)
> {
>      return 0;
> }
> #endif

Will do in the next version.

> 
>> +    shrinker->flags = flags;
>> +
>> +    if (flags & SHRINKER_MEMCG_AWARE) {
>> +        err = prealloc_memcg_shrinker(shrinker);
>> +        if (err == -ENOSYS)
>> +            shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
>> +        else if (err == 0)
>> +            goto done;
>> +        else
>> +            goto err_flags;
>> +    }
>> +
>> +    /*
>> +     * The nr_deferred is available on per memcg level for memcg aware
>> +     * shrinkers, so only allocate nr_deferred in the following cases:
>> +     *  - non memcg aware shrinkers
>> +     *  - !CONFIG_MEMCG
>> +     *  - memcg is disabled by kernel command line
>> +     */
>> +    size = sizeof(*shrinker->nr_deferred);
>> +    if (flags & SHRINKER_NUMA_AWARE)
>> +        size *= nr_node_ids;
>> +
>> +    shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
>> +    if (!shrinker->nr_deferred)
>> +        goto err_flags;
>> +
>> +done:
>> +    return shrinker;
>> +
>> +err_flags:
>> +#ifdef CONFIG_SHRINKER_DEBUG
>> +    kfree_const(shrinker->name);
>> +    shrinker->name = NULL;
> 
> This could be shrinker_debugfs_name_free()

Will do.

> 
>> +err_name:
>> +#endif
>> +    kfree(shrinker);
>> +    return NULL;
>> +}
>> +EXPORT_SYMBOL(shrinker_alloc);
>> +
>> +void shrinker_free_non_registered(struct shrinker *shrinker)
>> +{
>> +#ifdef CONFIG_SHRINKER_DEBUG
>> +    kfree_const(shrinker->name);
>> +    shrinker->name = NULL;
> 
> This could be shrinker_debugfs_name_free()
> 
>> +#endif
>> +    if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
>> +        down_write(&shrinker_rwsem);
>> +        unregister_memcg_shrinker(shrinker);
>> +        up_write(&shrinker_rwsem);
>> +    }
>> +
>> +    kfree(shrinker->nr_deferred);
>> +    shrinker->nr_deferred = NULL;
>> +
>> +    kfree(shrinker);
>> +}
>> +EXPORT_SYMBOL(shrinker_free_non_registered);
>> +
>> +void shrinker_register(struct shrinker *shrinker)
>> +{
>> +    down_write(&shrinker_rwsem);
>> +    list_add_tail(&shrinker->list, &shrinker_list);
>> +    shrinker->flags |= SHRINKER_REGISTERED;
>> +    shrinker_debugfs_add(shrinker);
>> +    up_write(&shrinker_rwsem);
>> +}
>> +EXPORT_SYMBOL(shrinker_register);
>> +
>> +void shrinker_unregister(struct shrinker *shrinker)
> 
> You have made all shrinkers to be dynamically allocated, so
> we should prevent users from allocating shrinkers statically and
> use this function to unregister it. It is better to add a
> flag like SHRINKER_ALLOCATED which is set in shrinker_alloc(),
> and check whether it is set in shrinker_unregister(), if not
> maybe a warning should be added to tell the users what happened.

Make sense, will do.

> 
>> +{
>> +    struct dentry *debugfs_entry;
>> +    int debugfs_id;
>> +
>> +    if (!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))
>> +        return;
>> +
>> +    down_write(&shrinker_rwsem);
>> +    list_del(&shrinker->list);
>> +    shrinker->flags &= ~SHRINKER_REGISTERED;
>> +    if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>> +        unregister_memcg_shrinker(shrinker);
>> +    debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
> 
> In the internal of this function, you also could use
> shrinker_debugfs_name_free().

Yeah, will do.

Thanks,
Qi

> 
> Thanks.
> 
>> +    up_write(&shrinker_rwsem);
>> +
>> +    shrinker_debugfs_remove(debugfs_entry, debugfs_id);
>> +
>> +    kfree(shrinker->nr_deferred);
>> +    shrinker->nr_deferred = NULL;
>> +
>> +    kfree(shrinker);
>> +}
>> +EXPORT_SYMBOL(shrinker_unregister);
>> +
>>   /*
>>    * Add a shrinker callback to be called from the vm.
>>    */
> 
