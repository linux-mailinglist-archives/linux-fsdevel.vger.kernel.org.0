Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE64FF573
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiDMLLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiDMLLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:11:46 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5CC764E
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 04:09:24 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s6so1092593qta.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zy1SisbeTVvdUCj/QRpIPHzpdPvSerUtAUJVlvSKXxQ=;
        b=Dgw6KeeoLS0gObWS6SXhzBNIcNAJxVKyG73Bd0glY0k3lVWtDg0gD7P+TAf9PPaR3+
         1DOOyW72z2eqG2/wG+NO/Q01ErPoubO02uUgwT8npwAtdUuJkFseuO9gpUHWZOqs55BF
         ABFoCaZjaaaY53fj57c7E9IrCtlY/KnBPl3Bt+txXDm7T4wEU+mJnTW8tbgFzOgKAukv
         0MKoUmEXLfycQVBtCacUrKBj45E7ffPlpmCWDkRHEhtsWmNNPzobyYxD6xHGcORi13QC
         quH9thJzxlm1FqgLJZQ6sfo+FitoqGCz+H7LSkWysVPxp8z28NlkPantLxXpGNsu0M/n
         cQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zy1SisbeTVvdUCj/QRpIPHzpdPvSerUtAUJVlvSKXxQ=;
        b=KS22A9NVIjnGEoFBsWxGvj3uh7tnrkbOXNHlaXcKSM3UhE/AKweyUnu8wCAT9zmnZ+
         nIo4I8MUcbV9GUt6fgDklO+/KdA7XZyTz1tiyvKklDskSQdRm2UIQ/6o9wCb1oCUbqKd
         35rYNfF9mIZUoEjB7kXy+1L1GFW1DYnLpVGY5KMpop+35M2EkjcwMbAEMPL+wGyOzarD
         CtkGiM/WdIFeeMxoCLQvxrbMZ6zXPDK1+ONJXCMyh1FIyWwKvXyTWC5dVKQ4GNnSFF+h
         qBZT2eQ8BDHnkvH0A7oh5p5kaK6Y/k7hM5R+GUPptFHiWhvDHh51Kugruu7F3mMiR0Hk
         jMpA==
X-Gm-Message-State: AOAM5312FlrH/GOMNhj7xbgwu514WmMuev2uubKK4+wjP5RdiZUVcT0X
        UICbGY5+DR1HAPiQg6XqKOAFsDv8OCpaAmoaiKU4Hbnk15c=
X-Google-Smtp-Source: ABdhPJzPOAxd6V5yFvI0h4izCOt4XhR4gPvukmEiilpikO+9rV3ln1W4G89cLB7H9laKANkJnLVi8hxMu1hthKTKrvM=
X-Received: by 2002:ac8:5dcb:0:b0:2e1:ce48:c186 with SMTP id
 e11-20020ac85dcb000000b002e1ce48c186mr6788114qtx.2.1649848164006; Wed, 13 Apr
 2022 04:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com> <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com> <20220314113337.j7slrb5srxukztje@quack3.lan>
