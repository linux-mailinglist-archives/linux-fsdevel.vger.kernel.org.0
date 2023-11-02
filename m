Return-Path: <linux-fsdevel+bounces-1823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 174CA7DF33D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE89E1F22684
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D141E125D8;
	Thu,  2 Nov 2023 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emGiXv5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC010A2C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 13:08:12 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C2BBD
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 06:08:11 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b52360cdf0so488215b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698930490; x=1699535290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC3Cm0LEGs08Dy1sSFO3jxuTfBBbavT46vuOFqL2w+I=;
        b=emGiXv5X9kDmw9JXRgSxlMrDHD7HcWHgAqUmOdvKh7kTu8wle7s6Viq84Zge35YNrF
         Pz9uwaq5Vpa02dXEBBCwrg4L39wsuul3E3iOLW+jbL9jql62pXnxsWQgyFNlrECdGMC4
         uuXI/Fr7BZggxuJ2yc3N272CMS5JAL8qtMjU5OWz5vCvc5xaomx68fp5+B6z1O9Hmncl
         GfF26+qQb6f1qoM38Pil2wHXat7ZB3VIFrvhB9UOtdikcRdrTwIcemQlxrcxVZTsOe9L
         ypwyIEjBt/TAk/lZcngQyoTOsSK4q9UKELSPyFOhSCtN4b6xfyzXJV7B1/c4VgdKnH4d
         70FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698930490; x=1699535290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC3Cm0LEGs08Dy1sSFO3jxuTfBBbavT46vuOFqL2w+I=;
        b=MxssCWBiukLxwdfMhy7eY/9levk/+rmFnDQbJ8wu9tg6K/lxc+zVgUeacgfBoOIMaf
         pvAl6JfZsnYjo9SmHsK7JudpScqQJBWICcRxPI8KmC9RxPJwiR1EBnN4T9RLAJE0XMqB
         gkX/11YEXbBeD++Klsb45M1puvRPmwPhyr8oXkI+TZ2fAUDClaCJA+gBupkGcTANHl0L
         Fx51Hj8zAILSutN89MihBcV7ObOKmGEvCOBUhmH+UYn4beU8taIEoauPn7pscDdG4eYb
         JyIjuYXlgtN1FOisEe3btPx1jZpty7SR2DrSxiiPp/AFoBcYg/PnfEcCv1w7S0gcO1pQ
         Nohw==
X-Gm-Message-State: AOJu0YxahV9gRO4k8C0pb059PHLCuTI2Uyz9kkyH1s7XdInue0amwoBf
	telYPCVxkit/mMas3zPyaHK3xEe1LxMcH8Qhm3BPlk9uq3M=
X-Google-Smtp-Source: AGHT+IGIDSCinoXMFvgG4zIZQ2wuFFWprJ68V5IV+PI6sdBdJIy+ze/xIxmOdfLACul0ut5keTQc9pF9BSClXoyT7m0=
X-Received: by 2002:aca:2303:0:b0:3ac:b73a:757f with SMTP id
 e3-20020aca2303000000b003acb73a757fmr15262112oie.39.1698930490301; Thu, 02
 Nov 2023 06:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
 <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
 <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
 <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
 <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
 <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com>
 <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
 <CAOQ4uxja2G2M22bWSi_kDE2vdxs+sJ0ua9JgD-e7LEGsTcNGXw@mail.gmail.com>
 <CAJfpegt3mEii075roOTk6RKeNKGc89pGMkWrvVM0uLyrpg7Ebg@mail.gmail.com>
 <CAOQ4uxipyZOSMcko+V+ZxGZwAgKVwWTUeoH79zqtMqbcKSnOoA@mail.gmail.com> <CAJfpegs5m-7QapX86CEiyy5oDzJQox6QsWjcLeegMV9OMbkBrg@mail.gmail.com>
In-Reply-To: <CAJfpegs5m-7QapX86CEiyy5oDzJQox6QsWjcLeegMV9OMbkBrg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 2 Nov 2023 15:07:58 +0200
Message-ID: <CAOQ4uxjc6B2kXvbnbYPNCr8+ysFCoH24s+3fFa_Xkapyb9ueKA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 12:46=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> >
> > Remember that we would actually need to do backing_file_open()
> > for all existing open files of the inode.
>
> I know.
>
> > Also, after the server calls FUSE_DEV_IOC_BACKING_CLOSE,
> > will the fuse_backing object still be referenced from the inode
> > (as it was in v13)? and then properly closed only on the last file
> > close on that inode?
>
> Yes, those seem the most intuitive semantics.
>

Just to be clear, at the last close for an inode, we would check
if attribute cache needs to be invalidate and the inode will return
to "neutral" mode, when server could legally switch between
caching and passthrough mode.

This part is critical to my in-house server, because when files are
not open, their content may become evicted and they may no longer
be passed through to.

> > I am not convinced that this complexity is a must for the first version=
.
> > If the server always sets FOPEN_PASSTHROUGH (as I expect many
> > servers will) this is unneeded complexity.
> >
> > It seems a *lot* easier to do what you suggested and ignore
> > FOPEN_PASSTHROUGH if the server is not being consistent
> > with the FOPEN_ flags it uses.
>
> The problem with ignoring is that we can't change the semantics later.
>
> So I think it would be better to enforce consistency such that if
> there's already an open file, new open files will have to have the
> same FOPEN_PASSTHROUGH state, and just reject with EIO if not.
>

EIO works for me.
Just as simple.
Will try to get this ready for early 6.8 cycle.

Thanks,
Amir.

