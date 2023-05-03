Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6103D6F5F4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 21:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjECTlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjECTlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 15:41:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C127DA8
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 12:41:21 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9ef06cb784so2160070276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683142881; x=1685734881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eRiiP2JCtlxvX+BHzTjXxhFfE3xb3L5Tko5xVivHIc=;
        b=njnY9/ZTWcA0YQLoTf3TUMfGQMs6qBR8x/WiO3YJ4m2rgzn9gPgiVmWeEd3meHgQOd
         veIE13lp/BEBibiOOZUNO+WD2iQQwInbq0mORyd3+wLWSUTFkhmbMs6fl3Tqmd3D0D5p
         V+y4b3/jKL+G7UEO8JQopzaWcrHdBR+imlq/VrwTOp1569eYFHFfi9pD7I53OyaoPSYd
         tj72nQLogAXIm5Pv95noTQ1YRpRrtHa+Dymto/1ndku51s0fuH/R0nkRvqq+7WbyeTBe
         or08gvlkQ55RtNC4M9pq8YNpCVr1Dsrvti1RMiJ42Ynp3MHUq3DPU/4MOuwmbk5VuygM
         Oy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683142881; x=1685734881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eRiiP2JCtlxvX+BHzTjXxhFfE3xb3L5Tko5xVivHIc=;
        b=FBhlbpynZpvXmVeY3DNT88nqUpHFQwL3QYuET1m2i9A9sM9Sx0S4uVJislsxggkCni
         4t54zOxEiW07z3X8daNebabtzZ1A9wHpebNBx8qD4lSkhiU7eTiSDcK3R9JWdAmpEFBx
         +hFJ/b6mSov68xM4dWp15wfm6qW9aqOuq5tMbn4JRP1GN2WH65tKKgRfv/iwNpCFsca8
         lCryVgddOwT1ZdSz/VILvsU55DOh3jcrqmcJzly3fqjKWN63WOmyu1r15aX1v1d0kfwE
         HTk64iOzcXFD77jDOPCEVmSwMmzX7V6tRq5h+CaMlJN1ATdkDMR/CaRgYWYvOYTD05Tx
         9Kjw==
X-Gm-Message-State: AC+VfDytXA6dj01SpbJulRcu5qn3WH4d39BKhBUU3EtUCFxe+tGm59af
        P6S2/2s/u7tSWST6Ug8QLRMzPq6pCJSUMoysJ+j4wQ==
X-Google-Smtp-Source: ACHHUZ4RFT+eYjp8zpqFQpuduTlyNDeYqB8fD0xjOEnMllgaLgM5ug7v5zBN549JMpsUAooBfYdYqk6S3BpMrYkFeqQ=
X-Received: by 2002:a25:308a:0:b0:b9a:38b2:8069 with SMTP id
 w132-20020a25308a000000b00b9a38b28069mr18330170ybw.6.1683142880244; Wed, 03
 May 2023 12:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <ZFIMaflxeHS3uR/A@dhcp22.suse.cz> <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz> <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org> <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org> <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan> <ZFKu6zWA00AzArMF@slm.duckdns.org> <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
In-Reply-To: <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 12:41:08 -0700
Message-ID: <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
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

On Wed, May 3, 2023 at 12:09=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, May 03, 2023 at 08:58:51AM -1000, Tejun Heo wrote:
> > On Wed, May 03, 2023 at 02:56:44PM -0400, Kent Overstreet wrote:
> > > On Wed, May 03, 2023 at 08:40:07AM -1000, Tejun Heo wrote:
> > > > > Yeah, easy / default visibility argument does make sense to me.
> > > >
> > > > So, a bit of addition here. If this is the thrust, the debugfs part=
 seems
> > > > rather redundant, right? That's trivially obtainable with tracing /=
 bpf and
> > > > in a more flexible and performant manner. Also, are we happy with r=
ecording
> > > > just single depth for persistent tracking?

IIUC, by single depth you mean no call stack capturing?
If so, that's the idea behind the context capture feature so that we
can enable it on specific allocations only after we determine there is
something interesting there. So, with low-cost persistent tracking we
can determine the suspects and then pay some more to investigate those
suspects in more detail.

> > >
> > > Not sure what you're envisioning?
> > >
> > > I'd consider the debugfs interface pretty integral; it's much more
> > > discoverable for users, and it's hardly any code out of the whole
> > > patchset.
> >
> > You can do the same thing with a bpftrace one liner tho. That's rather
> > difficult to beat.

debugfs seemed like a natural choice for such information. If another
interface is more appropriate I'm happy to explore that.

>
> Ah, shit, I'm an idiot. Sorry. I thought allocations was under /proc and
> allocations.ctx under debugfs. I meant allocations.ctx is redundant.

Do you mean that we could display allocation context in
debugfs/allocations file (for the allocations which we explicitly
enabled context capturing)?

>
> Thanks.
>
> --
> tejun
