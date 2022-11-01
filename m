Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE166144F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 08:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKAHR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 03:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKAHR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 03:17:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF9813E9B
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 00:17:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y4so12815027plb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Nov 2022 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X151aWAx0oBEk1QziksxFzs+DkRswE3AVquu+T8L8pY=;
        b=fpArzlG+lKoWhF2A+ZLFuBMFEmn0pPGQvVPPakbZleRlftKjDcjW0XO7wI+GymTmGD
         WiM475Io3rRtMK+wu99V/J0vYYH8k4IWKElkMB2KkItKkpjFpD46sHNlqa/F9mxDEYSf
         SdxPRvDQI4v0h8+ea+G6nW5QBxbRwinKBN/ltVIP+uUgPhgEKSkIBNaNf8e3oLUT2s/n
         mWeF6fa1LsqZGBgEJZNA++monDhWxn0jwQWpJSkuAB/7wxTTithMt+Se46IlRCkuEyKf
         kmvD9wY1CMbWKeVW8Q9gTJ+5iQ+JPvEtkdrn+LlhXfdMn3KvYBQ5rDc+Wo8EsZDjMTBH
         Hw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X151aWAx0oBEk1QziksxFzs+DkRswE3AVquu+T8L8pY=;
        b=Yq6VEGmRX6uVYvDTzoTqhAQELoSkahGtJHGZvSSR9Iiwn5gF1zLWx9PJxBxs1HvKdH
         hLNCj76GGqU2uUL5DPN/1Q5T57/8ZgY7L1GzKsds3Bkxd3Xy1PFSdct5E6eVEv8D8r4M
         anTgsJbcQ9tEURhjRc4vKgpmUr6q6rpwOyQ7mYaUTLbPBy3rAH5g9eVH1bzm4/KK2dCu
         fpSx9zBgCltKLwjGy5WFgc2SRut1P3885mnEZVkMzzFHBn7ifaukQ8jSlhpuiDUFHDOm
         HVa/YLodkzoahI8wKowFoqMcCo/lBK0gMAXDABIQaeFZGSs3BK5mZXozZES2corzkFyN
         8QPg==
X-Gm-Message-State: ACrzQf2v7MLqx1rg42wlU9FRYp4OFl1hl1z/8f+Eqkw7gLIFNd1K2g+v
        UOLR6zIyzRF/ICU3FPkIx2aYhw==
X-Google-Smtp-Source: AMsMyM7Ri3LgG4my6uX6230wfGoU3ezFfydJgC3ChlvBgeQhtoU71SL2HoBb6Vh2CwWhMIJXy4TNIQ==
X-Received: by 2002:a17:902:7485:b0:17d:5176:fe6e with SMTP id h5-20020a170902748500b0017d5176fe6emr18287907pll.147.1667287045594;
        Tue, 01 Nov 2022 00:17:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b0016c9e5f291bsm5609807plk.111.2022.11.01.00.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 00:17:25 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oplWT-008tcn-Sm; Tue, 01 Nov 2022 18:17:21 +1100
Date:   Tue, 1 Nov 2022 18:17:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <20221101071721.GV2703033@dread.disaster.area>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
 <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org>
 <20221018223042.GJ2703033@dread.disaster.area>
 <Y1AWXiJdyjdLmO1E@casper.infradead.org>
 <20221019220424.GO2703033@dread.disaster.area>
 <Y1HDDu3UV0L3cDwE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1HDDu3UV0L3cDwE@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:52:14PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 20, 2022 at 09:04:24AM +1100, Dave Chinner wrote:
