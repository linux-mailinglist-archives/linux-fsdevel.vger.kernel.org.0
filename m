Return-Path: <linux-fsdevel+bounces-7869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A6082BF76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 12:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0529CB2383D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC336A007;
	Fri, 12 Jan 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4j10oEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F2651BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-554acc951faso4232782a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 03:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705060284; x=1705665084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TseN7g0pet1ldc9EaSw/07BQWZW3q4sMA7PLy/XrEm8=;
        b=U4j10oEgcHFn0lyZMEmeL20YefRlbjUM2x4rBT8pcYugtyA3mzRpA/v+kfr+JRfJLW
         /wS5t7fmpN/BMn9L+kpXKIMxBNvMz9dR/cYDd4NAqCkQsBAyaJ9QDOGJnzGbz5C6XzAu
         uJ7EO8NKaYMpZtzUoQp0njmUZPpQqSkVSXx9+F1J5IqXsp5HTh7VTYoKaOBIajyHZqjv
         P9qjV9PuvtpU6cXAhiyO7DIvN1tb3Z1jXdhIBKULWZ2RQCR2neorznn0QSvyJvOUR+CY
         /aEpVnJSdCc4GnmlbYqMNcRPiZyigsuV7Zo5PPhnixw0mFMI4bnyDq6hJG3JUbW/3BBX
         kMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705060284; x=1705665084;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TseN7g0pet1ldc9EaSw/07BQWZW3q4sMA7PLy/XrEm8=;
        b=el8ywQzb8JqTbJnvX+C3ejI2s31kRd+hcRhWV4wCXEUA9snG9pOO8EMnuZqLqFym5K
         rGyMh1S8gISTZ+HLUNqGCm4s1WRlcrsEsW31wuEey6BIuX9PhdOhDycQprc6ny/AvsUG
         Za954LkjPmyHsgFaFRZckeRM/moYeFRRu2cUvhTLcETRkSeH1Y9NrPHVSVxg3yGZGEnE
         nbHTrUyHgB76dgZ8DZDvvtaW0HWDv1tXxvaBVvULbj7x0/pBXyHiwHK13JmQ5XTcc0lg
         WPCRswZV2+pSFcLGFXlhy10TheIkO4d67j2BjG9qcJceFHBQS4iYMDOloExW2+dR/kSw
         oI8g==
X-Gm-Message-State: AOJu0YxH74k/InbGMxDrFBVNX+zuhONDXUw0lOFGHC2AsmSIiIiS1UYa
	+qbCeRSYA1Q2meDkbO5YiICsF/at4C/aptsyhg==
X-Google-Smtp-Source: AGHT+IGJL2SaCk2QjBRCsoSYHX2UQTRhX4DBdCLMxRbXWvgRFMUVsv+HVG57IL0psmcycFS8gkca5EOLTfk=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:6695:c73f:f8c1:abaa])
 (user=gnoack job=sendgmr) by 2002:aa7:d413:0:b0:558:cce3:4dde with SMTP id
 z19-20020aa7d413000000b00558cce34ddemr5104edq.7.1705060284350; Fri, 12 Jan
 2024 03:51:24 -0800 (PST)
Date: Fri, 12 Jan 2024 12:51:14 +0100
In-Reply-To: <20231213.java5eeb4Nee@digikod.net>
Message-Id: <ZaEnsqnybWKgXg4N@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com> <20231208155121.1943775-10-gnoack@google.com>
 <20231213.java5eeb4Nee@digikod.net>
Subject: Re: [PATCH v8 9/9] landlock: Document IOCTL support
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:25:15PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Dec 08, 2023 at 04:51:21PM +0100, G=C3=BCnther Noack wrote:
> >  Documentation/userspace-api/landlock.rst | 119 ++++++++++++++++++++---
> >  1 file changed, 104 insertions(+), 15 deletions(-)
> >=20
>=20
> > +Restricting IOCTL commands
> > +--------------------------
> > +
> > +When the ``LANDLOCK_ACCESS_FS_IOCTL`` access right is handled, Landloc=
k will
>=20
> I only use "right" (instead of "access right") when LANDLOCK_ACCESS_*
> precede to avoid repetition.

Done.

> > +restrict the invocation of IOCTL commands.  However, to *permit* these=
 IOCTL
>=20
> This patch introduces the "permit*" wording instead of the currently
> used "allowed", which is inconsistent.

Done.


> > ++------------------------+-------------+-------------------+----------=
---------+
> > +|                        | ``IOCTL``   | ``IOCTL`` handled | ``IOCTL``=
 handled |
>=20
> I was a bit confused at first read, wondering why IOCTL was quoted, then
> I realized that it was in fact LANDLOCK_ACCESS_FS_IOCTL. Maybe using the
> "FS_" prefix would avoid this kind of misreading (same for READ_FILE)?

Done.


> > +|                        | not handled | and permitted     | and not p=
ermitted |
> > ++------------------------+-------------+-------------------+----------=
---------+
> > +| ``READ_FILE`` not      | allow       | allow             | deny     =
         |
> > +| handled                |             |                   |          =
         |
> > ++------------------------+             +-------------------+----------=
---------+
> > +| ``READ_FILE`` handled  |             | allow                        =
         |
> > +| and permitted          |             |                              =
         |
> > ++------------------------+             +-------------------+----------=
---------+
> > +| ``READ_FILE`` handled  |             | deny                         =
         |
> > +| and not permitted      |             |                              =
         |
>=20
> If it makes the raw text easier to read, it should be OK to extend this
> table to 100 columns (I guess checkpatch.pl will not complain).

I got it down to 72 columns and it still reads reasonably well.
(Emacs has support for editing ASCII tables. :))

=E2=80=94G=C3=BCnther

