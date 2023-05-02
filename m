Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5AA6F3B37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 02:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjEBAMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 20:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjEBALT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 20:11:19 -0400
Received: from out-56.mta1.migadu.com (out-56.mta1.migadu.com [95.215.58.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF035B0
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 17:11:17 -0700 (PDT)
Date:   Mon, 1 May 2023 20:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682986273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LGkXxcXbL3GK/fmGgSEfCfzDoWKBFDwYj9o6aWx8/Qk=;
        b=Gmp5ZD9nZN0dN2JWve8TuEsBbpH3Qw6wtBbE0JR/AgDkC56d01L5iQ46Mavw7py6Vk9DfT
        amxHtlJ45eMzW84A+uK5Hfr4ox7Dnev1oJ2Yy8A+2WvibSyj4uUhf9gi+dGElANV/CAdFq
        T6mFJogh6K/S0EnKKXjo3GhiYGvkFTg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        willy@infradead.org, corbet@lwn.net, void@manifault.com,
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
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Noralf =?utf-8?B?VHLDr8K/wr1ubmVz?= <noralf@tronnes.org>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in
 string_get_size's output
Message-ID: <ZFBVFfNo3OHd3izd@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan>
 <CAHp75VeJ_a6j3uweLN5-woSQUtN5u36c2gkoiXhnJa1HXJdoyQ@mail.gmail.com>
 <20230501213349.bvbf6i72eepcd56m@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501213349.bvbf6i72eepcd56m@revolver>
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

On Mon, May 01, 2023 at 05:33:49PM -0400, Liam R. Howlett wrote:
> * Andy Shevchenko <andy.shevchenko@gmail.com> [230501 15:57]:
> This fixes the output to be better aligned with:
> the output of ls -sh
> the input expected by find -size
> 
> Are there counter-examples of commands that follow the SI Brochure?

Even perf, which is included in the kernel tree, doesn't include the
space - example perf top output:

0 bcachefs:move_extent_fail
0 bcachefs:move_extent_alloc_mem_fail
3 bcachefs:move_data
0 bcachefs:evacuate_bucket
0 bcachefs:copygc
2 bcachefs:copygc_wait
195K bcachefs:transaction_commit
0 bcachefs:trans_restart_injected

(I'm also going to need to submit a patch that deletes or makes optional
the B suffix, just because we're using human readable units doesn't mean
it's bytes).
