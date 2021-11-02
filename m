Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328434436D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 20:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhKBT75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 15:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKBT74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:59:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC5C061714
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Nov 2021 12:57:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u17so491253plg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Nov 2021 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27/CElpQAMzqqxlHmQpeS6Xg/mCPIF70OaGp9omQL+c=;
        b=gnmFikOM0EZHcxypXtFnpwLzOY0Njy6YMU8YvFC8zWIuvUdPg0ng/ShUl1GQH9946d
         j/uml9OxPc8/cIYdu5U+X7/EKsdz41DbrpobujjKkxErQyj+0U9SSrXqSHvGaLweJbBI
         Vw7WMgzYl6YtyH/wl3L+/YQVZQ1SZP0LZVeeAAYx2qvIb277Lj4JJI/0NEI48DBcNhCj
         ssj6g52WUR3TmsF60UJ8OwLblx0dz/v1O2jc2hcUaypWBm5VF8uFZKYSAcAvUAIlV84s
         PXKSkGIa5Efu1x+AUfXtKpWi7fsvOt9V8k6CS6FB5Onm4Onqik2F6aJHvmb8xZ4Ntuo0
         t7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27/CElpQAMzqqxlHmQpeS6Xg/mCPIF70OaGp9omQL+c=;
        b=jnmiQDgacwzHCdUKmkg6KnFfG+NS6YCJ2Bilo+ucMQVi64vJ/2C/3zJfRc+c6OOm7z
         I50rJoeR0t3S2nBE8HsYNJSfQTCw6fDthy3hyeF/S7t2pq6ffblGNcVzf+zjajAFSVi8
         6FaGoODrxPeSivebmeFm+D0EKbISKrNeMUuubeEZ8JkSouFmVj4xRC8tM1oj8GhScpKl
         5MtCaRpOASvj69DdvMGd7Lxz6RlM1+qjlQXilA4Sz90uu15Gu/6UjZVtJF/hPJWN+08x
         B6NSco69EUc0MFHz8YzzPG08xpPPli0bY0JpAGewUC3FyXWk70eqXRkm5EsloiEZwj1w
         kOtQ==
X-Gm-Message-State: AOAM530T/2ycNV/5DKrCxFIxKZoVGqJJ3Tme5YkhHDQ3IqZgLTFEXf+m
        otz2PJXbqdg9FRXV0nDYrtP5x5eHq16jQwyTm5Vbzw==
X-Google-Smtp-Source: ABdhPJzq586k0UH/EQKwqZQVt2ykdjLrrPOPnL+mNuoKsJoIKHfRoBAF8+snuu5yn1iHwpf7ywngttf1p1qav9DOqoI=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr9265133pjp.8.1635883041063;
 Tue, 02 Nov 2021 12:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211021001059.438843-1-jane.chu@oracle.com> <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com> <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com> <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia> <YYDYUCCiEPXhZEw0@infradead.org>
In-Reply-To: <YYDYUCCiEPXhZEw0@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Nov 2021 12:57:10 -0700
Message-ID: <CAPcyv4j8snuGpy=z6BAXogQkP5HmTbqzd6e22qyERoNBvFKROw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA flag
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jane Chu <jane.chu@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 1, 2021 at 11:19 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Oct 27, 2021 at 05:24:51PM -0700, Darrick J. Wong wrote:
> > ...so would you happen to know if anyone's working on solving this
> > problem for us by putting the memory controller in charge of dealing
> > with media errors?
>
> The only one who could know is Intel..
>
> > The trouble is, we really /do/ want to be able to (re)write the failed
> > area, and we probably want to try to read whatever we can.  Those are
> > reads and writes, not {pre,f}allocation activities.  This is where Dave
> > and I arrived at a month ago.
> >
> > Unless you'd be ok with a second IO path for recovery where we're
> > allowed to be slow?  That would probably have the same user interface
> > flag, just a different path into the pmem driver.
>
> Which is fine with me.  If you look at the API here we do have the
> RWF_ API, which them maps to the IOMAP API, which maps to the DAX_
> API which then gets special casing over three methods.
>
> And while Pavel pointed out that he and Jens are now optimizing for
> single branches like this.  I think this actually is silly and it is
> not my point.
>
> The point is that the DAX in-kernel API is a mess, and before we make
> it even worse we need to sort it first.  What is directly relevant
> here is that the copy_from_iter and copy_to_iter APIs do not make
> sense.  Most of the DAX API is based around getting a memory mapping
> using ->direct_access, it is just the read/write path which is a slow
> path that actually uses this.  I have a very WIP patch series to try
> to sort this out here:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dax-devirtualize
>
> But back to this series.  The basic DAX model is that the callers gets a
> memory mapping an just works on that, maybe calling a sync after a write
> in a few cases.  So any kind of recovery really needs to be able to
> work with that model as going forward the copy_to/from_iter path will
> be used less and less.  i.e. file systems can and should use
> direct_access directly instead of using the block layer implementation
> in the pmem driver.  As an example the dm-writecache driver, the pending
> bcache nvdimm support and the (horribly and out of tree) nova file systems
> won't even use this path.  We need to find a way to support recovery
> for them.  And overloading it over the read/write path which is not
> the main path for DAX, but the absolutely fast path for 99% of the
> kernel users is a horrible idea.
>
> So how can we work around the horrible nvdimm design for data recovery
> in a way that:
>
>    a) actually works with the intended direct memory map use case
>    b) doesn't really affect the normal kernel too much
>
> ?

Ok, now I see where you are going, but I don't see line of sight to
something better than RWF_RECOVER_DATA.

This goes back to one of the original DAX concerns of wanting a kernel
library for coordinating PMEM mmap I/O vs leaving userspace to wrap
PMEM semantics on top of a DAX mapping. The problem is that mmap-I/O
has this error-handling-API issue whether it is a DAX mapping or not.
I.e. a memory failure in page cache is going to signal the process the
same way and it will need to fall back to something other than mmap
I/O to make forward progress. This is not a PMEM, Intel or even x86
problem, it's a generic CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE problem.

CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE implies that processes will
receive SIGBUS + BUS_MCEERR_A{R,O} when memory failure is signalled
and then rely on readv(2)/writev(2) to recover. Do you see a readily
available way to improve upon that model without CPU instruction
changes? Even with CPU instructions changes, do you think it could
improve much upon the model of interrupting the process when a load
instruction aborts?

I do agree with you that DAX needs to separate itself from block, but
I don't think it follows that DAX also needs to separate itself from
readv/writev for when a kernel slow-path needs to get involved because
mmap I/O (just CPU instructions) does not have the proper semantics.
Even if you got one of the ARCH_SUPPORTS_MEMORY_FAILURE to implement
those semantics in new / augmented CPU instructions you will likely
not get all of them to move and certainly not in any near term
timeframe, so the kernel path will be around indefinitely.

Meanwhile, I think RWF_RECOVER_DATA is generically useful for other
storage besides PMEM and helps storage-drivers do better than large
blast radius "I/O error" completions with no other recourse.
