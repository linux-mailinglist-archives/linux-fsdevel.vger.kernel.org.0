Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC57A64C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjISNXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjISNXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:23:03 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257F5F3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:22:58 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7a8b522ae46so1317362241.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695129777; x=1695734577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekc9qUFt2cSPQrsp9B3ZKOZ/8N5/iZMALtA2rXQkxV0=;
        b=iqEQPBJsMgVG9Zja91t1WL8MgXpGxxNPWv2pDINlvFT+c/HtLxfB5n9T5GxRDtuvOn
         RrCERY7r991x4cOtSxoHUTMSROx3dEpJk61N6F/FkxjXkC4wc05LDwVNPgT2Kcf8jjw6
         BG5Y45JrW6qJPAbH017dduCgfYjWGcyY5kBD2cfKu5eCufu/3ab6/5vzGBKi6x350jM0
         TCl5k0E6wzfAri6MURik4/h70OTt+JAat7vVfjgSJFPra6TlO8Ir91UeTA8zyEztiOXP
         sabPeHdhn7/GXYt/xnEuGZ56twNal6lfKNSut3OVJA0R6KR4/Op+IzdCPAnlXbUckcfO
         SYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129777; x=1695734577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekc9qUFt2cSPQrsp9B3ZKOZ/8N5/iZMALtA2rXQkxV0=;
        b=nwMBWYEyQV5keTzN8aC9TztJ8wZnWPRUH4maKddN1gqkQQtv6tVtofI9Qp1abqXRdq
         Sk5QuP7SonuQd7O2HzGoQPMgx+0pAwF/IcFGVu2R27mTmxvJVJvB/hLDpyihHusddqvV
         OUODlhP4HdJWbWT2F/w2XmOX+V9+RUWgStucX8glE8hxitGURd/xEwrhfBKVW8KP1sBm
         cGRvjPzbBPE7VC/ujyV2ec2TSDrvAPiYJci1/GG02TH2DTLXnSxpn61qVJ07gLzgzcae
         8WX7X03POEuNt78Da0tb5mwGjYvYf81xdHKA0tzIOtl8NJ7j4SJHFp5Av8Cn8VYdq/Ne
         Va1g==
X-Gm-Message-State: AOJu0Yx9FKgljmudJ27upLwq+LN3Htah1A/nIAc6l0HYI3gOngz0RffT
        LMlMg4CBngA/xD9fyIt89a3AVLecvSyQ6eszycc=
X-Google-Smtp-Source: AGHT+IHS1biLf30+GneBM796voQM7nuawYV1/ZFR3ObHVFmYrabZYmfonhkpafgBHESMHQKRUj9kjyCFae3l+JOS3jI=
X-Received: by 2002:a05:6122:178a:b0:496:9f4f:5a41 with SMTP id
 o10-20020a056122178a00b004969f4f5a41mr6101217vkf.6.1695129777114; Tue, 19 Sep
 2023 06:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
 <20230919100112.nlb2t4nm46wmugc2@quack3> <CAKPOu+-apWRekyqRyYfsFkdx13uocCPKMzYJqmTsVEc6a=9uuA@mail.gmail.com>
 <CAOQ4uxgG6ync6dSBJiGW98docJGnajALiV+9tuwGiRt8NE8F+w@mail.gmail.com>
 <CAKPOu+9ds-dbq2-idehU5XR2s3Xz2NL-=fB+skKoN_zCym_OtA@mail.gmail.com>
 <CAOQ4uxgvh6TG3ZsjzzdD+VhMUss3NLTO8Hk7YWDZs=yZagc+oQ@mail.gmail.com>
 <CAKPOu+_y-rCsKXJ1A7YGqEXKeWyji1tF6_Nj2WWtrB36MTmpiQ@mail.gmail.com>
 <CAOQ4uxhtfyt8v3LwYLOY9FwA46RYrwcZpZv7J8znn5zW-1N5sA@mail.gmail.com> <CAKPOu+8tCP+bRXFy0br3D7C8h5iHxBr+WoSfiMyBQnrYN8g7Uw@mail.gmail.com>
In-Reply-To: <CAKPOu+8tCP+bRXFy0br3D7C8h5iHxBr+WoSfiMyBQnrYN8g7Uw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Sep 2023 16:22:45 +0300
Message-ID: <CAOQ4uxi0P+drqY2krEZ6tGzD1ZZfCcM_Eg6xjYF_vf39tPgbKg@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 4:11=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Tue, Sep 19, 2023 at 3:01=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> > We do not add new system calls for doing something that is already
> > possible with existing system calls to make the life of a programmer
> > easier - this has never been a valid argument for adding a new syscall.
>
> - it's not possible to safely add an inotify watch; this isn't about
> making something easier, but about making something
> safe/reliable/race-free in a way that wasn't possible before

Yes, I meant it is possible to get the very similar functionality in
a race-free way using fanotify.
If fanotify does not meet your requirements please let us know
in what way and perhaps fanotify could be improved.
Using "inotify and not fanotity" is not a legit technical requirement.

> - there are many precedents of new system calls just to add dfd
> support (fchmodat, execveat, linkat, mkdirat, ....)
> - there are also a few new system calls that were added to make the
> life of a programmer easier even though the same was already possible
> with existing system calls (close_range, process_madvise, pidfd_getfd,
> mount_setattr, ...)

All those new syscalls add new functionality/security/performance.
If you think they were added to make the life of the programmer easier
you did not understand them.

Anyway, I've said my opinion about inotify_add_watch_at().
final call is up to Jan.

Thanks,
Amir.

P.S. you may be able to provide magic /proc/self/$fd symlinks
as path argument to inotify_add_watch() after opening them
with O_PATH to get what you want - I didn't try.
