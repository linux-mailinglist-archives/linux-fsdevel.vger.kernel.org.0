Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C2C73CE35
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jun 2023 05:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjFYDPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jun 2023 23:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFYDPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jun 2023 23:15:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F411E7C
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jun 2023 20:15:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6687b209e5aso495383b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jun 2023 20:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687662910; x=1690254910;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKI5JnbDIC0GxIDWgHq4O/cOoJK+mFi4lHzSLMfVTqU=;
        b=ZAMx9Z9f9sidua+INHohqUOzi6qohVG8u4jVCH5kW+5KNZXm213btXme0+oY3eiFas
         kJ1eg2nzkYdYzNdOe7oa9qHmaJUnXCYxjS+yzRkh4fKBRaJsJ8sThwNTH8lHQfNkQNAM
         VzcFUF7+yXpjBTL7GbZNoITLErtoJw0Vjk1rTp/DbKRrvAbdhI1W9mMFrodUhQiTOgU4
         x87qi5B+whZkF6jL19/UUqYgrCxdv27BCv4u4d4gCY3C0TEpHKxxaHXbF0gjifwSN242
         21vqEHW8Cm8PCiF/LjQeQL8d9CMETY+gbtFossFoUbQJa5ZrwnE/J5ioBpxXDyTlqBxM
         qigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687662910; x=1690254910;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKI5JnbDIC0GxIDWgHq4O/cOoJK+mFi4lHzSLMfVTqU=;
        b=Dt0vSSI/JKZ/ezO8PRNpoCCZ40oiTCLbOHQ9zjYXeVUXbPWZBsspx7tRxa7EONjcm2
         0hEfKkpySiwsVBfC0Uczn5rEUTcpYEQ8bYzrzL83k+m5cAPR4anXQ81PL16mNSJuJAYo
         HS5gb9wm894sP6un1KfDMPEl8n1MPKUTiijUmFvjXtQhUHgHHVhBeJDT8+LgkNt9Y8H7
         pSW/Cue7TfXfXTOw8uv9ftRsYkFLwYKQt94lKve1TPistGk/dD9pdlVN21+FHc/3mqOh
         MHfUtvCx22sjWYZuhytAnXPb/dOuSHG8r7PGsm2L4wvkmi30qWFJClp8tdMYhRKVUzi0
         b7Wg==
X-Gm-Message-State: AC+VfDy7HtLmYh1ZkN8FZ8yP8GX/gd0kffuwdiPeJVKcoMZ25rrPA0rH
        /1qSZGYz2hBDJCLX1SbftXI4Vg==
X-Google-Smtp-Source: ACHHUZ4cDGND46+rMO/jpoItKK6gyWoVPMpHTImOruhTgKiq3D9MdRMxw7KZsaNY9vtDgu3MtWReMw==
X-Received: by 2002:a05:6a20:8426:b0:11f:7829:6d6c with SMTP id c38-20020a056a20842600b0011f78296d6cmr28507253pzd.3.1687662910560;
        Sat, 24 Jun 2023 20:15:10 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id r9-20020a62e409000000b0066642f95bc5sm1648412pfh.35.2023.06.24.20.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 20:15:10 -0700 (PDT)
Message-ID: <00641d5b-86a3-f5d1-02ee-13b4f815df75@bytedance.com>
Date:   Sun, 25 Jun 2023 11:15:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 24/29] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     Dave Chinner <david@fromorbit.com>, paulmck@kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        tkhai@ya.ru, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, RCU <rcu@vger.kernel.org>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-25-zhengqi.arch@bytedance.com>
 <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
 <ZJU708VIyJ/3StAX@dread.disaster.area>
 <a21047bb-3b87-a50a-94a7-f3fa4847bc08@bytedance.com>
 <ZJYaYv4pACmCaBoT@dread.disaster.area>
 <a7baf44a-1eb8-d4e1-d112-93cf9cdb7beb@bytedance.com>
In-Reply-To: <a7baf44a-1eb8-d4e1-d112-93cf9cdb7beb@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/6/24 19:08, Qi Zheng wrote:
> Hi Dave,
> 
> On 2023/6/24 06:19, Dave Chinner wrote:
>> On Fri, Jun 23, 2023 at 09:10:57PM +0800, Qi Zheng wrote:
>>> On 2023/6/23 14:29, Dave Chinner wrote:
>>>> On Thu, Jun 22, 2023 at 05:12:02PM +0200, Vlastimil Babka wrote:
>>>>> On 6/22/23 10:53, Qi Zheng wrote:
>>>> Yes, I suggested the IDR route because radix tree lookups under RCU
>>>> with reference counted objects are a known safe pattern that we can
>>>> easily confirm is correct or not.  Hence I suggested the unification
>>>> + IDR route because it makes the life of reviewers so, so much
>>>> easier...
>>>
>>> In fact, I originally planned to try the unification + IDR method you
>>> suggested at the beginning. But in the case of CONFIG_MEMCG disabled,
>>> the struct mem_cgroup is not even defined, and root_mem_cgroup and
>>> shrinker_info will not be allocated.  This required more code 
>>> changes, so
>>> I ended up keeping the shrinker_list and implementing the above pattern.
>>
>> Yes. Go back and read what I originally said needed to be done
>> first. In the case of CONFIG_MEMCG=n, a dummy root memcg still needs
>> to exist that holds all of the global shrinkers. Then shrink_slab()
>> is only ever passed a memcg that should be iterated.
>>
>> Yes, it needs changes external to the shrinker code itself to be
>> made to work. And even if memcg's are not enabled, we can still use
>> the memcg structures to ensure a common abstraction is used for the
>> shrinker tracking infrastructure....
> 
> Yeah, what I imagined before was to define a more concise struct
> mem_cgroup in the case of CONFIG_MEMCG=n, then allocate a dummy root
> memcg on system boot:
> 
> #ifdef !CONFIG_MEMCG
> 
> struct shrinker_info {
>      struct rcu_head rcu;
>      atomic_long_t *nr_deferred;
>      unsigned long *map;
>      int map_nr_max;
> };
> 
> struct mem_cgroup_per_node {
>      struct shrinker_info __rcu    *shrinker_info;
> };
> 
> struct mem_cgroup {
>      struct mem_cgroup_per_node *nodeinfo[];
> };
> 
> #endif
> 
> But I have a concern: if all global shrinkers are tracking with the
> info->map of root memcg, a shrinker->id needs to be assigned to them,
> which will cause info->map_nr_max to become larger than before, then
> making the traversal of info->map slower.

But most of the system is 'sb-xxx' shrinker instances, they all have
the SHRINKER_MEMCG_AWARE flag, so it should have little impact on the
speed of traversing info->map. ;)

> 
>>
>>> If the above pattern is not safe, I will go back to the unification +
>>> IDR method.
>>
>> And that is exactly how we got into this mess in the first place....
> 
> I only found one similar pattern in the kernel:
> 
> fs/smb/server/oplock.c:find_same_lease_key/smb_break_all_levII_oplock/lookup_lease_in_table
> 
> But IIUC, the refcount here needs to be decremented after holding
> rcu lock as I did above.
> 
> So regardless of whether we choose unification + IDR in the end, I still
> want to confirm whether the pattern I implemented above is safe. :)

Also + RCU mailing list.

> 
> Thanks,
> Qi
> 
>>
>> -Dave