In-Reply-To: <20220314113337.j7slrb5srxukztje@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Apr 2022 14:09:12 +0300
Message-ID: <CAOQ4uxgSubkz84_21qa5mPpBn7qHJUsA35ciJ5JHOH2UmAnnbA@mail.gmail.com>
Subject: Re: Fanotify Directory exclusion not working when using FAN_MARK_MOUNT
To:     Jan Kara <jack@suse.cz>
Cc:     Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 14, 2022 at 1:33 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 14-03-22 11:28:23, Amir Goldstein wrote:
> > On Mon, Mar 14, 2022 at 10:47 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sat 12-03-22 11:22:29, Srinivas wrote:
> > > > If a  process calls fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT=
,
> > > > FAN_OPEN_PERM, 0, "/mountpoint") no other directory exclusions can =
be
> > > > applied.
> > > >
> > > > However a path (file) exclusion can still be applied using
> > > >
> > > > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> > > > FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN_PERM | FAN_CLOSE_WRITE, AT_F=
DCWD,
> > > > "/tmp/fio/abc");  =3D=3D=3D> path exclusion that works.
> > > >
> > > > I think the directory exclusion not working is a bug as otherwise A=
V
> > > > solutions cant exclude directories when using FAN_MARK_MOUNT.
> > > >
> > > > I believe the change should be simple since we are already supporti=
ng
> > > > path exclusions. So we should be able to add the same for the direc=
tory
> > > > inode.
> > > >
> > > > 215676 =E2=80=93 fanotify Ignoring/Excluding a Directory not workin=
g with
> > > > FAN_MARK_MOUNT (kernel.org)
> > >
> > > Thanks for report! So I believe this should be fixed by commit 4f0b90=
3ded
> > > ("fsnotify: fix merge with parent's ignored mask") which is currently
> > > sitting in my tree and will go to Linus during the merge (opening in =
a
> > > week).
> >
> > Actually, in a closer look, that fix alone is not enough.
> >
> > With the current upstream kernel this should work to exclude events
> > in a directory:
> >
> > fanotify_mark(fd, FAN_MARK_ADD, FAN_EVENT_ON_CHILD |
> >                        FAN_OPEN_PERM | FAN_CLOSE_WRITE,
> >                        AT_FDCWD, "/tmp/fio/");
> > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> >                        FAN_MARK_IGNORED_SURV_MODIFY,
> >                        FAN_OPEN_PERM | FAN_CLOSE_WRITE,
> >                        AT_FDCWD, "/tmp/fio/");
> >
> > The first call tells fanotify that the inode mark on "/tmp/foo" is
> > interested in events on children (and not only on self).
> > The second call sets the ignored mark for open/close events.
> >
> > The fix only removed the need to include the events in the
> > first call.
> >
> > Should we also interpret FAN_EVENT_ON_CHILD correctly
> > in a call to fanotify_mark() to set an ignored mask?
> > Possibly. But that has not been done yet.
> > I can look into that if there is interest.
>
> Oh, right. I forgot about the need for FAN_EVENT_ON_CHILD in the
> mark->mask. It seems we can set FAN_EVENT_ON_CHILD in the ignored_mask as
> well but it just gets ignored currently. So we would need to propagate it
> even from ignore_mask to inode->i_fsnotify_mask. But send_to_group() woul=
d
> also need to be more careful now with ignore masks and apply them from
> parent only if the particular mark has FAN_EVENT_ON_CHILD in the ignore
> mask. Interestingly fanotify_group_event_mask() does explicitely apply
> ignore_mask from the parent regardless of FAN_EVENT_ON_CHILD flags. So
> there is some inconsistency there and it would need some tweaking...
>

Jan,

Just a heads up - you were right about this inconsistency and I have both
patches to fix it [1] and LTP test to reproduce the issue [2] and started w=
ork
on the new FAN_MARK_IGNORE API.
The new API has no tests yet, but it has a man page draft [3].

The description of the bugs as I wrote them in the fix commit message:

    This results in several subtle changes of behavior, hopefully all
    desired changes of behavior, for example:

    - Group A has a mount mark with FS_MODIFY in mask
    - Group A has a mark with ignored mask that does not survive FS_MODIFY
      and does not watch children on directory D.
    - Group B has a mark with FS_MODIFY in mask that does watch children
      on directory D.
    - FS_MODIFY event on file D/foo should not clear the ignored mask of
      group A, but before this change it does

    And if group A ignored mask was set to survive FS_MODIFY:
    - FS_MODIFY event on file D/foo should be reported to group A on accoun=
t
      of the mount mark, but before this change it is wrongly ignored

    Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events
on child and on dir")


Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fan_mark_ignore
[2] https://github.com/amir73il/ltp/commits/fan_mark_ignore
[3] https://github.com/amir73il/man-pages/commits/fan_mark_ignore
