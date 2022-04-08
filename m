Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21D14F9B69
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 19:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiDHRQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiDHRQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:16:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B500AE5F
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 10:14:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l26so18641591ejx.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Apr 2022 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0o/SUj9l7QxccG0h5Jo/GmbooXfRNd11V119ZFnMckU=;
        b=Bcop1hZHOgBQuDGa7QitchzS0rKGKo3Ujzo71w/Wg7uqUxCVHUVlo92yaoWsUMrhRj
         ESWDeJ108bo2TC+NhPefjFOhaRDCLsElwntWQdZsiIRsMFV+a5N26gAoJHqQ0NaNmC5N
         2j8VZstcNjF4gMMxOfs4qJxHsBKOOT+pM2XOXa5hn9gDbXYa/Q3BtQtEvlQ9AeoLxidO
         GjZSsNlAk/Y9LFNVvuDWh0aLFlTNhOXx8qHdOtx7pxqnWiEY05W9UsL2en5nX+x3eScQ
         Umlu4wdPONyvMdVp+Da+0cCRIW3ekitvW5oEav/ZqeLXGawpVHbb8fcdR5wvvBQ3NPeF
         cMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0o/SUj9l7QxccG0h5Jo/GmbooXfRNd11V119ZFnMckU=;
        b=OW2Vo8+uSQ+6JuUPeikb4YgQDAewwtWtYO07RurUFzxtYTx5ARqGWRCsS4KFsJY45C
         1jA2qem/IrU8MM7BoY9z6SFFvuz4zon6Ype6UvT4B6RuNpo4Soh673Oy9IEKEEKvMLJE
         pTeuF/XA859eKvsuVUo1RpDAPbAI3QGJ/j5+WMyLYbCDh2/XFHHfZ/DQLn6hNZTj+od0
         MflAWD9IOIc9K9TWsQZ+u/qB+YcALswnMAOia+SJzo+9IzxzKkd5fVTcI9cxUbEsd2VT
         albeqSjnFaJIJs0Jt+ICuNwQQiDG7Xr65SNyqTmtj1xHBoYw4k0AbYgfjcWk588WBGB9
         /uSw==
X-Gm-Message-State: AOAM5316VoCT+G8BVrwZsqTFjpmk4pJX9qACIgr2EFivUZWzFTFQtTxy
        voGf1u9RMlIgprm4JvTteY2vTR3M1IDQCB9vZjPt
X-Google-Smtp-Source: ABdhPJw4m50Heq+ZwCYADtd52nzp0qTl5o19w463Q1Ul92xNBNhrSzqy+I1ZLWln2A2dGR15BjDtzskUMutG3LrWeoU=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr20127403ejb.517.1649438050929; Fri, 08
 Apr 2022 10:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220329125117.1393824-1-mic@digikod.net> <20220329125117.1393824-8-mic@digikod.net>
 <CAHC9VhQpZ12Chgd+xMibUxgvcPjTn9FMnCdMGYbLcWG3eTqDQg@mail.gmail.com> <3a5495b8-5d69-e327-1dfc-7a99257269ae@digikod.net>
