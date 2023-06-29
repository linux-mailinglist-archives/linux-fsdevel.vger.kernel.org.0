Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB9874264C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 14:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjF2MZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 08:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjF2MYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:24:46 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060FA49F3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 05:21:08 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7919342c456so122838241.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 05:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688041267; x=1690633267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjZO7wf53CpZEbDUiLZ4eRsCtLpMDtuzYYVomhMTN9I=;
        b=nfqJh82/xdXAg0xwnNd5DBe/UUor/ZnH/8qnySngPkU7oCCeRRCgTM+Zj1VKEn2rcr
         ZBTkGDTHTN8x41YkXaTcpU7H5F0+A7M/J40mMpdfOWwlQOh58bSXIkZWDT310fFxztPL
         mCBDbRCGYLqpvi+i88cNc/08OomtJleOl0CJAMlxOltrrsD6AwalXsAuQB+zRm0gX6Qz
         JHstnF/YZ1mBhHH34rj3gEZC56+9srKMTwtDexfgE5BH+JrkVFHyKTyirx8ajx25h7vv
         /4jcDCceizxlCP05zYdGkcKoIcIqbc1BkOvyL2EuLdPcdg0uNjYakMfHSYDRnZoa+J2O
         7KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688041267; x=1690633267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjZO7wf53CpZEbDUiLZ4eRsCtLpMDtuzYYVomhMTN9I=;
        b=GTAOhu79lh7F6VJNSUtMb5QFJevuWB7inQWe36FnaFYUt2U4tXQx3bATTk41DRQ6s/
         5fjat3rvh0TFsF+Kk7yX3/L5eNeik4gSI15vC0UJfdh42OtBX0GqKoUNPZFjfLKcbcjn
         j4QS/p3M6bhOtYbAi5cfHaTu9cDr65BA3fsgMp18MW3PExp0ZptbxdIBkX0KMLoLlcc4
         1UWYh+EzhiB3pRApp5FvkXQVfdVUBNO8Osp/4eB/R8xvAW+aSSFTMsheGClmrvsS/t8g
         6LwLvIWVD3/ruoZFEjPetzerSwkfBIoB3a9UkUHmeJF3SSA+Fc/NaEaWaqGgc9Bq4Pty
         jNbg==
X-Gm-Message-State: AC+VfDwRhHW5rk9AhOOPr/Kq9qv1HgFrjIREYsgkUL/S0Qx590Pyue/S
        fIvoCRpwgpPMXDkm+7IpWbvqnj6U7xB3jSsCZfX1wvjZMNM=
X-Google-Smtp-Source: ACHHUZ53XS91kG2/kdIinTuagE6vXNMfs5i3cL+W5DXZchlFBoBi/9CxfPahEipFCZvCUVIVPU5fJsI+H2xxElBnx7k=
X-Received: by 2002:a67:cf88:0:b0:443:5d8e:de22 with SMTP id
 g8-20020a67cf88000000b004435d8ede22mr4995502vsm.24.1688041266917; Thu, 29 Jun
 2023 05:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230629042044.25723-1-amir73il@gmail.com> <20230629101858.72ftsgnfblb5kv64@quack3>
In-Reply-To: <20230629101858.72ftsgnfblb5kv64@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 29 Jun 2023 15:20:55 +0300
Message-ID: <CAOQ4uxhNH2FKhvsyLuCU7EFrbWy=8kmCi-c1u=63yuQoCkH74w@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: disallow mount/sb marks on kernel internal
 pseudo fs
To:     Jan Kara <jack@suse.cz>
Cc:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
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

On Thu, Jun 29, 2023 at 1:18=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 29-06-23 07:20:44, Amir Goldstein wrote:
> > Hopefully, nobody is trying to abuse mount/sb marks for watching all
> > anonymous pipes/inodes.
> >
> > I cannot think of a good reason to allow this - it looks like an
> > oversight that dated back to the original fanotify API.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kvchg544mczx=
v2pm@quack3/
> > Fixes: d54f4fba889b ("fanotify: add API to attach/detach super block ma=
rk")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > As discussed, allowing sb/mount mark on anonymous pipes
> > makes no sense and we should not allow it.
> >
> > I've noted FAN_MARK_FILESYSTEM as the Fixes commit as a trigger to
> > backport to maintained LTS kernels event though this dates back to day =
one
> > with FAN_MARK_MOUNT. Not sure if we should keep the Fixes tag or not.
>
> I can add CC to stable. We can also modify the Fixes tag to:
>
> Fixes: 0ff21db9fcc3 ("fanotify: hooks the fanotify_mark syscall to the vf=
smount code")
>
> to make things a bit more accurate. Not that it would matter much...
>

Whatever you decide.
I guess that this could wait for 6.6?
but maybe before, because I wouldn't want to additional
fsnotify splice hooks to be added without this, so then
this restriction can be in place by the time vfs maintainers
merge the splice patches.

> > The reason this is an RFC and that I have not included also the
> > optimization patch is because we may want to consider banning kernel
> > internal inodes from fanotify and/or inotify altogether.
>
> So here I guess you mean to ban also inode marks for them? And by
> kernel-internal I suppose you mean on SB_NOUSER superblock?
>

Yes and yes.

> > The tricky point in banning anonymous pipes from inotify, which
> > could have existing users (?), but maybe not, so maybe this is
> > something that we need to try out.
> >
> > I think we can easily get away with banning anonymous pipes from
> > fanotify altogeter, but I would not like to get to into a situation
> > where new applications will be written to rely on inotify for
> > functionaly that fanotify is never going to have.
>
> Yeah, so didn't we try to already disable inotify on some virtual inodes
> and didn't it break something? I have a vague feeling we've already tried
> that in the past and it didn't quite fly but searching the history didn't
> reveal anything so maybe I'm mistaking it with something else.
>

I do have the same memory now that you mention it.
I will try to track it down.

> I guess you are looking for this so that fsnotify code can bail early whe=
n
> it sees such inodes and thus improve performance?
>

Not exactly.

Bailing early is easy even if we allow a mark on anonymous inode.
That is what the optimization patch looks like:

 /* Could the inode be watched by inode/mount/sb mark? */
 static inline bool fsnotify_inode_has_watchers(struct inode *inode, __u32 =
mask)
 {
+       /*
+        * For objects that are not mapped into user accessible path like
+        * anonymous pipes/inodes, we do not need to check for watchers on
+        * parent/mount/sb and the sb watchers optimizations below are
+        * not as effective, so check the inode mask directly.
+        */
+       if (inode->i_sb->s_flags & SB_NOUSER &&
+           !(mask & inode->i_fsnotify_mask))
+               return 0;
+
        if (mask & ALL_FSNOTIFY_PERM_EVENTS)
                return atomic_long_read(&inode->i_sb->s_fsnotify_perm_watch=
ers);

        return atomic_long_read(&inode->i_sb->s_fsnotify_connectors);
}

My question was about: do we need this optimization patch or could
we just ban SB_NOUSER from inotify and fanotify altogether and then
s_fsnotify_connectors will be zero on the pseudo fs anyway.

Thanks,
Amir.
