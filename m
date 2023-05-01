Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C886F35A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjEASI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjEASIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 14:08:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7573F1984
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 11:08:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f833bda191so1584295f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682964501; x=1685556501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2lYHhqlJD16G2HYpsFMb3ZFL7Kq76WjunB2OGwz3cs=;
        b=InnNvCbyWRIxKxFGHEw18GDFvAR07SJg7UsaQSzayd856NvZvHy/7D82OiVunxTwOQ
         iI4bPEnaVC8DKfBD9q2mpFU/D2+4QZOsePkMvk/nKecGEkR7ieMp18RUohlow/ONsuPb
         fRpdmKiy/hCz/JHzVWz2n5Mg5OcWXlB55bYJJxXjQz7D5uG5SID6uaCO/Kks5xdfPjJJ
         it9fnMSSuNm2JWdg5Tcm2D1rTGbvS4aDpWOvTKMsD+KeIoUScC3se5ywU/XKx17SosJd
         CH4HSE+fdc45RYf+DKFB/2hLNASZoyYfq4ehjOUiQfqHoIRcizKtgl3mADdezSKqh+u9
         RU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682964501; x=1685556501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2lYHhqlJD16G2HYpsFMb3ZFL7Kq76WjunB2OGwz3cs=;
        b=L9abWSnYcb8xh+rXBgu750paEM1S5zBOpQ1ZvGmIDahoWhYS2/hrKn7zBArSnwZBNJ
         oSAUJqJEBpE7c5t9YNRds74kXSvqsX9Fo726uHmqiSGXWA3Ejh2cp6IahhEnZCIBLO9A
         FQsvXblMpn6czIXShlKqeaYPxXpP9pvCGC1EWruTuk42wzj4qTtPxTyrlj+invIujc3F
         TAUQpOb5s+OGCO1yxUlVq1IALmcbiGxiTFvyNgA5b/wZsoUx1IKA7f8GdMcet1iFRyBI
         27Jmqo5Yau+PaDjoBp7e1piKY3NqSErQAtOKgz+cJSravVJBDmfrj+A4zv3BD2STsxY3
         EUZA==
X-Gm-Message-State: AC+VfDz9E2BDbte4L3m4bB637KuM1DPpLgA5+LVQD1rgpXVJy0OKMrHl
        4KEvcdGNMclMpUOceQp8cu8fDtPiPULmBxltCLKYRg==
X-Google-Smtp-Source: ACHHUZ5amJjA/6tq+0x964OebbbLQ/pHCZFbXYS1+6FrTMuusEGNpiFnDiBKAeRF77HbwZnod13qqDRv0TRCNeDlvRc=
X-Received: by 2002:a5d:6351:0:b0:306:2b9e:2a8c with SMTP id
 b17-20020a5d6351000000b003062b9e2a8cmr3336094wrw.11.1682964500617; Mon, 01
 May 2023 11:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <ZE/7FZbd31qIzrOc@P9FQF9L96D>
In-Reply-To: <ZE/7FZbd31qIzrOc@P9FQF9L96D>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 1 May 2023 11:08:05 -0700
Message-ID: <CAJuCfpHU3ZMsNuqi1gSxzAWKr2D3VkiaTY0BEUQgM-QHNxRtSg@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
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

On Mon, May 1, 2023 at 10:47=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Mon, May 01, 2023 at 09:54:10AM -0700, Suren Baghdasaryan wrote:
> > Performance overhead:
> > To evaluate performance we implemented an in-kernel test executing
> > multiple get_free_page/free_page and kmalloc/kfree calls with allocatio=
n
> > sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
> > affinity set to a specific CPU to minimize the noise. Below is performa=
nce
> > comparison between the baseline kernel, profiling when enabled, profili=
ng
> > when disabled (nomem_profiling=3Dy) and (for comparison purposes) basel=
ine
> > with CONFIG_MEMCG_KMEM enabled and allocations using __GFP_ACCOUNT:
> >
> >                       kmalloc                 pgalloc
> > Baseline (6.3-rc7)    9.200s                  31.050s
> > profiling disabled    9.800 (+6.52%)          32.600 (+4.99%)
> > profiling enabled     12.500 (+35.87%)        39.010 (+25.60%)
> > memcg_kmem enabled    41.400 (+350.00%)       70.600 (+127.38%)
>
> Hm, this makes me think we have a regression with memcg_kmem in one of
> the recent releases. When I measured it a couple of years ago, the overhe=
ad
> was definitely within 100%.
>
> Do you understand what makes the your profiling drastically faster than k=
mem?

I haven't profiled or looked into kmem overhead closely but I can do
that. I just wanted to see how the overhead compares with the existing
accounting mechanisms.

For kmalloc, the overhead is low because after we create the vector of
slab_ext objects (which is the same as what memcg_kmem does), memory
profiling just increments a lazy counter (which in many cases would be
a per-cpu counter). memcg_kmem operates on cgroup hierarchy with
additional overhead associated with that. I'm guessing that's the
reason for the big difference between these mechanisms but, I didn't
look into the details to understand memcg_kmem performance.

>
> Thanks!
