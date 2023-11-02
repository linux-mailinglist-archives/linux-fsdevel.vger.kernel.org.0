Return-Path: <linux-fsdevel+bounces-1808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C17DF077
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BAC8B20E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065D4125B0;
	Thu,  2 Nov 2023 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cWI/UPu+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9D86FAD
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 10:46:30 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B60A12E
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 03:46:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c603e2354fso157883066b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 03:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698921983; x=1699526783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JFmGqAlo8YE9NM/lf5n/tSBCWxvDVSe4ziOVIuirGQ=;
        b=cWI/UPu+oqcUiUrAvmXJbki6cBZ2kFF1rSXP8T2ZLzdvZjDlOsyKNonwQjJjxPgEpg
         FYe06p2ls3sdoYTwMLZhHXR2XcNSMvB70Bw3nQwJh1p7pfJSj5vKYZZBo8nV0PeTJSX/
         67dFirRNettD7j5QTF63gfvrcyvOD50x+2HoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921983; x=1699526783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JFmGqAlo8YE9NM/lf5n/tSBCWxvDVSe4ziOVIuirGQ=;
        b=ETWHat5Kn1xMsO8AEVuhQLDBKTUDsoFKIk1HEm3vbztF/JQqKlIX7qvaCTk5ALP1Pn
         Nvz+XfP+QES9x1/yHloGX2Uf9nGha7rVepH1EDIf/aZi56ZPLDO142Jp9nh6Kx/pgozI
         fCW6Uk7ABEGQAO98KqJmQGbetAmkWGLFD/Yuc8p51ka5AOQbLfvrLvroml/X4J1zjvPi
         TayqTaOPY/TPAQuNPCRvvCaQ9YJJ6BvpJ1T7CpE3QTbnYX4gxoiTxfaakTeotxQKdtU+
         Itl4n5bOyT/xIO55kRis5QoLugAvLp9n573v464qQPUuyr6785dCU8FOwa1WTZTnS/x0
         rx3Q==
X-Gm-Message-State: AOJu0YyikoJCRm4uF2sJ0U4wpS6M2wDJqkUQAH0zwur+x44aQ1tEZyvy
	/MS3Sg3LwpRHYCpHAwA+jHP7S+JVNPWKBuKAmK1qHg==
X-Google-Smtp-Source: AGHT+IEDpZNEa/4bPrlfbbRbQ2CEy+ba+A27f9SG+KKRySs1nN/0ACS0TBcZaC7Ep+Kzcg9gjSRxDFdaNHg9dCLvGbU=
X-Received: by 2002:a17:906:52d2:b0:9c5:7f5d:42dc with SMTP id
 w18-20020a17090652d200b009c57f5d42dcmr4654657ejn.33.1698921983668; Thu, 02
 Nov 2023 03:46:23 -0700 (PDT)
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
 <CAJfpegt3mEii075roOTk6RKeNKGc89pGMkWrvVM0uLyrpg7Ebg@mail.gmail.com> <CAOQ4uxipyZOSMcko+V+ZxGZwAgKVwWTUeoH79zqtMqbcKSnOoA@mail.gmail.com>
In-Reply-To: <CAOQ4uxipyZOSMcko+V+ZxGZwAgKVwWTUeoH79zqtMqbcKSnOoA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 2 Nov 2023 11:46:12 +0100
Message-ID: <CAJfpegs5m-7QapX86CEiyy5oDzJQox6QsWjcLeegMV9OMbkBrg@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 19:32, Amir Goldstein <amir73il@gmail.com> wrote:

> I see. so if dir has backing inode, we can always
> disable FOPEN_CACHE_DIR (as my patch already does)
> but instead of alway doing passthrough readdir, we employ the
> heuristic whether or not to do readdirplus.
> If not doing readdirplus, we can do fuse_passthrough_readdir().

Okay.

> In the future, we could do async readdirplus and always call
> fuse_passthrough_readdir() if we have backing inode.

Yes.

> For now, I will just remove the readdir passthough patch.

Yes, let try to do the minimal useful thing first.

>
> Remember that we would actually need to do backing_file_open()
> for all existing open files of the inode.

I know.

> Also, after the server calls FUSE_DEV_IOC_BACKING_CLOSE,
> will the fuse_backing object still be referenced from the inode
> (as it was in v13)? and then properly closed only on the last file
> close on that inode?

Yes, those seem the most intuitive semantics.

> I am not convinced that this complexity is a must for the first version.
> If the server always sets FOPEN_PASSTHROUGH (as I expect many
> servers will) this is unneeded complexity.
>
> It seems a *lot* easier to do what you suggested and ignore
> FOPEN_PASSTHROUGH if the server is not being consistent
> with the FOPEN_ flags it uses.

The problem with ignoring is that we can't change the semantics later.

So I think it would be better to enforce consistency such that if
there's already an open file, new open files will have to have the
same FOPEN_PASSTHROUGH state, and just reject with EIO if not.

Thanks,
Miklos

