Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD30323372E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgG3QwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 12:52:22 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:36652 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbgG3QwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:52:20 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2020 12:52:19 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 9D5093FC07;
        Thu, 30 Jul 2020 18:45:18 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Ban6eCam;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.911
X-Spam-Level: 
X-Spam-Status: No, score=-2.911 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.812,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FGIani5JgmKM; Thu, 30 Jul 2020 18:45:17 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 22D5D3FBCF;
        Thu, 30 Jul 2020 18:45:14 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 68E9E361FE2;
        Thu, 30 Jul 2020 18:45:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1596127516; bh=WmoqVD5xMx2mKhiXkA7Wx6HNNvArGiPu3cb42J8Eqq8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ban6eCam79LaP2aso+KqRtn4VGxizeZQ3uHVvcID5i+rm+f7F9Yk/y4F1LRpx7kM4
         7+UvyzkUHOyPhdiSOiHvQteBECLWcX8gITVwl8MQG3RSVLKJZ8EZjCZK5d63q9vEYr
         4f/39kCtOd/IbfmxfAV+kxoiRaUob9Nuv5nZKE4E=
Subject: Re: [PATCH] dma-resv: lockdep-prime address_space->i_mmap_rwsem for
 dma-resv
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Dave Chinner <david@fromorbit.com>, Qian Cai <cai@lca.pw>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20200728135839.1035515-1-daniel.vetter@ffwll.ch>
 <38cbc4fb-3a88-47c4-2d6c-4d90f9be42e7@shipmail.org>
 <CAKMK7uFe-70DE5qOBJ6FwD8d_A0yZt+h5bCqA=e9QtYE1qwASQ@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <60f2b14f-8cef-f515-9cf5-bdbc02d9c63c@shipmail.org>
Date:   Thu, 30 Jul 2020 18:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFe-70DE5qOBJ6FwD8d_A0yZt+h5bCqA=e9QtYE1qwASQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/30/20 3:17 PM, Daniel Vetter wrote:
> On Thu, Jul 30, 2020 at 2:17 PM Thomas Hellström (Intel)
> <thomas_os@shipmail.org> wrote:
>>
>> On 7/28/20 3:58 PM, Daniel Vetter wrote:
>>> GPU drivers need this in their shrinkers, to be able to throw out
>>> mmap'ed buffers. Note that we also need dma_resv_lock in shrinkers,
>>> but that loop is resolved by trylocking in shrinkers.
>>>
>>> So full hierarchy is now (ignore some of the other branches we already
>>> have primed):
>>>
>>> mmap_read_lock -> dma_resv -> shrinkers -> i_mmap_lock_write
>>>
>>> I hope that's not inconsistent with anything mm or fs does, adding
>>> relevant people.
>>>
>> Looks OK to me. The mapping_dirty_helpers run under the i_mmap_lock, but
>> don't allocate any memory AFAICT.
>>
>> Since huge page-table-entry splitting may happen under the i_mmap_lock
>> from unmap_mapping_range() it might be worth figuring out how new page
>> directory pages are allocated, though.
> ofc I'm not an mm expert at all, but I did try to scroll through all
> i_mmap_lock_write/read callers. Found the following:
>
> - kernel/events/uprobes.c in build_map_info:
>
>              /*
>               * Needs GFP_NOWAIT to avoid i_mmap_rwsem recursion through
>               * reclaim. This is optimistic, no harm done if it fails.
>               */
>
> - I got lost in the hugetlb.c code and couldn't convince myself it's
> not allocating page directories at various levels with something else
> than GFP_KERNEL.
>
> So looks like the recursion is clearly there and known, but the
> hugepage code is too complex and flying over my head.
> -Daniel

OK, so I inverted your annotation and ran a memory hog, and got the 
below splat. So clearly your proposed reclaim->i_mmap_lock locking order 
is an already established one.

So

Reviewed-by: Thomas Hellström <thomas.hellstrom@intel.com>

8<---------------------------------------------------------------------------------------------

[  308.324654] WARNING: possible circular locking dependency detected
[  308.324655] 5.8.0-rc2+ #16 Not tainted
[  308.324656] ------------------------------------------------------
[  308.324657] kswapd0/98 is trying to acquire lock:
[  308.324658] ffff92a16f758428 (&mapping->i_mmap_rwsem){++++}-{3:3}, 
at: rmap_walk_file+0x1c0/0x2f0
[  308.324663]
                but task is already holding lock:
[  308.324664] ffffffffb0960240 (fs_reclaim){+.+.}-{0:0}, at: 
__fs_reclaim_acquire+0x5/0x30
[  308.324666]
                which lock already depends on the new lock.

[  308.324667]
                the existing dependency chain (in reverse order) is:
[  308.324667]
                -> #1 (fs_reclaim){+.+.}-{0:0}:
[  308.324670]        fs_reclaim_acquire+0x34/0x40
[  308.324672]        dma_resv_lockdep+0x186/0x224
[  308.324675]        do_one_initcall+0x5d/0x2c0
[  308.324676]        kernel_init_freeable+0x222/0x288
[  308.324678]        kernel_init+0xa/0x107
[  308.324679]        ret_from_fork+0x1f/0x30
[  308.324680]
                -> #0 (&mapping->i_mmap_rwsem){++++}-{3:3}:
[  308.324682]        __lock_acquire+0x119f/0x1fc0
[  308.324683]        lock_acquire+0xa4/0x3b0
[  308.324685]        down_read+0x2d/0x110
[  308.324686]        rmap_walk_file+0x1c0/0x2f0
[  308.324687]        page_referenced+0x133/0x150
[  308.324689]        shrink_active_list+0x142/0x610
[  308.324690]        balance_pgdat+0x229/0x620
[  308.324691]        kswapd+0x200/0x470
[  308.324693]        kthread+0x11f/0x140
[  308.324694]        ret_from_fork+0x1f/0x30
[  308.324694]
                other info that might help us debug this:

[  308.324695]  Possible unsafe locking scenario:

[  308.324695]        CPU0                    CPU1
[  308.324696]        ----                    ----
[  308.324696]   lock(fs_reclaim);
[  308.324697] lock(&mapping->i_mmap_rwsem);
[  308.324698]                                lock(fs_reclaim);
[  308.324699]   lock(&mapping->i_mmap_rwsem);
[  308.324699]
                 *** DEADLOCK ***

[  308.324700] 1 lock held by kswapd0/98:
[  308.324701]  #0: ffffffffb0960240 (fs_reclaim){+.+.}-{0:0}, at: 
__fs_reclaim_acquire+0x5/0x30
[  308.324702]
                stack backtrace:
[  308.324704] CPU: 1 PID: 98 Comm: kswapd0 Not tainted 5.8.0-rc2+ #16
[  308.324705] Hardware name: VMware, Inc. VMware Virtual Platform/440BX 
Desktop Reference Platform, BIOS 6.00 07/29/2019
[  308.324706] Call Trace:
[  308.324710]  dump_stack+0x92/0xc8
[  308.324711]  check_noncircular+0x12d/0x150
[  308.324713]  __lock_acquire+0x119f/0x1fc0
[  308.324715]  lock_acquire+0xa4/0x3b0
[  308.324716]  ? rmap_walk_file+0x1c0/0x2f0
[  308.324717]  ? __lock_acquire+0x394/0x1fc0
[  308.324719]  down_read+0x2d/0x110
[  308.324720]  ? rmap_walk_file+0x1c0/0x2f0
[  308.324721]  rmap_walk_file+0x1c0/0x2f0
[  308.324722]  page_referenced+0x133/0x150
[  308.324724]  ? __page_set_anon_rmap+0x70/0x70
[  308.324725]  ? page_get_anon_vma+0x190/0x190
[  308.324726]  shrink_active_list+0x142/0x610
[  308.324728]  balance_pgdat+0x229/0x620
[  308.324730]  kswapd+0x200/0x470
[  308.324731]  ? lockdep_hardirqs_on_prepare+0xf5/0x170
[  308.324733]  ? finish_wait+0x80/0x80
[  308.324734]  ? balance_pgdat+0x620/0x620
[  308.324736]  kthread+0x11f/0x140
[  308.324737]  ? kthread_create_worker_on_cpu+0x40/0x40
[  308.324739]  ret_from_fork+0x1f/0x30



>> /Thomas
>>
>>
>>
>
