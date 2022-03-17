Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125894DD055
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 22:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiCQVn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 17:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiCQVnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:43:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543929A57D
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 14:42:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qa43so13364619ejc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uuFVFoh8GxFpq3rhyzg4kf8sSyYu+xyDqDIjlxGEeGg=;
        b=t4QY5EIr0aGlcdAPnW3ysLpDdR9Dl3cxWbqg4WcV0rS4+OK1puD+9Wb+lN7yWCgGVq
         hzEazIwWLo+k5hTXgUf/mCvhicL1iX5e9nCFgcjpzVHpWK6QKviDyoUztVg9iTko3rGA
         nRjqfqTgCmiQ4HpTtqwmuf+loueg/O6y7/LJo+lIXe3mCmHDtAaiytdHx5waFJ/OZujW
         XKvddkOyhoD+q2DnbSJjS7rBZRp6s0aGnzCLoP0CgfCC0KBefG/t2vnrDpMn2hwVgKHk
         A8wP+iKCZmVIZeevqmjaUXQmkNW0HQ3/pEA8rJ/ooymQLBH+OxgwaKCB8q9OqrRlSiLE
         aTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uuFVFoh8GxFpq3rhyzg4kf8sSyYu+xyDqDIjlxGEeGg=;
        b=cp/m3Gk4dcaXv2h5w0XQCEmuRYzbmekODBb2t7xUspPGm4pRP2A/p4U6EBk1ROvRcb
         Wt7CITpOrcWz7G8P21tRFvuN3sCrD4gAwUIgek6UiqfyRAQNAAcz4Zt+icRZt/kzAp1r
         bPm7LijLSKDc9pD7it0xAPWjOd/7ukTX9e9kXrLs/IeYIck9uylMEuaPgHQEb/JtgPAz
         QmQioBjVuibfgbeeVg0Hou3MPN/0if20gj8/SGKmGqPIzOdLoU3zegMTQRTK8uu/nDje
         BXM2bPQIW0GyMHb4g2kAFsc383P02Os9NFHqjJMmzmrlKqQ0sOkyhK7Ok+YS/yj1b99f
         tAeA==
X-Gm-Message-State: AOAM533d+wmfHlwPfOusQ0IuPA2KCiwXmkdvhsaTUitSr0ZZGo//bJWN
        TcRCPNyhCzqut+WIvhFuPb7LL7fmKcBq/a4GB0Zh
X-Google-Smtp-Source: ABdhPJz9YlV9YgOkXqaW5rcm0fT31+PVN0jEaABhbGaxK+MPb1fkLl9VV1uW9vwqU4w+HzgXvXbyXSSD60F/3pX52fQ=
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id
 mp9-20020a1709071b0900b006d8faa84a06mr6264040ejc.701.1647553355924; Thu, 17
 Mar 2022 14:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-7-mic@digikod.net>
 <CAHC9VhSFXN39EuVG5aVK0jtgCOmzM2FSCoVa2Xrs=oJQ4AkWMQ@mail.gmail.com> <588e0fec-6a45-db81-e411-ae488b29e533@digikod.net>
In-Reply-To: <588e0fec-6a45-db81-e411-ae488b29e533@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Mar 2022 17:42:24 -0400
Message-ID: <CAHC9VhTY06mOTD3LqTzhTsqt-VBJwezFyX8hwpJTz0VMC8KK7Q@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 8:03 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 17/03/2022 02:26, Paul Moore wrote:
> > On Mon, Feb 21, 2022 at 4:15 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
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
> >> (to make it a superset).
> >>
> >> See the provided documentation for additional details.
> >>
> >> New tests are provided with a following commit.
> >>
> >> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >> Link: https://lore.kernel.org/r/20220221212522.320243-7-mic@digikod.ne=
t
> >> ---
> >>   include/uapi/linux/landlock.h                |  27 +-
> >>   security/landlock/fs.c                       | 550 ++++++++++++++++-=
--
> >>   security/landlock/limits.h                   |   2 +-
> >>   security/landlock/syscalls.c                 |   2 +-
> >>   tools/testing/selftests/landlock/base_test.c |   2 +-
> >>   tools/testing/selftests/landlock/fs_test.c   |   3 +-
> >>   6 files changed, 516 insertions(+), 70 deletions(-)

...

