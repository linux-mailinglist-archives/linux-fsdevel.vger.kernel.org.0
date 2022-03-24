Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4AB4E692D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 20:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352892AbiCXTSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 15:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbiCXTSy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:18:54 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36D3B6D25
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Mar 2022 12:17:21 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-de3ca1efbaso5892942fac.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Mar 2022 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSeUJtVAq2ojFIEZKt8eo8ON15UTWZtGxKUohpv+bBQ=;
        b=hxaCeFGxdMDuFJJM53jBLf2eFdzBZkRVzsUAmbutF8+sS1/1BpHJnLX1hmL20lBX+n
         a5YMnyS5AEgxGnBfHM5M/BubScuvnGmj0U17fKDxlUyHp+DxM2nCX2aWp0zE7QgzQo9y
         aonoS5UUvBLQvjbCIKZNPFEajMA7EVkOIn9X2cp0QbLMyFW8gvmaGK7MKf0+Nxz7/8uG
         f0/buczhhPQ/Qo36kGlRZlApUThUD6Y/UXtKVN/CezsD0nI8qUq2FwL93QMP5BQnpS8q
         l0rphq1CcCJhgEBzYA3kA11sLxS0/molmFsSw3b5jTd8tBzxNaTNqG9KKOOV2K74CPIj
         tqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSeUJtVAq2ojFIEZKt8eo8ON15UTWZtGxKUohpv+bBQ=;
        b=UqdpzTbCAa30BBiP8nndNaIIykTKEoWTbIUyD0kWHK/UwLYcXAJFoRqSrwW254rjn9
         Gc2s4sB1YGJhbS+IBGpktt9lMpQbmgPnPoR0Eq2ktYVa2An7vxmdNW7tV41xXYdz/k3Q
         99bSFQX3To0JsYg5Z9PfrK/0rOMFw5LUTA69jGWWGN7bmxAQAk9fO0gWEZlwAeF+/YcJ
         pyW3IH7gzD7yDDZxDSfxp6898NNQBQhTy3+e4mK/acxKIq57tuWlQCCM5ZSiUHIhncsR
         tVMRvfBYi3VO07s3167DGtFNPlxD8Mkt5M6D/5+4sp6lvVuNoeiD2Mo6kSGVGqfzTMsZ
         bl0g==
X-Gm-Message-State: AOAM533iBVOTysaVH4HFibxPYJkNpZ06QgUJdnSVPJ4pEoru6ZrVA/ZT
        rcqNSAW7NHdzQuJK+Sxvn0w+Z5Xg17sCaY0Jz4U=
X-Google-Smtp-Source: ABdhPJyEMCzn89HQP90whphAo5bq93xqLQeXCjS0Y2IH4+JL58Fn2dJlsK9VQvFIcmno9rzsjPIoV9bxlmfv8SbUs+A=
X-Received: by 2002:a05:6870:7393:b0:dd:9a31:96d1 with SMTP id
 z19-20020a056870739300b000dd9a3196d1mr7475562oam.98.1648149440484; Thu, 24
 Mar 2022 12:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
 <20220321112310.vpr7oxro2xkz5llh@quack3.lan> <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
 <20220321145111.qz3bngofoi5r5cmh@quack3.lan> <CAOQ4uxgOpfezQ4ydjP4SPA8-7x9xSXjTmTyZOYQE3d24c2Zf7Q@mail.gmail.com>
 <20220323104129.k4djfxtjwdgoz3ci@quack3.lan> <CAOQ4uxgH3aCKnXfUFuyC7JXGtuprzWr6U9Y2T1rTQT3COoZtzw@mail.gmail.com>
 <20220323134851.px6s4i6iiaj4zlju@quack3.lan> <CAOQ4uxhBH_0UqEmOdcUaV0E8oGTGF7arr+Q_EZPuQ=KWfvJWoQ@mail.gmail.com>
 <20220323142835.epitipiq7zc55vgb@quack3.lan> <CAOQ4uxjEj4FWsd87cuYHR+vKb0ogb=zqrKHJLapqaPovUhgfFQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjEj4FWsd87cuYHR+vKb0ogb=zqrKHJLapqaPovUhgfFQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Mar 2022 21:17:09 +0200
Message-ID: <CAOQ4uxgkV8ULePEuxgMp2zSsYR_N0UPdGZcCJzB49Ndeyo2paw@mail.gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
To:     Jan Kara <jack@suse.cz>
Cc:     "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 5:46 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Mar 23, 2022 at 4:28 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 23-03-22 16:00:30, Amir Goldstein wrote:
> > > > Well, but reclaim from kswapd is always the main and preferred source of
> > > > memory reclaim. And we will kick kswapd to do work if we are running out of
> > > > memory. Doing direct filesystem slab reclaim from mark allocation is useful
> > > > only to throttle possibly aggressive mark allocations to the speed of
> > > > reclaim (instead of getting ENOMEM). So I'm still not convinced this is a
> > > > big issue but I certainly won't stop you from implementing more fine
> > > > grained GFP mode selection and lockdep annotations if you want to go that
> > > > way :).
> > >
> > > Well it was just two lines of code to annotate the fanotify mutex as its own
> > > class, so I just did that:
> > >
> > > https://github.com/amir73il/linux/commit/7b4b6e2c0bd1942cd130e9202c4b187a8fb468c6
> >
> > But this implicitely assumes there isn't any allocation under mark_mutex
> > anywhere else where it is held. Which is likely true (I didn't check) but
> > it is kind of fragile. So I was rather imagining we would have per-group
> > "NOFS" flag and fsnotify_group_lock/unlock() would call
> > memalloc_nofs_save() based on the flag. And we would use
> > fsnotify_group_lock/unlock() uniformly across the whole fsnotify codebase.
> >
>
> I see what you mean, but looking at the code it seems quite a bit of churn to go
> over all the old backends and convert the locks to use wrappers where we "know"
> those backends are fs reclaim safe (because we did not get reports of deadlocks
> over the decades they existed).
>
> I think I will sleep better with a conversion to three flavors:
>
> 1. pflags = fsnotify_group_nofs_lock(fanotify_group);
> 2. fsnotify_group_lock(dnotify_group) =>
>     WARN_ON_ONCE(group->flags & FSNOTIFY_NOFS)
>     mutex_lock(&group->mark_mutex)
> 3. fsnotify_group_lock_nested(group) =>
>     mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING)
>

I think I might have misunderstood you and you meant that the
SINGLE_DEPTH_NESTING subcalls should be eliminated and then
we are left with two lock classes.
Correct?

Thanks,
Amir.
