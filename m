Return-Path: <linux-fsdevel+bounces-3295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C77F28ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 10:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D51C216EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759863B7B9;
	Tue, 21 Nov 2023 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzq2SDHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E1C1
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 01:28:52 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-daec4e4c5eeso4817876276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 01:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700558931; x=1701163731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xjWYTkRLYL6XC3DUIdKM15xQEWem4tDVRNC9bqGaBw=;
        b=Qzq2SDHu7HwzErVTVLFfkmgbwIRvYUVCKqsnd4/JVAOkZd9teYRbhdT/y02rL5kXqC
         Wv1yzxr0PkHc2Zd3Yi3nlg18rqj6c9RXoCVqwcXFAnmECSiKAUidVSz9a1gzEo6B2olG
         OrAeorKFU3FkarVFazovCv4m2dBfRKGd9Qb8PNhC/F3R+CcO8hSUcBfvzt7pgqsMkuNq
         bl5n+vklNF4SAt5CerDiqDzSP6/vG2DSphphULSJe/1V7+j1oJWPXi2AJb/wc0s9u6g9
         Jj91J3aCYPnuzaB/UH2AAxu//w8YMAkB8CTIlxHneJ0Bm7lGIRVb6Cyd6scBVEIFHHnC
         PkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700558931; x=1701163731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xjWYTkRLYL6XC3DUIdKM15xQEWem4tDVRNC9bqGaBw=;
        b=OksiLpRV/Pnva3cZNHcf0wwlVh7itYlZEUbvpTfnkFUPzsZYTo/vX0cl5EhFeeSYpw
         CiQ32GXIqZnAzhFOkPixJEL/OIOkIj0edaLPDFxCI0g6YuYJEkqYmDDPl5UNBCxGJheR
         2fCEB9x3l/E2xwmuAQXyHMaM3k5AEpo8Xnt/vIK5Eyt4jHAvZdwPeS6Zy5AMmeJxiOSP
         gykJpvkNsVG+Dkymg02qHse4RWn0MccHz6PtegXIraEB1S4RlVYzH0X/TO1u6vDWnyUu
         B2wrYa+dWOBpEEU6Jzrg1+dgg6vZjzkzy5Saxmt0sTe2PFM3L6kCP0HQUom+kyg6YhhZ
         sDZw==
X-Gm-Message-State: AOJu0YxNEsB9OmZ5YflGLCTlTeZRqkQl/g4HWPpS1Q/YP19Q158+qA5l
	PjHPEEdWNdkO7ZOQZtBjVuOwYJISpQrfyrD2oNY=
X-Google-Smtp-Source: AGHT+IG4s9y3HRQuQ4i4U4tQQ+Pc9b3KYgHnR3Roj5TmSXDeQQf30NptUgmajCvGRXwLY/CbRR07fwI48w+WRUugASc=
X-Received: by 2002:a5b:74d:0:b0:d9b:4f28:4f7a with SMTP id
 s13-20020a5b074d000000b00d9b4f284f7amr9567943ybq.55.1700558931527; Tue, 21
 Nov 2023 01:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120101424.2201480-1-amir73il@gmail.com> <20231120165646.GA1606827@perftesting>
 <CAOQ4uxhNhmGrb7_Lwp9pt-hyaBUQz9++PH0KR1r3=cjKVCJJfQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhNhmGrb7_Lwp9pt-hyaBUQz9++PH0KR1r3=cjKVCJJfQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Nov 2023 11:28:40 +0200
Message-ID: <CAOQ4uxhgb+S9=_CVz1sMK7X4=0C2=tE=GUBmow8QTuyHP+X2NQ@mail.gmail.com>
Subject: Re: [PATCH] cachefiles: move kiocb_start_write() after error injection
To: Josef Bacik <josef@toxicpanda.com>
Cc: David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 7:05=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Nov 20, 2023 at 6:56=E2=80=AFPM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > On Mon, Nov 20, 2023 at 12:14:24PM +0200, Amir Goldstein wrote:
> > > We want to move kiocb_start_write() into vfs_iocb_iter_write(), but
> > > first we need to move it passed cachefiles_inject_write_error() and
> > > prevent calling kiocb_end_write() if error was injected.
> > >
> > > We set the IOCB_WRITE flag after cachefiles_inject_write_error()
> > > and use it as indication that kiocb_start_write() was called in the
> > > cleanup/completion handler.
> > >
> > > Link: https://lore.kernel.org/r/CAOQ4uxihfJJRxxUhAmOwtD97Lg8PL8RgXw88=
rH1UfEeP8AtP+w@mail.gmail.com/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Sorry Amir I meant to respond on Saturday but I got busy with other thi=
ngs.
> >
> > I was thinking instead, for your series, you could do something like
> >
> > ret =3D cachefiles_inject_write_error();
> > if (ret) {
> >         /* Start kiocb so the error handling is done below. */
> >         kiocb_start_write(&ki->iocb);
> > } else {
> >         ret =3D vfs_iocb_iter_write(file, &ki->iocb, iter);
> > }
> >
> > which seems a bit cleaner than messing with the flags everywhere.
>
> I think that both our options are pretty ugly ;-)
>
> I'll use whatever the maintainers of cachefiles and vfs prefer.

Looking closer, that's a self NACK.

My patch moves kiocb_start_write() to after the permission hook,
so calling vfs_iocb_iter_write() is no guarantee that kiocb_start_write()
was called...

I will send a new patch that does not change cachefiles.

Thanks,
Amir.

