Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4166F5A13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 16:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjECOcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjECOcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 10:32:23 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3810265BD
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 07:32:10 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9e2f227640so4287417276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683124329; x=1685716329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEvcpQRFstUtOR1Eu0GIXU3Feju4Sch+HPMbK8t4eZw=;
        b=YYnwd/M3xcBLc1VRnRyKFD9vkc0d2D3qgDDL79EsNRxNCa7TxdjY6Vm/bTYHRcE7zH
         T2JnRgsSoDgD7n4yPCSwILW+e/MLYDFGyYpwoik0lQZdi5X0T2moaEEdeGV9ciw/MI5/
         NOPLZ5QZ+txodD+d3urnPo1XZ7TbBY075JJgIj1bS5xtW/81qQMZFGqCUr2UqiRf22Np
         dbsSB0cEyq+/tGKFKGpOF1Jek93XjSTP2B0edRqRQbK7PoGDQgU8172qBF8QZwxPtO5N
         hOZVk15gzUMXIBEGld86wkoLF3lnnLnX9ksExP2peH7/jtY9tNGoj+EOq+rXAzkp7Swk
         j/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124329; x=1685716329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEvcpQRFstUtOR1Eu0GIXU3Feju4Sch+HPMbK8t4eZw=;
        b=Iclg0/J+RNtqJZZPv7bZcxzUb7afZweZ0nMvUetNujXNlUfHBVUp4lb+aMAuDDj9TI
         7FvpB6LmYVYLwcN92Pu02khv86y4OdmS+7cppcKF8EPjor7OALU3yPqVJyuEdclagexS
         UjgFDqXN7+JyPvbu9RCVBfnt31IrhiNI70A0+jufzUQfgXKBidkP3zd3g44F1DFEIu/J
         dS0PjAd+OCx91B0mYZ5joBABmqcRGoouXMd7zMr1xDpMjjkHOq9s5mjTWX5aX/eXB38z
         WBM9UrhJ+VYQbpWd8fM8xJF0FW1kta2ur1AeWFLHH9ou+pI3sq9u6TR8bjEeenRg4uFS
         JRPQ==
X-Gm-Message-State: AC+VfDwnhJzTjbmUUQJuFQDKtpvEshZyaS3BVVWvcu6hzNphf5JBPWqY
        SC3jkksFJn5zQYMWgsEG0ic7olBKRaL5/h/QDL3Cxw==
X-Google-Smtp-Source: ACHHUZ62ugyZVwsnHBXMYjdbiWqDWizXIg764GF6n5Kz8ZrSC3IwTZiC2PVdnW1kxB49Xblr0EH+rbJRRflkUY+jBA4=
X-Received: by 2002:a25:7356:0:b0:b9d:de23:3c27 with SMTP id
 o83-20020a257356000000b00b9dde233c27mr12904071ybc.9.1683124329016; Wed, 03
 May 2023 07:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan> <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <20230503115051.30b8a97f@meshulam.tesarici.cz> <ZFIv+30UH7+ySCZr@moria.home.lan>
 <25a1ea786712df5111d7d1db42490624ac63651e.camel@HansenPartnership.com>
In-Reply-To: <25a1ea786712df5111d7d1db42490624ac63651e.camel@HansenPartnership.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 07:31:57 -0700
Message-ID: <CAJuCfpFZHOLxhrimPbLg+MjyzLR7U=C2Nk+i5Jc+-ZaNvnVu8Q@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
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

On Wed, May 3, 2023 at 5:34=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2023-05-03 at 05:57 -0400, Kent Overstreet wrote:
> > On Wed, May 03, 2023 at 11:50:51AM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > > If anyone ever wants to use this code tagging framework for
> > > something
> > > else, they will also have to convert relevant functions to macros,
> > > slowly changing the kernel to a minefield where local identifiers,
> > > struct, union and enum tags, field names and labels must avoid name
> > > conflict with a tagged function. For now, I have to remember that
> > > alloc_pages is forbidden, but the list may grow.
> >
> > Also, since you're not actually a kernel contributor yet...
>
> You have an amazing talent for being wrong.  But even if you were
> actually right about this, it would be an ad hominem personal attack on
> a new contributor which crosses the line into unacceptable behaviour on
> the list and runs counter to our code of conduct.

Kent, I asked you before and I'm asking you again. Please focus on the
technical discussion and stop personal attacks. That is extremely
counter-productive.

>
> James
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
