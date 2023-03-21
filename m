Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191486C270F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCUBLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCUBLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:11:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82638035
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:10:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so18491135pjt.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1679360957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ard8tYEtuim88umne0gyaePxSaABF63V8F0JJy1BBA8=;
        b=2j9RQkllMk34kvITCdHHjbV+9is81Ls1mIfbwpFF0L5ntmfjrZkH3/NfJCdQkerk9F
         9jB+kVCeIcfsN4zSQqa7P/4mc6GGhWbZgjj6RwGJlqMG1cieO7aTZXyE505+yaBuKcCF
         T2Yy3ULdf0DVv5/fivzuhR2U2Uuuk556TlrBmuHg4esUEOa37J8uO1DpHIFXInGDsXGZ
         uYUtaGTC4eyXjOo8Rrrnys7rGvTdpncaLTgYaT5qYQ1UpcpK7eMmgHj5YfTLC7lpcrNu
         V427PnGRswjr8vdYxpl88XyC2Dqm2bCZiquR+94YqMrYGWDEN8Fu9BrhRowl4HCQjO67
         qUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679360957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ard8tYEtuim88umne0gyaePxSaABF63V8F0JJy1BBA8=;
        b=cA+gVJv5kHb4hEQdP66SPNXdARHSiHZt44T2BcXe49aflPy2T+PqAMmoChZMtxw7FW
         DTw1K7UFDpzFtQwfFr+4zX+3S05RxWebvrazcWdQVfArkQbwZHgnRiDRTu6ugaDrDDlc
         ZLXJiYrImXdH1Y5cK1OOF5s8sFHU8POsQZgXVqbNv3otv7TlZ9GAPavx6ywC7d7Kydb7
         gkHjfx4uvC6xISut2Iv5Nut94brVyD8QH2sAZxya4GcO0seJ22/y3SOwikHiECphKtK1
         M08ZIVYhpNf38rFOhzPMnIy+9GWHbX2oa/WP9XkJ5a81liv/rBZMRDy8SXhp2jYKpZdq
         5BLQ==
X-Gm-Message-State: AO0yUKUuQAD+MPP7kfUWJ/TMto27YhTpedOG8t6hPvsoRcJ+fQya+TOi
        yoiEh9U1vDRHiXyVfALqgjCW5w==
X-Google-Smtp-Source: AK7set+UOYEWRVZ3UVEikJR6Cx2WhJxXds4/6C4hRFkW/myx6zHNT32/ivnnzhI1BkOCjTw/kBkjRw==
X-Received: by 2002:a17:902:d48c:b0:1a0:57df:861c with SMTP id c12-20020a170902d48c00b001a057df861cmr16695481plg.1.1679360956742;
        Mon, 20 Mar 2023 18:09:16 -0700 (PDT)
Received: from destitution (pa49-196-94-140.pa.vic.optusnet.com.au. [49.196.94.140])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0019a723a831dsm7344655plr.158.2023.03.20.18.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 18:09:16 -0700 (PDT)
Received: from dave by destitution with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1peQUy-000WO0-0v;
        Tue, 21 Mar 2023 12:09:12 +1100
Date:   Tue, 21 Mar 2023 12:09:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBkDuLKLhsOHNUeG@destitution>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 19, 2023 at 07:09:31AM +0000, Lorenzo Stoakes wrote:
> vmalloc() is, by design, not permitted to be used in atomic context and
> already contains components which may sleep, so avoiding spin locks is not
> a problem from the perspective of atomic context.
> 
> The global vmap_area_lock is held when the red/black tree rooted in
> vmap_are_root is accessed and thus is rather long-held and under
> potentially high contention. It is likely to be under contention for reads
> rather than write, so replace it with a rwsem.
> 
> Each individual vmap_block->lock is likely to be held for less time but
> under low contention, so a mutex is not an outrageous choice here.
> 
> A subset of test_vmalloc.sh performance results:-
> 
> fix_size_alloc_test             0.40%
> full_fit_alloc_test		2.08%
> long_busy_list_alloc_test	0.34%
> random_size_alloc_test		-0.25%
> random_size_align_alloc_test	0.06%
> ...
> all tests cycles                0.2%
> 
> This represents a tiny reduction in performance that sits barely above
> noise.

I'm travelling right now, but give me a few days and I'll test this
against the XFS workloads that hammer the global vmalloc spin lock
really, really badly. XFS can use vm_map_ram and vmalloc really
heavily for metadata buffers and hit the global spin lock from every
CPU in the system at the same time (i.e. highly concurrent
workloads). vmalloc is also heavily used in the hottest path
throught the journal where we process and calculate delta changes to
several million items every second, again spread across every CPU in
the system at the same time.

We really need the global spinlock to go away completely, but in the
mean time a shared read lock should help a little bit....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
