Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0394F34EE05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 18:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhC3QgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 12:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhC3QgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:36:13 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F071AC061574;
        Tue, 30 Mar 2021 09:36:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k8so17057262iop.12;
        Tue, 30 Mar 2021 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oeYjBqHc7PZBTMmBxWJLQqVGY7NmsdQtgDUEsBknHEY=;
        b=fOmINC19Y9ovXara48by0IaM2ntvQEqUCo2suwUTHdeuAq30HWiP0fyuk7Iut1O4R7
         1jr7uXmUkxL0tgLUEesdncOHKI+aJoQmZhxPfEdk2IXx+rU4wcJktkuUUZ25+8NtFPd3
         66o7lSsw5mkXXKDbCiRS66aTMBiK3iHL+ucH/kilPOmK39NxpBwmCLVZTGK7H28mMTTD
         GYVaxzkm3H/xZKUe37Gw3RiP3W9h4XhF35lTl2lUgWjVWS/5itI5gh2gBmmgwXxtVUlA
         9hjUak1DPjzLZqP3YO/Qh0koOyJ/6LQus5ybTuypCvS7d7YsqZC0EGvNiF6UDDQSQTax
         kS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oeYjBqHc7PZBTMmBxWJLQqVGY7NmsdQtgDUEsBknHEY=;
        b=RNtsJCae9PoCKnkYWISkx+yWw5B9LhdRP1u/4PAm4KuVpcgEH3na1+46mBA+YYhXjf
         O3Zs4J3d+XCf8KKr1hERZhrTRZrPaWOwk79QvV0ILQP09ksuMPlKXqxGEDwjap2OzA84
         2GtzbipFLjf6iKQ1jpkJFCMp30Fj9msboK1TE+/6uscD//9uIRBRnXfcBtG+enIXSZMV
         5ClUOik7ysNnadeiKGBVvBeLSK3I8ehGQY7Pz9FqDc5YFm+9NsBV04dax3HB6r07OqCq
         723iAoxZTDMrDx7+33y//BPIDoT3kZyPWYLHTJwCYd6gkTAUkMuxMkwxB14weaohZ1/0
         VUIw==
X-Gm-Message-State: AOAM531rTbwYxsq+1rqkmZfO8zab+0go9pgPd2BbML2cXvvSKY2NSmjW
        LgGcsejr7d237Gsh/gNi0qL6PexetI+hb2Sr+FXUBF4MHY2OlA==
X-Google-Smtp-Source: ABdhPJyxNQ1hK/Oi+il7wYXauWWUmOq85abvhZYkrAMxGbUZZrfoWppAI82AQPjyknVOdY3yQa/gX0upGGzKVddZTCk=
X-Received: by 2002:a5d:8707:: with SMTP id u7mr24519616iom.18.1617122172459;
 Tue, 30 Mar 2021 09:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org> <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
 <m1blc1gxdx.fsf@fess.ebiederm.org> <CALCv0x2-Q9o7k1jhzN73nZ9F5+tcp7T8SkLKQWXW=1gLLJNegA@mail.gmail.com>
 <m1r1kwdyo0.fsf@fess.ebiederm.org> <CALCv0x0FQN+LSUkJaSsV=MCjpFokfgHeqSTHYOTpzA6cOyvQoA@mail.gmail.com>
 <e52b2625-8d33-c081-adeb-f92f64ca1e8e@wanyeetech.com> <CALCv0x29Dvs2R=Hg9FebGUFZpd+vN1Lzz2N6a2Zohgo47ZhsGg@mail.gmail.com>
 <05dc921e-da71-4e71-6132-736eccd35680@wanyeetech.com> <CAHk-=whHhEQW52FYV+J68Z+OZd5tUPv=Fa_o06n9Jj5J4wJU4w@mail.gmail.com>
In-Reply-To: <CAHk-=whHhEQW52FYV+J68Z+OZd5tUPv=Fa_o06n9Jj5J4wJU4w@mail.gmail.com>
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Date:   Tue, 30 Mar 2021 09:36:01 -0700
Message-ID: <CALCv0x3V5kN_hU2-=XPPo=QETyQ2kSUc+4Z_=2kT7ecE5meA3w@mail.gmail.com>
Subject: Re: exec error: BUG: Bad rss-counter
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 9:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 29, 2021 at 9:56 PM Zhou Yanjie <zhouyanjie@wanyeetech.com> w=
rote:
> >
> > On 2021/3/29 =E4=B8=8A=E5=8D=8810:48, Ilya Lipnitskiy wrote:
> > >
> > > Try:
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index c8e357627318..1fd753245369 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -166,7 +166,7 @@ static int __init init_zero_pfn(void)
> > >          zero_pfn =3D page_to_pfn(ZERO_PAGE(0));
> > >          return 0;
> > >   }
> > > -core_initcall(init_zero_pfn);
> > > +early_initcall(init_zero_pfn);
> >
> > It works, thanks!
>
> Looks good to me - init_zero_pfn() can be called early, because it
> depends on paging_init() will should have happened long before any
> initcalls in setup_arch().
>
> Ilya, mind sending a signed-off version with a nice commit message,
> and I'll apply it.
Sorry, I could have done better linking it to this thread - I actually
did submit it recently - please see
https://lkml.kernel.org/r/20210330044208.8305-1-ilya.lipnitskiy@gmail.com

Ilya
