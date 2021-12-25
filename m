Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59F47F45F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Dec 2021 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhLYULy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Dec 2021 15:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbhLYULw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Dec 2021 15:11:52 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA97C061401;
        Sat, 25 Dec 2021 12:11:52 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id i14so13584379ioj.12;
        Sat, 25 Dec 2021 12:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9gSv+D6ZVabSi8kdjFElUiGMxvV86r+Boyq2WmXC7Gc=;
        b=lSyNqrx/70L2ZkYNtrA7Nc9QWt1iF+rqmErUIk67pO1S9JetJvapHyv6UHtug5tAru
         +tmlB4Q3k/p+TCirjQjRZ89sf6A10pJlUb2BRtoELGBVFISt5C4TEep/+oGP2C5fo201
         +kTh0OLVl4n1mMewagSHRor0zBvNxcK378vBCT8JVHfv3+YnMrZcXGOb5qXKJbxBz1E/
         RswJHgLhs7m30SkPoY2mLNByX01Ve5rKcOqlAVMjKR537F2+qflXNlegexNw+/MHXVbk
         QBeNc1NXixB2HBTmSRvYaVT0J5AoerlyAHRTyu/ZeWuy3fkh6I5toTdAPo1N08KCK/Vp
         ykGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9gSv+D6ZVabSi8kdjFElUiGMxvV86r+Boyq2WmXC7Gc=;
        b=dnPonkIfJVt8mAC/GPx0OAYfB3fIftWGcsThKj/9BH4tfqLAnRRwIHQj5S+Yjx5TXj
         YUUnR5NBvaQGHcvIaKHw0r2IklrlipErBp3gyZMbXANsG/H2A4mP/syPokRccqYBCQ2n
         nvR9A34WEQU2+AgkfrVpIrL1M1yh7PP1JTDgmF/AR8u6EVmsjGX+V0pXfoLSNA3yhcYr
         o0knmEClU0saYwySFMG+vFpUUnAyaeH1+x7zpBsHgKkKh2GFmA69Z+tpXM+D/icFHRae
         i5hDQOl5Cg29sLIoCpfl4SEcb1iXbd9bPKEJU6iS/xSxSJB8zv+I3/e5y6yYqppZiyrB
         aHCg==
X-Gm-Message-State: AOAM533KCYgfHBlTaKhkvI+tKuUlpt6BUZDgt4u90XNlU5V7JrrAdFkY
        nclcO1ipjOSz/8t+YGsNG8Jle3jnW6XhiSPO0XE=
X-Google-Smtp-Source: ABdhPJyWyolpO76Z0/jfR3sAqvFD5d/G04a6FUG3MOFoNbZQamzEjgO93FIFRa5ya7QazdjtYVFyksv0wc8fUWZqq1c=
X-Received: by 2002:a05:6602:2c83:: with SMTP id i3mr4859680iow.128.1640463111095;
 Sat, 25 Dec 2021 12:11:51 -0800 (PST)
MIME-Version: 1.0
References: <b5817114-8122-cf0e-ca8e-b5d1c9f43bc2@gmail.com>
 <20211217152456.l7b2mbefdkk64fkj@work> <b1fa8d59-02e8-16b7-7218-a3f6ac66e3fa@gmail.com>
 <df69973d-47c5-fbd6-f83d-4d7d8a261c4c@gmail.com> <d05a95a9-0bbd-3495-2b81-18673909edd4@gmail.com>
 <20211220111231.ncdfcynvoiidl7is@work>
