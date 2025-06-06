Return-Path: <linux-fsdevel+bounces-50877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C090AD0A27
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6AFB7AB3C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0B23ED74;
	Fri,  6 Jun 2025 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Dne/0Q5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABB23C4FC
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749251101; cv=none; b=XzWGev/ccZsQSvahZHqEMqUJrI2km23iQ8OL5OX7Xnt2qCT/XOr0ps29Hp4vCgfX7L2WuNTMffMGHehn8LOkEQHDUegygyPyMsCoB4KO0Vh5D6tKfTxQH/5z0xR1qRgGheVwLGoX91MsnwyP29hkM7O20J8/hPI7w8syYHd8/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749251101; c=relaxed/simple;
	bh=QOivU9cCWOuD6+qnCQXHqwXBoofn756k+BYeNjlbNGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/bQ1UTwbgQnGgJNKnIMYTACfszW40+BwgFhRKIW2Ye4hvXjcZMWeCMvACLbn9emKujk4nIT0XjJMR/EK3hYuUaTQ/TePNymX4Nh8woNE9p1h+d++yKMzXOm7g+xz9Dk2OtB4GAX31I6dILyVZqNOYd1dj0rbt9nsJuSiWzWtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Dne/0Q5q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b26d7ddbfd7so2798672a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 16:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749251099; x=1749855899; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8FCwWKZSt8jlO+Nh8PWh4qO6V0jK1RFpZe2Cr7kkzR4=;
        b=Dne/0Q5qqaKrbXz7KduXx2zlzMNmN96B2q+Vin2OC0P4VIo0cmaoDMzAl+gtw0yBAH
         rNOedtEqBGRos+Ofv2R8YdHTWT/2YO2gwjfXRdoOoN4ZrUwUvEbJG4vgRR7lJtX7O9o4
         WJ4/OI/Gm+odswFbLQRdW7D3eIbOyjuGzLXbXjRtPdIVEvFQZKs21nMGJrLlbcO24DTB
         lfeMf2ecidmiv4VBPYfKPe2li6Ju/BI0/8Rf97rmqmblgYsoEd5ZS7j2Y3r7T/XUE5N/
         mB/gvBJnJu+GaG1bOVNHnOrH5nhNpDjznwi8P3+sYbJ2GKF9Yf8iILcLiJ3EZ1w5qi4X
         bckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749251099; x=1749855899;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FCwWKZSt8jlO+Nh8PWh4qO6V0jK1RFpZe2Cr7kkzR4=;
        b=qI9JeAIZSnx92NbodywRrAUx4q7+/mLI7mkBm2+cF3bEjIEHGOpt2n0Piv/HsNHXkV
         2fr7x9QXMOAqi2a/lferrCpBX6b0Z8m3CxFovKG4G7TWkx45kwQajsGu7VamhAsq2iMC
         azHm6kQINl+Y1FZzYS73hq/QeceEWI40wN6uBJ5s0DWUlYiSRJMA+h2WW+13wWckVsul
         XAKSC+JXxGWSSOW+KkHt7MAKlbofenI7lvGgOFKwTVcjHfTsmu3i4aaj81xCXEPehY6F
         rpD2e72CXWvVDntul1umWvIwmALCUYRE/ywr4g7kR9GWN2rumw6Q7PyUdp9h+2NkKU9b
         9xGw==
X-Gm-Message-State: AOJu0YwwOv/AxOuUjqFLnLx348hWb09CgKFrbW7kUPJ6kGNWNJs8tJcD
	RJhJ2J5DTshhx1Rh5Qi95DrAetTZIL67NXc/P6MGmDn+KDBAgom8lnFVKd18czuBJT0=
