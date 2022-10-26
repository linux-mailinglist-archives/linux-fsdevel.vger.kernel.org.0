Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B163A60DD2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 10:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiJZIjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 04:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiJZIjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:39:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDD6C50A6;
        Wed, 26 Oct 2022 01:39:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bs14so20848514ljb.9;
        Wed, 26 Oct 2022 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJjZgtRnPpD+DKy46Vef77v0SBnaAr1AvkJEDPpJazc=;
        b=X83V3zxSEIO+n1gh8XIS5K3mPNHQg6EdWtJ5UTrZ/mXJyPm56M3neccxMLiPuwSDGI
         z60g87S8E4xDakKpxQtYjZY6b93/IPsl6U43cNd+Fk6xFGjTdCaJnJmJigZaK9WKEQSM
         59ztziArg8HLu33w3yJED4bjqOL/tkQ/F4h6tVJ+azlkrx0g3i/ncGfyOMXYkwVID0ll
         cCaXVC/hQSpXeMCBAN+2nWDCCOHn1S3t+nDpxa4zPr/CXE8BrpDMd38Pk8z9EFAElF6K
         w83VGpJbRUtaTf/gMBVJqc7E07nG/SbiQKF/roXi+52GfyqW0IXb0Mbr/ogYj262fZRH
         7B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJjZgtRnPpD+DKy46Vef77v0SBnaAr1AvkJEDPpJazc=;
        b=IqOJjkdY8WKp6FUYTE2MT15D1APsLA4XC754coMERxSgq/jlk7daZX8AurlnXF/SQN
         IcLU4+OM4Gyo9q1hD8rKZv2PNGzr5tkQoPawEjbuKTi9RwZ12T+1y10R78QkA5GdVaaB
         v200aaTjRvD1Sg0MfTwUjGQYkAIEVWj6/08zcVfIHZSTueMSOpoiYCmznF5BV95X7cYv
         KXYnuYixLP673wuEjXWOZ4qKhV1oQVy65rXsyJeVNwiB9uEL2ikO9CkuGKcmWa6+WnVA
         7aB/T/l+oceyqGiRbNd6TwCnBYXIEl9Yq5NeTcbJCPzDtcJrd+qBYcRHRMhIadtVBN6k
         XNEg==
X-Gm-Message-State: ACrzQf0kSaUZf0a46aXf5RZ4ayGrcjZe7F0aIFqj7Le5BtjEuQYhdFRD
        RO88FdQ1E9qij9hi+ujvrShJ9bnMde0V0f+/z8U=
X-Google-Smtp-Source: AMsMyM6w5GeKFzkQEzDM5vYl+oLu14kckff7OfB8zua8UsATQTnV6tDrGqesSdOhDGlW7y1pXP+mZBA7NVQ8OwyCBhQ=
X-Received: by 2002:a05:651c:d4:b0:277:23bb:71ee with SMTP id
 20-20020a05651c00d400b0027723bb71eemr302575ljr.114.1666773539910; Wed, 26 Oct
 2022 01:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org> <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org> <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org> <20221018223042.GJ2703033@dread.disaster.area>
 <Y1AWXiJdyjdLmO1E@casper.infradead.org> <20221019220424.GO2703033@dread.disaster.area>
 <Y1HDDu3UV0L3cDwE@casper.infradead.org>
In-Reply-To: <Y1HDDu3UV0L3cDwE@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 26 Oct 2022 16:38:31 +0800
Message-ID: <CAGWkznELCKmz8jtNcWvzb7ThCDAESv019EdWbDYzAtZUCBVQqQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org, lvqiang.huang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 21, 2022 at 5:52 AM Matthew Wilcox <willy@infradead.org> wrote:
>
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
>
> Perhaps a bad suggestion for debugging would be to call dump_page()
> with a __ratelimit() wrapper to not be overwhelmed with information?
>
> > I would have thought:
> >
> >       if (!folio_try_get_rcu(folio)) {
> >               rcu_read_unlock();
> >               cond_resched();
> >               rcu_read_lock();
> >               goto repeat;
> >       }
> >
> > Would be the right way to yeild the CPU to avoid priority
> > inversion related livelocks here...
>
> I'm not sure we're allowed to schedule here.  We might be under another
> spinlock?
Any further ideas on this issue? Could we just deal with it as simply
as surpass the zero refed page to break the livelock as a workaround?
IMO, the system could survive if it is a single inode leak or expose
other faults if the page cache messed up, which is better than
livelock here. We do the similar thing during reclaiming as force
reset the page's mapcount to -1 even if there is active reference on
it.

static void unaccount_page_cache_page(struct address_space *mapping,
     struct page *page)
{

if (mapping_exiting(mapping) &&
   page_count(page) >= mapcount + 2) {

/*
* All vmas have already been torn down, so it's
* a good bet that actually the page is unmapped,
* and we'd prefer not to leak it: if we're wrong,
* some other bad page check should catch it later.
*/

page_mapcount_reset(page);
page_ref_sub(page, mapcount);
}