> > On Wed, Oct 19, 2022 at 04:23:10PM +0100, Matthew Wilcox wrote:
> > > On Wed, Oct 19, 2022 at 09:30:42AM +1100, Dave Chinner wrote:
> > > > This is reading and writing the same amount of file data at the
> > > > application level, but once the data has been written and kicked out
> > > > of the page cache it seems to require an awful lot more read IO to
> > > > get it back to the application. i.e. this looks like mmap() is
> > > > readahead thrashing severely, and eventually it livelocks with this
> > > > sort of report:
> > > > 
> > > > [175901.982484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > [175901.985095] rcu:    Tasks blocked on level-1 rcu_node (CPUs 0-15): P25728
> > > > [175901.987996]         (detected by 0, t=97399871 jiffies, g=15891025, q=1972622 ncpus=32)
> > > > [175901.991698] task:test_write      state:R  running task     stack:12784 pid:25728 ppid: 25696 flags:0x00004002
> > > > [175901.995614] Call Trace:
> > > > [175901.996090]  <TASK>
> > > > [175901.996594]  ? __schedule+0x301/0xa30
> > > > [175901.997411]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > > [175901.998513]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > > [175901.999578]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > > [175902.000714]  ? xas_start+0x53/0xc0
> > > > [175902.001484]  ? xas_load+0x24/0xa0
> > > > [175902.002208]  ? xas_load+0x5/0xa0
> > > > [175902.002878]  ? __filemap_get_folio+0x87/0x340
> > > > [175902.003823]  ? filemap_fault+0x139/0x8d0
> > > > [175902.004693]  ? __do_fault+0x31/0x1d0
> > > > [175902.005372]  ? __handle_mm_fault+0xda9/0x17d0
> > > > [175902.006213]  ? handle_mm_fault+0xd0/0x2a0
> > > > [175902.006998]  ? exc_page_fault+0x1d9/0x810
> > > > [175902.007789]  ? asm_exc_page_fault+0x22/0x30
> > > > [175902.008613]  </TASK>
> > > > 
> > > > Given that filemap_fault on XFS is probably trying to map large
> > > > folios, I do wonder if this is a result of some kind of race with
> > > > teardown of a large folio...
> > > 
> > > It doesn't matter whether we're trying to map a large folio; it
> > > matters whether a large folio was previously created in the cache.
> > > Through the magic of readahead, it may well have been.  I suspect
> > > it's not teardown of a large folio, but splitting.  Removing a
> > > page from the page cache stores to the pointer in the XArray
> > > first (either NULL or a shadow entry), then decrements the refcount.
> > > 
> > > We must be observing a frozen folio.  There are a number of places
> > > in the MM which freeze a folio, but the obvious one is splitting.
> > > That looks like this:
> > > 
> > >         local_irq_disable();
> > >         if (mapping) {
> > >                 xas_lock(&xas);
> > > (...)
> > >         if (folio_ref_freeze(folio, 1 + extra_pins)) {
> > 
> > But the lookup is not doing anything to prevent the split on the
> > frozen page from making progress, right? It's not holding any folio
> > references, and it's not holding the mapping tree lock, either. So
> > how does the lookup in progress prevent the page split from making
> > progress?
> 
> My thinking was that it keeps hammering the ->refcount field in
> struct folio.  That might prevent a thread on a different socket
> from making forward progress.  In contrast, spinlocks are designed
> to be fair under contention, so by spinning on an actual lock, we'd
> remove contention on the folio.
> 
> But I think the tests you've done refute that theory.  I'm all out of
> ideas at the moment.  Either we have a frozen folio from somebody who
> doesn't hold the lock, or we have someone who's left a frozen folio in
> the page cache.  I'm leaning towards that explanation at the moment,
> but I don't have a good suggestion for debugging.

It's something else. I got gdb attached to qemu and single stepped
the looping lookup. The context I caught this time is truncate after
unlink:

(gdb) bt
#0  find_get_entry (mark=<optimized out>, max=<optimized out>, xas=<optimized out>) at mm/filemap.c:2014
#1  find_lock_entries (mapping=mapping@entry=0xffff8882445e2118, start=start@entry=25089, end=end@entry=18446744073709551614, 
    fbatch=fbatch@entry=0xffffc900082a7dd8, indices=indices@entry=0xffffc900082a7d60) at mm/filemap.c:2095
#2  0xffffffff8128f024 in truncate_inode_pages_range (mapping=mapping@entry=0xffff8882445e2118, lstart=lstart@entry=0, lend=lend@entry=-1)
    at mm/truncate.c:364
#3  0xffffffff8128f452 in truncate_inode_pages (lstart=0, mapping=0xffff8882445e2118) at mm/truncate.c:452
#4  0xffffffff8136335d in evict (inode=inode@entry=0xffff8882445e1f78) at fs/inode.c:666
#5  0xffffffff813636cc in iput_final (inode=0xffff8882445e1f78) at fs/inode.c:1747
#6  0xffffffff81355b8b in do_unlinkat (dfd=dfd@entry=10, name=0xffff88834170e000) at fs/namei.c:4326
#7  0xffffffff81355cc3 in __do_sys_unlinkat (flag=<optimized out>, pathname=<optimized out>, dfd=<optimized out>) at fs/namei.c:4362
#8  __se_sys_unlinkat (flag=<optimized out>, pathname=<optimized out>, dfd=<optimized out>) at fs/namei.c:4355
#9  __x64_sys_unlinkat (regs=<optimized out>) at fs/namei.c:4355
#10 0xffffffff81e92e35 in do_syscall_x64 (nr=<optimized out>, regs=0xffffc900082a7f58) at arch/x86/entry/common.c:50
#11 do_syscall_64 (regs=0xffffc900082a7f58, nr=<optimized out>) at arch/x86/entry/common.c:80
#12 0xffffffff82000087 in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:120
#13 0x0000000000000000 in ?? ()

The find_lock_entries() call is being asked to start at index
25089, and we are spinning on a folio we find because
folio_try_get_rcu(folio) is failing - the folio ref count is zero.

The xas state on lookup is:

(gdb) p *xas
$6 = {xa = 0xffff8882445e2120, xa_index = 25092, xa_shift = 0 '\000', xa_sibs = 0 '\000', xa_offset = 4 '\004', xa_pad = 0 '\000', 
  xa_node = 0xffff888144c15918, xa_alloc = 0x0 <fixed_percpu_data>, xa_update = 0x0 <fixed_percpu_data>, xa_lru = 0x0 <fixed_percpu_data>

indicating that we are trying to look up index 25092 (3 pages
further in than the start of the batch), and the folio that this
keeps returning is this:

(gdb) p *folio
$7 = {{{flags = 24769796876795904, {lru = {next = 0xffffea0005690008, prev = 0xffff88823ffd5f50}, {__filler = 0xffffea0005690008, 
          mlock_count = 1073569616}}, mapping = 0x0 <fixed_percpu_data>, index = 18688, private = 0x8 <fixed_percpu_data+8>, _mapcount = {
        counter = -129}, _refcount = {counter = 0}, memcg_data = 0}, page = {flags = 24769796876795904, {{{lru = {next = 0xffffea0005690008, 
              prev = 0xffff88823ffd5f50}, {__filler = 0xffffea0005690008, mlock_count = 1073569616}, buddy_list = {
              next = 0xffffea0005690008, prev = 0xffff88823ffd5f50}, pcp_list = {next = 0xffffea0005690008, prev = 0xffff88823ffd5f50}}, 
          mapping = 0x0 <fixed_percpu_data>, index = 18688, private = 8}, {pp_magic = 18446719884544507912, pp = 0xffff88823ffd5f50, 
          _pp_mapping_pad = 0, dma_addr = 18688, {dma_addr_upper = 8, pp_frag_count = {counter = 8}}}, {
          compound_head = 18446719884544507912, compound_dtor = 80 'P', compound_order = 95 '_', compound_mapcount = {counter = -30590}, 
          compound_pincount = {counter = 0}, compound_nr = 0}, {_compound_pad_1 = 18446719884544507912, 
          _compound_pad_2 = 18446612691733536592, deferred_list = {next = 0x0 <fixed_percpu_data>, 
            prev = 0x4900 <irq_stack_backing_store+10496>}}, {_pt_pad_1 = 18446719884544507912, pmd_huge_pte = 0xffff88823ffd5f50, 
          _pt_pad_2 = 0, {pt_mm = 0x4900 <irq_stack_backing_store+10496>, pt_frag_refcount = {counter = 18688}}, 
          ptl = 0x8 <fixed_percpu_data+8>}, {pgmap = 0xffffea0005690008, zone_device_data = 0xffff88823ffd5f50}, callback_head = {
          next = 0xffffea0005690008, func = 0xffff88823ffd5f50}}, {_mapcount = {counter = -129}, page_type = 4294967167}, _refcount = {
        counter = 0}, memcg_data = 0}}, _flags_1 = 24769796876795904, __head = 0, _folio_dtor = 3 '\003', _folio_order = 8 '\b', 
  _total_mapcount = {counter = -1}, _pincount = {counter = 0}, _folio_nr_pages = 0}
(gdb)

The folio has a NULL mapping, and an index of 18688, which means
even if it was not a folio that has been invalidated or freed, the
index is way outside the range we are looking for.

If I step it round the lookup loop, xas does not change, and the
same folio is returned every time through the loop. Perhaps
the mapping tree itself might be corrupt???

It's simple enough to stop the machine once it has become stuck to
observe the iteration and dump structures, just tell me what you
need to know from here...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