X-Gm-Gg: ASbGncuGFNnP/evIoIwnFnR9dWB4rTxiyZ1K6x2tI5Qb1zPKn9D2NKK6+aPxD0A9Q4o
	HHZFrb/9neObSVTZmFwe1UhAev1Y0z0epLvG085dk7BrKIce61Erf6qu0quPIBwmnFHu3CTszA5
	D6AuPuxdXsFO82q1FkakHNz3Z7ODW7otBckRYEYT2UAAZrN6zbY1M/404oejtSFrjTXDnAjo7ke
	tpysJ0nYuwlhtyebAQwACd4+yVHgkzA4S9oJSTtm4jwrHHBdOUVVHhNPN5GssbFku+TbYsF0CYC
	e3o5CLIRppm5sGTz7aubSncQOOTKV8ZAbo1qIiY7OVlbwuutXf36VsNgg927uAj2fhHoCdVSpmg
	BqXLe4VzeQfOTdG51CA4X
X-Google-Smtp-Source: AGHT+IG64ChHlIEnH7AGZWP1roW4oYFooio9dxXqOSvuAYjcY7yPJNcaadXJ+ghoASQqymoWgh+a0A==
X-Received: by 2002:a17:90b:4e83:b0:312:f54e:ba28 with SMTP id 98e67ed59e1d1-31347057c9amr8210172a91.24.1749251098933;
        Fri, 06 Jun 2025 16:04:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:77a3:4e60:32de:3fd? ([2600:1700:6476:1430:77a3:4e60:32de:3fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349f32cc6sm1829579a91.11.2025.06.06.16.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:04:58 -0700 (PDT)
Message-ID: <e9aa0276f0aad149ee7225da5f6b2493d7593df9.camel@dubeyko.com>
Subject: Re:  [PATCH 2/2] hfs: make splice write available again
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>, Viacheslav
 Dubeyko <Slava.Dubeyko@ibm.com>,  "frank.li@vivo.com"	 <frank.li@vivo.com>,
 "glaubitz@physik.fu-berlin.de"	 <glaubitz@physik.fu-berlin.de>,
 "viro@zeniv.linux.org.uk"	 <viro@zeniv.linux.org.uk>, "kees@kernel.org"
 <kees@kernel.org>
Date: Fri, 06 Jun 2025 16:04:57 -0700
In-Reply-To: <604cca238cdecbbe3dee499b8363f31ddd9e63bc.camel@ibm.com>
References: <20250529140033.2296791-1-frank.li@vivo.com>
		 <20250529140033.2296791-2-frank.li@vivo.com>
	 <604cca238cdecbbe3dee499b8363f31ddd9e63bc.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Christian,

Could you please pick up the patch?

Thanks,
Slava.

On Thu, 2025-05-29 at 18:28 +0000, Viacheslav Dubeyko wrote:
> On Thu, 2025-05-29 at 08:00 -0600, Yangtao Li wrote:
> > Since 5.10, splice() or sendfile() return EINVAL. This was
> > caused by commit 36e2c7421f02 ("fs: don't allow splice read/write
> > without explicit ops").
> >=20
> > This patch initializes the splice_write field in file_operations,
> > like
> > most file systems do, to restore the functionality.
> >=20
> > Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without
> > explicit ops")
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> > =C2=A0fs/hfs/inode.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> > index a81ce7a740b9..451115360f73 100644
> > --- a/fs/hfs/inode.c
> > +++ b/fs/hfs/inode.c
> > @@ -692,6 +692,7 @@ static const struct file_operations
> > hfs_file_operations =3D {
> > =C2=A0	.write_iter	=3D generic_file_write_iter,
> > =C2=A0	.mmap		=3D generic_file_mmap,
> > =C2=A0	.splice_read	=3D filemap_splice_read,
> > +	.splice_write	=3D iter_file_splice_write,
> > =C2=A0	.fsync		=3D hfs_file_fsync,
> > =C2=A0	.open		=3D hfs_file_open,
> > =C2=A0	.release	=3D hfs_file_release,
>=20
> Makes sense.
>=20
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>=20
> Thanks,
> Slava.

