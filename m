Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509A66F6DC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 16:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjEDObW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEDObU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 10:31:20 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EEA8A6B
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 07:31:18 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9a824c3a95so790274276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 May 2023 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683210677; x=1685802677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JS6msPuToyJynO3sTVIKpHDiqUqJNNgVeQDo4ExI+FY=;
        b=B5odhRz5pl82Qodj9r2guUYfauBi1/TsFjLxRQqEz3zjcJjd//DMmZjNJKPPi7+nQ5
         xuKBZ6j/WQW0W3dcKfsj589Fsc+uJ6BYPO2OLNobtTmF3hvusxOFblAjFzy4VuEOrD27
         shVv5j4flGfZP5ZKf0oD9z3I5mcfEgazfAAXF3El44hYhX1ZRJaYFp+RYh8KC456HFZc
         kSCAd/ObzJ2UJVsrp6Z49s4y6jg7flU32RKu03oDmXNXsZW8yRicseUXEdJ33k/uoDns
         3t9BrSAOH3jBGP78RFzGvpDDNA510GhlcIeVQC/3SRIP7nZ/gPC/uJcOwTrT82pyTD6i
         AF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683210677; x=1685802677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JS6msPuToyJynO3sTVIKpHDiqUqJNNgVeQDo4ExI+FY=;
        b=FtD6Lqx+JoozFlqdsUtGDIA52K3f7p/WqnHY0+bUy1EFJsNMJpRqllWOP5nkF8BORb
         uEN11No+H8uIvS32xYEdWc2tbQB3SzICxYJkF/HFJJ05PGpJUS+adyr3aUjTazRxxpHp
         UH9AoMDnNWJcOkb2Z9al+fuk/JzDFsxpP+vog+flY/nEaeMpwTVwTg2zt/kQTEH/tpnI
         ZJPECBe+DKyShD2wTLanGK0DoqPG3rSLFCzv/PVSKjW1/YjuOR0sc2JGXPGLldmLf7l0
         KB20A83i/lPRXh5dVhN9EYsC9DmEPG1eAlR2ytXx61gGageKPjBJhSgVi/0eZL7k81Md
         0oaQ==
X-Gm-Message-State: AC+VfDzf5V+e9ao3u0zDngvxU/Cu0WvSjbcgXoNIea2/K8skZdgXrG02
        aXwdoWpNwlrRJGQbKatmeOD6fynfe4dvP5jPWb4oWA==
X-Google-Smtp-Source: ACHHUZ5E9WXnTl16LxgdrH+7bPTNFRvDYVSM0w82lR/qVCCtHXAzvUBD8IG8coi/bDLOeNuU/XqnEJgf+6xYt7++7Tk=
X-Received: by 2002:a25:cec1:0:b0:b99:4ac6:3c75 with SMTP id
 x184-20020a25cec1000000b00b994ac63c75mr122983ybe.10.1683210677091; Thu, 04
 May 2023 07:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-35-surenb@google.com>
 <ZFIO3tXCbmTn53uv@dhcp22.suse.cz> <CAJuCfpHrZ4kWYFPvA3W9J+CmNMuOtGa_ZMXE9fOmKsPQeNt2tg@mail.gmail.com>
 <ZFNnKHR2nCSimjQf@dhcp22.suse.cz>
In-Reply-To: <ZFNnKHR2nCSimjQf@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 4 May 2023 07:31:05 -0700
Message-ID: <CAJuCfpF7WeVuJpmZN3KEu=FAUH34xfYG4wPg-YNjxj+GtmdBXQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] lib: code tagging context capture support
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

On Thu, May 4, 2023 at 1:04=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 03-05-23 08:18:39, Suren Baghdasaryan wrote:
> > On Wed, May 3, 2023 at 12:36=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 01-05-23 09:54:44, Suren Baghdasaryan wrote:
> > > [...]
> > > > +static inline void add_ctx(struct codetag_ctx *ctx,
> > > > +                        struct codetag_with_ctx *ctc)
> > > > +{
> > > > +     kref_init(&ctx->refcount);
> > > > +     spin_lock(&ctc->ctx_lock);
> > > > +     ctx->flags =3D CTC_FLAG_CTX_PTR;
> > > > +     ctx->ctc =3D ctc;
> > > > +     list_add_tail(&ctx->node, &ctc->ctx_head);
> > > > +     spin_unlock(&ctc->ctx_lock);
> > >
> > > AFAIU every single tracked allocation will get its own codetag_ctx.
> > > There is no aggregation per allocation site or anything else. This lo=
oks
> > > like a scalability and a memory overhead red flag to me.
> >
> > True. The allocations here would not be limited. We could introduce a
> > global limit to the amount of memory that we can use to store contexts
> > and maybe reuse the oldest entry (in LRU fashion) when we hit that
> > limit?
>
> Wouldn't it make more sense to aggregate same allocations? Sure pids
> get recycled but quite honestly I am not sure that information is all
> that interesting. Precisely because of the recycle and short lived
> processes reasons. I think there is quite a lot to think about the
> detailed context tracking.

That would be a nice optimization. I'll need to look into the
implementation details. Thanks for the idea.

>
> > >
> > > > +}
> > > > +
> > > > +static inline void rem_ctx(struct codetag_ctx *ctx,
> > > > +                        void (*free_ctx)(struct kref *refcount))
> > > > +{
> > > > +     struct codetag_with_ctx *ctc =3D ctx->ctc;
> > > > +
> > > > +     spin_lock(&ctc->ctx_lock);
> > >
> > > This could deadlock when allocator is called from the IRQ context.
> >
> > I see. spin_lock_irqsave() then?
>
> yes. I have checked that the lock is not held over the all list
> traversal which is good but the changelog could be more explicit about
> the iterators and lock hold times implications.

Ack. Will add more information.

>
> --
> Michal Hocko
> SUSE Labs
