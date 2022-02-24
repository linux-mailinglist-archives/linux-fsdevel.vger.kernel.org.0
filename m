Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6394C393C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 23:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiBXW40 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 17:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiBXW40 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:56:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5A20A94A;
        Thu, 24 Feb 2022 14:55:54 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g39so6385381lfv.10;
        Thu, 24 Feb 2022 14:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIp1Ls9npdQP0dgHRyy6ZSI7XeqWxJiAI55yJU64ieQ=;
        b=AfqemhLSOAtw2XdWZ9vDKqvl+KonvMzuAzd4D5Ip5L/KptC1ppki4GJwIEqcLqUw4s
         NzL7AY9Z45oQlV9q1byBgSo0ULWZyZJGzB/dZmci0sipPoO0u8nkzpJeQSXUVb+5hzYE
         lDoippfcVs0+R7qdQHmAAXXSJJtN8+HzQ0KARNxko7v8ZqP/iO0WWkMGL/WSfJPpLUB4
         LrrKEo4woY7jZklwnsR9b3vfkzQLrcrTSwf28/InZe4nqmb6fCVsxW0JKdeFlebWLkiD
         rjFwzVSxu4oteiUobValcrli8v2SXAorRlHR+bP55zyTm8zSqhH5SX/mRz+zNnb1jL8C
         GHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIp1Ls9npdQP0dgHRyy6ZSI7XeqWxJiAI55yJU64ieQ=;
        b=E3PE3rioG1Mb/89P+BmlRMNoHwp9gWGiMrRvR8oWEDsEpXwRZKHl401PiQwtlvMMHc
         L5N2Yq11FPutMNANdSYG4HRCB4Zr2lNf1lci6nUsjSorPJxe+p52kRFQ1z0G0DwmUwTX
         UBFxCUgRRreljiKRT3iUgQjTpxbMZWPtGXGbth6tHNYvnTOwL1AA8W0VHaR0ehuJsC/q
         kzBW1MGlb7T9HyWnJMS07VvtGKmUVlUYyKPBL8d64xw+LuEbUao1gvMQnhJ1n8pnV5ep
         XuqmotItRJuaqCVj/JKpwvp31/s31Ru/XyvxB4SeNkRMjMDX0SajIR/u/EZ7CqC+27li
         lw0w==
X-Gm-Message-State: AOAM533F3cju2lIVoWDl/m4dn97k39xhJg+lG71ntQ0RQxmrqiJv0mni
        413IYY/0bX9o+PbVydPUYnUVZvvrbIMARPeXltk=
X-Google-Smtp-Source: ABdhPJwPZOllNLGCFXZIs/UQ69leeeHS5g+8R50RoYyG/mTBxqTQeWXCTSbicLNsXzCpmVDdwubSVU75jEp3PX65fFM=
X-Received: by 2002:a05:6512:2001:b0:443:5e17:14a0 with SMTP id
 a1-20020a056512200100b004435e1714a0mr3179234lfb.320.1645743353155; Thu, 24
 Feb 2022 14:55:53 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
 <Yhf+FemcQQToB5x+@redhat.com>
In-Reply-To: <Yhf+FemcQQToB5x+@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 24 Feb 2022 16:55:42 -0600
Message-ID: <CAH2r5mt6Sh7qorfCHWnZzc6LUDd-s_NzGB=sa-UDM2-ivzpmAQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Enabling change notification for network and
 cluster fs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ioannis Angelakopoulos <jaggel@bu.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  With this proposal, you are trying to move away from cifs specific ioctl?

Yes - since there are some applications that already use inotify
(although presumably less common than the similar API on Macs and
Windows), just fixing inotify to call into the fs to register events
is a good first step.  See inotify(7) - Linux manual page e.g.

For the case of SMB3.1.1 the wire protocol should be fine for this
(although perhaps could be a few flags added to inotify to better
match what servers support) See
https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/598f395a-e7a2-4cc8-afb3-ccb30dd2df7c

But there may be other APIs other than inotify that could be mapped to
what is already supported on the wire (with minor changes to the vfs)

On Thu, Feb 24, 2022 at 3:52 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Feb 23, 2022 at 11:16:33PM -0600, Steve French wrote:
> > Currently only local events can be waited on with the current notify
> > kernel API since the requests to wait on these events is not passed to
> > the filesystem.   Especially for network and cluster filesystems it is
> > important that they be told that applications want to be notified of
> > these file or directory change events.
> >
> > A few years ago, discussions began on the changes needed to enable
> > support for this.   Would be timely to finish those discussions, as
> > waiting on file and directory change events to network mounts is very
> > common for other OS, and would be valuable for Linux to fix.
> >
>
> This sounds like which might have some overlap with what we are trying
> to do.
>
> Currently inotify/fanotify only work for local filesystems. We were
> thinking is it possible to extend it for remote filesystems as well. My
> interest primarily was to make notifications work on virtiofs. So I
> asked Ioannis (an intern with us) to try to prototype it and see what are
> the challenges and roadblocks.
>
> He posted one version of patches just as proof of concept and only tried
> to make remote inotify work. One primary feedback from Amir was that
> this is too specific to inotify and if you are extending fsnotify, then
> it should have some support for fanotify as well. There is bunch of
> other feedback too. So Ioannis is trying to rework his patches now.
>
> https://lore.kernel.org/linux-fsdevel/20211025204634.2517-1-iangelak@redhat.com/
>
> Anyway, you had pointed to following commit.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/cifs/ioctl.c?id=d26c2ddd33569667e3eeb577c4c1d966ca9192e2
>
> So looks like application calls this cifs specific ioctl and blocks and
> unblocks when notifications comes, IIUC.
>
> I don't know about SMB and what kind of other notifications does it
> support. With this proposal, you are trying to move away from cifs
> specific ioctl? What will user use to either block or poll for the
> said notification.
>
> Sorry, I might be just completely off the mark. Just trying to find out
> if there is any overlap in what you are looking for and what we are
> trying to do.
>
> Thanks
> Vivek
>
> > --
> > Thanks,
> >
> > Steve
> >
>


-- 
Thanks,

Steve
