Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542301DF8AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbgEWRPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 13:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387571AbgEWRPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 13:15:11 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D16C061A0E
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 10:15:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d7so14891948ioq.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJLDRRYi0j2+KObfjb+c8PErL8WuW63dv28p7/3ds0U=;
        b=GWe+VKXN+ZFC05Q/7VLva5fv1UouA1+lkSUvPDlDv7NY8jI/Cplo8aZ5isfRpTtwqG
         yOvED3b5udDOs7IXj05q7WpxkkCJZU/Ee5gbruNvOD0yunge/IwtSiU/j6U/KpwhQaAC
         aTurTxaozUYhZmmKDsxdGQ0bQ3vWY6mqcSetrSDbWd7TCNX2wX7rqS9gnaxUctrOKVpA
         9K3vSeLaSUCcs62HhECe9LJ6RFSxi6caCRWvlc4VE65zKAokic2KRjMBupVe5DQezCRw
         eWiCW+6ak3lgA3qKbB85ISlxxQODufIiz/HNrJxvxljKmSQn3JKE1hlHAMj/xVY4JGpo
         5gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJLDRRYi0j2+KObfjb+c8PErL8WuW63dv28p7/3ds0U=;
        b=RNvad0JFnponEnmPoy2QF+bdaqaZbhm69WMdozu3/jeS/tageFqQm1cZc/90x3vuvJ
         f54R+Ri6WTSBFV6yDgDc5MRlPIvg8VcUMrUmeiI9niSFSvMG4Sc4kAsKLLpnGJUQ31Id
         rWq+ZVI9iVJpjcBN/5kzgppZ++01YFn7nKTTD978v0uxou+RzRMRMmNb2RHpV6MGE624
         xNgpbA0lM4VFgSVc/wk5kFdMGO1ciSlPTzvSqc4lTWyCrzX0AaJotyTjGX25hjGv4GKd
         +S2L4a7XGVPLzj1DgGWMbQnMaECkQ2XOg9HaT3dh2LZIL0pRu4JsTUr9akMNvseU8YWx
         b4eA==
X-Gm-Message-State: AOAM530McgUUK6THdzXfpeHEheviSb3GRLD2trtTxidflFlyrG2b7ZTo
        XFiuES6uEBOMsThO2+20sSMjl4GwGFXpm+OJhFfCDO3E
X-Google-Smtp-Source: ABdhPJzF3bgnL7zWPqCZJMPrJ37IJtsD7C7tw7KHJlOAEZGgpNCWobf29kQjn9wxLUQZK1TZcLDxtJGSTlS5RhWDeqw=
X-Received: by 2002:a5d:8c95:: with SMTP id g21mr7591623ion.72.1590254109493;
 Sat, 23 May 2020 10:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200521162443.GA26052@quack2.suse.cz> <CAOQ4uxirUfcpOdxFG9TAHUFSz+A5FMJdT=y4UKwpFUVov43nSA@mail.gmail.com>
In-Reply-To: <CAOQ4uxirUfcpOdxFG9TAHUFSz+A5FMJdT=y4UKwpFUVov43nSA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 May 2020 20:14:58 +0300
Message-ID: <CAOQ4uxgBGTAnZUedY3dEwR9V=hdrr_4PH_snj9E=sz-_UuVzTg@mail.gmail.com>
Subject: Re: Ignore mask handling in fanotify_group_event_mask()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 21, 2020 at 9:10 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, May 21, 2020 at 7:24 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello Amir!
> >
> > I was looking into backporting of commit 55bf882c7f13dd "fanotify: fix
> > merging marks masks with FAN_ONDIR" and realized one oddity in
> > fanotify_group_event_mask(). The thing is: Even if the mark mask is such
> > that current event shouldn't trigger on the mark, we still have to take
> > mark's ignore mask into account.
> >
> > The most realistic example that would demonstrate the issue that comes to my
> > mind is:
> >
> > mount mark watching for FAN_OPEN | FAN_ONDIR.
> > inode mark on a directory with mask == 0 and ignore_mask == FAN_OPEN.
> >
> > I'd expect the group will not get any event for opening the dir but the
> > code in fanotify_group_event_mask() would not prevent event generation. Now
> > as I've tested the event currently actually does not get generated because
> > there is a rough test in send_to_group() that actually finds out that there
> > shouldn't be anything to report and so fanotify handler is actually never
> > called in such case. But I don't think it's good to have an inconsistent
> > test in fanotify_group_event_mask(). What do you think?
> >
>
> I agree this is not perfect.
> I think that moving the marks_ignored_mask line
> To the top of the foreach loop should fix the broken logic.
> It will not make the code any less complicated to follow though.
> Perhaps with a comment along the lines of:
>
>              /* Ignore mask is applied regardless of ISDIR and ON_CHILD flags */
>              marks_ignored_mask |= mark->ignored_mask;
>
> Now is there a real bug here?
> Probably not because send_to_group() always applied an ignore mask
> that is greater or equal to that of fanotify_group_event_mask().
>

That's a wrong statement of course.
We do need to re-apply the ignore mask when narrowing the event mask.

Exposing the bug requires a "compound" event.

The only case of compound event I could think of is this:

mount mark with mask == 0 and ignore_mask == FAN_OPEN. inode mark
on a directory with mask == FAN_EXEC | FAN_EVENT_ON_CHILD.

The event: FAN_OPEN | FAN_EXEC | FAN_EVENT_ON_CHILD
would be reported to group with the FAN_OPEN flag despite the
fact that FAN_OPEN is in ignore mask of mount mark because
the mark iteration loop skips over non-inode marks for events
on child.

I'll try to work that case into the relevant LTP test to prove it and
post a fix.

Thanks,
Amir.
