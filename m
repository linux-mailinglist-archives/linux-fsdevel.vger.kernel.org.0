Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DE56F5FB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjECUI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjECUI4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:08:56 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824535BAB
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 13:08:53 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so5395631276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683144532; x=1685736532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaEl0+ttAfDVYkQkgOF9inVIlQxPo4MAHa3r5TcHPqs=;
        b=ZBFmhNUtx4spDPZ2Tc+ao7Umap1oUxGgS6L35zoiaIlLMa3sbvfe1yyzPgLcae3Fty
         gA+quo34T7AKstKRwlQ7/Ft2WrnkU+rEhs/+hqpbEUBx2dmlPORy4QLjme1jFVo6xrFm
         5ILD7V5NtcxuXC6YpDb35KI9Z72miAAGUfujh1KI5hzn6IQVZLP/6kKOSaDUuTufQ8Ku
         q+1OYE8Cg6APTP1NiSWm7QBLpXw9UsuF2OAhdSzB2PChvOsgj7ZoUWNOcF4i8/Nlqo2k
         4O1C3AV8COhnBUUJ7YqqIWrgXPcexM0yzg0bdV03LGdXCG1g+DB8aKT153Xkp0dZ7AtK
         Zo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683144532; x=1685736532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaEl0+ttAfDVYkQkgOF9inVIlQxPo4MAHa3r5TcHPqs=;
        b=clzzz2e0pvLIDTHiXVGVoKbkbmiko/XyvsNd0xtbj24cyG2NTUCKjwry1l1MXfcjhr
         J4T31m+HbkcL8P4ByH6oUiEVJjdG92GZCe/G4jnDnhb1haR7GZfLC2569Eav0J3ADyvP
         m2CwzJqHunC/P2bMNS/eXwa4Fn218uRflyEHFaNNbHCNLhQEHjw2PjCy8gSnlZ3xy5Vv
         YKCdwV+5Sn3eWjFHxKiImaKPzNk6qiIh+UJE2GlLdlwST0shwyLr3JjWKXTxwcKZWo1h
         042Jiqb2mgPUDCJVkYgippxXGQQjiFPyhhTOvPzd8R5UIbGksHjyfndnqx/+hOpVIAI5
         eJdg==
X-Gm-Message-State: AC+VfDwYplJPJ4KGDTG/qygaNU1Mjqi5/+A68wysmiG7fo8E5RDdKKhL
        2oVWZO1Xh/CQckTJgB3e/zAZafu+bsW1lpkmrgQs9Q==
X-Google-Smtp-Source: ACHHUZ5Zgn5KmLsK0xUXMtQ1V3cIfppdzeEQFI0bWMD7MbEWCqGn353J4Os9Iuap9y2I3NsIHQCGkXzmHh1rNAt3fns=
X-Received: by 2002:a25:3450:0:b0:b9d:9f6e:f1d5 with SMTP id
 b77-20020a253450000000b00b9d9f6ef1d5mr3049024yba.16.1683144532379; Wed, 03
 May 2023 13:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <ZFISlX+mSx4QJDK6@dhcp22.suse.cz> <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org> <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org> <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan> <ZFKu6zWA00AzArMF@slm.duckdns.org>
 <ZFKxcfqkUQ60zBB_@slm.duckdns.org> <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
 <ZFK6pwOelIlhV8Bm@slm.duckdns.org>
In-Reply-To: <ZFK6pwOelIlhV8Bm@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 13:08:40 -0700
Message-ID: <CAJuCfpG4TmRpT5iU7bJmKcjW2Tghstdo1b=qEG=tDsmtJQYuWA@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To:     Tejun Heo <tj@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, muchun.song@linux.dev,
        rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
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
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Wed, May 3, 2023 at 12:49=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, May 03, 2023 at 12:41:08PM -0700, Suren Baghdasaryan wrote:
> > On Wed, May 3, 2023 at 12:09=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > On Wed, May 03, 2023 at 08:58:51AM -1000, Tejun Heo wrote:
> > > > On Wed, May 03, 2023 at 02:56:44PM -0400, Kent Overstreet wrote:
> > > > > On Wed, May 03, 2023 at 08:40:07AM -1000, Tejun Heo wrote:
> > > > > > > Yeah, easy / default visibility argument does make sense to m=
e.
> > > > > >
> > > > > > So, a bit of addition here. If this is the thrust, the debugfs =
part seems
> > > > > > rather redundant, right? That's trivially obtainable with traci=
ng / bpf and
> > > > > > in a more flexible and performant manner. Also, are we happy wi=
th recording
> > > > > > just single depth for persistent tracking?
> >
> > IIUC, by single depth you mean no call stack capturing?
>
> Yes.
>
> > If so, that's the idea behind the context capture feature so that we
> > can enable it on specific allocations only after we determine there is
> > something interesting there. So, with low-cost persistent tracking we
> > can determine the suspects and then pay some more to investigate those
> > suspects in more detail.
>
> Yeah, I was wondering whether it'd be useful to have that configurable so
> that it'd be possible for a user to say "I'm okay with the cost, please
> track more context per allocation".

I assume by "more context per allocation" you mean for a specific
allocation, not for all allocations.
So, in a sense you are asking if the context capture feature can be
dropped from this series and implemented using some other means. Is
that right?

> Given that tracking the immediate caller
> is already a huge improvement and narrowing it down from there using
> existing tools shouldn't be that difficult, I don't think this is a block=
er
> in any way. It just bothers me a bit that the code is structured so that
> source line is the main abstraction.
>
> > > > > Not sure what you're envisioning?
> > > > >
> > > > > I'd consider the debugfs interface pretty integral; it's much mor=
e
> > > > > discoverable for users, and it's hardly any code out of the whole
> > > > > patchset.
> > > >
> > > > You can do the same thing with a bpftrace one liner tho. That's rat=
her
> > > > difficult to beat.
> >
> > debugfs seemed like a natural choice for such information. If another
> > interface is more appropriate I'm happy to explore that.
> >
> > >
> > > Ah, shit, I'm an idiot. Sorry. I thought allocations was under /proc =
and
> > > allocations.ctx under debugfs. I meant allocations.ctx is redundant.
> >
> > Do you mean that we could display allocation context in
> > debugfs/allocations file (for the allocations which we explicitly
> > enabled context capturing)?
>
> Sorry about the fumbled communication. Here's what I mean:
>
> * Improving memory allocation visibility makes sense to me. To me, a more
>   natural place for that feels like /proc/allocations next to other memor=
y
>   info files rather than under debugfs.

TBH I would love that if this approach is acceptable.

>
> * The default visibility provided by "allocations" provides something whi=
ch
>   is more difficult or at least cumbersome to obtain using existing traci=
ng
>   tools. However, what's provided by "allocations.ctx" can be trivially
>   obtained using kprobe and BPF and seems redundant.

Hmm. That might be a good way forward. Since context capture has
already high performance overhead, maybe choosing not the most
performant but more generic solution is the right answer here. I'll
need to think about it some more but thanks for the idea!

>
> Thanks.
>
> --
> tejun
