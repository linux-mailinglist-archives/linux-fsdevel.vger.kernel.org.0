Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516546F5FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjECUP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjECUPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:15:54 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA78D4EFF
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 13:15:24 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55af4277904so24862247b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683144920; x=1685736920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJv5xHBTJjNv/pix2rgh9sMW7sCnrk66nOy29HPAlus=;
        b=UCO8xAxPQELEnJ5Z/+6POOiyN0vC8Y3LS4oWyDMuhEhZvFzcfiun+ebWGPwrO+pD6P
         oaWSGqmefHbl5lAEiPf5lmUVnYEfPjsrvltc8OpHClJDRLqR0c6JCt2K4/o8XHiKCVdf
         J53ZnSfM4WQ/BqrKp+eVl6M1p/n6Qe+G3n50PB19Uzdxt6cKRczUS8ApWupvLyGowGSr
         nGY8DkG6nB+Z74vkrN7ka4kE+r+AVY9ut3CcNzBfOZ5eIHL+qS/vkhlLgZTTLFk7Q8GU
         5cYkPlXWlkK/9gZow1krRfzsVVYIijdz+900Nl7CuaPdx5c8WOD0aSivErWELXWkx49V
         I4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683144920; x=1685736920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJv5xHBTJjNv/pix2rgh9sMW7sCnrk66nOy29HPAlus=;
        b=Xqri7JjTeBa0Z5QCfu4DkxrszwYK/CSC29ED9Zby+l763/habSNG6oxF0TGnov8tuc
         oZrJvQ7xUyXWEsYegz3OmseD4YpSrVkrmZnWhiflC6Uz+ulL8hlIMHvlb6RD3ak0DjWH
         ErTfPczbwlusqMQBQXD9PLjpfdUoPMuhgpzULQF9s1ylIPAz+cZG0LbR/2mzxI7ko5Ji
         sJmHwwFZ7kCQp+w8xG9sXcNWVmi9kg9NWS0joG9Jefi5u8RXUwq7vR0ygf3Owk0GuDXY
         D1A9H7b8n7ZA/A//OnmcrHRkNArLtr6qPPNQAXH+5wU03KUSstvFgmhKWNTTVB8KfNIC
         c0Nw==
X-Gm-Message-State: AC+VfDzgL4/MNyqHCsA7voMmW7JSZuqDWt2iWtpRNDAkeXYQBZ/dzxMV
        Uv+TZmgZwxeTCYQXCogPeXdq+55bJO21zVB/JOOirg==
X-Google-Smtp-Source: ACHHUZ7mImQ/1wXTYz0SIgMaa2LSNhSdXyURzMfJt6GpNMGuq33NeGKiMX4mFybM8LMTHwiJs7q6jFVMM1TC3F7btJ0=
X-Received: by 2002:a25:2b45:0:b0:b8e:db20:eccf with SMTP id
 r66-20020a252b45000000b00b8edb20eccfmr22508398ybr.55.1683144919429; Wed, 03
 May 2023 13:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <ZFIVtB8JyKk0ddA5@moria.home.lan> <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org> <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org> <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org> <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
 <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
 <ZFK6pwOelIlhV8Bm@slm.duckdns.org> <ZFK9XMSzOBxIFOHm@slm.duckdns.org>
In-Reply-To: <ZFK9XMSzOBxIFOHm@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 13:14:57 -0700
Message-ID: <CAJuCfpE4YD_BumqFf2-NC8KS9D+kq0s_o4gRyWAH-WK4SgqUbA@mail.gmail.com>
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

On Wed, May 3, 2023 at 1:00=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, May 03, 2023 at 09:48:55AM -1000, Tejun Heo wrote:
> > > If so, that's the idea behind the context capture feature so that we
> > > can enable it on specific allocations only after we determine there i=
s
> > > something interesting there. So, with low-cost persistent tracking we
> > > can determine the suspects and then pay some more to investigate thos=
e
> > > suspects in more detail.
> >
> > Yeah, I was wondering whether it'd be useful to have that configurable =
so
> > that it'd be possible for a user to say "I'm okay with the cost, please
> > track more context per allocation". Given that tracking the immediate c=
aller
> > is already a huge improvement and narrowing it down from there using
> > existing tools shouldn't be that difficult, I don't think this is a blo=
cker
> > in any way. It just bothers me a bit that the code is structured so tha=
t
> > source line is the main abstraction.
>
> Another related question. So, the reason for macro'ing stuff is needed is
> because you want to print the line directly from kernel, right?

The main reason is because we want to inject a code tag at the
location of the call. If we have a code tag injected at every
allocation call, then finding the allocation counter (code tag) to
operate takes no time.

> Is that
> really necessary? Values from __builtin_return_address() can easily be
> printed out as function+offset from kernel which already gives most of th=
e
> necessary information for triaging and mapping that back to source line f=
rom
> userspace isn't difficult. Wouldn't using __builtin_return_address() make
> the whole thing a lot simpler?

If we do that we have to associate that address with the allocation
counter at runtime on the first allocation and look it up on all
following allocations. That introduces the overhead which we are
trying to avoid by using macros.

>
> Thanks.
>
> --
> tejun
