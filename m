Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D3F35A2B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhDIQJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhDIQJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:09:29 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2232BC061760
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Apr 2021 09:09:16 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id t14so5150402ilu.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVgQuugp35/IwikYZQzNlXkslqCMcUntW5Q3g+Ok++8=;
        b=gPXMvDHcL1NhahWmX4PkfNdFuZuxveZW1Pzu5oDTmXV/WXQ1pH6GmMtR3x8D+P8wsX
         96Ri0Aha1uvRFNs7CsQVWqzkbeEn7Uht03YbQKeyEjfpZxO70U3YJUPDxyJ+PeOuECqI
         DtiUXWYgvzqkpdELIo17i+2vcWt2B8tVxRNu4vFEIlJn081pMEOGDgJ/KSWaFW/dLfJR
         WTQXp070tGVgyPpJz3GyaUL5CpbhOA/oPeApPpe6i6yR7oWLucdoimJMnChPFc5Cd9it
         9eAw3hiriYbK0GDLXMS27+9ATlSJ8dZvGb4PIrNdZSwib5FsEZ3VEu8/QSY1BLH7B0w5
         T6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVgQuugp35/IwikYZQzNlXkslqCMcUntW5Q3g+Ok++8=;
        b=lJtfIjEQnvMGThXg2gVnqt+R+qoMpaUCeUE3wlu8ry3qkYX7rM+5W6Gilad/NpRsj1
         m7qINp79hN3B/WydX/bg30A5eBWSLWq+lK9CHmgsTSZFPfTU4xWKYjQ4JzYhS6WNpkuz
         Z1HDu+KoH7ETTPIfnQ+O9+lgHZiWUDlSRtFg+b4mnLVnJEXw7WLf5o1W9tC6ikHR4/h3
         5H2yXb0AbN8+hfNAvinhWfP2dZXTZ5LAfgWVDIC4WtoGALQg/7N5Slw2MQ7+QmuOTxTa
         ra5l5exdBn09h6/3oupPcGFhQHnw1AH1tNGtQ11EGCHu3QXIICnooxohwZxa3S4xdfpb
         MxmA==
X-Gm-Message-State: AOAM5330+LUGdbkLqJcqYwurWdL3Pm5LU/kGDx8t+qmwf/7IjeeNjspa
        PkbOcFsACUFHRf5jRBoHCFTljbe4pyrWjH5vm5w=
X-Google-Smtp-Source: ABdhPJytPMND4obtBTZGfXdaP5b4k1srySSezmsx65Kx5O55d07ycR91ODaLJIYnHlWiQLi0jeR7cQSP6WjKeX1HHgI=
X-Received: by 2002:a92:d44c:: with SMTP id r12mr12219716ilm.275.1617984555662;
 Fri, 09 Apr 2021 09:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz> <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz> <CAOQ4uxi5Njbp-yd_ohNbuxdbeLsYDYaqooYeTp+LpaSnxs2r4A@mail.gmail.com>
 <YHBk9f6aQ/TMsj5n@zeniv-ca.linux.org.uk> <CAOQ4uxi-UhF=6eaxhybvdBX-L5qYx_uEuu-eCiiUzJPvz2U8aw@mail.gmail.com>
In-Reply-To: <CAOQ4uxi-UhF=6eaxhybvdBX-L5qYx_uEuu-eCiiUzJPvz2U8aw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Apr 2021 19:09:04 +0300
Message-ID: <CAOQ4uxiLhTPFKHE8k285+C_GwfUOJCD74sSBjuC6rcc2TaiX2A@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 9, 2021 at 7:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Apr 9, 2021 at 5:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Apr 09, 2021 at 04:22:58PM +0300, Amir Goldstein wrote:
> >
> > > But we are actually going in cycles around the solution that we all want,
> > > but fear of rejection. It's time to try and solicit direct feedback from Al.
> > >
> > > Al,
> > >
> > > would you be ok with passing mnt arg to vfs_create() and friends,
> > > so that we can pass that to fsnotify_create() (and friends) in order to
> > > be able to report FAN_CREATE events to FAN_MARK_MOUNT listeners?
> >
> > I would very much prefer to avoid going that way.
>
> OK, so I will go with the more "expressive" implementation that Jan suggested.
>
> Callers that do NOT care about mount mark semantics will use the
> wrapper:
>
> vfs_create_notify(mnt, ...)

Oops, there was not supposed to be mnt arg in this wrapper -
that's the point.
Maybe I should name it xxx_inode_notify() to be more exact.

Thanks,
Amir.

> {
>     vfs_create(...
>     fsnotify_create(NULL,...
> }
>
> The two callers that do care about mount mark semantics (syscalls
> and nfsd) will open code:
>
> vfs_create(...
> fsnotify_create(mnt,...
>
> Hope that way works better for you.
>
> Thanks,
> Amir.
