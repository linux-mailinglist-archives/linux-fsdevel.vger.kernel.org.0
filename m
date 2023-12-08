Return-Path: <linux-fsdevel+bounces-5374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6782D80AE40
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06283B209E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA4446BBF;
	Fri,  8 Dec 2023 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WyUcGDRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0BB1706
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 12:49:03 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d9d84019c5so1516599a34.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702068542; x=1702673342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwE2AzYmkpAw8bzbj4MxYvJwrrSeZEF9D3ieIA5Ehk0=;
        b=WyUcGDRYKxsSmCDgaFtMaLINsp0mrkaRWEynSKiXKw0l7dGGozmzEl3GO9PhwTJrId
         M2aWP71eHYe4mmaahsvbqLsGF6+qNUfMw0xM7YR3LaQEcXxI4UsewEh9eJOlpfzlH8a9
         i9Bte7+ebGo9hvzCCDBVs8yyA/cfd05GHe4mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702068542; x=1702673342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwE2AzYmkpAw8bzbj4MxYvJwrrSeZEF9D3ieIA5Ehk0=;
        b=DWU6pRVt6oe53OvaS0GbKe1wYv9AGOXkQCUbcF65g1LiTibRtexO9xofxymPPe1jF9
         JssVEcsr3kpjhfutfj99/lcsLiiEcNmTT2tjdzD2LUaIx7CjDrB1Aa2lKZQt4oU49vSs
         Iyxwzd7+PNP7Yk0XUzA08gsPN+lilR7adZy65T4wjiYue6sj9EFxKPSSHftECwBp1DqQ
         V4WQoOM+AhXK6SR1qXE6E4S5tNN73Pfiq7wRSBL+NIJZqcm2pmPqidQouZFMAcMEh5Ph
         eudbkordhG0G93dznIKHP1ZXkiYIJuo5g3osydVQWAOtS+nFBCDtO7SEGCs91O8HYY5l
         N/JA==
X-Gm-Message-State: AOJu0YwXjMP7BJJPPcgdTC1WIxTl2eV9ySCsF7LNdtKHDinGGleURMXI
	JoSXBILnSeBiJFGz2tWma+czrePwXypPb9ACu5NfQw==
X-Google-Smtp-Source: AGHT+IEYFwS3zE5RSWcMS4d3izmpBbuXCYSvepWUvQlenba8H9TA1qIDN/wlsjSCKB/RoUvLy2AIjEHKVgllD4g77eQ=
X-Received: by 2002:a05:6870:d625:b0:1fb:75b:1321 with SMTP id
 a37-20020a056870d62500b001fb075b1321mr860802oaq.115.1702068542444; Fri, 08
 Dec 2023 12:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com> <20231201143042.3276833-5-gnoack@google.com>
 <CABi2SkXvTdrygc4rNmKBSRT5DRv_FeoX+y26JruBbeX_MwwLTQ@mail.gmail.com> <ZXLt_GB-3ngyMM2O@google.com>
In-Reply-To: <ZXLt_GB-3ngyMM2O@google.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 8 Dec 2023 12:48:50 -0800
Message-ID: <CABi2SkV2qzK6ufW_qfJbWRKiApNqsJ54uNeWXHcaS_B8=Pc-zg@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] landlock: Add IOCTL access right
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 2:20=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> Hello Jeff!
>
> On Fri, Dec 01, 2023 at 11:51:16AM -0800, Jeff Xu wrote:
> > On Fri, Dec 1, 2023 at 6:40=E2=80=AFAM G=C3=BCnther Noack <gnoack@googl=
e.com> wrote:
> > > --- a/security/landlock/limits.h
> > > +++ b/security/landlock/limits.h
> > > @@ -18,7 +18,10 @@
> > >  #define LANDLOCK_MAX_NUM_LAYERS                16
> > >  #define LANDLOCK_MAX_NUM_RULES         U32_MAX
> > >
> > > -#define LANDLOCK_LAST_ACCESS_FS                LANDLOCK_ACCESS_FS_TR=
UNCATE
> > > +#define LANDLOCK_LAST_PUBLIC_ACCESS_FS LANDLOCK_ACCESS_FS_IOCTL
> >
> > iiuc, for the next feature, it only needs to update
> > LANDLOCK_LAST_PUBLIC_ACCESS_FS to the new LANDLOCK_ACCESS_FS_ABC here.
> > and keep below the same, right ?
> >
> > > +#define LANDLOCK_MASK_PUBLIC_ACCESS_FS ((LANDLOCK_LAST_PUBLIC_ACCESS=
_FS << 1) - 1)
> > > +
> > > +#define LANDLOCK_LAST_ACCESS_FS                (LANDLOCK_LAST_PUBLIC=
_ACCESS_FS << 4)
> > maybe add a comment why "<<4" is used ?
>
> I'll add a comment to the section explaining it:
>
>   For file system access rights, Landlock distinguishes between the publi=
cly
>   visible access rights (1 to LANDLOCK_LAST_PUBLIC_ACCESS_FS) and the pri=
vate
>   ones which are not exposed to userspace (LANDLOCK_LAST_PUBLIC_ACCESS_FS=
 + 1 to
>   LANDLOCK_LAST_ACCESS_FS).  The private access rights are defined in fs.=
c.
>
> This should clarify both questions, I hope.
>
Yes. Thanks!
-Jeff

> You are correct -- the private access rights in fs.c are defined relative=
 to the
> last public access right.
>
> =E2=80=94G=C3=BCnther

