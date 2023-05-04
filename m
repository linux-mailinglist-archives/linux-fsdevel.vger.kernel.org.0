Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FD36F6EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjEDPIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjEDPId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 11:08:33 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7FD4227
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 08:08:26 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b99f0a0052fso873457276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 May 2023 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683212905; x=1685804905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpI3TgDyhkti03RqKX4aJ+LI47o/coVvQYc1czzI8zs=;
        b=FNofsLdv/+7cq18LESbrv72DxTOtLR7I9kjhPi1qP4Q3LOJM6z2Qwy4LxmeVOSRV1Z
         xK+g4AMIJhpry6DKZYI++Pk/k+tIoKY5MDlKbzPcxFqtpsTF9KyhL/CnMcUvTRQFU1XW
         s77y30fDpMQ0IAed3GmRXiG0b/uvK6WqPwJdfl0zE1KIt9+luKSvRC/QVW5PpatI86J1
         8Lleqs+mqleJV9W3YvOGElVKE+XmHEyvUzWjfiQlhf68dkmkvTC9QVzwaCMHP6HyYov0
         fyMfje9piFOaym+JTibnTPFGqcqfJtpyIPdeKRtc5PVjhwHQRxzmBvCsLDjcVSYkRaxf
         RH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212905; x=1685804905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpI3TgDyhkti03RqKX4aJ+LI47o/coVvQYc1czzI8zs=;
        b=Xmsz98iM3LT7IiEUgheg20KaAsFeaB+LIIGWzhz00DTfntvqk2Hwsjt2X1ep1Z3wXt
         FhDG6XKKnnsb2zbg0Gsh6V2yuWk2StqesD2EVXWLR7lfCeZzmDTHxI6Q7Cz1X/n/Djzn
         jS5Db2Efdh+rcwX4ERg60aS0576f09wMDaiQyjHdsV6tUFDG3y89P+S6mW18iRIgXfrl
         1ifbUoW8unvSXNFy20Uw1F+T/ZlS9gfIX+1htqC4OViqoEhT9aFy31VghiU3Zz/KSx2d
         o8Ns36ctN6AvH5F4oLfbIm+revFZaN2zUK7e84GZY0beNGLjW0lOfwW5m9/2vgpiTgND
         KxNw==
X-Gm-Message-State: AC+VfDzZyn8g1edgAJqsA/952KBYg1tWANtDypRhXU5EbgX+N7RXUdWS
        wwDezb+8Mzj3/QHpeXwN1Co2+tMVjpqe+XE1ASftvQ==
X-Google-Smtp-Source: ACHHUZ7hI7Vxo4JFi305ipzfOlYOUrc5ajrRHXdhnDh4eBp5Mjy+UHcFwOsphq83i8E2EemKBiNMD3DduEPsVwVmGlE=
X-Received: by 2002:a25:b21f:0:b0:ba1:78df:20fc with SMTP id
 i31-20020a25b21f000000b00ba178df20fcmr253521ybj.21.1683212905109; Thu, 04 May
 2023 08:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com> <ZFN1yswCd9wRgYPR@dhcp22.suse.cz>
In-Reply-To: <ZFN1yswCd9wRgYPR@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 4 May 2023 08:08:13 -0700
Message-ID: <CAJuCfpEkV_+pAjxyEpMqY+x7buZhSpj5qDF6KubsS=ObrQKUZg@mail.gmail.com>
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

On Thu, May 4, 2023 at 2:07=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 03-05-23 08:09:28, Suren Baghdasaryan wrote:
> > On Wed, May 3, 2023 at 12:25=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> [...]
> > Thanks for summarizing!
> >
> > > At least those I find the most important:
> > > - This is a big change and it adds a significant maintenance burden
> > >   because each allocation entry point needs to be handled specificall=
y.
> > >   The cost will grow with the intended coverage especially there when
> > >   allocation is hidden in a library code.
> >
> > Do you mean with more allocations in the codebase more codetags will
> > be generated? Is that the concern?
>
> No. I am mostly concerned about the _maintenance_ overhead. For the
> bare tracking (without profiling and thus stack traces) only those
> allocations that are directly inlined into the consumer are really
> of any use. That increases the code impact of the tracing because any
> relevant allocation location has to go through the micro surgery.
>
> e.g. is it really interesting to know that there is a likely memory
> leak in seq_file proper doing and allocation? No as it is the specific
> implementation using seq_file that is leaking most likely. There are
> other examples like that See?

Yes, I see that. One level tracking does not provide all the
information needed to track such issues. Something more informative
would cost more. That's why our proposal is to have a light-weight
mechanism to get a high level picture and then be able to zoom into a
specific area using context capture. If you have ideas to improve
this, I'm open to suggestions.

>
> > Or maybe as you commented in
> > another patch that context capturing feature does not limit how many
> > stacks will be captured?
>
> That is a memory overhead which can be really huge and it would be nice
> to be more explicit about that in the cover letter. It is a downside for
> sure but not something that has a code maintenance impact and it is an
> opt-in so it can be enabled only when necessary.

