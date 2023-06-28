Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5751D7419EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 22:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjF1UyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjF1UyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:54:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46B42961
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 13:54:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-676cc97ca74so36169b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687985648; x=1690577648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhRG05GlU4RJJ7xv+jzoKr3i+fIGPg8MRBPy8snbcU8=;
        b=Ep3L5wmiVI27ZoKOZNB/CNRyrmDlSSs1LUNZC4Et7lDD5kIZblfuAXFMZvcfQvO8m4
         py5D82d/6MF6895JhO6m/4N2xRYFz/KbJJsO2pSr4vQShVqe+MVCbCBfyiunK2BYgMKr
         4fT6cWEh5SnCaL4ngLmOPw3irrgz+V33DbCXR4pCI4Dfq2uzdI7UVXCpydoe7SI11cLH
         IvlK+G//vTF6edTpEN5ANT5s4CqJo87H1yrE4LHrXi8MmJBW+v99ds9JbAbytwP0mSCB
         xFd9xB8rMEhpYLdfYCCeDyviTa4a+YwfgPBtUBiFFYGz59jaXq7yAPLdNlaAUzY10tpS
         WcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985648; x=1690577648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhRG05GlU4RJJ7xv+jzoKr3i+fIGPg8MRBPy8snbcU8=;
        b=VNXsIaNBzftBEcGVJNntVysc5+gRFTBwiCvfIfJr9dzO90kuMY6Za8F3S2UTatXo7f
         eY++Jn4T+W4Tr481SWh7jWf/PZ1rRypq/KK7pj4VzEnf1J/b9ZceMwc8ngA4kAg3G8Mt
         mL3EampEl+KTSv1mdl68VASg9HTM3AEEYll/x1MrL5NqblvuV1HWZP3Jky8F7/oPUdd4
         y6RYfb8FAzBka/bXKzZry2vEVIRv7wF8gvUCeljiOAIeRjDdZK7CNLvo/mZbj6tGhhdf
         LaW5dIMHt1hajzFkBrXfvgyLWE33QR2QEqZJwAvm7y4d3KCjlAi5lJsOJpJydSZlAwYF
         lJaQ==
X-Gm-Message-State: AC+VfDx9UpjWHjuXH7oZ2X/v65iGBu+NLBpNijHtLw5KNnFCOX55LfKE
        Pv6RAo3WRIIZr735CD8jpxHgxg==
X-Google-Smtp-Source: ACHHUZ4ogsVS0lX3nCPBIG5bc6Q95Br2cbk12Jk/ulWzavPWNHR06zRL4hyqFaBkj7P63x6gP3A8Yw==
X-Received: by 2002:a05:6a20:8f04:b0:121:b5af:acbc with SMTP id b4-20020a056a208f0400b00121b5afacbcmr38240738pzk.3.1687985648291;
        Wed, 28 Jun 2023 13:54:08 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j5-20020a62b605000000b00640f51801e6sm7375748pff.159.2023.06.28.13.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 13:54:07 -0700 (PDT)
