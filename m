Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580646F5023
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 08:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjECGav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 02:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjECGau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 02:30:50 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D61BC1;
        Tue,  2 May 2023 23:30:49 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-61b6101a166so10036056d6.0;
        Tue, 02 May 2023 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683095448; x=1685687448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSWUOSuqVLpIOWgszk2VW3MzVdJnM+9N5Gz+a5oZIik=;
        b=FwxsWECu6Vmz2nS2N36nqdmqGUy6EtTWCwQbQH8C4yyx7S50D7jj6hwfI3pG4WOWTe
         J5Ac/nm/4jjf2uonNwEk7kkgqGFkqqOlCnFifWxFhM5HBLHG5/+yNdwPcGRQZD8xyZgY
         y564jPge77bFOjQ7/C7PbIZo2J/D/9HIgWm1qaK+/JMqtAHJacp7Y7p+jXsMBKVPwiay
         de3olKWgxT5zQQmgR6+1vlYmLMhp7LATVC+UKYup+7gpwYRYwOXn88552r8N8+SfOO97
         mz3mbEB+LcrH93Ca5jn3i5g7nB6tCk4YfB1Kz47lyE0ZxPdxng7OE8IRGtE3NBhEpUXq
         C5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683095448; x=1685687448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSWUOSuqVLpIOWgszk2VW3MzVdJnM+9N5Gz+a5oZIik=;
        b=LZ8g6qgCasB0UbWpZlTJfNky3m5otbn6PjY6RwXQu+MDJPhx7+b/0cP5iSqjK6IarW
         XZZ6Yo2SN65wDHuMjjM16QvJ2+F0Oama4XLbqsmBgbyVyvkWa+GbjRg2ZrafvtPXw+Z/
         a9NkLP43GnHPax/mHAuHxO6hk4oRAyjaoW6R9eCSD54CQjf2aFI9HYvIOnTPhjccKx/x
         TXlGwwT2c4b3fhUQfL07QIbGsMIoCOJmS6G6f82pg2f+tiplvSY7dt7PSCrH7bUdpx6+
         HZnaWiPp36SFl1uMrj0pqPL1UyHwE9/TtoiLzMuFN98aPWAMwXQBHkHA/1VnA0a5DaMC
         a6zw==
X-Gm-Message-State: AC+VfDwrMV2BdmzmTBrtaoU+npTWUl9khzMIJ+MTGaP9KpuFDjTRlI+4
        7hvm+PERBQ8vK96Cf/WEU7KB6Dz47imKeYFLZt4=
X-Google-Smtp-Source: ACHHUZ6mwR/Eb9QNNQC3EY6y0Gd5Rl8C7T1qIt5du/51986iaziD1AevtUJQS/vhAg1zqokn+I2SvW0bGzGu5uBEHP4=
X-Received: by 2002:a05:6214:1941:b0:61b:5cba:5820 with SMTP id
 q1-20020a056214194100b0061b5cba5820mr9799913qvk.50.1683095448149; Tue, 02 May
 2023 23:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan> <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
 <ZFCA2FF+9MI8LI5i@moria.home.lan> <CAHp75VdK2bgU8P+-np7ScVWTEpLrz+muG-R15SXm=ETXnjaiZg@mail.gmail.com>
 <ZFCsAZFMhPWIQIpk@moria.home.lan> <CAHp75VdvRshCthpFOjtmajVgCS_8YoJBGbLVukPwU+t79Jgmww@mail.gmail.com>
 <ZFHB2ATrPIsjObm/@moria.home.lan>
In-Reply-To: <ZFHB2ATrPIsjObm/@moria.home.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 May 2023 09:30:11 +0300
Message-ID: <CAHp75VdH07gTYCPvp2FRjnWn17BxpJCcFBbFPpjpGxBt1B158A@mail.gmail.com>
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

On Wed, May 3, 2023 at 5:07=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Tue, May 02, 2023 at 06:19:27PM +0300, Andy Shevchenko wrote:
> > On Tue, May 2, 2023 at 9:22=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > On Tue, May 02, 2023 at 08:33:57AM +0300, Andy Shevchenko wrote:
> > > > Actually instead of producing zillions of variants, do a %p extensi=
on
> > > > to the printf() and that's it. We have, for example, %pt with T and
> > > > with space to follow users that want one or the other variant. Same
> > > > can be done with string_get_size().
> > >
> > > God no.
> >
> > Any elaboration what's wrong with that?
>
> I'm really not a fan of %p extensions in general (they are what people
> reach for because we can't standardize on a common string output API),

The whole story behind, for example, %pt is to _standardize_ the
output of the same stanza in the kernel.

> but when we'd be passing it bare integers the lack of type safety would
> be a particularly big footgun.

There is no difference to any other place in the kernel where we can
shoot into our foot.

> > God no for zillion APIs for almost the same. Today you want space,
> > tomorrow some other (special) delimiter.
>
> No, I just want to delete the space and output numbers the same way
> everyone else does. And if we are stuck with two string_get_size()
> functions, %p extensions in no way improve the situation.

I think it's exactly for the opposite, i.e. standardize that output
once and for all.

--=20
With Best Regards,
Andy Shevchenko
