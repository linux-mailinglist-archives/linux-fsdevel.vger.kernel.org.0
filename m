Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6CD6C2BA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 08:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCUHqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCUHq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:46:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0904410B9;
        Tue, 21 Mar 2023 00:46:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso8889170wmo.0;
        Tue, 21 Mar 2023 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679384759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGNPqTjSMUqDfHrgW6kgUvbw3qknVLkyvvVwqcSq3M8=;
        b=U5P6dkc4hbEDC/eQltNr2iI40AnzZGA5AIz637Rqk5+jaPXD9z2dIAd+F2YMI1opDp
         8m0wLRKI280ryNuNwnqZxB3JEN6fjayqp4Xc+tzeUMUYjREhDTOYb+1BbmRlDF5jUbHj
         QlRURQ0Ghzr1+Q8BGWNAyWS/PZ1lBuDsuMdlFzRUFVF0uK6NsxM6vS23THO4+DU2bO4U
         8Yw6UdqwgwSYIQuROvjkDYl1nmiHE43bXKuw0+o8LpgKXcLPXvx3pI9oU8SmxKK9BZ18
         wws7FzZx4GkcwtOrC/ZfgzYJ24ndDuqpLa44vt+z61bjHB7xIrdFdazU6a/tAS17I1A6
         FGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGNPqTjSMUqDfHrgW6kgUvbw3qknVLkyvvVwqcSq3M8=;
        b=NFgxrWzTKTv9nEA0B26FJAoq4gMTjtHp2cBolbsFqKDKsSc1Y2UBuZ6Txebff157xl
         W39lV+pgV7HMCpLMciJGEjBgrMc+T7AlTfVU8srLXLjkFbca6sc13s7Rm5Ycsag/aPJ3
         P8FGM5Tvb6FJZ7OJ3X0RoPJPmR95PfE9KH+c85cHMWfZJncMqTeGS+wEJdRpuIsY5B5x
         ua53YTYCKFzn3O3r9Mas2jlzAOq7hUIfnYMm1LCVpGJGIagKQ9Y5t+77H38xCNrJzY9v
         5EGvS1n3WpAAG6dp/9mLtE/foWC+vf5nxziCHCgCynjPKrxUyhMTn+K7Ts3ZLeGpYb2e
         7yqw==
X-Gm-Message-State: AO0yUKXRNZsVtJxmzga3L/zmSVAgn4gkUWdoc5PvFf4YypF/rHUVCYtG
        T/SQjXak3BM+Ld4xjfVEpH8=
X-Google-Smtp-Source: AK7set995a5DnVD7LqGUABlMiy0yRpKpPaU+FTuy57OjMDKiF9VDwShiiFTEvhhWTpHc/8vvKPPzhg==
X-Received: by 2002:a7b:c409:0:b0:3e2:19b0:887d with SMTP id k9-20020a7bc409000000b003e219b0887dmr1539717wmi.25.1679384758498;
        Tue, 21 Mar 2023 00:45:58 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c05c500b003edf2ae2432sm5496183wmd.7.2023.03.21.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 00:45:57 -0700 (PDT)
Date:   Tue, 21 Mar 2023 07:45:56 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <8cd31bcd-dad4-44e3-920f-299a656aea98@lucifer.local>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBk/Wxj4rXPra/ge@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBk/Wxj4rXPra/ge@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 06:23:39AM +0100, Uladzislau Rezki wrote:
> On Tue, Mar 21, 2023 at 12:09:12PM +1100, Dave Chinner wrote:
> > On Sun, Mar 19, 2023 at 07:09:31AM +0000, Lorenzo Stoakes wrote:
> > > vmalloc() is, by design, not permitted to be used in atomic context and
> > > already contains components which may sleep, so avoiding spin locks is not
> > > a problem from the perspective of atomic context.
> > >
> > > The global vmap_area_lock is held when the red/black tree rooted in
> > > vmap_are_root is accessed and thus is rather long-held and under
> > > potentially high contention. It is likely to be under contention for reads
> > > rather than write, so replace it with a rwsem.
> > >
> > > Each individual vmap_block->lock is likely to be held for less time but
> > > under low contention, so a mutex is not an outrageous choice here.
> > >
> > > A subset of test_vmalloc.sh performance results:-
> > >
> > > fix_size_alloc_test             0.40%
> > > full_fit_alloc_test		2.08%
> > > long_busy_list_alloc_test	0.34%
> > > random_size_alloc_test		-0.25%
> > > random_size_align_alloc_test	0.06%
> > > ...
> > > all tests cycles                0.2%
> > >
> > > This represents a tiny reduction in performance that sits barely above
> > > noise.
> >
> > I'm travelling right now, but give me a few days and I'll test this
> > against the XFS workloads that hammer the global vmalloc spin lock
> > really, really badly. XFS can use vm_map_ram and vmalloc really
> > heavily for metadata buffers and hit the global spin lock from every
> > CPU in the system at the same time (i.e. highly concurrent
> > workloads). vmalloc is also heavily used in the hottest path
> > throught the journal where we process and calculate delta changes to
> > several million items every second, again spread across every CPU in
> > the system at the same time.
> >
> > We really need the global spinlock to go away completely, but in the
> > mean time a shared read lock should help a little bit....
> >

Hugely appreciated Dave, however I must disappoint on the rwsem as I have now
reworked my patch set to use the original locks in order to satisfy Willy's
desire to make vmalloc atomic in future, and Uladzislau's desire to not have a
~6% performance hit -
https://lore.kernel.org/all/cover.1679354384.git.lstoakes@gmail.com/

> I am working on it. I submitted a proposal how to eliminate it:
>
>
> <snip>
> Hello, LSF.
>
> Title: Introduce a per-cpu-vmap-cache to eliminate a vmap lock contention
>
> Description:
>  Currently the vmap code is not scaled to number of CPU cores in a system
>  because a global vmap space is protected by a single spinlock. Such approach
>  has a clear bottleneck if many CPUs simultaneously access to one resource.
>
>  In this talk i would like to describe a drawback, show some data related
>  to contentions and places where those occur in a code. Apart of that i
>  would like to share ideas how to eliminate it providing a few approaches
>  and compare them.
>
> Requirements:
>  * It should be a per-cpu approach;
>  * Search of freed ptrs should not interfere with other freeing(as much as we can);
>  *   - offload allocated areas(buzy ones) per-cpu;
>  * Cache ready sized objects or merge them into one big per-cpu-space(split on demand);
>  * Lazily-freed areas either drained per-cpu individually or by one CPU for all;
>  * Prefetch a fixed size in front and allocate per-cpu
>
> Goals:
>  * Implement a per-cpu way of allocation to eliminate a contention.
>
> Thanks!
> <snip>
>
> --
> Uladzislau Rezki
>

That's really awesome! I will come to that talk at LSF/MM :) being able to
sustain the lock in atomic context seems to be an aspect that is important going
forward also.