> >> +/*
> >> + * Returns true if there is at least one access right different than
> >> + * LANDLOCK_ACCESS_FS_REFER.
> >> + */
> >> +static inline bool is_eacces(
> >> +               const layer_mask_t (*const
> >> +                       layer_masks)[LANDLOCK_NUM_ACCESS_FS],
> >>                  const access_mask_t access_request)
> >>   {
> >
> > Granted, I don't have as deep of an understanding of Landlock as you
> > do, but the function name "is_eacces" seems a little odd given the
> > nature of the function.  Perhaps "is_fsrefer"?
>
> Hmm, this helper does multiple things which are necessary to know if we
> need to return -EACCES or -EXDEV. Renaming it to is_fsrefer() would
> require to inverse the logic and use boolean negations in the callers
> (because of ordering). Renaming to something like without_fs_refer()
> would not be completely correct because we also check if there is no
> layer_masks, which indicated that it doesn't contain an access right
> that should return -EACCES. This helper is named as such because the
> underlying semantic is to check for such error code, which is a tricky.
> I can rename it co contains_eacces() or something, but a longer name
> would require to cut the caller lines to fit 80 columns. :|

You know the Landlock code better than I do, if you like
"is_eacces()", then leave it as it is.

> >> -       layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
> >> -       bool allowed =3D false, has_access =3D false;
> >> +       unsigned long access_bit;
> >> +       /* LANDLOCK_ACCESS_FS_REFER alone must return -EXDEV. */
> >> +       const unsigned long access_check =3D access_request &
> >> +               ~LANDLOCK_ACCESS_FS_REFER;
> >> +
> >> +       if (!layer_masks)
> >> +               return false;
> >> +
> >> +       for_each_set_bit(access_bit, &access_check, ARRAY_SIZE(*layer_=
masks)) {
> >> +               if ((*layer_masks)[access_bit])
> >> +                       return true;
> >> +       }
> >
> > Is calling for_each_set_bit() overkill here?  @access_check should
> > only ever have at most one bit set (LANDLOCK_ACCESS_FS_REFER), yes?
>
> No, it is the contrary ...

Gotcha.  Thanks for the clarification, I must have missed that when I
was looking at it last night.

> >> @@ -287,22 +460,20 @@ static int check_access_path(const struct landlo=
ck_ruleset *const domain,
> >>          if (WARN_ON_ONCE(domain->num_layers < 1))
> >>                  return -EACCES;
> >>
> >> -       /* Saves all layers handling a subset of requested accesses. *=
/
> >> -       for (i =3D 0; i < domain->num_layers; i++) {
> >> -               const unsigned long access_req =3D access_request;
> >> -               unsigned long access_bit;
> >> -
> >> -               for_each_set_bit(access_bit, &access_req,
> >> -                               ARRAY_SIZE(layer_masks)) {
> >> -                       if (domain->fs_access_masks[i] & BIT_ULL(acces=
s_bit)) {
> >> -                               layer_masks[access_bit] |=3D BIT_ULL(i=
);
> >> -                               has_access =3D true;
> >> -                       }
> >> -               }
> >> +       BUILD_BUG_ON(!layer_masks_dst_parent);
> >
> > I know the kbuild robot already flagged this, but checking function
> > parameters with BUILD_BUG_ON() does seem a bit ... unusual :)
>
> Yeah, I like such guarantee but it may not work without __always_inline.
> I moved this check in the previous WARN_ON_ONCE().

That sounds good to me.

> >> @@ -312,11 +483,50 @@ static int check_access_path(const struct landlo=
ck_ruleset *const domain,
> >>           */
> >>          while (true) {
> >>                  struct dentry *parent_dentry;
> >> +               const struct landlock_rule *rule;
> >> +
> >> +               /*
> >> +                * If at least all accesses allowed on the destination=
 are
> >> +                * already allowed on the source, respectively if ther=
e is at
> >> +                * least as much as restrictions on the destination th=
an on the
> >> +                * source, then we can safely refer files from the sou=
rce to
> >> +                * the destination without risking a privilege escalat=
ion.
> >> +                * This is crucial for standalone multilayered securit=
y
> >> +                * policies.  Furthermore, this helps avoid policy wri=
ters to
> >> +                * shoot themselves in the foot.
> >> +                */
> >> +               if (is_dom_check && is_superset(child_is_directory,
> >> +                                       layer_masks_dst_parent,
> >> +                                       layer_masks_src_parent,
> >> +                                       layer_masks_child)) {
> >> +                       allowed_dst_parent =3D
> >> +                               scope_to_request(access_request_dst_pa=
rent,
> >> +                                               layer_masks_dst_parent=
);
> >> +                       allowed_src_parent =3D
> >> +                               scope_to_request(access_request_src_pa=
rent,
> >> +                                               layer_masks_src_parent=
);
> >> +
> >> +                       /* Stops when all accesses are granted. */
> >> +                       if (allowed_dst_parent && allowed_src_parent)
> >> +                               break;
> >> +
> >> +                       /*
> >> +                        * Downgrades checks from domain handled acces=
ses to
> >> +                        * requested accesses.
> >> +                        */
> >> +                       is_dom_check =3D false;
> >> +                       access_masked_dst_parent =3D access_request_ds=
t_parent;
> >> +                       access_masked_src_parent =3D access_request_sr=
c_parent;
> >> +               }
> >> +
> >> +               rule =3D find_rule(domain, walker_path.dentry);
> >> +               allowed_dst_parent =3D unmask_layers(rule, access_mask=
ed_dst_parent,
> >> +                               layer_masks_dst_parent);
> >> +               allowed_src_parent =3D unmask_layers(rule, access_mask=
ed_src_parent,
> >> +                               layer_masks_src_parent);
> >>
> >> -               allowed =3D unmask_layers(find_rule(domain, walker_pat=
h.dentry),
> >> -                               access_request, &layer_masks);
> >> -               if (allowed)
> >> -                       /* Stops when a rule from each layer grants ac=
cess. */
> >> +               /* Stops when a rule from each layer grants access. */
> >> +               if (allowed_dst_parent && allowed_src_parent)
> >>                          break;
> >
> > If "(allowed_dst_parent && allowed_src_parent)" is true, you break out
> > of the while loop only to do a path_put(), check the two booleans once
> > more, and then return zero, yes?  Why not just do the path_put() and
> > return zero here?
>
> Correct, that would work, but I prefer not to duplicate the logic of
> granting access if it doesn't make the code more complex, which I think
> is not the case here, and I'm reluctant to duplicate path_get/put()
> calls. This loop break is a small optimization to avoid walking the path
> one more step, and writing it this way looks cleaner and less
> error-prone from my point of view.

I'm a big fan of maintainable code, and since you are the maintainer,
if you prefer this approach I say stick with what you have :)

--=20
paul-moore.com
