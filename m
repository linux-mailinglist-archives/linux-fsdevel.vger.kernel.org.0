Return-Path: <linux-fsdevel+bounces-1743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ECB7DE2F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 16:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF92B210BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02414282;
	Wed,  1 Nov 2023 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lFipfLJ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC27480
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 15:25:59 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912BA102
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 08:25:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a6190af24aso1068442166b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698852352; x=1699457152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iiFjAxByoCZ6Ygn48aA2uumGAG1mUgxAGkg/dB8QzFk=;
        b=lFipfLJ08y1VI0bw9xkl+SmM48hOy7Q8XPnvMEEGDEqh/LJ0wYf+X27b6JjuQDxtuf
         gdBPf5pdUmaMQ4Pl1SsNh5QJ6vaWeScZQskRECy2PuFTwY6LEfS4aAGA+kq9ExmPHJMS
         283GC7i3OdaDTjhS5cdnnBDVYK4QZ7wE55XC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698852352; x=1699457152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiFjAxByoCZ6Ygn48aA2uumGAG1mUgxAGkg/dB8QzFk=;
        b=lSXLTrDr3BP+Zb+zLtIH/rVqz8CuQsRb/raot7DchkIq73uSDv+4dhXMWQRbNWJ1mO
         nLFpS0DcO+2tnJr1qMjQ9Lz9nXfIk1kxUjIAJ3OrK2AtLugbjx7XHxg8oHZiXlATjURK
         v0E5vWZOEx0jUv873qutHdMM28fu7c7lEGKMD9bTYbvdk3SoszCmrP58jeJpfuFe+IEt
         /L3URej7IlSejT/lN4ZgM7XBc8wL6cMqQC4xczPgMAwYYjap32X4VRJAh6Dvy7cOX05Q
         bdMdtdED3busLo2uFiKvHmEc19wT3kxSKTDF5KhIaShtm/wbbYkjkNS92o1TB/GQnNce
         vKeA==
X-Gm-Message-State: AOJu0Yyc/WdnHqWI7TanzoVbXG3W27xQ7hkHgwehD3Vo3wuuQoWTm4Df
	IzJBITIvniIa6/2dHmonfjxTpM2gT51UZkSATr/0lw==
X-Google-Smtp-Source: AGHT+IFZPiPQod9Hy63BMn5slkRO0RWlM7EeW6gkS5SshoeBnp24XwqibB+gSqoo98i+X0E63U7T879yoSNcbwzhd+c=
X-Received: by 2002:a17:907:806:b0:9c7:54a1:9fe5 with SMTP id
 wv6-20020a170907080600b009c754a19fe5mr2535855ejb.49.1698852351945; Wed, 01
 Nov 2023 08:25:51 -0700 (PDT)
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
 <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com> <CAOQ4uxja2G2M22bWSi_kDE2vdxs+sJ0ua9JgD-e7LEGsTcNGXw@mail.gmail.com>
In-Reply-To: <CAOQ4uxja2G2M22bWSi_kDE2vdxs+sJ0ua9JgD-e7LEGsTcNGXw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 1 Nov 2023 16:25:40 +0100
Message-ID: <CAJfpegt3mEii075roOTk6RKeNKGc89pGMkWrvVM0uLyrpg7Ebg@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 16:06, Amir Goldstein <amir73il@gmail.com> wrote:

> That would make sense if readdirplus request is sent to server
> in parallel to executing readdir passthrough and readdirplus
> response does the prepopulation asynchronously.

Yes, that's fine, and it might even make sense to do that regardless
of passthrough.  Readdirplus is similar to read-ahead in this regard.

> Are you also referring to mixing cached and uncached readdir?
> because that seems fine to me.

But is it really fine?  The server must be very careful to prevent
inconsistency between the cached and the uncached readdir, which could
lead to really surprising results.  I just see no point in caching if
the same result is available from a backing directory.

> I will try to add these rules to FOPEN_PASSTHROUGH:
> - ignore request on backing inode conflict
> - ignore request if inode is already open in caching mode
> - make FOPEN_PASSTHROUGH implicit if inode is already open
>   in passthrough *unless* file is open with FOPEN_DIRECT_IO

Sounds good.

There's still this case:

 - file is opened in non-passthrough caching mode, and is being read/written
 - at the same time the file is opened in passthrough mode

The proper thing would be to switch the first file to passthrough mode
while it's open.  It adds some complexity but I think it's worth it.

Thanks,
Miklos



>
> Thanks,
> Amir.

