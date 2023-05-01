Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676046F3545
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjEARzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjEARzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:55:50 -0400
X-Greylist: delayed 505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 May 2023 10:55:49 PDT
Received: from out-4.mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0317319AC
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 10:55:48 -0700 (PDT)
Date:   Mon, 1 May 2023 10:47:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682963238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pCOJ4TIX11zw2jBaDOP97T7hx/pG0LP03OwHceiD+AE=;
        b=DiqG+Df4D+DZsn0wO9LjwkV/mLuZ3abtM/u+Nuamt3enIlxM0dOl/zDiGUemCbI1ba6Ge7
        UFxA8r7ovThZ0bL+PW2tO2CTjinF1Mnn4ax/lyq+OVwg8tX+hPdBw7CohOYds+psfqGMqa
        jFVVfskQ2Ze12DnahYd6juPiFkLzBag=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <ZE/7FZbd31qIzrOc@P9FQF9L96D>
References: <20230501165450.15352-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 01, 2023 at 09:54:10AM -0700, Suren Baghdasaryan wrote:
> Performance overhead:
> To evaluate performance we implemented an in-kernel test executing
> multiple get_free_page/free_page and kmalloc/kfree calls with allocation
> sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
> affinity set to a specific CPU to minimize the noise. Below is performance
> comparison between the baseline kernel, profiling when enabled, profiling
> when disabled (nomem_profiling=y) and (for comparison purposes) baseline
> with CONFIG_MEMCG_KMEM enabled and allocations using __GFP_ACCOUNT:
> 
> 			kmalloc			pgalloc
> Baseline (6.3-rc7)	9.200s			31.050s
> profiling disabled	9.800 (+6.52%)		32.600 (+4.99%)
> profiling enabled	12.500 (+35.87%)	39.010 (+25.60%)
> memcg_kmem enabled	41.400 (+350.00%)	70.600 (+127.38%)

Hm, this makes me think we have a regression with memcg_kmem in one of
the recent releases. When I measured it a couple of years ago, the overhead
was definitely within 100%.

Do you understand what makes the your profiling drastically faster than kmem?

Thanks!
