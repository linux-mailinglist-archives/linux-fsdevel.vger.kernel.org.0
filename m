Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116D0788670
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244379AbjHYLzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 07:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244471AbjHYLza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:55:30 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16141BFA
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 04:55:28 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-52a0f6f7a3aso840431a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692964527; x=1693569327;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75JF1uizcRpIuBOtRq8OadZCdyPKrtwcPXBr2O/HCPk=;
        b=I8cIs+Sq2gbO2dZ/e4q3KONDBVeVoVPLOekYvmluM/lQoKcScGZDpA3UiD98xj+ROX
         h/XzsDAvGOHAYqm3DtszJdPo828X3/mAF5M1f5exLbDvZQVcsU9cE55NiY3R6uTwiC4b
         VMfjh+vR2xqUTtSmVJSzX/5l0JN3y0rXaLTYdNsbF6Lw/KwQk1ALW9mHKh6GTj4MkF2R
         mvaLbQ6fcWYmDQGDLD8q9SYnXK4+TNJYtnp597aElHW61cpebMuBAdvNihpaPOLKl7JQ
         mCJQs+woQT7B5JWjcjY10NHGxVoy3oz6Ej5Gq+A1NmwFeNUy0pSV/mzNWRgSMS1cktmH
         VsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692964527; x=1693569327;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=75JF1uizcRpIuBOtRq8OadZCdyPKrtwcPXBr2O/HCPk=;
        b=cA3lRmezY79z9IYJWXgr9sdgpgvK8QsH5HGrqKgt+IUdGTrDoNK4Z6xk8YvQ/wp/m8
         VrqzHfkfE/tEad1aRwHJBTooq50vFn/WAwOrobwNTzwqFkISqLIQFGxRNxwW+SINv9dP
         RQqhZLMEePG6LL93j6d5jSM6Zc4DhCq9Ac60i/4eJ4N8/TtCbiYIPCrm9NtAe+Z2AmiU
         iixqQ2N7F/DxQRd3NdUahr5v6aa73DHk+kn1BHwwIpZyZDgtlSy9LTbJc3nsrpUd36S1
         2YUf7mjtCIzGFICmHUKlHHGgg3rliPlzNU713nSTEKFB15P+qt+Y+sqYcGWgryIPDdf+
         7Ogw==
X-Gm-Message-State: AOJu0YxUjWJ9LkZCV5f4m5Jl8SuAk6l7xTO+kpa8GIlLrGo8C6QWYz/f
        e1lr73UZWZdDPYOZJe3krdTPETE43pA=
X-Google-Smtp-Source: AGHT+IHdO2ePGWZ2T/u6ouW2RyOFAnxFSuMN6KLQF+uwQpvzyQnCwTs2W/bl2lKxXN9M1bJyUTS0v4MaghQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:33b0:9e28:e79a:8e70])
 (user=gnoack job=sendgmr) by 2002:a50:9351:0:b0:526:4d4c:fca4 with SMTP id
 n17-20020a509351000000b005264d4cfca4mr273583eda.1.1692964527080; Fri, 25 Aug
 2023 04:55:27 -0700 (PDT)
Date:   Fri, 25 Aug 2023 13:55:24 +0200
In-Reply-To: <20230818.ShaiGhu3wae9@digikod.net>
Message-Id: <ZOiWrOFYQdDyOch/@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com> <20230814172816.3907299-6-gnoack@google.com>
 <20230818.ShaiGhu3wae9@digikod.net>
Subject: Re: [PATCH v3 5/5] landlock: Document ioctl support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Fri, Aug 18, 2023 at 06:28:41PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> This looks good!
>=20
> On Mon, Aug 14, 2023 at 07:28:16PM +0200, G=C3=BCnther Noack wrote:
> > +IOCTL support
> > +-------------
> > +
> > +The ``LANDLOCK_ACCESS_FS_IOCTL`` access right restricts the use of
> > +:manpage:`ioctl(2)`, but it only applies to newly opened files.  This =
means
> > +specifically that pre-existing file descriptors like STDIN, STDOUT and=
 STDERR
>=20
> According to man pages (and unlike IOCTL commands) we should not
> capitalize stdin, stdout and stderr.

Done.

> > +are unaffected.
> > +
> > +Users should be aware that TTY devices have traditionally permitted to=
 control
> > +other processes on the same TTY through the ``TIOCSTI`` and ``TIOCLINU=
X`` IOCTL
> > +commands.  It is therefore recommended to close inherited TTY file des=
criptors.
>=20
> Good to see such warnings in the documentation.
>=20
> We could also propose a simple solution to still uses stdin, stdout and
> stderr without complex TTY proxying: re-opening the TTY, or replacing
> related FD thanks to /proc/self/fd/*
>=20
> For instance, with shell scripts it would look like this:
> exec </proc/self/fd/0
> exec >/proc/self/fd/1
> exec 2>/proc/self/fd/2
>=20
> Because of TIOCGWINSZ and TCGETS, an interactive shell may not work as
> expected though.

I inserted the phrase

  ..., or to reopen them from ``/proc/self/fd/*`` without the
  ``LANDLOCK_ACCESS_FS_IOCTL`` right, if possible.

to hint at that approach.

I added "if possible" there, because there are thorny edge cases that make =
it
difficult as a general approach -- the open(2) can fail if a stacked Landlo=
ck
policy exists.

=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
