Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7C17426BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 14:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjF2MwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 08:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2MwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:52:12 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209641FC6
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 05:52:11 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7919342c456so134075241.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 05:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688043130; x=1690635130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y40vTrc0YAi/XLanrTk5SziLTY/9e+F6RsHjpQkZTM=;
        b=eBn/vdf2/EEabOVOcGJBqTTuLdsa5Ocboybdx5yN6VitbwNasEJ6fkETBJ4jBGXWsV
         1NanMrFsyx3JG+84od8kqYoGCjv5yS7VpdWsA515btWzclO4/oYUqiNu9EYKuSRfkksB
         G75NlEhFui2i2rxhNrumYs+XZ6m4shEM5tAmpdmQFSDySZ/Nn6MgmhXizL8h8+Ix96jr
         wHhgRyLdpkgTexqUDFncmS7N9p0y/y543vduWNJCKdCFtGYRKt0gs1lExDuZFrvZqhGN
         QKRaGOZ8AkYFZKGxsMdKJyjABHaYF3pPk8IfRV3hapdIAtkzyI+T9h/dFGL1A2Drx2v3
         uETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688043130; x=1690635130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Y40vTrc0YAi/XLanrTk5SziLTY/9e+F6RsHjpQkZTM=;
        b=FJErEVyKnyGpjzJ3Rgtn1mqhXVYRIkE5DVLuwsuPkM6P9QAuqq2BWJ7qsYUYFbGGGf
         kIVDDKeV1gnx37/iY/A11sz7Q0gd+VinYdxZu50DerpITYT3X5Lm4E64dNyTCg2NUJN5
         n4Tx4FhwMYwKWf1TfzgMpb7rZNiYigcqMhtP//nUnXRXRMTdlhAWevg62rcoJHpFr4/F
         4G9biQsUSOQi+HfqXozFk2VWRfk1S7Tih4lEyVpqHksztZNSexZ/OlObqd914TI9M8Qa
         Sr2BxJZ/v0+V1gEfnapgd9onNAzru42GZByo8+520ZcEdWGOy+q0+xYofbqZNr1EA7RB
         9jNA==
X-Gm-Message-State: AC+VfDzgXnRiVn3uCb1kgLk2/fblnXGXjjD57bpQOUJCCCFuyo0A7SuZ
        SGYgnX/XLz0DN4/3ByFQfMskv3qNnS0Klya8EKk+ZYNa2Tg=
X-Google-Smtp-Source: ACHHUZ7FOKm/pGZfNQ9kMNVfnGBeT3mzm/OFxrmCArduZT6s0qkJdaWC47RUsgjfYx1sdew2seCi0MRiL2vZXefU3MQ=
X-Received: by 2002:a67:ea8f:0:b0:443:6917:214f with SMTP id
 f15-20020a67ea8f000000b004436917214fmr4708579vso.30.1688043130020; Thu, 29
 Jun 2023 05:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230629042044.25723-1-amir73il@gmail.com> <20230629101858.72ftsgnfblb5kv64@quack3>
 <CAOQ4uxhNH2FKhvsyLuCU7EFrbWy=8kmCi-c1u=63yuQoCkH74w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhNH2FKhvsyLuCU7EFrbWy=8kmCi-c1u=63yuQoCkH74w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 29 Jun 2023 15:51:58 +0300
Message-ID: <CAOQ4uxgfOc-HEj9dDGw4M5aqiitu_wFJf+5gz37N4h1bwqwfLg@mail.gmail.com>
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

On Thu, Jun 29, 2023 at 3:20=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Jun 29, 2023 at 1:18=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 29-06-23 07:20:44, Amir Goldstein wrote:
> > > Hopefully, nobody is trying to abuse mount/sb marks for watching all
> > > anonymous pipes/inodes.
> > >
> > > I cannot think of a good reason to allow this - it looks like an
> > > oversight that dated back to the original fanotify API.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kvchg544mc=
zxv2pm@quack3/
> > > Fixes: d54f4fba889b ("fanotify: add API to attach/detach super block =
mark")
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Jan,
> > >
> > > As discussed, allowing sb/mount mark on anonymous pipes
> > > makes no sense and we should not allow it.
> > >
> > > I've noted FAN_MARK_FILESYSTEM as the Fixes commit as a trigger to
> > > backport to maintained LTS kernels event though this dates back to da=
y one
> > > with FAN_MARK_MOUNT. Not sure if we should keep the Fixes tag or not.
> >
> > I can add CC to stable. We can also modify the Fixes tag to:
> >
> > Fixes: 0ff21db9fcc3 ("fanotify: hooks the fanotify_mark syscall to the =
vfsmount code")
> >
> > to make things a bit more accurate. Not that it would matter much...
> >
>
> Whatever you decide.
> I guess that this could wait for 6.6?
> but maybe before, because I wouldn't want to additional
> fsnotify splice hooks to be added without this, so then
> this restriction can be in place by the time vfs maintainers
> merge the splice patches.
>
> > > The reason this is an RFC and that I have not included also the
> > > optimization patch is because we may want to consider banning kernel
> > > internal inodes from fanotify and/or inotify altogether.
> >
> > So here I guess you mean to ban also inode marks for them? And by
> > kernel-internal I suppose you mean on SB_NOUSER superblock?
> >
>
> Yes and yes.
>
> > > The tricky point in banning anonymous pipes from inotify, which
> > > could have existing users (?), but maybe not, so maybe this is
> > > something that we need to try out.
> > >
> > > I think we can easily get away with banning anonymous pipes from
> > > fanotify altogeter, but I would not like to get to into a situation
> > > where new applications will be written to rely on inotify for
> > > functionaly that fanotify is never going to have.
> >
> > Yeah, so didn't we try to already disable inotify on some virtual inode=
s
> > and didn't it break something? I have a vague feeling we've already tri=
ed
> > that in the past and it didn't quite fly but searching the history didn=
't
> > reveal anything so maybe I'm mistaking it with something else.
> >
>
> I do have the same memory now that you mention it.
> I will try to track it down.
>

Here it is:
https://lore.kernel.org/linux-fsdevel/20200629130915.GF26507@quack2.suse.cz=
/

A regression report on Mel's patch:
e9c15badbb7b ("fs: Do not check if there is a fsnotify watcher on
pseudo inodes")

Chromium needs IN_OPEN/IN_CLOSE on anon pipes.
It does not need IN_ACCESS/IN_MODIFY, but the value of eliminating
those was deemed as marginal after the alternative optimizations by Mel:

71d734103edf ("fsnotify: Rearrange fast path to minimise overhead when
there is no watcher")

The reason I would like to ban the "global" watch on all anon inodes
is because it is just wrong and an oversight of sb/mount marks that
needs to be fixed.

The SB_NOUSER optimization is something that we can consider later.
It's not critical, but just a very low hanging fruit to pick.

Based on this finding, I would go with this RFC patch as is.
I will let you decide how to CC stable and about the timing
of sending this to Linus.

Thanks,
Amir.
