Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24F26F6365
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 05:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEDDdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 23:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEDDdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 23:33:44 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A49198D
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 20:33:41 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b996127ec71so49656276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 20:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683171221; x=1685763221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezowVIfZ+j5q5fnHBXFJgjQgqAlO13MfPXw7qEM899U=;
        b=lL+P1HWGx+y87/s7tJ3yJEOlJ9xZakfyxCZ/vj2vLDVlNBtKFp5TryG8cJdaJpBcY3
         guIC/GIEBTyQZrHE6ZNHiQ86VI1OapFezm0uE0T+1OK+K4KYYfBBjtbLybxs4JzubUJ/
         YHIYmrIrkP5sV/C/lw2aAB2KyoF9ze882p2X7gtWbJ7Ck0EEAHwV0AOp5iYiKP9dpnkl
         JG4AkClQv8a9C8JNwybz3M08XO+E4JFF6RNOKRacmV8gTFgw1n0DajrnRmLfrbF5RGNA
         oAFHvA1e8eD3Al3/gqVbjERe8sD7tl0wTSvmn2cJLhru0NU5xErhL5P5WdguSe6A94ip
         wwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683171221; x=1685763221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezowVIfZ+j5q5fnHBXFJgjQgqAlO13MfPXw7qEM899U=;
        b=KloaHgZyYeeyLWJC1j4PldwL7d127RwAtLS1cbDeGCmdCoQX9retwVBtJAwz3taStQ
         kxqyyDSdT9fXINoYfLXkv+xV+5hFkKuTBVc90F5FnHSvgYCHQCDAakojOdPQnK9WaK3z
         NPl2PTWT42zLvzjnfmC2koMaSkO7lNh6+OnrhrqZW/V98a5aDPXssB6GPGpdtYSentza
         hxZdCNm/BBQaVb1m8fdswuLnXG2O/AHgWlB7b1txtfTFadsjgD2zwfeASi1HeeTEPd6+
         TdENLkMruJtUlGG7vbv0xBQd1NPITlQej6w5joOODFVHZouBIQUAXZkz5XPMLB5u5Kqb
         ASLQ==
X-Gm-Message-State: AC+VfDzelkh9wp+D4+Yle9kW3CC85od84G7WRg74K93YHT1TXg3zXH7Z
        lglZJATyEuad4YYP3n9oBUH4sLFT1jFM5l8IUIMNVA==
X-Google-Smtp-Source: ACHHUZ45mGN+GR4nSu7Wa2mDPuzxUEEU0oecLdcE3XKkTt3qYSjVz+G7V7TA1b9va9C/DDvQwmfyGTeJUntbFTp86oM=
X-Received: by 2002:a25:b55:0:b0:ba1:8b5a:581e with SMTP id
 82-20020a250b55000000b00ba18b5a581emr1541686ybl.17.1683171220475; Wed, 03 May
 2023 20:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230503180726.GA196054@cmpxchg.org> <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org> <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org> <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
 <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
 <ZFK6pwOelIlhV8Bm@slm.duckdns.org> <ZFK9XMSzOBxIFOHm@slm.duckdns.org>
 <CAJuCfpE4YD_BumqFf2-NC8KS9D+kq0s_o4gRyWAH-WK4SgqUbA@mail.gmail.com> <ZFMXmj9ZhSe5wyaS@slm.duckdns.org>
In-Reply-To: <ZFMXmj9ZhSe5wyaS@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 20:33:28 -0700
Message-ID: <CAJuCfpGmc==xztXgiM+UUA5GGhxstB2r=yTjNUwSshaj5FpBFw@mail.gmail.com>
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

On Wed, May 3, 2023 at 7:25=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, May 03, 2023 at 01:14:57PM -0700, Suren Baghdasaryan wrote:
> > On Wed, May 3, 2023 at 1:00=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> > > Another related question. So, the reason for macro'ing stuff is neede=
d is
> > > because you want to print the line directly from kernel, right?
> >
> > The main reason is because we want to inject a code tag at the
> > location of the call. If we have a code tag injected at every
> > allocation call, then finding the allocation counter (code tag) to
> > operate takes no time.
> >
> > > Is that
> > > really necessary? Values from __builtin_return_address() can easily b=
e
> > > printed out as function+offset from kernel which already gives most o=
f the
> > > necessary information for triaging and mapping that back to source li=
ne from
> > > userspace isn't difficult. Wouldn't using __builtin_return_address() =
make
> > > the whole thing a lot simpler?
> >
> > If we do that we have to associate that address with the allocation
> > counter at runtime on the first allocation and look it up on all
> > following allocations. That introduces the overhead which we are
> > trying to avoid by using macros.
>
> I see. I'm a bit skeptical about the performance angle given that the hot
> path can be probably made really cheap even with lookups. In most cases,
> it's just gonna be an extra pointer deref and a few more arithmetics. Tha=
t
> can show up in microbenchmarks but it's not gonna be much. The benefit of
> going that route would be the tracking thing being mostly self contained.

I'm in the process of rerunning the tests to compare the overhead on
the latest kernel but I don't expect that to be cheap compared to
kmalloc().

>
> That said, it's nice to not have to worry about allocating tracking slots
> and managing hash table, so no strong opinion.
>
> Thanks.
>
> --
> tejun
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
