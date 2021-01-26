Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6398305D3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313384AbhAZWfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbhAZR3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:29:07 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA3C061573;
        Tue, 26 Jan 2021 09:28:23 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d7so9230291otf.3;
        Tue, 26 Jan 2021 09:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oE+4O1Wh9Zqz46DBqGL2Qpek/W+/I2Xiwsv0KyiP524=;
        b=d/8WnMnaF/quGeEMZHiT8Zxqe19lgsTBzzWcgEN0yqpm1dZJahR99+OO6cqNRErnZ7
         Ugu0nqiFCxkaGMfbkKoaH+4lYOV5eAxo7af+c2540odlOiP33+6R2rpqcBAdeVQmr5ou
         Dw+KEt3tCUKd9+8gQOkMEwmYocbeYKnse7owIKBqX/vw4SPnFuW7HckgmTXW0AdRor6H
         VfSBgiszgdcKKSwstWHStqgkPpO8ybR6ReMPzT4dcY3B7J0aZRT0AoMOItrb5rXAz6Xl
         hSfn6EnbpITrAbrmhlp17qGmxFCvlTwhnH4Enjx4DMxweP2RbXbHaeCsg/qvI+sVi+Ra
         v1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oE+4O1Wh9Zqz46DBqGL2Qpek/W+/I2Xiwsv0KyiP524=;
        b=U8GFD2mytrXd3Gtpi4TnW54v5j4D++sa9hXOpJvaPOpIc63ESc+v2pgGtqvJTkFBux
         guELYEemvQWnV4C0yvPPe3gUpQ+aFkCD6ytK6SzFOneTP9OBFzHuHAF7k+X+lqPR9pkw
         7TErzfuSWxrZ5pgd3iGUzYvh7UEXoOCxYb0oeZ8qpPwVd6YCzT3mkdTT0Ez770GOl+DH
         DeRylfG35tICUkqKB2Dqne3ugrmubDWen0YCiXrgFNNPHhW9iDtDYjIYTIyn0RrOiRUO
         +UpWLbYt/tUxODBj7cbwq5cjMuw287n+degVzta4O5silUAkRWGgrHrkkxB4KF1/yxVY
         46sQ==
X-Gm-Message-State: AOAM530ZjqF3Qv9DLOy3/+5CwPrrtRJAdlZzgsYfw0U2tT8kmm7rNxix
        4tHflXqYmXnPCNKsCIW20CIpaIpZg5M5+TI6m6KBQFlgwKM=
X-Google-Smtp-Source: ABdhPJw6e0y83C2uAxHk92Y53Wt13i5KjU/L806bk8n6MArQlkQlijvn3RHOgS1tETkAAOXJxLvORZ22zGpHEU0ayas=
X-Received: by 2002:a05:6830:15c5:: with SMTP id j5mr4736245otr.185.1611682102975;
 Tue, 26 Jan 2021 09:28:22 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
 <D66E412C-ED63-4FF7-A0F9-C78EF846AAF4@dilger.ca>
In-Reply-To: <D66E412C-ED63-4FF7-A0F9-C78EF846AAF4@dilger.ca>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 26 Jan 2021 09:28:11 -0800
Message-ID: <CAE1WUT5phUhqhQgsC82c8pZXBPZ3Aj+TarpGwhSFP=XK6jHQog@mail.gmail.com>
Subject: Re: Getting a new fs in the kernel
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 9:15 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Jan 26, 2021, at 09:25, Amy Parker <enbyamy@gmail.com> wrote:
> >
> > =EF=BB=BFKernel development newcomer here. I've begun creating a concep=
t for a
> > new filesystem, and ideally once it's completed, rich, and stable I'd
> > try to get it into the kernel.
>
> Hello Amy, and welcome.
>
> I guess the first question to ask is what would be unique and valuable
> about the new filesystem compared to existing filesystems in the kernel?

Currently planning those bits out.

>
> Given that maintaining a new filesystem adds ongoing maintenance
> efforts, there has to be some added value before it would be accepted.
> Also, given that filesystems are storing critical data for users, and
> problems in the code can lead to data loss that can't be fixed by a reboo=
t,
> like many other software bugs, it takes a very long time for filesystems
> to become stable enough for general use (the general rule of thumb is 10
> years before a new filesystem is stable enough for general use).

Yeah, I understood that. Wasn't expecting this to go quickly or
anything, just wanted to know for the future.

>
> Often, if you have ideas for new functionality, it makes more sense to
> add this into the framework of an existing filesystem (e.g. data verity,
> data encryption, metadata checksum, DAX, etc. were all added to ext4).

Been considering doing this too.

>
> Not only does this simplify efforts in terms of ongoing maintenance, but
> it also means many more users will benefit from your development effort
> in a much shorter timeframe. Otherwise, users would have to stop
> using their existing filesystem before
> they started using yours, and that is
> a very slow process, because your filesystem would have to be much
> better at *something* before they would make that switch.

True, alright.

>
> > What would be the process for this? I'd assume a patch sequence, but
> > they'd all be dependent on each other, and sending in tons of
> > dependent patches doesn't sound like a great idea. I've seen requests
> > for pulls, but since I'm new here I don't really know what to do.
>
> Probably the first step, before submitting any patches, would be to
> provide a description of your work, and how it improves on the current
> filesystems in the kernel. It may be that there are existing projects tha=
t
> duplicate this effort, and combining resources will result in a 100% done
> filesystem rather than two 80% done
> projects...

Alright, if I continue on with this I'll do that.

>
> Note that I don't want to discourage you from participating in the Linux
> filesystem development community, but there are definitely considerations
> going both ways wrt. accepting a new filesystem into the kernel. It may b=
e
> that your ideas, time, and efforts are better spent in contributing to an
> exiting project.  It may also be that you have something groundbreaking
> work, and I look forward to reading about what that is.

Alright, thank you so much!

Best regards,
Amy Parker
(she/her/hers)
