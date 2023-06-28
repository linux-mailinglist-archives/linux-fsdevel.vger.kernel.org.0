Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5FE741467
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjF1O6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 10:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF1O6t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:58:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A569198D
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 07:58:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7835bbeb6a0so41239f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687964327; x=1690556327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVLNXNflhPvOjKnlG9FYM+xBF+ayKh5uOsxIYUZEgxY=;
        b=lmWDep4/foHHuWOg+T+C38eGEwSCW87j75nSrsXSSgyGwiEzo78rycisK0RhcTYjHz
         A5DgDN5dHMJNRlIHjYgjHpR4t+Ln7bPZRUDlGgSDh0oT468QnJ9gfgSszo1qIyosTHsL
         uO7UCLYbEuqYzAsnA1nJGM4a063BFGexhk7R969Odwaimt8kaGTVxkP1aMPfGmhzsQH8
         Zryau8Z8S5kQeDfTidchYIDTi2en4/GCNYqs0GJVGvoF2mMU+E9vRZ0g9OnhGuGm6QYQ
         c/9srChW0qiRZcxXxPunrHjQX1P4yCdAQaeOmoEdbRWyFtY/QMgCvoYf3qCmxGh8TJsD
         sJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964327; x=1690556327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVLNXNflhPvOjKnlG9FYM+xBF+ayKh5uOsxIYUZEgxY=;
        b=bNTpkrU5iSW1H+54fkTaWStR+PkcK+IeGHPNLXvf7vEeM5iYfKuuAvqygd11+nbIn5
         DQKC6N9u2MBUPNyW2PSnEy+li8WNtFrSM+wMILksH+EemStOcDJ1SezO+dnjJsxbzh5x
         To1d5GqesYbklHDla7puQATyG8wdE703ljzp/ZhCDlHm2k09smjG9JLA9UusceQccT7C
         Q/c1oIHp8yHghDlRtrSWGCIvmYcrIpLwR6li82lmTGZFpHCUPwMgDwDyns06LjpGnSmg
         6r8+osyv4qrX0MbTxg0IBnctgS3gBb4a1xCeGsKRL/NdBvLzd6JuTiI3h7uC0CopyjDY
         5mAg==
X-Gm-Message-State: AC+VfDwGZO/YKrWqwSsroopiltqR2NdCMIo/JBBzwO7+ep36SJ9km51g
        P8J3B1QkP81KvbaZ3QgUzqH5DQ==
X-Google-Smtp-Source: ACHHUZ6yXxz0aKi0MBzP3P/ZuTOUmKacdIASSEIpMs068KoO+HZtRsH+uymQF08FOr0i66Z4zDgJXQ==
X-Received: by 2002:a05:6602:1648:b0:780:c6bb:ad8d with SMTP id y8-20020a056602164800b00780c6bbad8dmr165235iow.0.1687964327301;
        Wed, 28 Jun 2023 07:58:47 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x5-20020a6bda05000000b0077e2637f897sm3606771iob.13.2023.06.28.07.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 07:58:46 -0700 (PDT)
Message-ID: <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
Date:   Wed, 28 Jun 2023 08:58:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/27/23 10:01?PM, Kent Overstreet wrote:
> On Tue, Jun 27, 2023 at 09:16:31PM -0600, Jens Axboe wrote:
>> On 6/27/23 2:15?PM, Kent Overstreet wrote:
>>>> to ktest/tests/xfstests/ and run it with -bcachefs, otherwise it kept
>>>> failing because it assumed it was XFS.
>>>>
>>>> I suspected this was just a timing issue, and it looks like that's
>>>> exactly what it is. Looking at the test case, it'll randomly kill -9
>>>> fsstress, and if that happens while we have io_uring IO pending, then we
>>>> process completions inline (for a PF_EXITING current). This means they
>>>> get pushed to fallback work, which runs out of line. If we hit that case
>>>> AND the timing is such that it hasn't been processed yet, we'll still be
>>>> holding a file reference under the mount point and umount will -EBUSY
>>>> fail.
>>>>
>>>> As far as I can tell, this can happen with aio as well, it's just harder
>>>> to hit. If the fput happens while the task is exiting, then fput will
>>>> end up being delayed through a workqueue as well. The test case assumes
>>>> that once it's reaped the exit of the killed task that all files are
>>>> released, which isn't necessarily true if they are done out-of-line.
>>>
>>> Yeah, I traced it through to the delayed fput code as well.
>>>
>>> I'm not sure delayed fput is responsible here; what I learned when I was
>>> tracking this down has mostly fell out of my brain, so take anything I
>>> say with a large grain of salt. But I believe I tested with delayed_fput
>>> completely disabled, and found another thing in io_uring with the same
>>> effect as delayed_fput that wasn't being flushed.
>>
>> I'm not saying it's delayed_fput(), I'm saying it's the delayed putting
>> io_uring can end up doing. But yes, delayed_fput() is another candidate.
> 
> Sorry - was just working through my recollections/initial thought
> process out loud

No worries, it might actually be a combination and this is why my
io_uring side patch didn't fully resolve it. Wrote a simple reproducer
and it seems to reliably trigger it, but is fixed with an flush of the
delayed fput list on mount -EBUSY return. Still digging...

