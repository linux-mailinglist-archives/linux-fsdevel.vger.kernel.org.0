Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABC26A70DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCAQ2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 11:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCAQ2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:28:16 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EA5619C;
        Wed,  1 Mar 2023 08:28:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so17869812pjb.3;
        Wed, 01 Mar 2023 08:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7haAdLVLlDeldbPNE93BNwsAAMcDWz2aparhFZ6snc=;
        b=ScpO2xYGcncaAu7MJmZ0jOxZc2MFhctvdoHr8MPqN1YeVqLXaIKJf5687TOMRiLeJF
         ov2n7XuS384LRK55cbIy9sINjo1DFTtCGGIx1jRAczK8s1rL8cNJlKPhRnL+JYlUjsEr
         wI2ajEmTljOZVPblwy7hyMNhD8L4uYLwT1lx4C2AyIfTfVGzvluQ4/XXH1O6JP4L1drU
         nj6B/jiNGF4gmgEoKuYDcq2xGzxbhhsC3BQeSH9999F074yinxk/8R7JtY2h/QA/5l2W
         bCUpFfKHg43g3H7X6dTk0WPmbKmKOxRwjAqtiTkqX066qqDSDiar0f59NDI8buGqoZT7
         VL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7haAdLVLlDeldbPNE93BNwsAAMcDWz2aparhFZ6snc=;
        b=UIU2B0ZAR44MDUIZtrqJefYa2zVysncAsrZ0I7GFT5tPOFlHAeaWJ7Ph2c5UT535f6
         pLBSwQLeHLwfqcnWj/Kt22sPoj8Gx7carQRRgjSmiT7u6bM55ioRnNXyuSqHIE+tsQXw
         2pihMvd8M2xNHA8DLa2LRHNtPHuPFT3syajoohfgghipIqSy0EkPx7oCH0/EON0qWm1o
         WrU929RycJCQX6VClCRdHm6LZcppAz4/Dq3Mc8+gzf/pB9Dlz+ZhZFqI72ZM/rpKjzyf
         1UURrzvwK/K8KljIr79tdTyIKFTVkmbllcm/qTV2Vke8vfBeVKnDicgVQr0VyCuOMpqD
         auvQ==
X-Gm-Message-State: AO0yUKVg6mJ0S95zvwmz7qn/U8h/P2TkzdKbGBIid09JGktFNmcF86Eq
        XmAXhnUeVWaiRt2rkrD0gvQ=
X-Google-Smtp-Source: AK7set+ervFmTCiG6ysVAUSUHqEReNOEh1qF1r4N++pKBJkkynck6Z0EyTk83a923L/HE/nYajTVtg==
X-Received: by 2002:a17:903:247:b0:19c:f1ab:4220 with SMTP id j7-20020a170903024700b0019cf1ab4220mr7245531plh.46.1677688094437;
        Wed, 01 Mar 2023 08:28:14 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902ed0b00b0019602b2c00csm8633420pld.175.2023.03.01.08.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 08:28:13 -0800 (PST)
Date:   Wed, 01 Mar 2023 21:57:58 +0530
Message-Id: <87v8jka12p.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+dd426ae4af71f1e74729@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in evict (3)
In-Reply-To: <20230301000142.GK2825702@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner <david@fromorbit.com> writes:

> [obvious one for the ext4 people]
>
> On Tue, Feb 28, 2023 at 09:25:55AM -0800, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    ae3419fbac84 vc_screen: don't clobber return value in vcs_..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1136fe18c80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff98a3b3c1aed3ab
>> dashboard link: https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+dd426ae4af71f1e74729@syzkaller.appspotmail.com
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.2.0-syzkaller-12913-gae3419fbac84 #0 Not tainted
>> ------------------------------------------------------
>> kswapd0/100 is trying to acquire lock:
>> ffff888047aea650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:665
>>
>> but task is already holding lock:
>> ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
>> ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #3 (fs_reclaim){+.+.}-{0:0}:
>>        __fs_reclaim_acquire mm/page_alloc.c:4716 [inline]
>>        fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4730
>>        might_alloc include/linux/sched/mm.h:271 [inline]
>>        prepare_alloc_pages+0x159/0x570 mm/page_alloc.c:5362
>>        __alloc_pages+0x149/0x5c0 mm/page_alloc.c:5580
>>        alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
>>        __get_free_pages+0xc/0x40 mm/page_alloc.c:5641
>>        kasan_populate_vmalloc_pte mm/kasan/shadow.c:309 [inline]
>>        kasan_populate_vmalloc_pte+0x27/0x150 mm/kasan/shadow.c:300
>>        apply_to_pte_range mm/memory.c:2578 [inline]
>>        apply_to_pmd_range mm/memory.c:2622 [inline]
>>        apply_to_pud_range mm/memory.c:2658 [inline]
>>        apply_to_p4d_range mm/memory.c:2694 [inline]
>>        __apply_to_page_range+0x68c/0x1030 mm/memory.c:2728
>>        alloc_vmap_area+0x536/0x1f20 mm/vmalloc.c:1638
>>        __get_vm_area_node+0x145/0x3f0 mm/vmalloc.c:2495
>>        __vmalloc_node_range+0x250/0x1300 mm/vmalloc.c:3141
>>        kvmalloc_node+0x156/0x1a0 mm/util.c:628
>>        kvmalloc include/linux/slab.h:737 [inline]
>>        ext4_xattr_move_to_block fs/ext4/xattr.c:2570 [inline]
>
> 	buffer = kvmalloc(value_size, GFP_NOFS);
>
> Yeah, this doesn't work like the code says it should. The gfp mask
> is not passed down to the page table population code and it hard
> codes GFP_KERNEL allocations so you have to do:
>
> 	memalloc_nofs_save();
> 	buffer = kvmalloc(value_size, GFP_KERNEL);
> 	memalloc_nofs_restore();
>
> to apply GFP_NOFS to allocations in the pte population code to avoid
> memory reclaim recursion in kvmalloc.

What about this patch mentioned below? Is it the kasan allocations
(kasan_populate_vmalloc()), which hasn't been taken care of in this
patch. Does this means we need kvmalloc fixed instead for kasan allocations?

Though I agree we can have the fix like you mentioned above
(as many of the API users are already doing above). Just wanted to have the
full context of what is going on here.

451769ebb7e792c3404db53b3c2a422990de654e
Author:     Michal Hocko <mhocko@suse.com>

mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc

Patch series "extend vmalloc support for constrained allocations", v2.

Based on a recent discussion with Dave and Neil [1] I have tried to
implement NOFS, NOIO, NOFAIL support for the vmalloc to make life of
kvmalloc users easier.

[1] http://lkml.kernel.org/r/163184741778.29351.16920832234899124642.stgit@noble.brown


Thanks
-ritesh
