Return-Path: <linux-fsdevel+bounces-7880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD682C4BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 18:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3261F24A92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 17:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32AA22638;
	Fri, 12 Jan 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irTNUOwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191917C81
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbeba57a668so10043798276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 09:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705080707; x=1705685507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/xDksuN+LvJ10/jI/Zyo8K2rdrsP5fjP/70uJdQbj4=;
        b=irTNUOwFMchl96hCZqdBmo/Vwo8bXGwiPov/lA0Xu57XlLdeJKYXlaoC02sZc0iFHH
         +luGZwCTx4zuBpNrcJgy0XT8Gyxi9BywRIPmvBUnUXu2Eh0dYBtfTKV3E9NVcgo5Qr+6
         W2INk7J85C0rb2XmV2Y/LPiYWm/pZqqY0RI9yTarpu3S/WIroeh0cpmd9oamg1ldybN1
         Mf4UNid0lILQ16Wy/OQC9yDb3RhV6Ip/jYWtF6gac8vJGidYsYzG2G+kmzfgIvwQUlUb
         hGtmkgY9NaNyPQYkXiQ4qA4aceoEYNjxJRP5CgY8xdUFTVokK6Ybfd/1Ds9mvB7yf5o7
         ul1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705080707; x=1705685507;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1/xDksuN+LvJ10/jI/Zyo8K2rdrsP5fjP/70uJdQbj4=;
        b=STQwcHeUM5vj+dGLDY+SHMGGlZfavEAYZ9Slizo2Kz5z3MZOQFNJcCsbJh1dGg7Oyj
         d7L7BTxwTMi52+xncFuCwBEObHbtrb8VUgSPgdmg1wGPHvHdMxR+di/P4z1gvtd/CQmM
         3XTFT73cu7+z4Bm3jAkf/XIYv/kkVDRpDL7BdQWJ9Aw9iDAVMMuNXrMIhfXuxE01QEBN
         jeIy6CweDvRcMl4BRrsFCO0F3HxFDgh4O646hwHkuKVL4latW9CGaE6tkuwnXuiXYqsg
         neN/ZwJ5p7URn1UxqOU0PE3E2PZ2K5Jhh0T27rgvQq3kMc8mIYDGUKNGFvjOolheT/6n
         84VA==
X-Gm-Message-State: AOJu0YzonTE4SzY3tTH9vRsvFQJ5j8Xt/n0pbsmOK4umA8NbYzROYXTt
	/E8nJsa3C8Wzrkcjh07f18CVOVqGTcBTIeOteA==
X-Google-Smtp-Source: AGHT+IEQaz/Dkuk1zJCcZSVyvpbCs7ezLbQi0Lj526Y6e7IqtqBjWNMfte+WVeYQfNmmLbqzUOlV+NFFBGc=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:6695:c73f:f8c1:abaa])
 (user=gnoack job=sendgmr) by 2002:a05:6902:4cb:b0:dbe:fe5f:8a19 with SMTP id
 v11-20020a05690204cb00b00dbefe5f8a19mr507882ybs.1.1705080707026; Fri, 12 Jan
 2024 09:31:47 -0800 (PST)
Date: Fri, 12 Jan 2024 18:31:37 +0100
In-Reply-To: <11cdac1e-e96c-405f-63e8-35b0e2926337@arm.com>
Message-Id: <ZaF3eWlwAPQcFpoG@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com> <20231208155121.1943775-6-gnoack@google.com>
 <11cdac1e-e96c-405f-63e8-35b0e2926337@arm.com>
Subject: Re: [PATCH v8 5/9] selftests/landlock: Test IOCTL support
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-security-module@vger.kernel.org, 
	"=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Aishwarya!

Thanks for the bug report!

I tried this with the aarch64-linux-gnu-gcc-13 cross compiler on Debian, on
next-20231215, but I can not reproduce it.

On Fri, Dec 15, 2023 at 12:52:19PM +0000, Aishwarya TCV wrote:
> On 08/12/2023 15:51, G=C3=BCnther Noack wrote:
> > Exercises Landlock's IOCTL feature in different combinations of
> > handling and permitting the rights LANDLOCK_ACCESS_FS_IOCTL,
> > LANDLOCK_ACCESS_FS_READ_FILE, LANDLOCK_ACCESS_FS_WRITE_FILE and
> > LANDLOCK_ACCESS_FS_READ_DIR, and in different combinations of using
> > files and directories.
> >=20
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c | 431 ++++++++++++++++++++-
>=20
> Hi G=C3=BCnther,
>=20
> When building kselftest against next-master the below build error is
> observed. A bisect (full log
> below) identified this patch as introducing the failure.
>=20
> Full log from a failure:
> https://storage.kernelci.org/next/master/next-20231215/arm64/defconfig+ks=
elftest/gcc-10/logs/kselftest.log
>=20
> -----
> make[4]: Entering directory
> '/tmp/kci/linux/tools/testing/selftests/landlock'
> aarch64-linux-gnu-gcc -Wall -O2 -isystem
> /tmp/kci/linux/build/usr/include     base_test.c -lcap -o
> /tmp/kci/linux/build/kselftest/landlock/base_test
> aarch64-linux-gnu-gcc -Wall -O2 -isystem
> /tmp/kci/linux/build/usr/include     fs_test.c -lcap -o
> /tmp/kci/linux/build/kselftest/landlock/fs_test
> In file included from /tmp/kci/linux/build/usr/include/linux/fs.h:19,
>                  from fs_test.c:12:
> /usr/include/aarch64-linux-gnu/sys/mount.h:35:3: error: expected

The IOCTL patch set has introduced an "#include <linux/fs.h>" at the top of
selftests/landlock/fs_test.c (that file includes some IOCTL command numbers=
),
but that should in my mind normally be safe to include?

I'm surprised that according to the log, fs.h line 19 is including sys/moun=
t.h
instead of linux/mount.h...?  This line says =E2=80=9C#include <linux/mount=
.h>=E2=80=9D?

> identifier before numeric constant
>    35 |   MS_RDONLY =3D 1,  /* Mount read-only.  */
>       |   ^~~~~~~~~
> In file included from common.h:19,
>                  from fs_test.c:27:

If you have more leads or more concrete reproduction steps, I'd be interest=
ed to
know.  Otherwise, I'd have to just hope that it'll work better on the next
attempt...?

Thanks,
=E2=80=94G=C3=BCnther

