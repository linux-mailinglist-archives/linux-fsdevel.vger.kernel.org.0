Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C499C434DD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhJTOd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJTOd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:33:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B679C06161C;
        Wed, 20 Oct 2021 07:31:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z20so26992524edc.13;
        Wed, 20 Oct 2021 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFAwf1Gu+ZBiSW1CPvj4L0uWy2D/0RqhKLQHFsLSUs8=;
        b=EWotqfG/a7IlHyHxzfO3IlJLzDf3b0K6lOYL+cxy84J+m/sr9lXC2gmL8ASPIphDhB
         a0FxJKhe1yt/qWjukMgg1kyE2MOoH3jPt+G2uKtlYo5RAYK1Ut/RT0rU4XUreflUQd+Q
         HC5PCXHYr8QgSZyT19rQyw53al0QucB3wxp70xgOTgI7ULOKA0YlP41uSdGWOuHqRsHL
         1VIB2mxBqdmHUVZQQrI4Ko5QyPb9IMHpqoitpJkHVYF56naYmfbBhDWezJ5vOWrhyVct
         EMrqO7WFk3utTJ67IEn7PT7ku00ZbEkYOKQNtlDFrEqzZg5rtJ0x/qvqESmAu8ZwKFv3
         m3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFAwf1Gu+ZBiSW1CPvj4L0uWy2D/0RqhKLQHFsLSUs8=;
        b=YKYMPIbBqj3TLJsFTpwmtaMQVxxn72IRdCDdecoGNnpXu2KOgyv5yd4rSQB03oG0g6
         TWbqz/2dPPp92dbFEnZIdvxyI2Ebr90H/D3bljDrVf3LJ09z8DCmZuuhTxnJj6bS+wa7
         vayUxjmuBPcI6Sm5qbkJOtWfOzjsqoaLPaWF3/UM5a4ZZkhAUxf2dNtHC5D7V3XagTAR
         zDFoKZygdAjAEMFE/mqnbgoH+/SCMhpMsFwPk8YvqnEAhmvdpzUuH9Ykn/OSJPzABi7c
         NkpFpkb2juiD8URgvGiWNDnFKpUh4siJdbHnX1B1gNe3Ra84qbjLQAMiq+iHLcZgne48
         0abQ==
X-Gm-Message-State: AOAM531hbZkjGa9vw26sJkjd1VBeAQkEWogDM+VvE7RveTHvTn/TDKAW
        UIPZtKOrgtG/EiiRRkvUd2ySaY2+MEWdk3NQ/MxeboTcWIryAQ==
X-Google-Smtp-Source: ABdhPJwCa3TZeYsIQ2sAMttfKhqN3NLqsHmP68L6+eiUiFfr79Mg0tsKGFRs5QqAtWGxtFxc6woGdKg8hI4xr0F5NL8=
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr367043edb.209.1634740165899;
 Wed, 20 Oct 2021 07:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211018114712.9802-1-mhocko@kernel.org> <20211018114712.9802-3-mhocko@kernel.org>
 <20211019110649.GA1933@pc638.lan> <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
 <20211019194658.GA1787@pc638.lan> <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
 <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com> <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>
In-Reply-To: <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 20 Oct 2021 16:29:14 +0200
Message-ID: <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 4:06 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 20-10-21 15:54:23, Uladzislau Rezki wrote:
> > > > >
> > > > I think adding kind of schedule() will not make things worse and in corner
> > > > cases could prevent a power drain by CPU. It is important for mobile devices.
> > >
> > > I suspect you mean schedule_timeout here? Or cond_resched? I went with a
> > > later for now, I do not have a good idea for how to long to sleep here.
> > > I am more than happy to change to to a sleep though.
> > >
> > cond_resched() reschedules only if TIF_NEED_RESCHED is raised what is not good
> > here. Because in our case we know that we definitely would like to
> > take a breath. Therefore
> > invoking the schedule() is more suitable here. It will give a CPU time
> > to another waiting
> > process(if exists) in any case putting the "current" one to the tail.
>
> Yes, but there is no explicit event to wait for currently.
>
> > As for adding a delay. I am not sure about for how long to delay or i
> > would say i do not
> > see a good explanation why for example we delay for 10 milliseconds or so.
>
> As I've said I am OK with either of the two. Do you or anybody have any
> preference? Without any explicit event to wake up for neither of the two
> is more than just an optimistic retry.
>
From power perspective it is better to have a delay, so i tend to say
that delay is better.

-- 
Uladzislau Rezki
