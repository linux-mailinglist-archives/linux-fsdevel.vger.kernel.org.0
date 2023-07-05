Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7446747BCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 05:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGED2L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 23:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGED2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 23:28:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329E510D5
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 20:27:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-682a5465e9eso173062b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jul 2023 20:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688527657; x=1691119657;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOwOUvz1NPkWlBxAp0GPGGO2Nrixl73uZn6xROfOEj8=;
        b=ifLsYO8F2I4MBHVlF2Or5hf7tTNep81Mx+BsSk/nCvCzxaPTLrQYJUCegbZ71CLvqI
         jnwmhHljMYjJqvknT1p7Cvh4o3Zetn0nbYVkcxdIejyVlEmEoOc51mjv2rm9Oe7hCkmi
         BhkEzv2gsaM2VKlzfD2ZXlb5JXn4cFBH6rlbCG9Gisi0SSs52NHZD0JL0DYBTusr279z
         ECt8JJbhMcUgBeDhNudIJn3gOdFaKif3GEH22u6ET+bb2NCPdK1crIBUZU+UjNX2cqQu
         Xo1u3OB8WsD6YcqowSF12wIwDOJl+hjeHnPzPy5ZJwY8SE6f5Rm09aAg64VyQm7gLUPN
         jgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688527657; x=1691119657;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOwOUvz1NPkWlBxAp0GPGGO2Nrixl73uZn6xROfOEj8=;
        b=YpxpYL6FI3JoOOfwk0XDOLtKjvgftKHbw/eNQJwk3wu4H5SejsqZ4WmR1o195d+E1p
         sTpxWChVplyl8XLyRA9bksnUlbj7kqYgUqya5stNy02l8Q4m6I1YZbkFquACcHY36E+E
         vzAjQHBqt0YvCX0M1XMsz34tIpCK8QiznQvHnl8ENm3Bu1FVv7sohXL1KjgBrwXnvSrp
         rpBt2q2zOU9ikRqGLjrG1vIj8El2WriicsDvnL9ftgV9q87jrJrmF7jCtpK2cJehLmx/
         D4sm5lh4vWlF2pM0OT5X1/6Ra0PxNw4GSJql5lqKpSb08LoTNtoL/7xivWhMpFNJQ985
         x0XQ==
X-Gm-Message-State: ABy/qLZq0uxvoch74PdiJoKRTTCwMVoG62DKJTJRPzUcFou/6y+l4tUN
        3VPcLk2X7yKJzXscI7XALbFTHg==
X-Google-Smtp-Source: APBJJlHJ/xdp2D4mprG7cOjZwHFFckWD0OnUdfulMpel6EsGVgn6d2uqpP3j7nke+gBKkBfRchiLhg==
X-Received: by 2002:a05:6a00:1f90:b0:675:8627:a291 with SMTP id bg16-20020a056a001f9000b006758627a291mr16245087pfb.3.1688527657628;
        Tue, 04 Jul 2023 20:27:37 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id fe10-20020a056a002f0a00b0064fde7ae1ffsm13136627pfb.38.2023.07.04.20.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 20:27:37 -0700 (PDT)
Message-ID: <733af312-fb2d-3ec4-54c8-f154447c2051@bytedance.com>
Date:   Wed, 5 Jul 2023 11:27:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 24/29] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     paulmck@kernel.org, Dave Chinner <david@fromorbit.com>
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
        linux-btrfs@vger.kernel.org
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-25-zhengqi.arch@bytedance.com>
 <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
 <ZJU708VIyJ/3StAX@dread.disaster.area>
 <cc894c77-717a-4e9f-b649-48bab40e7c60@paulmck-laptop>
 <3efa68e0-b04f-5c11-4fe2-2db0784064fc@bytedance.com>
