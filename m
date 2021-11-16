Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B297453774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 17:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhKPQcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 11:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhKPQcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:32:20 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ADAC061766
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 08:29:22 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id y3so59197885ybf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jo2z/sk4w5ET+TMNOU4Bv9tAqb0FTWbn//GMT837wWo=;
        b=Bj3MQbYKuY2HSsvTHleRkzdz0dS4u/QQIFIQVLy6ihpEnMue9pCmiUT3ro8/eJQHui
         uJYhXtGbAv55wIXPjWI9Dx/BKBAq3GHdtRIgBD3+smRb+wUDMLZJ1P9Thz2j+cPTOFlh
         FWPlVw5XIFz1/w9V5JXJFshQsFFTfUq7/HoA3xZqUfmgZo+sEytywvzlOyQDoAB6jE+I
         MLkxypGX8akOQxBMGvP7ZkMyuuldubtDbbwPASHgLgi0B3yrjwcMQpvGW2JQhRoj89UA
         uR1JzkQhGJOOI5RYp+dthWzzbkZ2esiMcZgrTg/pS8atsHEt71SpMxHAgxIm4KK+XuG3
         WrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jo2z/sk4w5ET+TMNOU4Bv9tAqb0FTWbn//GMT837wWo=;
        b=KAHeLbRq/7I9AaoKl3Kf6++erftABuHA91h38cj+v0Cg22waeg9wWHNfFCwhk1g3bD
         uoZ3xi8tsNZ4aK43Qe8SV+CtQFrl0pDbdLomvLgY8fXMSN6IF98cJz/FVNTjs6Ma1VW+
         ErTMK5qI6z967cdnTKdAgoj/1MutrgLEDeyjZPqUWB/i7p+chrjfT5WX2JcPSyEpXtpo
         mDHFtOx0RmwG71HYRvT9kTFBJ37yC300dSmiCmeJwCuWad3+yi1Gk2kCcvgTH6hN6PaM
         Y5Z+007uB209cxmlshaV5JzRShxECggVFgrqGNDh/KAvHmGtoADJalE0qVuww0711rDP
         A/7g==
X-Gm-Message-State: AOAM533BtnhV8NH9LQQ/rfyI/IWgZ/DCNqIsi+UGfuqcq+/LUtA7L7eP
        S0gQt7szZVsEnEjpHL+Gz3zZ/JdcxGMuWttjyzE+dA==
X-Google-Smtp-Source: ABdhPJyWGi9v6oZRY6+Aur7ihxhAeaLhwnzKpU43nXHE9UtzmOl9DYKed1QSbT413RMotAwHS4PAVJeWYYSOX5AUNN0=
X-Received: by 2002:a25:2f58:: with SMTP id v85mr9626618ybv.487.1637080161720;
 Tue, 16 Nov 2021 08:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20211019215511.3771969-1-surenb@google.com> <20211019215511.3771969-2-surenb@google.com>
 <89664270-4B9F-45E0-AC0B-8A185ED1F531@google.com> <CAJuCfpE-fR+M_funJ4Kd+gMK9q0QHyOUD7YK0ES6En4y7E1tjg@mail.gmail.com>
 <CAJuCfpHfnG8b4_RkkGhu+HveF-K_7o9UVGdToVuUCf-qD05Q4Q@mail.gmail.com>
 <CAJuCfpEJuVyRfjEE-NTsVkdCZyd6P09gHu7c+tbZcipk+73rLA@mail.gmail.com> <YZN/BMImQqrK4MWm@dhcp22.suse.cz>
In-Reply-To: <YZN/BMImQqrK4MWm@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 16 Nov 2021 08:29:10 -0800
Message-ID: <CAJuCfpH6Cg=CDut_9vd3BcX6U_X0WR2tFkqKePLU7aPxFO0UDw@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] mm: add a field to store names for private
 anonymous memory
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, Alexey Alexandrov <aalexand@google.com>,
        ccross@google.com, sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com, pavel@ucw.cz,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 1:51 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 15-11-21 10:59:20, Suren Baghdasaryan wrote:
> [...]
> > Hi Andrew,
> > I haven't seen any feedback on my patchset for some time now. I think
> > I addressed all the questions and comments (please correct me if I
> > missed anything).
>
> I believe the strings vs. ids have been mostly hand waved away. The
> biggest argument for the former was convenience for developers to have
> something human readable. There was no actual proposal about the naming
> convention so we are relying on some unwritten rules or knowledge of the
> code to be debugged to make human readable string human understandable
> ones. I believe this has never been properly resolved except for - this
> has been used in Android and working just fine. I am not convinced TBH.
>
> So in the end we are adding a user interface that brings a runtime and
> resource overhead that will be hard to change in the future. Reference
> counting handles a part of that and that is nice but ids simply do not
> have any of that.

I explained the way this interface is used and why ids would not work
for us in https://lore.kernel.org/all/CAJuCfpESeM_Xd8dhCj_okNggtDUXx3Nn9FpL_f9qsKXKZzCKpA@mail.gmail.com.
I explored all the proposed alternatives, all of which would be
prohibitive for our needs due to performance costs compared to this
solution. I wish I could come up with something simpler but a simpler
solution simply does not meet our needs.

It's true that this approach does not formalize how VMAs are named but
I don't see why kernel should impose a naming convention. I can see
some systems defining more formal conventions but I believe it should
be up to the userspace to do that.

>
> > Can it be accepted as is or is there something I should address
> > further?
>
> Is the above reason to nack it? No, I do not think so. I just do not
> feel like I want to ack it either. Concerns have been expressed and I
> have to say that I would like a minimalistic approach much more. Also
> extending ids into string is always possible. The other way around is
> not possible.

Unfortunately, extending ids into strings comes with the cost we can't
afford in Android. Therefore I don't see a point for me to upstream
such a solution which I can't use.
Thanks,
Suren.

>
> --
> Michal Hocko
> SUSE Labs