Message-ID: <4d3efe17-e114-96c1-dca8-a100cc6f7fc6@kernel.dk>
Date:   Wed, 28 Jun 2023 14:54:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <20230628175421.funhhfbx5kdvhclx@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230628175421.funhhfbx5kdvhclx@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 11:54?AM, Kent Overstreet wrote:
> On Wed, Jun 28, 2023 at 08:58:45AM -0600, Jens Axboe wrote:
>> On 6/27/23 10:01?PM, Kent Overstreet wrote:
>>> On Tue, Jun 27, 2023 at 09:16:31PM -0600, Jens Axboe wrote:
>>>> On 6/27/23 2:15?PM, Kent Overstreet wrote:
>>>>>> to ktest/tests/xfstests/ and run it with -bcachefs, otherwise it kept
>>>>>> failing because it assumed it was XFS.
>>>>>>
>>>>>> I suspected this was just a timing issue, and it looks like that's
>>>>>> exactly what it is. Looking at the test case, it'll randomly kill -9
>>>>>> fsstress, and if that happens while we have io_uring IO pending, then we
>>>>>> process completions inline (for a PF_EXITING current). This means they
>>>>>> get pushed to fallback work, which runs out of line. If we hit that case
>>>>>> AND the timing is such that it hasn't been processed yet, we'll still be
>>>>>> holding a file reference under the mount point and umount will -EBUSY
>>>>>> fail.
>>>>>>
>>>>>> As far as I can tell, this can happen with aio as well, it's just harder
>>>>>> to hit. If the fput happens while the task is exiting, then fput will
>>>>>> end up being delayed through a workqueue as well. The test case assumes
>>>>>> that once it's reaped the exit of the killed task that all files are
>>>>>> released, which isn't necessarily true if they are done out-of-line.
>>>>>
>>>>> Yeah, I traced it through to the delayed fput code as well.
>>>>>
>>>>> I'm not sure delayed fput is responsible here; what I learned when I was
>>>>> tracking this down has mostly fell out of my brain, so take anything I
>>>>> say with a large grain of salt. But I believe I tested with delayed_fput
>>>>> completely disabled, and found another thing in io_uring with the same
>>>>> effect as delayed_fput that wasn't being flushed.
>>>>
>>>> I'm not saying it's delayed_fput(), I'm saying it's the delayed putting
>>>> io_uring can end up doing. But yes, delayed_fput() is another candidate.
>>>
>>> Sorry - was just working through my recollections/initial thought
>>> process out loud
>>
>> No worries, it might actually be a combination and this is why my
>> io_uring side patch didn't fully resolve it. Wrote a simple reproducer
>> and it seems to reliably trigger it, but is fixed with an flush of the
>> delayed fput list on mount -EBUSY return. Still digging...
>>
>>>>>> For io_uring specifically, it may make sense to wait on the fallback
>>>>>> work. The below patch does this, and should fix the issue. But I'm not
>>>>>> fully convinced that this is really needed, as I do think this can
>>>>>> happen without io_uring as well. It just doesn't right now as the test
>>>>>> does buffered IO, and aio will be fully sync with buffered IO. That
>>>>>> means there's either no gap where aio will hit it without O_DIRECT, or
>>>>>> it's just small enough that it hasn't been hit.
>>>>>
>>>>> I just tried your patch and I still have generic/388 failing - it
>>>>> might've taken a bit longer to pop this time.
>>>>
>>>> Yep see the same here. Didn't have time to look into it after sending
>>>> that email today, just took a quick stab at writing a reproducer and
>>>> ended up crashing bcachefs:
>>>
>>> You must have hit an error before we finished initializing the
>>> filesystem, the list head never got initialized. Patch for that will be
>>> in the testing branch momentarily.
>>
>> I'll pull that in. In testing just now, I hit a few more leaks:
>>
>> unreferenced object 0xffff0000e55cf200 (size 128):
>>   comm "mount", pid 723, jiffies 4294899134 (age 85.868s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<000000001d69062c>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>>     [<00000000c503def2>] __kmem_cache_alloc_node+0xd0/0x178
>>     [<00000000cde48528>] __kmalloc+0xac/0xd4
>>     [<000000006cb9446a>] kmalloc_array.constprop.0+0x18/0x20
>>     [<000000008341b32c>] bch2_fs_alloc+0x73c/0xbcc
> 
> Can you faddr2line this? I just did a bunch of kmemleak testing and
> didn't see it.

0xffff800008589a20 is in bch2_fs_alloc (fs/bcachefs/super.c:813).
808		    !(c->online_reserved = alloc_percpu(u64)) ||
809		    !(c->btree_paths_bufs = alloc_percpu(struct btree_path_buf)) ||
810		    mempool_init_kvpmalloc_pool(&c->btree_bounce_pool, 1,
811						btree_bytes(c)) ||
812		    mempool_init_kmalloc_pool(&c->large_bkey_pool, 1, 2048) ||
813		    !(c->unused_inode_hints = kcalloc(1U << c->inode_shard_bits,
814						      sizeof(u64), GFP_KERNEL))) {
815			ret = -BCH_ERR_ENOMEM_fs_other_alloc;
816			goto err;
817		}

-- 
Jens Axboe

