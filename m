Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE71360535A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 00:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJSWqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 18:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiJSWqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:46:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E823817C16A
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 15:46:20 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e129so17564238pgc.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lI2fXM/HJXDbYYypU85JMv6ava4twJsKV3cSTxnNcQY=;
        b=Hn/WHkbDdzDa7BHtb7M7h3naX+60Xt0Ef5iKKMgjngqnSuxASV00FDy43XLbMU/DLh
         e733KyKPYpurJ2HDGYOvqdxYEfcODVsuMoPmMl1tNTVKOgS8X/zXuThaivWYHkA//OAa
         i3hl+ZuR8OVwbTyFwqvYEseevcsWJIQWv49QBs4BjCQ6yML75LQcrAPoniSiWC9HAFbi
         F/9UPkjZV9Ke2OEmRQ+z20KBBflqB+ZPSaDgtCS6InpNJt/kyXl8VqZGK/uTb83Dj7m7
         QW9U49wWFm8SkbHYlLAGWJ6rb2jnTc9/i8U7uvrz4DusdJOA5UmsIhyDf+G7OCuXh2k2
         iqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lI2fXM/HJXDbYYypU85JMv6ava4twJsKV3cSTxnNcQY=;
        b=j1n0LNxJWVItkRbZCuI0Jl0usOltcrY9bMtvWcrQMWtuibJpQFnlFJoOaK8/9qyGO+
         uVDAjT7u2JLBi/jftzPNo2Dooa7P3xQ+6Eq3PFF2ozVFEol17DxDtlF+FjVLhb0JUxVF
         c+h+Wa1pLFcNE7Dw3iSuca7GfuR8huEJWCol34rUHJ6VWwYUETh0BGPcxFOPbBfC52rs
         ioQ3zPPCxtNR0BwCWsE+UH7I5GSUUcyXVKrFRqeok28fjUwJcQK8n7o6vEbCxD6EIfRT
         MwS4A3d2Fy7ClwmMrMcdRrXMcAhngdv6GhJFrrV3ZVXc/D44zd+6YcmRIsTtKDYUMVa2
         7Xlg==
X-Gm-Message-State: ACrzQf2bQ6RstBT+9gzRm/yDnXqHDDKHJTp2cbAyTFCMqpPmt7bdb9UU
        Npprd05872B8Lzv8PsEIR40OIg==
X-Google-Smtp-Source: AMsMyM50N5TT8WzQ8RsGq/gj5TUOb9aOsUDmf1RLzeffdvNV6L7swf9eC4V13nmYqTZ185C40SsHqQ==
X-Received: by 2002:a63:540b:0:b0:43c:8ce9:2800 with SMTP id i11-20020a63540b000000b0043c8ce92800mr8974754pgb.481.1666219580444;
        Wed, 19 Oct 2022 15:46:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b00181e55d02dcsm11242789pla.139.2022.10.19.15.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:46:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1olHpI-0041g7-RW; Thu, 20 Oct 2022 09:46:16 +1100
Date:   Thu, 20 Oct 2022 09:46:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <20221019224616.GP2703033@dread.disaster.area>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
 <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org>
 <20221018223042.GJ2703033@dread.disaster.area>
 <Y1AWXiJdyjdLmO1E@casper.infradead.org>
 <20221019220424.GO2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019220424.GO2703033@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:04:24AM +1100, Dave Chinner wrote:
> On Wed, Oct 19, 2022 at 04:23:10PM +0100, Matthew Wilcox wrote:
> > On Wed, Oct 19, 2022 at 09:30:42AM +1100, Dave Chinner wrote:
> > > This is reading and writing the same amount of file data at the
> > > application level, but once the data has been written and kicked out
> > > of the page cache it seems to require an awful lot more read IO to
> > > get it back to the application. i.e. this looks like mmap() is
> > > readahead thrashing severely, and eventually it livelocks with this
> > > sort of report:
> > > 
> > > [175901.982484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [175901.985095] rcu:    Tasks blocked on level-1 rcu_node (CPUs 0-15): P25728
> > > [175901.987996]         (detected by 0, t=97399871 jiffies, g=15891025, q=1972622 ncpus=32)
> > > [175901.991698] task:test_write      state:R  running task     stack:12784 pid:25728 ppid: 25696 flags:0x00004002
> > > [175901.995614] Call Trace:
> > > [175901.996090]  <TASK>
> > > [175901.996594]  ? __schedule+0x301/0xa30
> > > [175901.997411]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > [175901.998513]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > [175901.999578]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > [175902.000714]  ? xas_start+0x53/0xc0
> > > [175902.001484]  ? xas_load+0x24/0xa0
> > > [175902.002208]  ? xas_load+0x5/0xa0
> > > [175902.002878]  ? __filemap_get_folio+0x87/0x340
> > > [175902.003823]  ? filemap_fault+0x139/0x8d0
> > > [175902.004693]  ? __do_fault+0x31/0x1d0
> > > [175902.005372]  ? __handle_mm_fault+0xda9/0x17d0
> > > [175902.006213]  ? handle_mm_fault+0xd0/0x2a0
> > > [175902.006998]  ? exc_page_fault+0x1d9/0x810
> > > [175902.007789]  ? asm_exc_page_fault+0x22/0x30
> > > [175902.008613]  </TASK>
> > > 
> > > Given that filemap_fault on XFS is probably trying to map large
> > > folios, I do wonder if this is a result of some kind of race with
> > > teardown of a large folio...
> > 
> > It doesn't matter whether we're trying to map a large folio; it
> > matters whether a large folio was previously created in the cache.
> > Through the magic of readahead, it may well have been.  I suspect
> > it's not teardown of a large folio, but splitting.  Removing a
> > page from the page cache stores to the pointer in the XArray
> > first (either NULL or a shadow entry), then decrements the refcount.
> > 
> > We must be observing a frozen folio.  There are a number of places
> > in the MM which freeze a folio, but the obvious one is splitting.
> > That looks like this:
> > 
> >         local_irq_disable();
> >         if (mapping) {
> >                 xas_lock(&xas);
> > (...)
> >         if (folio_ref_freeze(folio, 1 + extra_pins)) {
> 
> But the lookup is not doing anything to prevent the split on the
> frozen page from making progress, right? It's not holding any folio
> references, and it's not holding the mapping tree lock, either. So
> how does the lookup in progress prevent the page split from making
> progress?
> 
> 
> > So one way to solve this might be to try to take the xa_lock on
> > failure to get the refcount.  Otherwise a high-priority task
> > might spin forever without a low-priority task getting the chance
> > to finish the work being done while the folio is frozen.
> 
> IIUC, then you are saying that there is a scheduling priority
> inversion because the lookup failure looping path doesn't yeild the
> CPU?
> 
> If so, how does taking the mapping tree spin lock on failure cause
> the looping task to yield the CPU and hence allow the folio split to
> make progress?
> 
> Also, AFAICT, the page split has disabled local interrupts, so it
> should effectively be running with preemption disabled as it has
> turned off the mechanism the scheduler can use to preempt it. The
> page split can't sleep, either, because it holds the mapping tree
> lock. Hence I can't see how a split-in-progress can be preempted in
> teh first place to cause a priority inversion livelock like this...
> 
> > ie this:
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 08341616ae7a..ca0eed80580f 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1860,8 +1860,13 @@ static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
> >  	if (!folio || xa_is_value(folio))
> >  		goto out;
> >  
> > -	if (!folio_try_get_rcu(folio))
> > +	if (!folio_try_get_rcu(folio)) {
> > +		unsigned long flags;
> > +
> > +		xas_lock_irqsave(&xas, flags);
> > +		xas_unlock_irqrestore(&xas, flags);
> >  		goto repeat;
> > +	}

As I suspected, this change did not prevent the livelock. It
reproduced after just 650 test iterations (a few minutes) with this
change in place.

> I would have thought:
> 
> 	if (!folio_try_get_rcu(folio)) {
> 		rcu_read_unlock();
> 		cond_resched();
> 		rcu_read_lock();
> 		goto repeat;
> 	}
> 
> Would be the right way to yeild the CPU to avoid priority
> inversion related livelocks here...

I'm now trying this just to provide a data point that actually
yeilding the CPU avoids the downstream effects of the livelock (i.e.
RCU grace period never expires, system eventually dies...). Maybe it
will avoid the livelock altogether, but I still don't understand how
huge page splitting would be getting preempted in the first place...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
