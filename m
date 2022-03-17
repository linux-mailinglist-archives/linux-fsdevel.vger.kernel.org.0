Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A154DD038
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 22:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiCQVdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 17:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiCQVdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:33:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC21A8C37
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 14:32:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so13402256ejc.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qd/QzJroXqS76+vpGYR32s8ZS/L6ajxFmNzuyLr4spE=;
        b=SNT6l8pmb5pFsrqYmvLpPI/3ZKsi7wR83fXrEqcnFeeUXRxfmvozk6F5QOLZ9vy/Tp
         cOzpMNpimxIruZ//9FwUlZsqOJzHXIf7cwW6zjMBpkeSF1Xka5Z93J9Iwr3TtbUaKyjq
         VEKw02nl5xUI/Za71AOlfDMXN0H7h5ks7WdgPujnp5PYpjnwbzzKceAR/tEjDzFEI54z
         TNNTjkqLSR9Z9VJ8DY+sxaI4o6Ut567U3VMk6VHL9/yyYG9RU3J/8nbVjQ6/lLH9Qrm4
         4RkkcKOUE2DNa8gjLL0V6ONfKewve0+38rxi4+tCpIE2vD41h+HyA6yHSsflfKRbnkFK
         vsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qd/QzJroXqS76+vpGYR32s8ZS/L6ajxFmNzuyLr4spE=;
        b=2oFlK30PcaZ/zOy2c4BAm8Zkocyp0ZVV+9wydkROG+wjNn/nnA79imk2g1XyS1iVqr
         9nZS2d8VuQosvkypmUsK4vRIJS4NjhMyD6hhLcyipgr//3y9MZ5QIRqqv3tiex4gB7HY
         h+UTo5UszF50L4oCwcxza3M8GILLaiUL2fWOxRx8tYQhTwI0CDmBLC7YtoZhf4S6uT+m
         3WXPlj4yVoPnlm2fgr0EqppJNyjODv9H8FcQVONGHNj98ZsZ7vuxv6LtKahjXGc0GqGC
         RNHfamtIsi6zSEEz4FJc//7ndR7LTw98uy9/vm+I8A4P7fD/JldoqEduBLvA8w1Q0gx6
         WyJQ==
X-Gm-Message-State: AOAM532qRmEIbkVv5R1NlGAi7CXetLbO2Ht20AdUIdB5QiqlgjKJPYgG
        ijgKHDX/WDb1pYa/5CTC94deHzxQwlCovujkEb87vcNclw==
X-Google-Smtp-Source: ABdhPJxKiPHpnNQuOXjMk22qXkfCq7IIUqiUBCrX2aFtCf5Iu8Dj8BXOZ5EU1cEya3DvG41VZWdOzUEB7Yp0ZudJb2I=
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id
 dr2-20020a170907720200b006df83a967d2mr6248163ejc.327.1647552722265; Thu, 17
 Mar 2022 14:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-2-mic@digikod.net>
 <CAHC9VhQEEKGgCn7fYgUt-_WhXc-vrKq9TVm=cfwJUyWaUgY2Vw@mail.gmail.com> <ed8467f2-dcd0-bc2f-8e98-1d9129fb2c30@digikod.net>
In-Reply-To: <ed8467f2-dcd0-bc2f-8e98-1d9129fb2c30@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Mar 2022 17:31:51 -0400
Message-ID: <CAHC9VhRhYbxyBK39uRRpXF9o-Yf-yMwWRvsE15wJnZr3-dexMA@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] landlock: Define access_mask_t to enforce a
 consistent access mask size
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 4:35 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 17/03/2022 02:26, Paul Moore wrote:
> > On Mon, Feb 21, 2022 at 4:15 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >>
> >> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >>
> >> Create and use the access_mask_t typedef to enforce a consistent acces=
s
> >> mask size and uniformly use a 16-bits type.  This will helps transitio=
n
> >> to a 32-bits value one day.
> >>
> >> Add a build check to make sure all (filesystem) access rights fit in.
> >> This will be extended with a following commit.
> >>
> >> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >> Link: https://lore.kernel.org/r/20220221212522.320243-2-mic@digikod.ne=
t
> >> ---
> >>   security/landlock/fs.c      | 19 ++++++++++---------
> >>   security/landlock/fs.h      |  2 +-
> >>   security/landlock/limits.h  |  2 ++
> >>   security/landlock/ruleset.c |  6 ++++--
> >>   security/landlock/ruleset.h | 17 +++++++++++++----
> >>   5 files changed, 30 insertions(+), 16 deletions(-)

...

> >> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> >> index 2a0a1095ee27..458d1de32ed5 100644
> >> --- a/security/landlock/limits.h
> >> +++ b/security/landlock/limits.h
> >> @@ -9,6 +9,7 @@
> >>   #ifndef _SECURITY_LANDLOCK_LIMITS_H
> >>   #define _SECURITY_LANDLOCK_LIMITS_H
> >>
> >> +#include <linux/bitops.h>
> >>   #include <linux/limits.h>
> >>   #include <uapi/linux/landlock.h>
> >>
> >> @@ -17,5 +18,6 @@
> >>
> >>   #define LANDLOCK_LAST_ACCESS_FS                LANDLOCK_ACCESS_FS_MA=
KE_SYM
> >>   #define LANDLOCK_MASK_ACCESS_FS                ((LANDLOCK_LAST_ACCES=
S_FS << 1) - 1)
> >> +#define LANDLOCK_NUM_ACCESS_FS         __const_hweight64(LANDLOCK_MAS=
K_ACCESS_FS)
> >
> > The line above, and the static_assert() in ruleset.h are clever.  I'll
> > admit I didn't even know the hweightX() macros existed until looking
> > at this code :)
> >
> > However, the LANDLOCK_NUM_ACCESS_FS is never really going to be used
> > outside the static_assert() in ruleset.h is it?  I wonder if it would
> > be better to skip the extra macro and rewrite the static_assert like
> > this:
> >
> > static_assert(BITS_PER_TYPE(access_mask_t) >=3D
> > __const_hweight64(LANDLOCK_MASK_ACCESS_FS));
> >
> > If not, I might suggest changing LANDLOCK_NUM_ACCESS_FS to
> > LANDLOCK_BITS_ACCESS_FS or something similar.
>
> I declared LANDLOCK_NUM_ACCESS_FS in this patch to be able to have the
> static_assert() here and ease the review, but LANDLOCK_NUM_ACCESS_FS is
> really used in patch 6/11 to define an array size:
> get_handled_acceses(), init_layer_masks(), is_superset(),
> check_access_path_dual()=E2=80=A6

I wrote my comments as I was working my way through the patchset and
didn't think to go back and check this when I hit patch 6/11 :)

Looks good to me, sorry for the noise.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
