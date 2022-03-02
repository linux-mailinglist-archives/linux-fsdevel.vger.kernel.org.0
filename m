Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C844C9C8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 05:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiCBEh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 23:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbiCBEhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:37:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF2B1505;
        Tue,  1 Mar 2022 20:36:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cx5so741682pjb.1;
        Tue, 01 Mar 2022 20:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MBVo9IRYLnSmK+Iblovy/91BgmAKItz9I6FLFTlFR3s=;
        b=T//+HXoYGd5SHPocyGvn9oA/pAEpUTqo7VlemzCNSnoWetOclTaUlsngUr61rJ2G7d
         /OuYdIkBAbhPNZLQ8wQPnkInTVh38Ls8Rzivo8yG2dQ2j9SM2OZ3w9GtYX9NIP0bn7qt
         ixgty95hTGX0OrChZK/S92t+Bcms70WrQyPTgVZFZ3sWZY86tFv81p5QBEU2mlxZXa0u
         cIhEwZZj/IzXI+87zZ1uhC/oybTy9MQeQzGsbMTcDg8dSBxpq2NksYNgmteUSYNlKRN7
         539yOcybtHC/3YIgG7eUsG0vZwu4Lt8TlSRDiy7O5X0swF7n8vHg+Fj1uTgSGt2x67wP
         3kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MBVo9IRYLnSmK+Iblovy/91BgmAKItz9I6FLFTlFR3s=;
        b=Z4XWm97082sNfBeHGt3umzDiJEpXLsQd3CbLGo6PknTPByBRUx8TUmdXREAoMJiVUF
         HpXAbZikZ+PL+HljXQvy0lLwXu1LzC12KHamGKlABSwKNL1V6tmi3s39k+qzD+Ue33Cf
         Yo9exQS0tARddWU0nSfAe6P3m5x4/QOTsKBEF43ZknTUSeuuPDoL9y1GnTno6qW4XDbO
         uDuICEfXt+sudOHJRdmotc4HIHz+DemREjjeKfgV3IBTU0U7bHvAkStdF8uCwE0scX5S
         3vRvOqNLed4rrL62RdJpySvAHgPB0rPqgPfDf3ph+jykUK5NTdIo71u+XtUorVLcJInN
         2+xg==
X-Gm-Message-State: AOAM5310m0tMkUOBs23bZuz6zz/9ugycMjg5ZMWFKJ34qv1ny7GEhizy
        dnSr6opfp0hP9pqC6PKiMT0=
X-Google-Smtp-Source: ABdhPJwygkn6Gdjs/f03dTlM2nX3YEUOPKNAYUBPru3oLaGjP5FMk3G9LtrCdVN4wOIv/sEOkyecIg==
X-Received: by 2002:a17:902:7d83:b0:14e:f2f4:743 with SMTP id a3-20020a1709027d8300b0014ef2f40743mr28814797plm.107.1646195810769;
        Tue, 01 Mar 2022 20:36:50 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id q31-20020a17090a17a200b001bef4ea0377sm721157pja.10.2022.03.01.20.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 20:36:50 -0800 (PST)
Date:   Wed, 2 Mar 2022 04:36:38 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jack@suse.com,
        jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        djwong@kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com
Subject: Re: [PATCH v3 00/21] DEPT(Dependency Tracker)
Message-ID: <Yh70VkRkUfwIjPWv@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <1646042220-28952-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646042220-28952-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 06:56:39PM +0900, Byungchul Park wrote:
> I didn't want to bother you so I was planning to send the next spin
> after making more progress. However, PATCH v2 reports too many false
> positives because Dept tracked the bit_wait_table[] wrong way - I
> apologize for that. So I decided to send PATCH v3 first before going
> further for those who want to run Dept for now.
> 
> There might still be some false positives but not overwhelming.
>

Hello Byungchul, I'm running DEPT v3 on my system
and I see report below.

Looking at the kmemleak code and comment, I think
kmemleak tried to avoid lockdep recursive warning
but detected by DEPT?

===================================================
DEPT: Circular dependency has been detected.
5.17.0-rc1+ #1 Tainted: G        W
---------------------------------------------------
summary
---------------------------------------------------
*** AA DEADLOCK ***

context A
    [S] __raw_spin_lock_irqsave(&object->lock:0)
    [W] _raw_spin_lock_nested(&object->lock:0)
    [E] spin_unlock(&object->lock:0)

