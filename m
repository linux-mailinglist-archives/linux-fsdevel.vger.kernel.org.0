Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C5C6F38ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjEAT70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 15:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjEAT7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 15:59:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C543595;
        Mon,  1 May 2023 12:58:35 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-61b6101a1b9so2081556d6.3;
        Mon, 01 May 2023 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682971064; x=1685563064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KWtLWCFndJNZE972x4UIl3VMb5lgPnWy05QC+e9YHQ=;
        b=H8s0D2PnStbB558QXUaT5ll4HgeOP3F3gveA5ZpgVXoGtOyCk7qdahHdBJG2qJuoFD
         0HqzyJ4Zg0siuJOE4NGOCejap5WAcKxJOUSig772mCh4QsCtjNTYhOT/LwicIJWE9bWs
         jrJT26m+1Bq+eQTAJu9XUgL54sZ3rBnmD1Wf3mgD63haBjTeb1LZFJOQGajyc8vpiEsQ
         V1w1TCUdZjhisRQlyxsFwexQ3NynHRek48vOQiL25dSyMrTfOeaKKLioUpoCHgP64K4R
         6askIQpetdUtujGGp4kZIUBJMb/jdkXxrQ9+K8YBjSjSjTr4VDS6Hh6nwnpHLOhwtPL5
         B5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682971064; x=1685563064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KWtLWCFndJNZE972x4UIl3VMb5lgPnWy05QC+e9YHQ=;
        b=CeevHdJ8JhNjYbTOJpWlmBXSA2WYWq08jpFoCFii7fELOZjD+ZrJnQIdOYt43jL7Rt
         LLVvZzKlhBlCpvkS74cdl+kHUFqclPbiCH/vqTBl8jV4kVtcwEu+jR+vTpvxXE+O2KH1
         jg8LbqWNPB24HpeY+QuP7rVGaIOavmIjp/+mud54Sde1Zywb1DkRQ1/3HJtmuExAAvwj
         u9xBTL7nWKvTeAMHsYIXGF30Y1nECxTG1BTss8mSZLZEbY1G5kj3sUrMEzMFotac9hNg
         qVwP3ZS11XkVVaeK95ENKO43Gb7iZACSdeFE0J+71z/hVjVW9jNVmeW0D3vwRK3Ssfzj
         R5BA==
X-Gm-Message-State: AC+VfDzPDAlZu4DFM9EeQ/X8RC2UQzq+ZovsjpN84sSWs3gyuTfszDNe
        bFYU6yUaj7SiEtnGRFu3BKRiyow1as9gbPOP7UU=
X-Google-Smtp-Source: ACHHUZ4CCRpTSnLWkEGaALw7g2diddNGGTgl3gTtsMDJ7pS/HKTxf5g9t615t5zWEkRqE+QbhaeBbmG/dmnn24JEO8g=
X-Received: by 2002:a05:6214:4008:b0:5ea:654e:4d3f with SMTP id
 kd8-20020a056214400800b005ea654e4d3fmr1607440qvb.5.1682971064004; Mon, 01 May
 2023 12:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti> <ZFAUj+Q+hP7cWs4w@moria.home.lan>
In-Reply-To: <ZFAUj+Q+hP7cWs4w@moria.home.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 May 2023 22:57:07 +0300
Message-ID: <CAHp75VeJ_a6j3uweLN5-woSQUtN5u36c2gkoiXhnJa1HXJdoyQ@mail.gmail.com>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in string_get_size's output
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, willy@infradead.org,
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

On Mon, May 1, 2023 at 10:36=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Mon, May 01, 2023 at 11:13:15AM -0700, Davidlohr Bueso wrote:
> > On Mon, 01 May 2023, Suren Baghdasaryan wrote:
> >
> > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > >
> > > Previously, string_get_size() outputted a space between the number an=
d
> > > the units, i.e.
> > >  9.88 MiB
> > >
> > > This changes it to
> > >  9.88MiB
> > >
> > > which allows it to be parsed correctly by the 'sort -h' command.

But why do we need that? What's the use case?

> > Wouldn't this break users that already parse it the current way?
>
> It's not impossible - but it's not used in very many places and we
> wouldn't be printing in human-readable units if it was meant to be
> parsed - it's mainly used for debug output currently.
>
> If someone raises a specific objection we'll do something different,
> otherwise I think standardizing on what userspace tooling already parses
> is a good idea.

Yes, I NAK this on the basis of
https://english.stackexchange.com/a/2911/153144


--=20
With Best Regards,
Andy Shevchenko