You are right, I'll add that into the cover letter.

>
> Quite honestly, though, the more I look into context capturing part it
> seems to me that there is much more to be reconsidered there and if you
> really want to move forward with the code tagging part then you should
> drop that for now. It would make the whole series smaller and easier to
> digest.

Sure, I don't see an issue with removing that for now and refining the
mechanism before posting again.

>
> > > - It has been brought up that this is duplicating functionality alrea=
dy
> > >   available via existing tracing infrastructure. You should make it v=
ery
> > >   clear why that is not suitable for the job
> >
> > I experimented with using tracing with _RET_IP_ to implement this
> > accounting. The major issue is the _RET_IP_ to codetag lookup runtime
> > overhead which is orders of magnitude higher than proposed code
> > tagging approach. With code tagging proposal, that link is resolved at
> > compile time. Since we want this mechanism deployed in production, we
> > want to keep the overhead to the absolute minimum.
> > You asked me before how much overhead would be tolerable and the
> > answer will always be "as small as possible". This is especially true
> > for slab allocators which are ridiculously fast and regressing them
> > would be very noticable (due to the frequent use).
>
> It would have been more convincing if you had some numbers at hands.
> E.g. this is a typical workload we are dealing with. With the compile
> time tags we are able to learn this with that much of cost. With a dynami=
c
> tracing we are able to learn this much with that cost. See? As small as
> possible is a rather vague term that different people will have a very
> different idea about.

I'm rerunning my tests with the latest kernel to collect the
comparison data. I profiled these solutions before but the kernel
changed since then, so I need to update them.

>
> > There is another issue, which I think can be solved in a smart way but
> > will either affect performance or would require more memory. With the
> > tracing approach we don't know beforehand how many individual
> > allocation sites exist, so we have to allocate code tags (or similar
> > structures for counting) at runtime vs compile time. We can be smart
> > about it and allocate in batches or even preallocate more than we need
> > beforehand but, as I said, it will require some kind of compromise.
>
> I have tried our usual distribution config (only vmlinux without modules
> so the real impact will be larger as we build a lot of stuff into
> modules) just to get an idea:
>    text    data     bss     dec     hex filename
> 28755345        17040322        19845124        65640791        3e99957 v=
mlinux.before
> 28867168        17571838        19386372        65825378        3ec6a62 v=
mlinux.after
>
> Less than 1% for text 3% for data.  This is not all that terrible
> for an initial submission and a more dynamic approach could be added
> later. E.g. with a smaller pre-allocated hash table that could be
> expanded lazily. Anyway not something I would be losing sleep over. This
> can always be improved later on.

Ah, right. I should have mentioned this overhead too. Thanks for
keeping me honest.

> > I understand that code tagging creates additional maintenance burdens
> > but I hope it also produces enough benefits that people will want
> > this. The cost is also hopefully amortized when additional
> > applications like the ones we presented in RFC [1] are built using the
> > same framework.
>
> TBH I am much more concerned about the maintenance burden on the MM side
> than the actual code tagging itslef which is much more self contained. I
> haven't seen other potential applications of the same infrastructure and
> maybe the code impact would be much smaller than in the MM proper. Our
> allocator API is really hairy and convoluted.

Yes, other applications are much smaller and cleaner. MM allocation
code is quite complex indeed.

>
> > > - We already have page_owner infrastructure that provides allocation
> > >   tracking data. Why it cannot be used/extended?
> >
> > 1. The overhead.
>
> Do you have any numbers?

Will post once my tests are completed.

>
> > 2. Covers only page allocators.
>
> Yes this sucks.
> >
> > I didn't think about extending the page_owner approach to slab
> > allocators but I suspect it would not be trivial. I don't see
> > attaching an owner to every slab object to be a scalable solution. The
> > overhead would again be of concern here.
>
> This would have been a nice argument to mention in the changelog so that
> we know that you have considered that option at least. Why should I (as
> a reviewer) wild guess that?

Sorry, It's hard to remember all the decisions, discussions and
conclusions when working on a feature over a long time period. I'll
include more information about that.

>
> > I should point out that there was one important technical concern
> > about lack of a kill switch for this feature, which was an issue for
> > distributions that can't disable the CONFIG flag. In this series we
> > addressed that concern.
>
> Thanks, that is certainly appreciated. I haven't looked deeper into that
> part but from the cover letter I have understood that CONFIG_MEM_ALLOC_PR=
OFILING
> implies unconditional page_ext and therefore the memory overhead
> assosiated with that. There seems to be a killswitch nomem_profiling but
> from a quick look it doesn't seem to disable page_ext allocations. I
> might be missing something there of course. Having a highlevel
> describtion for that would be really nice as well.

Right, will add a description of that as well.
We eliminate the runtime overhead but not the memory one. However I
believe it's also doable using page_ext_operations.need callback. Will
look into it.
Thanks,
Suren.

>
> > [1] https://lore.kernel.org/all/20220830214919.53220-1-surenb@google.co=
m/
>
> --
> Michal Hocko
> SUSE Labs
