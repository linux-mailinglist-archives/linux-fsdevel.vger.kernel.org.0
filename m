Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9EE6F5AAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjECPJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 11:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjECPJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 11:09:44 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5504C01
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 08:09:41 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9e66ce80acso3183049276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683126580; x=1685718580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njkpY9V26txLi7xPErO/sERUlWcV1pHNyq5uOqiF2eY=;
        b=VExKdzK5WEHsMwlEvyXIbTAR60TSGl0weEuYF33kbqADYhPEKMB5BFVn748WX7nHdJ
         1ZlyCGGXJGu0YiWNCyZl5XyfyFi2tpLKda0+fB339jPRw/X0v46Au/FFd5+OD8pJxpRY
         +KkUzelDcKShio3avgpuSPMVkLeLPhlOjJQMnrVxm4Zf0u/pZ6cnJgNCbvz6qY3fWGrt
         1Vm4vafoXe+OM0WR4hPTdkalQ5gy1bMCwNEAd6xNhQ1f8Ie8DIosbbc/QS5C38of78Fb
         mqBoNYXzOBoZSmrx1Vo6JKftamzpTKOZAz7AVyV44cWc+5yFoj7tdjzyxk27OuKklV1Q
         3kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126580; x=1685718580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njkpY9V26txLi7xPErO/sERUlWcV1pHNyq5uOqiF2eY=;
        b=HHMh8Ie6i+68uFE51RpM5mBSeb/kvIAcCKIFcxsZJiIQZkVOcuzL2x7JdgAAwrk0d7
         Bgm3fwrWRcA/le+m6VW46kKCsW6cV48zCrN7Nu3TaGCukIB4Ea/jlDe3n53NNKcxBuzz
         Jg89kBLYPuBOJ5C2RIY0L71wBX4TMRbA0qCxR85qxpZUcUp7Vj3E9JWAyxjR9CA+U6dF
         A/uYoCUP3rM5ZlyAYYLLSn+jQPKWAmJBLnvmnERW4hCDYXLvFPVUE2tb/vqnWjRuEqPo
         YxytdvO8AR8GuUmvXQoMjui0ayG9iTwQ2C+tqROKyLMzXRqWDc6AFXixh+9YSbst+nCI
         aBEg==
X-Gm-Message-State: AC+VfDzVEowjM3TENLAFXNBiDOI4Y6WQ9hsVXmy8lxF9YYU6m/mAsY35
        xFXkGAlXmPpja0kmouxG53uU6lSM6AHOADMw+LEdyQ==
X-Google-Smtp-Source: ACHHUZ7hchC+rRk961tvHRqEu26jTqqMGmIvsUJgIGP7Wi8Xmqgc6hTnmpP8bu8bBbAHqpv8p0ou1nAieiF4VLsALvc=
X-Received: by 2002:a25:dc4a:0:b0:b9f:1992:112e with SMTP id
 y71-20020a25dc4a000000b00b9f1992112emr4038060ybe.9.1683126580275; Wed, 03 May
 2023 08:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
In-Reply-To: <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 08:09:28 -0700
Message-ID: <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 3, 2023 at 12:25=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 01-05-23 09:54:10, Suren Baghdasaryan wrote:
> > Memory allocation profiling infrastructure provides a low overhead
> > mechanism to make all kernel allocations in the system visible. It can =
be
> > used to monitor memory usage, track memory hotspots, detect memory leak=
s,
> > identify memory regressions.
> >
> > To keep the overhead to the minimum, we record only allocation sizes fo=
r
> > every allocation in the codebase. With that information, if users are
> > interested in more detailed context for a specific allocation, they can
> > enable in-depth context tracking, which includes capturing the pid, tgi=
d,
> > task name, allocation size, timestamp and call stack for every allocati=
on
> > at the specified code location.
> [...]
> > Implementation utilizes a more generic concept of code tagging, introdu=
ced
> > as part of this patchset. Code tag is a structure identifying a specifi=
c
> > location in the source code which is generated at compile time and can =
be
> > embedded in an application-specific structure. A number of applications
> > for code tagging have been presented in the original RFC [1].
> > Code tagging uses the old trick of "define a special elf section for
> > objects of a given type so that we can iterate over them at runtime" an=
d
> > creates a proper library for it.
> >
> > To profile memory allocations, we instrument page, slab and percpu
> > allocators to record total memory allocated in the associated code tag =
at
> > every allocation in the codebase. Every time an allocation is performed=
 by
> > an instrumented allocator, the code tag at that location increments its
> > counter by allocation size. Every time the memory is freed the counter =
is
> > decremented. To decrement the counter upon freeing, allocated object ne=
eds
> > a reference to its code tag. Page allocators use page_ext to record thi=
s
> > reference while slab allocators use memcg_data (renamed into more gener=
ic
> > slabobj_ext) of the slab page.
> [...]
> > [1] https://lore.kernel.org/all/20220830214919.53220-1-surenb@google.co=
m/
> [...]
> >  70 files changed, 2765 insertions(+), 554 deletions(-)
>
> Sorry for cutting the cover considerably but I believe I have quoted the
> most important/interesting parts here. The approach is not fundamentally
> different from the previous version [1] and there was a significant
> discussion around this approach. The cover letter doesn't summarize nor
> deal with concerns expressed previous AFAICS. So let me bring those up
> back.

Thanks for summarizing!

> At least those I find the most important:
> - This is a big change and it adds a significant maintenance burden
>   because each allocation entry point needs to be handled specifically.
>   The cost will grow with the intended coverage especially there when
>   allocation is hidden in a library code.

Do you mean with more allocations in the codebase more codetags will
be generated? Is that the concern? Or maybe as you commented in
another patch that context capturing feature does not limit how many
stacks will be captured?

> - It has been brought up that this is duplicating functionality already
>   available via existing tracing infrastructure. You should make it very
>   clear why that is not suitable for the job

I experimented with using tracing with _RET_IP_ to implement this
accounting. The major issue is the _RET_IP_ to codetag lookup runtime
overhead which is orders of magnitude higher than proposed code
tagging approach. With code tagging proposal, that link is resolved at
compile time. Since we want this mechanism deployed in production, we
want to keep the overhead to the absolute minimum.
You asked me before how much overhead would be tolerable and the
answer will always be "as small as possible". This is especially true
for slab allocators which are ridiculously fast and regressing them
would be very noticable (due to the frequent use).

There is another issue, which I think can be solved in a smart way but
will either affect performance or would require more memory. With the
tracing approach we don't know beforehand how many individual
allocation sites exist, so we have to allocate code tags (or similar
structures for counting) at runtime vs compile time. We can be smart
about it and allocate in batches or even preallocate more than we need
beforehand but, as I said, it will require some kind of compromise.

I understand that code tagging creates additional maintenance burdens
but I hope it also produces enough benefits that people will want
this. The cost is also hopefully amortized when additional
applications like the ones we presented in RFC [1] are built using the
same framework.

> - We already have page_owner infrastructure that provides allocation
>   tracking data. Why it cannot be used/extended?

1. The overhead.
2. Covers only page allocators.

I didn't think about extending the page_owner approach to slab
allocators but I suspect it would not be trivial. I don't see
attaching an owner to every slab object to be a scalable solution. The
overhead would again be of concern here.

I should point out that there was one important technical concern
about lack of a kill switch for this feature, which was an issue for
distributions that can't disable the CONFIG flag. In this series we
addressed that concern.

[1] https://lore.kernel.org/all/20220830214919.53220-1-surenb@google.com/

Thanks,
Suren.

>
> Thanks!
> --
> Michal Hocko
> SUSE Labs
