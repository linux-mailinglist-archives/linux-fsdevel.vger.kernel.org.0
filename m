Return-Path: <linux-fsdevel+bounces-6543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C7681976B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 04:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49ED1F25725
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 03:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6CBE68;
	Wed, 20 Dec 2023 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7WSjxZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508688F59;
	Wed, 20 Dec 2023 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67f0cfd3650so38539536d6.3;
        Tue, 19 Dec 2023 19:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703044430; x=1703649230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XkPfiEhvxa8YlHOcqWd+fwFu91GxNXEY4eP9sBc5VQ=;
        b=Y7WSjxZBhVcGp33zrgjzc6jd/+dKdv3Go9RxqRqcVa0+v4x9PqzVUhlg06wyHe9zG/
         Oaz6HBgRhbpeXZHF3VQ3q+2GHx3xBL2aMHhipq6Br3OEB6mOv9vyfyMEaol1xDz0+weZ
         tiZrTd6HddqWoFszdp+jM8IVJ1eyMuedzBTYLOKJ5qM5l9H7nA61xODRZcl3FJQjWKDe
         AiuUCgfoXYg32vHvBFdN0TqAsmNrBr3V9WEtexH/LSC16PfCLs8zWYvp+W96atPPMGoI
         H5oelkR0ykLmfSxBKhO7pxaCZABg8wyfASOoLFfCrgsDJtoVOXfAyYYIeebtQNReq9l5
         AYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044430; x=1703649230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XkPfiEhvxa8YlHOcqWd+fwFu91GxNXEY4eP9sBc5VQ=;
        b=Pe0YacC3vVkyh+4qEWKhBhJDiZ05mjQAZQZiNSjtz/6VmVAh/e/5ydQC+Xpmmdesva
         n3BptQw52qSU7wTbz57gtZGDkdZIkZ54WJsEoHH1R4peG2Elo+1KksEy/1b4Yw1PUqXP
         XzECg29pnDSuN9w+I5UORP+UU7cCW3Lytx5i/IYc8IFgaf9zMBELEhXVCqvxBo+Wl+fO
         ikN3IcO9pAvJxpIPLvP6UxXJsbBNZVpuBuvARlJR+s8eGhn3aPF028ieLSk70cpK5+zI
         CXTZEF5n9Mf1wdrj5D5YxKkwxq8s618P09C2tTiZQihxyxVcW65SVzHNmtthU1dD7hjZ
         pvLA==
X-Gm-Message-State: AOJu0Yw3XyU31+itpL6nhAG9Q3/bkK6E3Do/8z00fBuzwm7mGJNh0yrr
	VuUDJruhrfdPdGF8mIUHQrqzWgNTTi1m1w+Gylg=
X-Google-Smtp-Source: AGHT+IHAJPflP2ZKvyugtw3WMtAMIunzuTW7V+ADzkbLOcp2OMVpjNq9E4VI8GdfRLLz1F9Z4GIvG3y6T0LVFy7ndQ0=
X-Received: by 2002:a05:6214:48c:b0:67f:4bd6:ccdd with SMTP id
 pt12-20020a056214048c00b0067f4bd6ccddmr4825261qvb.64.1703044430124; Tue, 19
 Dec 2023 19:53:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e171200600d6d8bd@google.com> <000000000000847160060ce61580@google.com>
In-Reply-To: <000000000000847160060ce61580@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Dec 2023 05:53:38 +0200
Message-ID: <CAOQ4uxiUoWO10a7UH5UweQ_1f+Fu+jSKPO66yAv80izyx9hBGg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
To: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, rafael@kernel.org, syzkaller-bugs@googlegroups.com, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 2:30=E2=80=AFAM syzbot
<syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 1e8c813b083c4122dfeaa5c3b11028331026e85d
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed May 31 12:55:32 2023 +0000
>
>     PM: hibernate: don't use early_lookup_bdev in resume_store
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14b15592e8=
0000
> start commit:   2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.o=
r..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D16b15592e8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12b15592e8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De5751b3a22261=
35d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dda4f9f61f96525c=
62cc7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D176a4f49e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D154aa8d6e8000=
0
>
> Reported-by: syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com
> Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resum=
e_store")
>

I'm not sure this bisection is reliable, so I wouldn't use this Fixes tag.
The reproducer may be a little flakey.

Anyway, this is just one of many problems, real or false positives,
related to the unholy dependency which sendfile() creates between
locks on two different filesystems.

I think those changes that are queued for 6.8 are going so fix this class
of problems:

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.=
rw

Thanks,
Amir.

