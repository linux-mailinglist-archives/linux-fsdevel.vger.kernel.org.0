Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC56275B20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 17:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIWPEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgIWPEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:04:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC5C0613CE;
        Wed, 23 Sep 2020 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ose8ctZCTv8oUOd9k3tTT76nITLXgVZlsCte1r4Sf9c=; b=MkYEExTq1+wkaz83zMuspp5RjA
        Ql+JlgSLUtPgJQMk5ZRNIO+I2UvxTYWBAkIXlCxSLKN0kKXI86QBoGjW7A+yKUpkqMuuehrinsPuf
        iwX4oT+QNjApAyJGa8cH3EwMkixriTNBrfTFPhwDoOaCloAwyeLBZpcBeXr6ULKd7x6mz/VU1mrTF
        rjgPBXE/KVXkfXpLPhqrWyo99AM+ADFVOdaGRg6A3iJrv8o6ovKyridoI1mwkForkyoK8bF8rFGrw
        fd8w+PRxzla1bKvhyrYdLqm3AOmAqwCzB8te5Y2Zk6g0lBF64zMFMDuAmKdoz1JjyoTd9K7oNNJHv
        KnkoQvSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kL6Jn-0005Kf-EE; Wed, 23 Sep 2020 15:04:27 +0000
Date:   Wed, 23 Sep 2020 16:04:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
Message-ID: <20200923150427.GP32101@casper.infradead.org>
References: <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
 <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com>
 <20200922050314.GB12096@dread.disaster.area>
 <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com>
 <20200923095739.GC6719@quack2.suse.cz>
 <alpine.LRH.2.02.2009230841110.1800@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009230841110.1800@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 09:11:43AM -0400, Mikulas Patocka wrote:
> I also don't know how to implement journling on persistent memory :) On 
> EXT4 or XFS you can pin dirty buffers in memory until the journal is 
> flushed. This is obviously impossible on persistent memory. So, I'm 
> considering implementing only some lightweight journaling that will 
> guarantee atomicity between just a few writes.

That's a bit disappointing considering people have been publishing
papers on how to do umpteen different variations on persistent memory
journalling for the last five years.

https://www.google.com/search?q=intel+persistent+memory+atomic+updates

for example