In-Reply-To: <3a5495b8-5d69-e327-1dfc-7a99257269ae@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 8 Apr 2022 13:13:59 -0400
Message-ID: <CAHC9VhS0bYe9wOxuXoC2mw_K2g=Fw=LXiV+A_Z1vH_KqH-TBFA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 8, 2022 at 12:07 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 08/04/2022 03:42, Paul Moore wrote:
> > On Tue, Mar 29, 2022 at 8:51 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >>
> >> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >>
> >> Add a new LANDLOCK_ACCESS_FS_REFER access right to enable policy write=
rs
> >> to allow sandboxed processes to link and rename files from and to a
> >> specific set of file hierarchies.  This access right should be compose=
d
> >> with LANDLOCK_ACCESS_FS_MAKE_* for the destination of a link or rename=
,
> >> and with LANDLOCK_ACCESS_FS_REMOVE_* for a source of a rename.  This
> >> lift a Landlock limitation that always denied changing the parent of a=
n
> >> inode.
> >>
> >> Renaming or linking to the same directory is still always allowed,
> >> whatever LANDLOCK_ACCESS_FS_REFER is used or not, because it is not
> >> considered a threat to user data.
> >>
> >> However, creating multiple links or renaming to a different parent
> >> directory may lead to privilege escalations if not handled properly.
> >> Indeed, we must be sure that the source doesn't gain more privileges b=
y
> >> being accessible from the destination.  This is handled by making sure
> >> that the source hierarchy (including the referenced file or directory
> >> itself) restricts at least as much the destination hierarchy.  If it i=
s
> >> not the case, an EXDEV error is returned, making it potentially possib=
le
> >> for user space to copy the file hierarchy instead of moving or linking
> >> it.
> >>
> >> Instead of creating different access rights for the source and the
> >> destination, we choose to make it simple and consistent for users.
> >> Indeed, considering the previous constraint, it would be weird to
> >> require such destination access right to be also granted to the source
> >> (to make it a superset).  Moreover, RENAME_EXCHANGE would also add to
> >> the confusion because of paths being both a source and a destination.
> >>
> >> See the provided documentation for additional details.
> >>
> >> New tests are provided with a following commit.
> >>
> >> Cc: Paul Moore <paul@paul-moore.com>
> >> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >> Link: https://lore.kernel.org/r/20220329125117.1393824-8-mic@digikod.n=
et
> >> ---
> >>
> >> Changes since v1:
> >> * Update current_check_access_path() to efficiently handle
> >>    RENAME_EXCHANGE thanks to the updated LSM hook (see previous patch)=
.
> >>    Only one path walk is performed per rename arguments until their
> >>    common mount point is reached.  Superset of access rights is correc=
tly
> >>    checked, including when exchanging a file with a directory.  This
> >>    requires to store another matrix of layer masks.
> >> * Reorder and rename check_access_path_dual() arguments in a more
> >>    generic way: switch from src/dst to 1/2.  This makes it easier to
> >>    understand the RENAME_EXCHANGE cases alongs with the others.  Updat=
e
> >>    and improve check_access_path_dual() documentation accordingly.
> >> * Clean up the check_access_path_dual() loop: set both allowed_parent*
> >>    when reaching internal filesystems and remove a useless one.  This
> >>    allows potential renames in internal filesystems (like for other
> >>    operations).
> >> * Move the function arguments checks from BUILD_BUG_ON() to
> >>    WARN_ON_ONCE() to avoid clang build error.
> >> * Rename is_superset() to no_more_access() and make it handle superset
> >>    checks of source and destination for simple and exchange cases.
> >> * Move the layer_masks_child* creation from current_check_refer_path()
> >>    to check_access_path_dual(): this is simpler and less error-prone,
> >>    especially with RENAME_EXCHANGE.
> >> * Remove one optimization in current_check_refer_path() to make the co=
de
> >>    simpler, especially with the RENAME_EXCHANGE handling.
> >> * Remove overzealous WARN_ON_ONCE() for !access_request check in
> >>    init_layer_masks().
> >> ---
> >>   include/uapi/linux/landlock.h                |  27 +-
> >>   security/landlock/fs.c                       | 607 ++++++++++++++++-=
--
> >>   security/landlock/limits.h                   |   2 +-
> >>   security/landlock/syscalls.c                 |   2 +-
> >>   tools/testing/selftests/landlock/base_test.c |   2 +-
> >>   tools/testing/selftests/landlock/fs_test.c   |   3 +-
> >>   6 files changed, 566 insertions(+), 77 deletions(-)
> >
> > I'm still not going to claim that I'm a Landlock expert, but this
> > looks sane to me.
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Thanks Paul! I'll send a small update shortly, with some typo fixes,
> some unlikely() calls, and rebased on the other Landlock patch series.

Since it sounds like those are all pretty minor changes, feel free to
preserve my 'Reviewed-by' on the respun patch.

--=20
paul-moore.com
