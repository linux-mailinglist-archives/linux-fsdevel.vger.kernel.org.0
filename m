Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0346FB4D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 18:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjEHQJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjEHQJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 12:09:38 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21D65AF;
        Mon,  8 May 2023 09:09:21 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 481AC155357;
        Mon,  8 May 2023 18:09:14 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1683562155; bh=tZgheluO1aPVjg06yZiAFzLNKgO2HIpkAjGUkuoz+Xw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CADkuX60QMsFSs5K3h85ChAjshZd0+5QyWqLXjAQ5u35m53i5zXISvnd+ljlG5rW8
         3yfjn5cTtoMKzWJyMVk6cVz/NtUgY7fgdoS4Lh0LIxQNcHDhj0HSpdaF4B+jJ4EmMA
         5185N1LV9wkMWh/nAmI5f8IS5nYaeIOztE4g7FmmZN38FcuYByM/VlMF2byMx02IzO
         x7xCDbrZqC7ZiTvCVcnU/9QA9D8zIWHDYJDuqOaxAmw4//Gah5Zqccep8UubMR3MsW
         5sv9E3yE4y9cJgzxnJzn/sRvFqIs1IbT/NiGx03o8Sb1jC690ErN5b5lmVyIFNfb02
         FQ4gjDERvn0bg==
Date:   Mon, 8 May 2023 18:09:13 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
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
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <20230508180913.6a018b21@meshulam.tesarici.cz>
In-Reply-To: <ZFkb1p80vq19rieI@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
        <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
        <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com>
        <ZFN1yswCd9wRgYPR@dhcp22.suse.cz>
        <ZFfd99w9vFTftB8D@moria.home.lan>
        <20230508175206.7dc3f87c@meshulam.tesarici.cz>
        <ZFkb1p80vq19rieI@moria.home.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 8 May 2023 11:57:10 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Mon, May 08, 2023 at 05:52:06PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Sun, 7 May 2023 13:20:55 -0400
> > Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >  =20
> > > On Thu, May 04, 2023 at 11:07:22AM +0200, Michal Hocko wrote: =20
> > > > No. I am mostly concerned about the _maintenance_ overhead. For the
> > > > bare tracking (without profiling and thus stack traces) only those
> > > > allocations that are directly inlined into the consumer are really
> > > > of any use. That increases the code impact of the tracing because a=
ny
> > > > relevant allocation location has to go through the micro surgery.=20
> > > >=20
> > > > e.g. is it really interesting to know that there is a likely memory
> > > > leak in seq_file proper doing and allocation? No as it is the speci=
fic
> > > > implementation using seq_file that is leaking most likely. There are
> > > > other examples like that See?   =20
> > >=20
> > > So this is a rather strange usage of "maintenance overhead" :)
> > >=20
> > > But it's something we thought of. If we had to plumb around a _RET_IP_
> > > parameter, or a codetag pointer, it would be a hassle annotating the
> > > correct callsite.
> > >=20
> > > Instead, alloc_hooks() wraps a memory allocation function and stashes=
 a
> > > pointer to a codetag in task_struct for use by the core slub/buddy
> > > allocator code.
> > >=20
> > > That means that in your example, to move tracking to a given seq_file
> > > function, we just:
> > >  - hook the seq_file function with alloc_hooks =20
> >=20
> > Thank you. That's exactly what I was trying to point out. So you hook
> > seq_buf_alloc(), just to find out it's called from traverse(), which
> > is not very helpful either. So, you hook traverse(), which sounds quite
> > generic. Yes, you're lucky, because it is a static function, and the
> > identifier is not actually used anywhere else (right now), but each
> > time you want to hook something, you must make sure it does not
> > conflict with any other identifier in the kernel... =20
>=20
> Cscope makes quick and easy work of this kind of stuff.

Sure, although AFAIK the index does not cover all possible config
options (so non-x86 arch code is often forgotten). However, that's the
less important part.

What do you do if you need to hook something that does conflict with an
existing identifier?

Petr T
