Return-Path: <linux-fsdevel+bounces-5308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192580A12D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 11:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE9E1F2164D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5AE19BB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hsf9QDnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474EF1733
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 02:20:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db401df7735so2551897276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 02:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702030853; x=1702635653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySaFJ2QFmUuvPKAGDmyec7fNSS8cS31F+E74vXYhN7o=;
        b=Hsf9QDnZNtsMD6pnQdNBDizK3m7D9IhO2uCvJ7FVERE3l3AT7B2htznIgn19FbhPBh
         otGweY69GKwQWT0Ux7zVYV5C67otVq0JV3StN8d0Vcea/9SmIydeKZUcSWdP4oMVEP7x
         XnA9J15QPbNgBjZg8nzgArU1sHXzqV8NSPi7ODixelFzKSO/UXXlmltzoDxvhUuHNJWN
         yAOyzMV69qvga0PtFSbUzGDZZswRZbFd7q+Wo1o6NpJ0Tn8tSWDtDmUrepjtpOS9ASqy
         2FdaTEJrpgaocja2bYln2YUCd1Yep1x3mo2L1t+l2G/A7kHINXYqKUlPG0/7LUO4ER00
         wVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030853; x=1702635653;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ySaFJ2QFmUuvPKAGDmyec7fNSS8cS31F+E74vXYhN7o=;
        b=X251Fdg0piuLtoCuaNAuhVZuYUt5IbAiQQoiuJZ4usbbs8apwkhGUkVHmTs/eJ8tXX
         UIXLm1CfCMFz20VjGetmBr10tUXyCS9dnXmpSz6I4c9PgW2jHEmtzLLovu9S5LfBIyEk
         3I5wYMZaz3jQAZoyQDJEBS5tVJkecjmxZEnWKdykN+e3XGXIggk70Z4adyJ/fxRawsSH
         B8WJdsp7XhLXug9ZtpCjF+DfAc372+jHoVqbzw5yyjcQgb9GWaqJZV0ymqblqib8hlHY
         stFWKln0daKs6BXzkyMhhOUpEFGojQD1wOW5ZX0R906X5RGmLXy7+A6RH1tiPYWvpcxc
         jKfQ==
X-Gm-Message-State: AOJu0YxTOTr/tVI8qS0NLOBm5LDntzoN9eWew/K2ypuIY4USYSQKc5al
	5gZ0zWHPR5pxUySQOpV03UBGhUHnBcI=
X-Google-Smtp-Source: AGHT+IEIBJSHoHcB6uCL6FpS7AscAT4qpHma+cr8VFsmorCTLSRFzVjs6l0QTo9cfENLMZ1tCqAXOBRYhn0=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a25:d096:0:b0:db5:3e28:4893 with SMTP id
 h144-20020a25d096000000b00db53e284893mr46663ybg.12.1702030853455; Fri, 08 Dec
 2023 02:20:53 -0800 (PST)
Date: Fri, 8 Dec 2023 11:20:44 +0100
In-Reply-To: <CABi2SkXvTdrygc4rNmKBSRT5DRv_FeoX+y26JruBbeX_MwwLTQ@mail.gmail.com>
Message-Id: <ZXLt_GB-3ngyMM2O@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com> <20231201143042.3276833-5-gnoack@google.com>
 <CABi2SkXvTdrygc4rNmKBSRT5DRv_FeoX+y26JruBbeX_MwwLTQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] landlock: Add IOCTL access right
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: linux-security-module@vger.kernel.org, 
	"=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Jeff!

On Fri, Dec 01, 2023 at 11:51:16AM -0800, Jeff Xu wrote:
> On Fri, Dec 1, 2023 at 6:40=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.=
com> wrote:
> > --- a/security/landlock/limits.h
> > +++ b/security/landlock/limits.h
> > @@ -18,7 +18,10 @@
> >  #define LANDLOCK_MAX_NUM_LAYERS                16
> >  #define LANDLOCK_MAX_NUM_RULES         U32_MAX
> >
> > -#define LANDLOCK_LAST_ACCESS_FS                LANDLOCK_ACCESS_FS_TRUN=
CATE
> > +#define LANDLOCK_LAST_PUBLIC_ACCESS_FS LANDLOCK_ACCESS_FS_IOCTL
>=20
> iiuc, for the next feature, it only needs to update
> LANDLOCK_LAST_PUBLIC_ACCESS_FS to the new LANDLOCK_ACCESS_FS_ABC here.
> and keep below the same, right ?
>=20
> > +#define LANDLOCK_MASK_PUBLIC_ACCESS_FS ((LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 1) - 1)
> > +
> > +#define LANDLOCK_LAST_ACCESS_FS                (LANDLOCK_LAST_PUBLIC_A=
CCESS_FS << 4)
> maybe add a comment why "<<4" is used ?

I'll add a comment to the section explaining it:

  For file system access rights, Landlock distinguishes between the publicl=
y
  visible access rights (1 to LANDLOCK_LAST_PUBLIC_ACCESS_FS) and the priva=
te
  ones which are not exposed to userspace (LANDLOCK_LAST_PUBLIC_ACCESS_FS +=
 1 to
  LANDLOCK_LAST_ACCESS_FS).  The private access rights are defined in fs.c.

This should clarify both questions, I hope.

You are correct -- the private access rights in fs.c are defined relative t=
o the
last public access right.

=E2=80=94G=C3=BCnther