In-Reply-To: <20211220111231.ncdfcynvoiidl7is@work>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 25 Dec 2021 21:11:14 +0100
Message-ID: <CA+icZUXBBgaeF3NhoVZ7YSg9F66XJSPsbfCgSR5RB6x5-s55gA@mail.gmail.com>
Subject: Re: Problem with data=ordered ext4 mount option in linux-next
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:53 PM Lukas Czerner <lczerner@redhat.com> wrote:
>
> On Fri, Dec 17, 2021 at 07:26:30PM +0100, Heiner Kallweit wrote:
> > On 17.12.2021 18:02, Heiner Kallweit wrote:
> > > On 17.12.2021 16:34, Heiner Kallweit wrote:
> > >> On 17.12.2021 16:24, Lukas Czerner wrote:
> > >>> On Fri, Dec 17, 2021 at 04:11:32PM +0100, Heiner Kallweit wrote:
> > >>>> On linux-next systemd-remount-fs complains about an invalid mount option
> > >>>> here, resulting in a r/o root fs. After playing with the mount options
> > >>>> it turned out that data=ordered causes the problem. linux-next from Dec
> > >>>> 1st was ok, so it seems to be related to the new mount API patches.
> > >>>>
> > >>>> At a first glance I saw no obvious problem, the following looks good.
> > >>>> Maybe you have an idea where to look ..
> > >>>>
> > >>>> static const struct constant_table ext4_param_data[] = {
> > >>>>  {"journal",     EXT4_MOUNT_JOURNAL_DATA},
> > >>>>  {"ordered",     EXT4_MOUNT_ORDERED_DATA},
> > >>>>  {"writeback",   EXT4_MOUNT_WRITEBACK_DATA},
> > >>>>  {}
> > >>>> };
> > >>>>
> > >>>>  fsparam_enum    ("data",                Opt_data, ext4_param_data),
> > >>>>
> > >>>
> > >>> Thank you for the report!
> > >>>
> > >>> The ext4 mount has been reworked to use the new mount api and the work
> > >>> has been applied to linux-next couple of days ago so I definitelly
> > >>> assume there is a bug in there that I've missed. I will be looking into
> > >>> it.
> > >>>
> > >>> Can you be a little bit more specific about how to reproduce the problem
> > >>> as well as the error it generates in the logs ? Any other mount options
> > >>> used simultaneously, non-default file system features, or mount options
> > >>> stored within the superblock ?
> > >>>
> > >>> Can you reproduce it outside of the systemd unit, say a script ?
> > >>>
> > >> Yes:
> > >>
> > >> [root@zotac ~]# mount -o remount,data=ordered /
> > >> mount: /: mount point not mounted or bad option.
> > >> [root@zotac ~]# mount -o remount,discard /
> > >> [root@zotac ~]#
> > >>
> > >> "systemctl status systemd-remount-fs" shows the same error.
> > >>
> > >> Following options I had in my fstab (ext4 fs):
> > >> rw,relatime,data=ordered,discard
> > >>
> > >> No non-default system features.
> > >>
> > >>> Thanks!
> > >>> -Lukas
> > >>>
> > >> Heiner
> > >
> > > Sorry, should have looked at dmesg earlier. There I see:
> > > EXT4-fs: Cannot change data mode on remount
> > > Message seems to be triggered from ext4_check_opt_consistency().
> > > Not sure why this error doesn't occur with old mount API.
> > > And actually I don't change the data mode.
> >
> > Based on the old API code: Maybe we need something like this?
> > At least it works for me.
> >
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index b72d989b7..9ec7e526c 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -2821,7 +2821,9 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
> >                                  "Remounting file system with no journal "
> >                                  "so ignoring journalled data option");
> >                         ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
> > -               } else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) {
> > +               } else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS &&
> > +                          (ctx->vals_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) !=
> > +                          (sbi->s_mount_opt & EXT4_MOUNT_DATA_FLAGS)) {
>
> Hi,
>
> indeed that's where the problem is. It's not enogh to check whether
> we have a data= mount options set, we also have to check whether it's
> the same as it already is set on the file system during remount. In
> which case we just ignore it, rather then error out.
>
> Thanks for tracking it down. I think the condition can be simplified a
> bit. I also have to update the xfstest test to check for plain remount
> without changing anything to catch errors like these. I'll send patch
> soon.
>

Is "ext4: don't fail remount if journalling mode didn't change" the
fix for the issue reported by Heiner?

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=4c2467287779f744cdd70c8ec70903034d6584f0

> Thanks!
> -Lukas
>
> >                         ext4_msg(NULL, KERN_ERR, "Cannot change data mode "
> >                                  "on remount");
> >                         return -EINVAL;
> >
>
