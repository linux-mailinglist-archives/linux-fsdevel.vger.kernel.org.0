Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE6E311544
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBEW0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhBEOUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:20:10 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F8BC061BC3;
        Fri,  5 Feb 2021 07:56:11 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id q5so6202356ilc.10;
        Fri, 05 Feb 2021 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NkWrwD+0iBY0AMI/Yx8lcRpCycaSsO404tmH7mOdGV0=;
        b=l+EUrOAUSrfAV03jCy1lMdnJRW5gWWbZWzaLQCQ3ya/XW/WusXwUDtqerJY8QKDxjb
         nMyliiVONhz+gMFl3x49wy16tOfpfzI/ycqpDpSuLAFVkrEgs2/LABC6WVCkmrk4P3Jj
         YG8LW9x7upN8zKwzR2U/NnrCk+hOfEa3BW34UPbGsDA7iZvTAT7ieOIn6b5cIz6bHS8B
         N+ACnr4qU11yK/240H+7RU1If0I1v/ZIosfrBE+MXMhXMEuRmDh0XImyhgtRBMQAkcV6
         z244t9aGyFlLRIYzvJP0+RxrdISTzzNqSbE16DU4Iqy51X0awDMhbqQMnWK4wp4Gz9MM
         fGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NkWrwD+0iBY0AMI/Yx8lcRpCycaSsO404tmH7mOdGV0=;
        b=MyLV8JlWQ27b4mzJmswjgMKO+0Vejs5V+SqDNqw4NBNjuFkaWFx349EiseFKsGZ1Bz
         DHfAsDVqnGxUbYgWFRnVd1mBvNusof98s5nazJI79ZpRkCOZrBw45WGX8b31i2FAsuxl
         4KmhrNyP8zp9rvDr/diZVKUQho+bfF5M+AJeIKZ8oE/2H3KVuoEKAfDCAFyun/gUQeM2
         W61VgP6+jmILdQpyjOBvZIC86/2byDcWKr6LS4WOkHBRI883Wl14u+R9kA4qty4Hn0PH
         x5n3DploymXRIRXdVUsKCw0HKCGMXWy0pZXApLESTzXn43ejVeBjnyjeYlRMmwi2HccU
         nqxQ==
X-Gm-Message-State: AOAM532eaexAifL7cFyB+GzcrcCSoMRYX1Rvb8jyyjVB+8r1nxeKu5OK
        k4I7xkcmACrtp3fHUle0VDIO4kuvLtAFDkiayf4=
X-Google-Smtp-Source: ABdhPJzH9oG7rDdE0KHhlyTkzPELm3dtJnUracCm5bXpmsToyJPVAyZv8mv098u6Y9LghFSdQSjTEaQWbqNe5fabjQQ=
X-Received: by 2002:a92:6403:: with SMTP id y3mr4340494ilb.72.1612540571436;
 Fri, 05 Feb 2021 07:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20210205122033.1345204-1-unixbhaskar@gmail.com>
 <CAOQ4uxhy2XG=EBg6f6xwSNZnYU9z0vx0W6Q2pXDT_KOTKWPZ8A@mail.gmail.com> <YB1EHZL5gbVGO1Xx@ArchLinux>
In-Reply-To: <YB1EHZL5gbVGO1Xx@ArchLinux>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 5 Feb 2021 17:56:00 +0200
Message-ID: <CAOQ4uxgNQ9wCp_0jBiFf8Vzze6FG=pVO04gxF4wki4fePRTauA@mail.gmail.com>
Subject: Re: [PATCH] fs: notify: inotify: Replace a common bad word with
 better common word
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 3:12 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
> On 14:45 Fri 05 Feb 2021, Amir Goldstein wrote:
> >On Fri, Feb 5, 2021 at 2:20 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
> >>
> >>
> >>
> >> s/fucked/messed/
> >>
> >> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> >> ---
> >>  fs/notify/inotify/inotify_user.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> >> index 59c177011a0f..0a9d1a81edf0 100644
> >> --- a/fs/notify/inotify/inotify_user.c
> >> +++ b/fs/notify/inotify/inotify_user.c
> >> @@ -455,7 +455,7 @@ static void inotify_remove_from_idr(struct fsnotify_group *group,
> >>         /*
> >>          * We found an mark in the idr at the right wd, but it's
> >>          * not the mark we were told to remove.  eparis seriously
> >> -        * fucked up somewhere.
> >> +        * messed up somewhere.
> >>          */
> >>         if (unlikely(found_i_mark != i_mark)) {
> >>                 WARN_ONCE(1, "%s: i_mark=%p i_mark->wd=%d i_mark->group=%p "
> >> --
> >> 2.30.0
> >>
> >
> >Same comment as the previous attempt:
> >
> >https://lore.kernel.org/linux-fsdevel/20181205094913.GC22304@quack2.suse.cz/
> >
> >Please remove the part of the comment that adds no valuable information
> >and fix grammar mistakes.
> >
> I am not sure Amir ..could you please pinpoint that.
>

        /*
         * We found a mark in the idr at the right wd, but it's
         * not the mark we were told to remove.
         */

Thanks,
Amir.
