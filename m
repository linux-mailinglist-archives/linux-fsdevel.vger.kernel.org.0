Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCBE6F5426
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjECJN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjECJNS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 05:13:18 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB155BB;
        Wed,  3 May 2023 02:12:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-74e12e93384so213824985a.3;
        Wed, 03 May 2023 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683105170; x=1685697170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEZd+b8sulXt8fKAN8kz+Gm51fXRGcBOvDO84eUPrqA=;
        b=lkpnSWbImRhXpMdXf/j2tYcHtARa7pZxpe80UwOhD4R61KpJDN5E6c3vkOZJZtEsdd
         NIOFyi6+CcEllvCmz+ezBqynxF+o1JnKK9z/EV67UWGPh2kFZbUVxyRHZCZkw1kqq8rz
         D1ODfYDy+ZvYfj3AH/q3S+H4OrTddDujLMLoFoZBIeqfcAukFwbiQa/sO0taRXV/GD4U
         O5s1H1vUGlkYsqkokTGq0Ace+9Jt9tMQ9MhYfRBameD9A6V7QtQlcyepsIhLTlDMhvcT
         QESiwW/ebN8bNURL5Wk9400Ojw9jq2OZaVXEW9BBl9Ohxc4ib4YptZaU3URY4a45BJzR
         laiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683105170; x=1685697170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEZd+b8sulXt8fKAN8kz+Gm51fXRGcBOvDO84eUPrqA=;
        b=U+Nyzb3BdTcOJy/b6wqEVDe3rczisUUnHhEjmb90w9oMU2qFPs2cGx3mkOIeXZd7DR
         PjwOSeVNiQPOB3ubjVP5unEZ/NH3n70YMPcZkB+SdXDVhylx/qPmbdnxoTbcS+QhlrX/
         v/+xZDZ6mQ5M7w8dg/B1BevFNwnGXCVK/o82UsooLOZ0r+Bt+cGY2TdUOJJD8BHHRTtP
         iegfJlFdxSLeXI8//CFtr+KczfEuLawJpVaESC6ooeWDxSjOXPAFBNj42/YrxNhHfyNA
         G+zcuxkgOd3nYXmDRlrzJjashsamD1DIzNERAcJElXQJT+ySoL4YPU9co5PtOm1ou0UY
         uLJA==
X-Gm-Message-State: AC+VfDwrD8/mWpZq+gL1WzHthEszccxtT/uwzgUbGqmzwMfAE7MAS9xC
        QWbS7z6whmPTVqQ02ViNe7kMpXkaCbck+iOflYE=
X-Google-Smtp-Source: ACHHUZ4GQD0z7eUsogNetrMaZKEq5pKRE8mu+npoeyVDIT95CPFfsPGLoM4SFfpJ8DKd67/MmBCqruVhmQylmFOpJxg=
X-Received: by 2002:ad4:5947:0:b0:5ca:83ed:12be with SMTP id
 eo7-20020ad45947000000b005ca83ed12bemr11144076qvb.21.1683105169929; Wed, 03
 May 2023 02:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-2-surenb@google.com> <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan> <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
 <ZFCA2FF+9MI8LI5i@moria.home.lan> <CAHp75VdK2bgU8P+-np7ScVWTEpLrz+muG-R15SXm=ETXnjaiZg@mail.gmail.com>
 <ZFCsAZFMhPWIQIpk@moria.home.lan> <CAHp75VdvRshCthpFOjtmajVgCS_8YoJBGbLVukPwU+t79Jgmww@mail.gmail.com>
 <ZFHB2ATrPIsjObm/@moria.home.lan> <CAHp75VdH07gTYCPvp2FRjnWn17BxpJCcFBbFPpjpGxBt1B158A@mail.gmail.com>
 <ZFIJeSv9xn9qnMzg@moria.home.lan>
In-Reply-To: <ZFIJeSv9xn9qnMzg@moria.home.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 May 2023 12:12:12 +0300
Message-ID: <CAHp75Vd_VMOh1zxJvr0KqhxYBXAU1X+Ax7YA1sJ0G_abEpn-Dg@mail.gmail.com>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in string_get_size's output
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
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
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?B?Tm9yYWxmIFRyw6/Cv8K9bm5lcw==?= <noralf@tronnes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 3, 2023 at 10:13=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Wed, May 03, 2023 at 09:30:11AM +0300, Andy Shevchenko wrote:
> > On Wed, May 3, 2023 at 5:07=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > On Tue, May 02, 2023 at 06:19:27PM +0300, Andy Shevchenko wrote:
> > > > On Tue, May 2, 2023 at 9:22=E2=80=AFAM Kent Overstreet
> > > > <kent.overstreet@linux.dev> wrote:
> > > > > On Tue, May 02, 2023 at 08:33:57AM +0300, Andy Shevchenko wrote:
> > > > > > Actually instead of producing zillions of variants, do a %p ext=
ension
> > > > > > to the printf() and that's it. We have, for example, %pt with T=
 and
> > > > > > with space to follow users that want one or the other variant. =
Same
> > > > > > can be done with string_get_size().
> > > > >
> > > > > God no.
> > > >
> > > > Any elaboration what's wrong with that?
> > >
> > > I'm really not a fan of %p extensions in general (they are what peopl=
e
> > > reach for because we can't standardize on a common string output API)=
,
> >
> > The whole story behind, for example, %pt is to _standardize_ the
> > output of the same stanza in the kernel.
>
> Wtf does this have to do with the rest of the discussion? The %p thing
> seems like a total non sequitar and a distraction.
>
> I'm not getting involved with that. All I'm interested in is fixing the
> memory allocation profiling output to make it more usable.
>
> > > but when we'd be passing it bare integers the lack of type safety wou=
ld
> > > be a particularly big footgun.
> >
> > There is no difference to any other place in the kernel where we can
> > shoot into our foot.
>
> Yeah, no, absolutely not. Passing different size integers to
> string_get_size() is fine; passing pointers to different size integers
> to a %p extension will explode and the compiler won't be able to warn.

This is another topic. Yes, there is a discussion to have a compiler
plugin to check this.

> > > > God no for zillion APIs for almost the same. Today you want space,
> > > > tomorrow some other (special) delimiter.
> > >
> > > No, I just want to delete the space and output numbers the same way
> > > everyone else does. And if we are stuck with two string_get_size()
> > > functions, %p extensions in no way improve the situation.
> >
> > I think it's exactly for the opposite, i.e. standardize that output
> > once and for all.
>
> So, are you dropping your NACK then, so we can standardize the kernel on
> the way everything else does it?

No, you are breaking existing users. The NAK stays.
The whole discussion after that is to make the way on how users can
utilize your format and existing format without multiplying APIs.


--=20
With Best Regards,
Andy Shevchenko