>>>> For io_uring specifically, it may make sense to wait on the fallback
>>>> work. The below patch does this, and should fix the issue. But I'm not
>>>> fully convinced that this is really needed, as I do think this can
>>>> happen without io_uring as well. It just doesn't right now as the test
>>>> does buffered IO, and aio will be fully sync with buffered IO. That
>>>> means there's either no gap where aio will hit it without O_DIRECT, or
>>>> it's just small enough that it hasn't been hit.
>>>
>>> I just tried your patch and I still have generic/388 failing - it
>>> might've taken a bit longer to pop this time.
>>
>> Yep see the same here. Didn't have time to look into it after sending
>> that email today, just took a quick stab at writing a reproducer and
>> ended up crashing bcachefs:
> 
> You must have hit an error before we finished initializing the
> filesystem, the list head never got initialized. Patch for that will be
> in the testing branch momentarily.

I'll pull that in. In testing just now, I hit a few more leaks:

unreferenced object 0xffff0000e55cf200 (size 128):
  comm "mount", pid 723, jiffies 4294899134 (age 85.868s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000001d69062c>] slab_post_alloc_hook.isra.0+0xb4/0xbc
    [<00000000c503def2>] __kmem_cache_alloc_node+0xd0/0x178
    [<00000000cde48528>] __kmalloc+0xac/0xd4
    [<000000006cb9446a>] kmalloc_array.constprop.0+0x18/0x20
    [<000000008341b32c>] bch2_fs_alloc+0x73c/0xbcc
    [<000000003b8339fd>] bch2_fs_open+0x19c/0x430
    [<00000000aef40a23>] bch2_mount+0x194/0x45c
    [<0000000005e49357>] legacy_get_tree+0x2c/0x54
    [<00000000f5813622>] vfs_get_tree+0x28/0xd4
    [<00000000ea6972ec>] path_mount+0x5d0/0x6c8
    [<00000000468ec307>] do_mount+0x80/0xa4
    [<00000000ea5d305d>] __arm64_sys_mount+0x150/0x168
    [<00000000da6d98cb>] invoke_syscall.constprop.0+0x70/0xb8
    [<000000008f20c487>] do_el0_svc+0xbc/0xf0
    [<00000000a1018c2c>] el0_svc+0x74/0x9c
    [<00000000fc46d579>] el0t_64_sync_handler+0xa8/0x134
unreferenced object 0xffff0000e55cf580 (size 128):
  comm "mount", pid 723, jiffies 4294899134 (age 85.868s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000001d69062c>] slab_post_alloc_hook.isra.0+0xb4/0xbc
    [<00000000c503def2>] __kmem_cache_alloc_node+0xd0/0x178
    [<00000000cde48528>] __kmalloc+0xac/0xd4
    [<0000000097f806f1>] __prealloc_shrinker+0x3c/0x60
    [<000000008ff20762>] register_shrinker+0x14/0x34
    [<000000007fa7e36c>] bch2_fs_btree_cache_init+0xf8/0x150
    [<000000005135a635>] bch2_fs_alloc+0x7ac/0xbcc
    [<000000003b8339fd>] bch2_fs_open+0x19c/0x430
    [<00000000aef40a23>] bch2_mount+0x194/0x45c
    [<0000000005e49357>] legacy_get_tree+0x2c/0x54
    [<00000000f5813622>] vfs_get_tree+0x28/0xd4
    [<00000000ea6972ec>] path_mount+0x5d0/0x6c8
    [<00000000468ec307>] do_mount+0x80/0xa4
    [<00000000ea5d305d>] __arm64_sys_mount+0x150/0x168
    [<00000000da6d98cb>] invoke_syscall.constprop.0+0x70/0xb8
    [<000000008f20c487>] do_el0_svc+0xbc/0xf0
unreferenced object 0xffff0000e55cf480 (size 128):
  comm "mount", pid 723, jiffies 4294899134 (age 85.868s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000001d69062c>] slab_post_alloc_hook.isra.0+0xb4/0xbc
    [<00000000c503def2>] __kmem_cache_alloc_node+0xd0/0x178
    [<00000000cde48528>] __kmalloc+0xac/0xd4
    [<0000000097f806f1>] __prealloc_shrinker+0x3c/0x60
    [<000000008ff20762>] register_shrinker+0x14/0x34
    [<000000003d050c32>] bch2_fs_btree_key_cache_init+0x88/0x90
    [<00000000d9f351c0>] bch2_fs_alloc+0x7c0/0xbcc
    [<000000003b8339fd>] bch2_fs_open+0x19c/0x430
    [<00000000aef40a23>] bch2_mount+0x194/0x45c
    [<0000000005e49357>] legacy_get_tree+0x2c/0x54
    [<00000000f5813622>] vfs_get_tree+0x28/0xd4
    [<00000000ea6972ec>] path_mount+0x5d0/0x6c8
    [<00000000468ec307>] do_mount+0x80/0xa4
    [<00000000ea5d305d>] __arm64_sys_mount+0x150/0x168
    [<00000000da6d98cb>] invoke_syscall.constprop.0+0x70/0xb8
    [<000000008f20c487>] do_el0_svc+0xbc/0xf0

>>> I wonder if there might be a better way of solving this though? For aio,
>>> when a process is exiting we just synchronously tear down the ioctx,
>>> including waiting for outstanding iocbs.
>>
>> aio is pretty trivial, because the only async it supports is O_DIRECT
>> on regular files which always completes in finite time. io_uring has to
>> cancel etc, so we need to do a lot more.
> 
> ahh yes, buffered IO would complicate things
> 
>> But the concept of my patch should be fine, but I think we must be
>> missing a case. Which is why I started writing a small reproducer
>> instead. I'll pick it up again tomorrow and see what is going on here.
> 
> Ok. Soon as you've got a patch I'll throw it at my CI, or I can point my
> CI at your branch if you have one.

I should have something later today, don't feel like I fully understand
all of it just yet.

-- 
Jens Axboe

