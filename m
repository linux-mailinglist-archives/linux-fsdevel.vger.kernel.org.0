Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C416FB68F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 20:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjEHS7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 14:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHS7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 14:59:47 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9F76187;
        Mon,  8 May 2023 11:59:45 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 46D7A15660F;
        Mon,  8 May 2023 20:59:41 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1683572382; bh=uZkqx7aKUtaW85glkXkWc2KSVWl1+jLzvm0vqmvOK4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oMA1JDBfpJw4sW7xwHIesfwzVvuWGRfEibImYMO8MGVZr8iRllWIfuu/0e/mR8S35
         iSTkGom3l2vCdobWQ2bfVa6nZe4sueYcQ8TRCacsjjA5CE1u6g+C6TnyFwqEgekR80
         QJhrpkc85RcLvfsJty39syGBqRtbVmBD8gRTuYp0lKs/3I0TMuZAwoFEzyxCISt87Q
         jFclnxrFT242I64DoHaTh7hEShSdJRQAi3f8B9Gi+6bMke4t3VWU3TXk/2b2p3mKb+
         ZKQmv+XMh4jxUtnY4XLyIY3pSmPZPhKIaboj506ssLQOCqeMss+Ypkje+lMahARxZd
         uaDOOK7Oe/wvA==
Date:   Mon, 8 May 2023 20:59:39 +0200
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
Message-ID: <20230508205939.0b5b485c@meshulam.tesarici.cz>
In-Reply-To: <ZFkjRBCExpXfI+O5@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
        <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
        <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com>
        <ZFN1yswCd9wRgYPR@dhcp22.suse.cz>
        <ZFfd99w9vFTftB8D@moria.home.lan>
        <20230508175206.7dc3f87c@meshulam.tesarici.cz>
        <ZFkb1p80vq19rieI@moria.home.lan>
        <20230508180913.6a018b21@meshulam.tesarici.cz>
        <ZFkjRBCExpXfI+O5@moria.home.lan>
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

On Mon, 8 May 2023 12:28:52 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Mon, May 08, 2023 at 06:09:13PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > Sure, although AFAIK the index does not cover all possible config
> > options (so non-x86 arch code is often forgotten). However, that's the
> > less important part.
> >=20
> > What do you do if you need to hook something that does conflict with an
> > existing identifier? =20
>=20
> As already happens in this patchset, rename the other identifier.
>=20
> But this is C, we avoid these kinds of conflicts already because the
> language has no namespacing

This statement is not accurate, but I agree there's not much. Refer to
section 6.2.3 of ISO/IEC9899:2018 (Name spaces of identifiers).

More importantly, macros also interfere with identifier scoping, e.g.
you cannot even have a local variable with the same name as a macro.
That's why I dislike macros so much.

But since there's no clear policy regarding macros in the kernel, I'm
merely showing a downside; it's perfectly fine to write kernel code
like this as long as the maintainers agree that the limitation is
acceptable and outweighed by the benefits.

Petr T

> it's going to be a pretty rare situtaion
> going forward. Most of the hooking that will be done is done with this
> patchset, and there was only one identifier that needed to be renamed.
>=20

