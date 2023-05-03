Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9D96F5F5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjECTpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 15:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjECTpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 15:45:42 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EF67AA0
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 12:45:41 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9e66ce80acso3619587276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683143140; x=1685735140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq44fWKfzB7azpC5445h4zSgjB+E0XG23Sx5k3P/Wrs=;
        b=mNn8mOJ969yUibKfAWrXgatuIFi6FVIM4EsSSH9KQ1Go4d1sYzKZHUi8VHjbX6pfWa
         OlJ16nZGAbvURg1kkDTdEvJDfJPD2YhA8jF3Bo81PkL1ob0v9cS2gkR4gCqMlpmjnr/s
         tWs9Fu3MohlaypLe2rIvRSkpy7E5gp65K6pp8163QEUwdmBPDYTBTVK0GaffIx+/jWG1
         GkJ4oD48JkxrW+rrbEhXrrnBxumK3LN05X4J4kXdI0k+pYkkAnfDQi3ANZniOpY63cWz
         Q+VUnUlPsKkbZjKcze+vAukdxm3Nrif9W+zvOKGcMfCU5FAKE+MOBW4LpPVOFpo/QEqA
         mUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683143140; x=1685735140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq44fWKfzB7azpC5445h4zSgjB+E0XG23Sx5k3P/Wrs=;
        b=A9Qg/DjYH5lVlb4Mco6TcDr1Jyvw1DN5h3a7AqyvIsOxASJUILoWawKe9HJUBh7fBN
         HcBw3mqhOreLA6cLxF3TRlM+SH1eumWTUnt//FB5T18PItpWQlGas6+c5IGivZxR1G0v
         9qHkHS4G45lvNy6fR8NMGODigSkFlMe+sSCXITDCZfLzLVu9+/kaeeuKhbIF+YD/pVl/
         wkvU9Tba63nBXrbOHyjRKrMGyR2bYu7yyt6PMYi+2X8yGkeq+OpYYhJceIwWYC3gxxyq
         T2DastoJgSqSePUwi/zFRZGhYYZCETwZRpcbTrRB5E9DoFTCdvNp80sYenero9GJCcSL
         /K7A==
X-Gm-Message-State: AC+VfDxEx4OrTNsZTvLdbr8H+Mdcw7HtrmoXfkheg7DEQ1U77I4PqCt1
        u95l6fer9E6cd3AKTkTBVN1sE+et8v01rFZ2uxXw3g==
X-Google-Smtp-Source: ACHHUZ611vK/8POrb92/ZC137MJ/7lfkX+qvV2x7CR/VSAZxV6421Yhl76g7YvjnquNOZJwUgKJzKQx8X6OL1TqAAdQ=
X-Received: by 2002:a25:4f86:0:b0:b9a:9ad4:1d3 with SMTP id
 d128-20020a254f86000000b00b9a9ad401d3mr18494816ybb.5.1683143140255; Wed, 03
 May 2023 12:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-35-surenb@google.com>
 <ZFIO3tXCbmTn53uv@dhcp22.suse.cz> <CAJuCfpHrZ4kWYFPvA3W9J+CmNMuOtGa_ZMXE9fOmKsPQeNt2tg@mail.gmail.com>
 <b8ab89e6-0456-969d-ed31-fa64be0a0fd0@intel.com>
In-Reply-To: <b8ab89e6-0456-969d-ed31-fa64be0a0fd0@intel.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 12:45:29 -0700
Message-ID: <CAJuCfpGq4CjFLJ=QdQZUJPN72ecvWhVi_vUKrOz5_DvMAM07EQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] lib: code tagging context capture support
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
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

On Wed, May 3, 2023 at 8:26=E2=80=AFAM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 5/3/23 08:18, Suren Baghdasaryan wrote:
> >>> +static inline void rem_ctx(struct codetag_ctx *ctx,
> >>> +                        void (*free_ctx)(struct kref *refcount))
> >>> +{
> >>> +     struct codetag_with_ctx *ctc =3D ctx->ctc;
> >>> +
> >>> +     spin_lock(&ctc->ctx_lock);
> >> This could deadlock when allocator is called from the IRQ context.
> > I see. spin_lock_irqsave() then?
>
> Yes.  But, even better, please turn on lockdep when you are testing.  It
> will find these for you.  If you're on x86, we have a set of handy-dandy
> debug options that you can add to an existing config with:
>
>         make x86_debug.config

Nice!
I thought I tested with lockdep enabled but I might be wrong. The
beauty of working on multiple patchsets in parallel is that I can't
remember what I did for each one :)

>
> That said, I'm as concerned as everyone else that this is all "new" code
> and doesn't lean on existing tracing or things like PAGE_OWNER enough.

Yeah, that's being actively discussed.

>