[S]: start of the event context
[W]: the wait blocked
[E]: the event not reachable
---------------------------------------------------
context A's detail
---------------------------------------------------
context A
    [S] __raw_spin_lock_irqsave(&object->lock:0)
    [W] _raw_spin_lock_nested(&object->lock:0)
    [E] spin_unlock(&object->lock:0)

[S] __raw_spin_lock_irqsave(&object->lock:0):
[<ffffffc00810302c>] scan_gray_list+0x84/0x13c
stacktrace:
      dept_ecxt_enter+0x88/0xf4
      _raw_spin_lock_irqsave+0xf0/0x1c4
      scan_gray_list+0x84/0x13c
      kmemleak_scan+0x2d8/0x54c
      kmemleak_scan_thread+0xac/0xd4
      kthread+0xd4/0xe4
      ret_from_fork+0x10/0x20

[E] spin_unlock(&object->lock:0):
[<ffffffc008102ee0>] scan_block+0x60/0x128
---------------------------------------------------
information that might be helpful
---------------------------------------------------
CPU: 1 PID: 38 Comm: kmemleak Tainted: G        W         5.17.0-rc1+ #1
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.part.0+0x9c/0xc4
 show_stack+0x14/0x28
 dump_stack_lvl+0x9c/0xcc
 dump_stack+0x14/0x2c
 print_circle+0x2d4/0x438
 cb_check_dl+0x44/0x70
 bfs+0x60/0x168
 add_dep+0x88/0x11c
 add_wait+0x2d0/0x2dc
 __dept_wait+0x8c/0xa4
 dept_wait+0x6c/0x88
 _raw_spin_lock_nested+0xa8/0x1b0
 scan_block+0xb4/0x128
 scan_gray_list+0xc4/0x13c
 kmemleak_scan+0x2d8/0x54c
 kmemleak_scan_thread+0xac/0xd4
 kthread+0xd4/0xe4
 ret_from_fork+0x10/0x20

> ---
> 
> Hi Linus and folks,
> 
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock(?) acquisition order to try to
> cover all synchonization machanisms. It's done on v5.17-rc1 tag.
> 
> https://github.com/lgebyungchulpark/linux-dept/commits/dept1.14_on_v5.17-rc1
>
[...]
> Benifit:
> 
> 	0. Works with all lock primitives.
> 	1. Works with wait_for_completion()/complete().
> 	2. Works with 'wait' on PG_locked.
> 	3. Works with 'wait' on PG_writeback.
> 	4. Works with swait/wakeup.
> 	5. Works with waitqueue.
> 	6. Multiple reports are allowed.
> 	7. Deduplication control on multiple reports.
> 	8. Withstand false positives thanks to 6.
> 	9. Easy to tag any wait/event.
> 
> Future work:
> 
> 	0. To make it more stable.
> 	1. To separates Dept from Lockdep.
> 	2. To improves performance in terms of time and space.
> 	3. To use Dept as a dependency engine for Lockdep.
> 	4. To add any missing tags of wait/event in the kernel.
> 	5. To deduplicate stack trace.
> 
> How to interpret reports:
> 
> 	1. E(event) in each context cannot be triggered because of the
> 	   W(wait) that cannot be woken.
> 	2. The stack trace helping find the problematic code is located
> 	   in each conext's detail.
> 
> Thanks,
> Byungchul
> 
> ---
> 
> Changes from v2:
> 
> 	1. Disable Dept on bit_wait_table[] in sched/wait_bit.c
> 	   reporting a lot of false positives, which is my fault.
> 	   Wait/event for bit_wait_table[] should've been tagged in a
> 	   higher layer for better work, which is a future work.
> 	   (feedback from Jan Kara)
> 	2. Disable Dept on crypto_larval's completion to prevent a false
> 	   positive.
> 
> Changes from v1:
> 
> 	1. Fix coding style and typo. (feedback from Steven)
> 	2. Distinguish each work context from another in workqueue.
> 	3. Skip checking lock acquisition with nest_lock, which is about
> 	   correct lock usage that should be checked by Lockdep.
> 
> Changes from RFC:
> 
> 	1. Prevent adding a wait tag at prepare_to_wait() but __schedule().
> 	   (feedback from Linus and Matthew)
> 	2. Use try version at lockdep_acquire_cpus_lock() annotation.
> 	3. Distinguish each syscall context from another.
[ ... ] 

-- 
Thank you, You are awesome!
Hyeonggon :-)
