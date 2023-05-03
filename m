Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E036F4EBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 04:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjECCHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 22:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjECCHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 22:07:47 -0400
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [IPv6:2001:41d0:203:375::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9F6273A
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 19:07:38 -0700 (PDT)
Date:   Tue, 2 May 2023 22:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683079654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cpRynykubcluzGzuthbmrNkuNIeg8BzMwNks1+1YuhA=;
        b=v2LisaB7EAiYUc1+uIQeLvUn9sUnaliIsnvchC6IYmBRNpj565Pcae8UgINnbfoPSrDzf1
        dhyCKwDr9an9QOzJ3GvxlEwxpH2prnH3+mWfvk7cXKMy3v56CXygiL+SUSayiuSFsOEU6I
        BkOshCOA3yKQ/GtZDDIOPbmb5F9macw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
        Noralf =?utf-8?B?VHLDr8K/wr1ubmVz?= <noralf@tronnes.org>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in
 string_get_size's output
Message-ID: <ZFHB2ATrPIsjObm/@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan>
 <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
 <ZFCA2FF+9MI8LI5i@moria.home.lan>
 <CAHp75VdK2bgU8P+-np7ScVWTEpLrz+muG-R15SXm=ETXnjaiZg@mail.gmail.com>
 <ZFCsAZFMhPWIQIpk@moria.home.lan>
 <CAHp75VdvRshCthpFOjtmajVgCS_8YoJBGbLVukPwU+t79Jgmww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdvRshCthpFOjtmajVgCS_8YoJBGbLVukPwU+t79Jgmww@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 06:19:27PM +0300, Andy Shevchenko wrote:
> On Tue, May 2, 2023 at 9:22 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > On Tue, May 02, 2023 at 08:33:57AM +0300, Andy Shevchenko wrote:
> > > Actually instead of producing zillions of variants, do a %p extension
> > > to the printf() and that's it. We have, for example, %pt with T and
> > > with space to follow users that want one or the other variant. Same
> > > can be done with string_get_size().
> >
> > God no.
> 
> Any elaboration what's wrong with that?

I'm really not a fan of %p extensions in general (they are what people
reach for because we can't standardize on a common string output API),
but when we'd be passing it bare integers the lack of type safety would
be a particularly big footgun.

> God no for zillion APIs for almost the same. Today you want space,
> tomorrow some other (special) delimiter.

No, I just want to delete the space and output numbers the same way
everyone else does. And if we are stuck with two string_get_size()
functions, %p extensions in no way improve the situation.