In-Reply-To: <3efa68e0-b04f-5c11-4fe2-2db0784064fc@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/4 11:45, Qi Zheng wrote:
> 
> 
> On 2023/7/4 00:39, Paul E. McKenney wrote:
>> On Fri, Jun 23, 2023 at 04:29:39PM +1000, Dave Chinner wrote:
>>> On Thu, Jun 22, 2023 at 05:12:02PM +0200, Vlastimil Babka wrote:
>>>> On 6/22/23 10:53, Qi Zheng wrote:
>>>>> @@ -1067,33 +1068,27 @@ static unsigned long shrink_slab(gfp_t 
>>>>> gfp_mask, int nid,
>>>>>       if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>>>>>           return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>>>> -    if (!down_read_trylock(&shrinker_rwsem))
>>>>> -        goto out;
>>>>> -
>>>>> -    list_for_each_entry(shrinker, &shrinker_list, list) {
>>>>> +    rcu_read_lock();
>>>>> +    list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
>>>>>           struct shrink_control sc = {
>>>>>               .gfp_mask = gfp_mask,
>>>>>               .nid = nid,
>>>>>               .memcg = memcg,
>>>>>           };
>>>>> +        if (!shrinker_try_get(shrinker))
>>>>> +            continue;
>>>>> +        rcu_read_unlock();
>>>>
>>>> I don't think you can do this unlock?
>>
>> Sorry to be slow to respond here, this one fell through the cracks.
>> And thank you to Qi for reminding me!
>>
>> If you do this unlock, you had jolly well better nail down the current
>> element (the one referenced by shrinker), for example, by acquiring an
>> explicit reference count on the object.  And presumably this is exactly
>> what shrinker_try_get() is doing.  And a look at your 24/29 confirms 
>> this,
>> at least assuming that shrinker->refcount is set to zero before the call
>> to synchronize_rcu() in free_module() *and* that synchronize_rcu() 
>> doesn't
>> start until *after* shrinker_put() calls complete().  Plus, as always,
>> the object must be removed from the list before the synchronize_rcu()
>> starts.  (On these parts of the puzzle, I defer to those more familiar
>> with this code path.  And I strongly suggest carefully commenting this
>> type of action-at-a-distance design pattern.)
> 
> Yeah, I think I've done it like above. A more detailed timing diagram is
> below.
> 
>>
>> Why is this important?  Because otherwise that object might be freed
>> before you get to the call to rcu_read_lock() at the end of this loop.
>> And if that happens, list_for_each_entry_rcu() will be walking the
>> freelist, which is quite bad for the health and well-being of your 
>> kernel.
>>
>> There are a few other ways to make this sort of thing work:
>>
>> 1.    Defer the shrinker_put() to the beginning of the loop.
>>     You would need a flag initially set to zero, and then set to
>>     one just before (or just after) the rcu_read_lock() above.
>>     You would also need another shrinker_old pointer to track the
>>     old pointer.  Then at the top of the loop, if the flag is set,
>>     invoke shrinker_put() on shrinker_old.    This ensures that the
>>     previous shrinker structure stays around long enough to allow
>>     the loop to find the next shrinker structure in the list.
>>
>>     This approach is attractive when the removal code path
>>     can invoke shrinker_put() after the grace period ends.
>>
>> 2.    Make shrinker_put() invoke call_rcu() when ->refcount reaches
>>     zero, and have the callback function free the object.  This of
>>     course requires adding an rcu_head structure to the shrinker
>>     structure, which might or might not be a reasonable course of
>>     action.  If adding that rcu_head is reasonable, this simplifies
>>     the logic quite a bit.
>>
>> 3.    For the shrinker-structure-removal code path, remove the shrinker
>>     structure, then remove the initial count from ->refcount,
>>     and then keep doing grace periods until ->refcount is zero,
>>     then do one more.  Of course, if the result of removing the
>>     initial count was zero, then only a single additional grace
>>     period is required.
>>
>>     This would need to be carefully commented, as it is a bit
>>     unconventional.
> 
> Thanks for such a detailed addition!
> 
>>
>> There are probably many other ways, but just to give an idea of a few
>> other ways to do this.
>>
>>>>> +
>>>>>           ret = do_shrink_slab(&sc, shrinker, priority);
>>>>>           if (ret == SHRINK_EMPTY)
>>>>>               ret = 0;
>>>>>           freed += ret;
>>>>> -        /*
>>>>> -         * Bail out if someone want to register a new shrinker to
>>>>> -         * prevent the registration from being stalled for long 
>>>>> periods
>>>>> -         * by parallel ongoing shrinking.
>>>>> -         */
>>>>> -        if (rwsem_is_contended(&shrinker_rwsem)) {
>>>>> -            freed = freed ? : 1;
>>>>> -            break;
>>>>> -        }
>>>>> -    }
>>>>> -    up_read(&shrinker_rwsem);
>>>>> -out:
>>>>> +        rcu_read_lock();
>>>>
>>>> That new rcu_read_lock() won't help AFAIK, the whole
>>>> list_for_each_entry_rcu() needs to be under the single 
>>>> rcu_read_lock() to be
>>>> safe.
>>>
>>> Yeah, that's the pattern we've been taught and the one we can look
>>> at and immediately say "this is safe".
>>>
>>> This is a different pattern, as has been explained bi Qi, and I
>>> think it *might* be safe.
>>>
>>> *However.*
>>>
>>> Right now I don't have time to go through a novel RCU list iteration
>>> pattern it one step at to determine the correctness of the
>>> algorithm. I'm mostly worried about list manipulations that can
>>> occur outside rcu_read_lock() section bleeding into the RCU
>>> critical section because rcu_read_lock() by itself is not a memory
>>> barrier.
>>>
>>> Maybe Paul has seen this pattern often enough he could simply tell
>>> us what conditions it is safe in. But for me to work that out from
>>> first principles? I just don't have the time to do that right now.
>>
>> If the code does just the right sequence of things on the removal path
>> (remove, decrement reference, wait for reference to go to zero, wait for
>> grace period, free), then it would work.  If this is what is happening,
>> I would argue for more comments.  ;-)
> 
> The order of the removal path is slightly different from this:
> 
>      shrink_slab                 unregister_shrinker
>      ===========                 ===================
> 
>     shrinker_try_get()
>     rcu_read_unlock()
>                                  1. decrement initial reference
>                  shrinker_put()
>                  2. wait for reference to go to zero
>                  wait_for_completion()
>     rcu_read_lock()
> 
>     shrinker_put()
>                  3. remove the shrinker from list
>                  list_del_rcu()
>                                  4. wait for grace period
>                  kfree_rcu()/synchronize_rcu()
> 
> 
>     list_for_each_entry()
> 
>     shrinker_try_get()
>     rcu_read_unlock()
>                  5. free the shrinker
> 
> So the order is: decrement reference, wait for reference to go to zero,
> remove, wait for grace period, free.
> 
> I think this can work. And we can only do the *step 3* after we hold the
> RCU read lock again, right? Please let me know if I missed something.

Oh, you are right, It would be better to move step 3 to step 1. We
should first remove the shrinker from the shrinker_list to prevent
other traversers from finding it again, otherwise the following
situations may occur theoretically:

CPU 0                 CPU 1

shrinker_try_get()

                       shrinker_try_get()

shrinker_put()
shrinker_try_get()
                       shrinker_put()

Thanks,
Qi

> 
> Thanks,
> Qi
> 
>>
>>                             Thanx, Paul
>>
>>>> IIUC this is why Dave in [4] suggests unifying shrink_slab() with
>>>> shrink_slab_memcg(), as the latter doesn't iterate the list but uses 
>>>> IDR.
>>>
>>> Yes, I suggested the IDR route because radix tree lookups under RCU
>>> with reference counted objects are a known safe pattern that we can
>>> easily confirm is correct or not.  Hence I suggested the unification
>>> + IDR route because it makes the life of reviewers so, so much
>>> easier...
>>>
>>> Cheers,
>>>
>>> Dave.
>>> -- 
>>> Dave Chinner
>>> david@fromorbit.com
