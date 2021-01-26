Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC3C305D05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313575AbhAZWhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbhAZUR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:17:56 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1511C061756;
        Tue, 26 Jan 2021 12:17:14 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id f6so17503049ots.9;
        Tue, 26 Jan 2021 12:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kR1CzsXOyhbfdePrw8J7SJajl/lzunWy0D5vYXJHhs=;
        b=ukgjj6eKSIl6nKmIFvR7EPdIO6gTKy2AWW+H32T5WA+SgDyuOIK4LBsYcdDSVutkJx
         bTU0A9OjT68Hc205L431Lv/HtytbC3He6EDSwYmr6ycrub4aoahQH4fT2Cdj6oBm0BiV
         r6DRU0rOhp5cT/wWlaR2FJnlxUig3NIMIgrLJGHi8u+ikPjql+lVq/c3WXDAkX2GcIP8
         2dIiXaSijdTVmMLE9QY//VaoWesQj+QiApTCHdSW42zsleOurep8ogWB9eic5U+z0CHM
         q5anJEsloPSDJzGBXbn00p4lpsxG2KK+rLXYUiv4kkswW1hKIZu4rqvWsQ99F91vhcNO
         ovHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kR1CzsXOyhbfdePrw8J7SJajl/lzunWy0D5vYXJHhs=;
        b=mqaBXf4WApWPV6lwsukfjpuRsur1J3Bh/TFrvwYGfxAckrP2fe0Ui1P9digUhFn2cd
         J682nhw/gRuZ4K3m6HANgOBauokpxKOoi6jCrpDGydhdbxn93LPGud22np3VssEmMgor
         xynNzMPwEZqCMyerdtt71sUd4hecup5/PtA1NJJMiR3PoF7G7uPqEcvvoT39HhG9w+DE
         twj/9apA0xVXNy4d58ZnVpnkXHT7PUpwEOdBzR14w7MRNhwjlZ+q/C0LjL49909i3oFW
         AHFd/+SjsghvEu6jFYnulZg8iwB9EOMPV6STVvn1gaS11/tyovX7GI8pkLBhXH0eukYq
         lzzw==
X-Gm-Message-State: AOAM532MlmlaiBsZy7FF90ew7EbJYJ/cl8s6Kzt/JSYSEcDQAxehoPUj
        ErfeAmFpiNeqXQ35VYybdYcB5JnnUMGz1ExGGtw=
X-Google-Smtp-Source: ABdhPJz7K0U0HcbeTJG3mnHYKSVqLPrr6aH5M4xFQU5/PRNNtqzy2aCzpFnMsBDD0k7DSqTVVWZMZTYaY1Y59580h4s=
X-Received: by 2002:a9d:1421:: with SMTP id h30mr5350436oth.45.1611692233979;
 Tue, 26 Jan 2021 12:17:13 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
 <BYAPR04MB4965F2E2624369B34346CC5686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965F2E2624369B34346CC5686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 26 Jan 2021 12:17:02 -0800
Message-ID: <CAE1WUT4DF3hWBqTdrD5Mb8pmyr6EUiCQvpuCpwoGk27oq0vy8Q@mail.gmail.com>
Subject: Re: Getting a new fs in the kernel
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 11:06 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> Amy,
>
> On 1/26/21 8:26 AM, Amy Parker wrote:
> > Kernel development newcomer here. I've begun creating a concept for a
> > new filesystem, and ideally once it's completed, rich, and stable I'd
> > try to get it into the kernel.
> >
> > What would be the process for this? I'd assume a patch sequence, but
> > they'd all be dependent on each other, and sending in tons of
> > dependent patches doesn't sound like a great idea. I've seen requests
> > for pulls, but since I'm new here I don't really know what to do.
> >
> > Thank you for guidance!
> >
> > Best regards,
> > Amy Parker
> > she/her/hers
> >
> From what I've seen you can post the long patch-series as an RFC and get the
>
> discussion started.
>
> The priority should be ease of review and not the total patch-count.

Alright, thank you for the advice, Chaitanya!

Best regards,
Amy Parker
(she/her/hers)
