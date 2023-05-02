Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276456F3CFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 07:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjEBFek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 01:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbjEBFeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 01:34:36 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCAB40DD;
        Mon,  1 May 2023 22:34:35 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-5f45fad3be1so30437386d6.0;
        Mon, 01 May 2023 22:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683005674; x=1685597674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qrcuuma9akhRKA9cVsiv9Wp3Fts3/L+OpcqEI96PfXk=;
        b=QF1HVjPTepvbrQ9oJRLkb6f8AJvX+hO2zQE2ZY/l3fUgEFOfqL1wf8m0RGFQ4awGlN
         sWkxd9j28poLLl8dBgEc54m1kLx91P31/J3vbCIAx0/CoGXAsbwCOE363uYJGP9GkB5b
         3lymi+vNqj9QoS17H6nGkbM5o+IGDFDB9cd/G6K1hJSdkvWt972kMNAdb/+wzno7m9jZ
         f0XwZxnSXtuHXZc3vW87bizP3VIj3Spc6/Cesx4fCw9piQPSAItNDleA+xpCa+67Mn+G
         vzbu6giNBfMNRicZ3wSxkGrbLyqmcdrr5AdLiwR1ViUDz037I1qTRRGrjMrCbz3a2XiY
         9TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683005674; x=1685597674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qrcuuma9akhRKA9cVsiv9Wp3Fts3/L+OpcqEI96PfXk=;
        b=aSE8tbD0/3vqzvoIlK7v8nw454064FFpohwnHCAJT/TmfNuS/HioLhubgjbYomF8vi
         RDbPtyu5yRItJAt/ziDoYJEbnz34Jk+YpOrePJcBGq92iRdHGnvr+DxIvbaMPgBGub3V
         5QCTyV13EW48DvD8BHqewTp1qRde4IKSJvSjZVUw44KlmVZUXsCU198pmq/FOcgPQYcl
         z5nuc3egP2nNiO8CZgik1jZAThO5VJXTN1GwcfBl1lxGpznlzUfJ1xTVcviSdRqPxw3k
         URoWeZomVpufLp+hcdLUKK0sQo8/BBZgBNfkco7VC0cnuREBu0dms8AA7YWJJaNj3byV
         9cxw==
X-Gm-Message-State: AC+VfDzNBIlQEUtnfdULqB97tvctAPuFt2bG2Oywxj/B4YxgPuzS2/+6
        4cgFi2DfsRjMeGOpS9V8skc473k70MP7/cKwQg4=
X-Google-Smtp-Source: ACHHUZ6UI2cU+vYPscYDDBkkT3Plhp9qvN6okFjmkrVKfQQGe2MFQv7qiNq0uAhkrc7LvrOfXehK4e+SQ+W+CPsbV3k=
X-Received: by 2002:a05:6214:d04:b0:56e:aeaa:95b2 with SMTP id
 4-20020a0562140d0400b0056eaeaa95b2mr3054068qvh.9.1683005674261; Mon, 01 May
 2023 22:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan> <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
 <ZFCA2FF+9MI8LI5i@moria.home.lan>
In-Reply-To: <ZFCA2FF+9MI8LI5i@moria.home.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 May 2023 08:33:57 +0300
Message-ID: <CAHp75VdK2bgU8P+-np7ScVWTEpLrz+muG-R15SXm=ETXnjaiZg@mail.gmail.com>
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

On Tue, May 2, 2023 at 6:18=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Mon, May 01, 2023 at 10:22:18PM -0400, James Bottomley wrote:

...

> > > If someone raises a specific objection we'll do something different,
> > > otherwise I think standardizing on what userspace tooling already
> > > parses is a good idea.
> >
> > If you want to omit the space, why not simply add your own variant?  A
> > string_get_size_nospace() which would use most of the body of this one
> > as a helper function but give its own snprintf format string at the
> > end.  It's only a couple of lines longer as a patch and has the bonus
> > that it definitely wouldn't break anything by altering an existing
> > output.
>
> I'm happy to do that - I just wanted to post this version first to see
> if we can avoid the fragmentation and do a bit of standardizing with
> how everything else seems to do that.

Actually instead of producing zillions of variants, do a %p extension
to the printf() and that's it. We have, for example, %pt with T and
with space to follow users that want one or the other variant. Same
can be done with string_get_size().

--=20
With Best Regards,
Andy Shevchenko
