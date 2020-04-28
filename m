Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03261BCC75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 21:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgD1TgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 15:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728559AbgD1TgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:36:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC3AC03C1AC
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 12:36:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d25so2976177lfi.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dz35P/wW75JPScBtg1LhfcQt3MDYh9XOUGljSwITyf8=;
        b=LfNc2eHH26/bLReUobhiNZUaI4Psyh9CFL0F1oIKCTUu4vYDhvCgsiEQz9hbdMB4Rb
         KnW7pgutm0LfGxr8LV/zvOfjwMUdhySRv26V+yGk/hx4ZZ8MwH38PG53Ti+BpE8dcWd8
         gESAnzEV3eglxpHRlSSfv7r5LQPSduZHTrUtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dz35P/wW75JPScBtg1LhfcQt3MDYh9XOUGljSwITyf8=;
        b=YZI0ODPQbC7+tW1WQSuFqw+GNYULxOXeYoRSUUtz+vzRs1kF8VHew0h5aumm5a5Tdk
         EEeuXObsqB40yxFnJuNPYz4N/S5wT0BwwwR6bZ4qVluI7AKffJOO5WwihQpI0tpAGeqM
         MacXafqJKBvMsVG11w1JtJzdyX+CeNGU8qrmQNmJt/btvoIfu6j0OvQqxAWFwZ8jyFqp
         Zk9mmzy3cNvh/8LjRYrg/2oxm5jFP4GBIgZuQl2XzMpyCmAQCiCpl7hoT7i+eErVSlRv
         H3m3WUK2kKUQ+tPDiXAk7DaEYMojs8+98MkSxmTwjmUw0ep2ZEIBsiw8MYv0M4xfXi4V
         w9Og==
X-Gm-Message-State: AGi0PubvT8D9bA2TdwZH0pCwNGUdRrZoilKT07z5d45BJ5kbwDT+VQlI
        hV0GTCei0aaApVLBXuVxdoLz0kvMrs8=
X-Google-Smtp-Source: APiQypIqWQ3PIZTp6Mbkfev1giMODMq2zM1ti6TmeBik3L26ogump+JSAMVmU0Viqm/+5CBKwIWFCw==
X-Received: by 2002:a19:550a:: with SMTP id n10mr20103557lfe.143.1588102581153;
        Tue, 28 Apr 2020 12:36:21 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id o23sm131459ljh.63.2020.04.28.12.36.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 12:36:19 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a21so22764987ljb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 12:36:19 -0700 (PDT)
X-Received: by 2002:a2e:7308:: with SMTP id o8mr18561211ljc.16.1588102578694;
 Tue, 28 Apr 2020 12:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com> <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
 <875zdmmj4y.fsf_-_@x220.int.ebiederm.org> <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
 <878sihgfzh.fsf@x220.int.ebiederm.org> <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
 <87sggnajpv.fsf_-_@x220.int.ebiederm.org> <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
 <87zhav783k.fsf@x220.int.ebiederm.org>
In-Reply-To: <87zhav783k.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Apr 2020 12:36:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtGJH-jpy2=LuuSPjXp=C+xzxS+oj0E0udzLbnb1Wnag@mail.gmail.com>
Message-ID: <CAHk-=wjtGJH-jpy2=LuuSPjXp=C+xzxS+oj0E0udzLbnb1Wnag@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:59 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> > I think the series looks fine.
>
> Mind if I translate that into
>
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> on the patches?

Sure, go right ahead.

            Linus
