Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012F96C2D24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 09:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjCUI40 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 04:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCUIzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:55:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFFE268B;
        Tue, 21 Mar 2023 01:54:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bi9so18135265lfb.12;
        Tue, 21 Mar 2023 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679388869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihWLb6YDeUm4LyXoGDvnXvPNh5dZmfkRW4mzY5FPdhM=;
        b=PUeizF7dzLAZJmmyz4Qbzek28PUiJv9e9blTv2pw/0T3CuhF3KprL7LCtEIm9Jbwme
         eIkhw77b4qrg8nCvBEJebTu6itTSeuurkArgaVZ1YEkPcyI41jLz43/Vh7vBqquQ8i8U
         kOx+jzUiRR6h37OW8uI+XYmgIwVnsmTugrhGPhmTmoPmHgPBJyXhBKWg8ayzUhlumy4k
         bFRdCdg4RWqrwp8zDPG3ryeKWj1ZQnN87by6Y6axKqfevqW3Szk7O42xikCQtp3BpKYk
         s5e1ElpL/7HIKEX69eQWOzjC5ha2nWhlxFcURYkt8JMO8SSVt3/trvKLrIpSd/krX5YS
         xniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679388869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihWLb6YDeUm4LyXoGDvnXvPNh5dZmfkRW4mzY5FPdhM=;
        b=LVAZqXwUv4JeJyz3uKZcGvJQF7++9wyyP6ENQm2XmzNKtgoCSeQ0UyIr3pcsvBjV5C
         xoTCRLg87dhQec1ZRtSvN/xqQF5uls0KqZ33pdpJMTP3TWljNd+riDPUFKKKWPPnIiW0
         OysPMXB5wuv6nvJ1PFuifFMDcLGtELQjgdYLsDN3weJFk/b6gz6qygEakFnNH1nWp6h2
         DwUDjg2GGFJGFu3p8/G8EX0T9TE2CI9W16V0XD/ixpcBeMHOjP/d209CkNagmTEzNJgv
         NbqbKIGrAkF+XWIRSCCIA6/tUN9bUQrxW1zWWB+1cPEa+Jmg4ra6vblcUJoMDjeHEYBn
         2yXQ==
X-Gm-Message-State: AO0yUKXUYQfcziE/Wzyvf4ByOjliI/buxpDWryetFuSfBTYLZn/rVWBQ
        QZrlalQruehajIvkf4ulSWI=
X-Google-Smtp-Source: AK7set+HyqoO+eZz5C//84EZqAvcFQ7KS7XwqX9sdZR0jNq+5OaFBZIEVgNAuP9hR3nhr0Nv+lsEZA==
X-Received: by 2002:ac2:5a1a:0:b0:4d5:a689:7580 with SMTP id q26-20020ac25a1a000000b004d5a6897580mr582688lfn.47.1679388869163;
        Tue, 21 Mar 2023 01:54:29 -0700 (PDT)
Received: from pc636 (host-90-233-209-15.mobileonline.telia.com. [90.233.209.15])
        by smtp.gmail.com with ESMTPSA id h11-20020ac250cb000000b004db3d57c3a8sm2079989lfm.96.2023.03.21.01.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 01:54:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 21 Mar 2023 09:54:26 +0100
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBlwwkGrnyF25/Pv@pc636>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBk/Wxj4rXPra/ge@pc636>
 <8cd31bcd-dad4-44e3-920f-299a656aea98@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd31bcd-dad4-44e3-920f-299a656aea98@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 07:45:56AM +0000, Lorenzo Stoakes wrote:
> On Tue, Mar 21, 2023 at 06:23:39AM +0100, Uladzislau Rezki wrote:
> > On Tue, Mar 21, 2023 at 12:09:12PM +1100, Dave Chinner wrote:
> > > On Sun, Mar 19, 2023 at 07:09:31AM +0000, Lorenzo Stoakes wrote:
> > > > vmalloc() is, by design, not permitted to be used in atomic context and
> > > > already contains components which may sleep, so avoiding spin locks is not
> > > > a problem from the perspective of atomic context.
> > > >
> > > > The global vmap_area_lock is held when the red/black tree rooted in
> > > > vmap_are_root is accessed and thus is rather long-held and under
> > > > potentially high contention. It is likely to be under contention for reads
> > > > rather than write, so replace it with a rwsem.
> > > >
> > > > Each individual vmap_block->lock is likely to be held for less time but
> > > > under low contention, so a mutex is not an outrageous choice here.
> > > >
> > > > A subset of test_vmalloc.sh performance results:-
> > > >
> > > > fix_size_alloc_test             0.40%
> > > > full_fit_alloc_test		2.08%
> > > > long_busy_list_alloc_test	0.34%
> > > > random_size_alloc_test		-0.25%
> > > > random_size_align_alloc_test	0.06%
> > > > ...
> > > > all tests cycles                0.2%
> > > >
> > > > This represents a tiny reduction in performance that sits barely above
> > > > noise.
> > >
> > > I'm travelling right now, but give me a few days and I'll test this
> > > against the XFS workloads that hammer the global vmalloc spin lock
> > > really, really badly. XFS can use vm_map_ram and vmalloc really
> > > heavily for metadata buffers and hit the global spin lock from every
> > > CPU in the system at the same time (i.e. highly concurrent
> > > workloads). vmalloc is also heavily used in the hottest path
> > > throught the journal where we process and calculate delta changes to
> > > several million items every second, again spread across every CPU in
> > > the system at the same time.
> > >
> > > We really need the global spinlock to go away completely, but in the
> > > mean time a shared read lock should help a little bit....
> > >
> 
> Hugely appreciated Dave, however I must disappoint on the rwsem as I have now
> reworked my patch set to use the original locks in order to satisfy Willy's
> desire to make vmalloc atomic in future, and Uladzislau's desire to not have a
> ~6% performance hit -
> https://lore.kernel.org/all/cover.1679354384.git.lstoakes@gmail.com/
> 
> > I am working on it. I submitted a proposal how to eliminate it:
> >
> >
> > <snip>
> > Hello, LSF.
> >
> > Title: Introduce a per-cpu-vmap-cache to eliminate a vmap lock contention
> >
> > Description:
> >  Currently the vmap code is not scaled to number of CPU cores in a system
> >  because a global vmap space is protected by a single spinlock. Such approach
> >  has a clear bottleneck if many CPUs simultaneously access to one resource.
> >
> >  In this talk i would like to describe a drawback, show some data related
> >  to contentions and places where those occur in a code. Apart of that i
> >  would like to share ideas how to eliminate it providing a few approaches
> >  and compare them.
> >
> > Requirements:
> >  * It should be a per-cpu approach;
> >  * Search of freed ptrs should not interfere with other freeing(as much as we can);
> >  *   - offload allocated areas(buzy ones) per-cpu;
> >  * Cache ready sized objects or merge them into one big per-cpu-space(split on demand);
> >  * Lazily-freed areas either drained per-cpu individually or by one CPU for all;
> >  * Prefetch a fixed size in front and allocate per-cpu
> >
> > Goals:
> >  * Implement a per-cpu way of allocation to eliminate a contention.
> >
> > Thanks!
> > <snip>
> >
> > --
> > Uladzislau Rezki
> >
> 
> That's really awesome! I will come to that talk at LSF/MM :) being able to
> sustain the lock in atomic context seems to be an aspect that is important going
> forward also.
>
Uhh... So i need to prepare then :)))

--
Uladzislau Rezki
