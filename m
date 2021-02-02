Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF5430B449
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 01:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhBBArZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 19:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhBBArY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:47:24 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56834C061573
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Feb 2021 16:46:44 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id h14so18271572otr.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 16:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WH6UCRamzAhKYnpldxr0hXAVPURIDRKU7CFvf5itX0A=;
        b=j0Yf9DRn64cU7+TwHA+p+7dluOx1mTeDwZDjNr8i9XNKyPplUkdwWZcobAuYaUWwO/
         Z8O9rYIGERC390kAZUlxNvpKH6jxA4//70IO1yw4kh1p0qbNtejDJYiZzZ5UaIbWy/nI
         jQkBVUD0PI4/NNbHDGENDW14d8v9V4F2qE3jf2r+C7y1EM8wNGMZ4m5zrnXodJ1bkLJn
         n8IVOjdVnLoEKBnMI5v+tbIN17AzDU/EFUZ1WpmJBDjLYvPlxPj+6g4xA8bdix37fn0b
         Vk2hMtEX9gdEuzqncx45RWi8+Z/Kw4YrzT2m/2z0UMJqlOOBQdLQtynuAkvz8rNXyIgw
         pJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WH6UCRamzAhKYnpldxr0hXAVPURIDRKU7CFvf5itX0A=;
        b=WdB9/AdEcL+w98Jc7tQffoHZ1wHvcgq9lZCf8achjGDJeiy2c/VLyrtiJwNrcsswUT
         utfxLW2PK3Shlr5sYvv6eEUvmWflI/ZVzvTw9hu0mE5yWnOdhn2SSPsQW9BM4pA587li
         Pm0Qd1rxYNgxzdMCjVWA39wlzqkq6IjFXLFJqqicSyEFccS+bNO4AepzL/x4EaGuCdFk
         Tr0SBNdgg/jxHVX6DZXztTySxTZDbbFq9Js8bBXPKE/5f0NnoVQSlJwfDXisV+tJreCP
         WsxdafwpP/0JkqntjOtQkZMKrkEpVJwMzTVLQGonhVXvHHCAGahrBQ5xpwwLgwA0eUx9
         2bJw==
X-Gm-Message-State: AOAM533UuJxlGGOO5ljUsuoYYiRCuJctG1L82FPFtX2VqJjb4jkakJRY
        t3xKMJrNfhsX3S5vtg7v4WkT7rJ1RHeOrQ7a3UE=
X-Google-Smtp-Source: ABdhPJzdgscs8ENbeHZ7FxXqfh8U/YkcPXJvzmJ7IHhxmm62kVEWof3ZFsz5KE/fnrfR+Yqs0lR2/DSn+qvUnRTC3NA=
X-Received: by 2002:a05:6830:15c5:: with SMTP id j5mr13610430otr.185.1612226803629;
 Mon, 01 Feb 2021 16:46:43 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
 <759c43fe-c482-4eaf-8f5e-b82985bbc7da@infradead.org>
In-Reply-To: <759c43fe-c482-4eaf-8f5e-b82985bbc7da@infradead.org>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Mon, 1 Feb 2021 16:46:32 -0800
Message-ID: <CAE1WUT5=xXUcS2m=2bCh_5F7xduh3+mKShVOOZ1Ny17hF=M+Sg@mail.gmail.com>
Subject: Re: Using bit shifts for VXFS file modes
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 1, 2021 at 4:21 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/1/21 3:49 PM, Amy Parker wrote:
> > Hello filesystem developers!
> >
> > I was scouting through the FreeVXFS code, when I came across this in
> > fs/freevxfs/vxfs.h:
> >
> > enum vxfs_mode {
> >         VXFS_ISUID = 0x00000800, /* setuid */
> >         VXFS_ISGID = 0x00000400, /* setgid */
> >         VXFS_ISVTX = 0x00000200, /* sticky bit */
> >         VXFS_IREAD = 0x00000100, /* read */
> >         VXFS_IWRITE = 0x00000080, /* write */
> >         VXFS_IEXEC = 0x00000040, /* exec */
> >
> > Especially in an expanded form like this, these are ugly to read, and
> > a pain to work with.
> >
> > An example of potentially a better method, from fs/dax.c:
> >
> > #define DAX_SHIFT (4)
> > #define DAX_LOCKED (1UL << 0)
> > #define DAX_PMD (1UL << 1)
> > #define DAX_ZERO_PAGE (1UL << 2)
> > #define DAX_EMPTY (1UL << 3)
> >
> > Pardon the space condensation - my email client is not functioning properly.
>
> That's the gmail web interface, right?

Sadly for now yes. Currently migrating to my own local email system -
just waiting on a domain purchase.

> I believe that you can use a real email client to talk to
> smtp.gmail.com and it won't mangle spaces in your emails.

I've tried - smtp.gmail.com either requires:
- OAuth2: doesn't work for most things
- App passwords: not used by any email client dev with a touch of respect

>
> > Anyways, I believe using bit shifts to represent different file modes
> > would be a much better idea - no runtime penalty as they get
> > calculated into constants at compile time, and significantly easier
> > for the average user to read.
> >
> > Any thoughts on this?
>
> It's all just opinions. :)

Sure, it's just opinions, but this is about making stuff easier to
work with for the average kernel monkey.

>
> I find the hex number list easier to read .. and the values are

Fair, wonder what the average person would think? When trying to help
others understand hex I usually show representations in bitshift form
so they can get the place value nature.

> right there in front of you when debugging, instead of having to
> determine what 1 << 9 is.

Maybe, but it takes barely more time to find the ninth digit of the
hex expression when debugging. Plus, since you're counting the places
in - you're a lot less likely to accidentally select the wrong one
when you're debugging if you're just eyeballing the values.

Perhaps adding a docstring above this with maps of the bitshifts to
their raw hex equivalents set as current could be a good idea?

>
> cheers.
> --
> ~Randy
>

Best regards,
Amy Parker
(she/her/hers)
