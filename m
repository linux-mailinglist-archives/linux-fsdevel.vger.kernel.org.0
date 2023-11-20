Return-Path: <linux-fsdevel+bounces-3224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1997F1945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4F01F21D1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4321CABF;
	Mon, 20 Nov 2023 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1hn0H3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37335C3
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 09:05:46 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-677fba00a49so17518926d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 09:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700499945; x=1701104745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMRj3utl2peFSXEV216yDjK1XsnkPxHQDhPFa1jdawQ=;
        b=g1hn0H3g7xWZXad1RrpvlIPzYMtACJ79xkhNaQg049FdWYqbFHSxVFm9HSfPPvwjEe
         pIblRR4aYy4oRxuBtfPCeqnK8BTqFQD4oOIckR6MCPvy4D8hiCeD+96x4Eh/ZYsJZN9U
         LRnZ7XxyiPZ9wPHMB911zpz2yqYaFjCpnvVBtTte0IEkWae/uhApVwf6aueEBFiKhj8S
         PQed9buIQuuHLp8e8m3lS9A8K5l3cWeOzqaDrjzsCIGDN7lBJ2QV/9ABos9rQwJb7mWO
         eSLhbthHxu1tY5Lw43EPS21HJUmAnXQ2LdVYjXBAn40VesEN9iIfWzzb+n0nU1vthQwS
         svzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700499945; x=1701104745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMRj3utl2peFSXEV216yDjK1XsnkPxHQDhPFa1jdawQ=;
        b=B/Ywr2+ZoXS4s6iUsYHI8hjFLWLuCxnB0vNyTHLcOD9yUtJ95JX2tAs6qFSnFC4TDe
         qr3vy0T5vN7TcRwDE3chmD4GHDcHaYnf48ikBzHFv6BvHPyNOkszjjZ5ETC0T1F34/kt
         7jLhA/eldxejvGiKyXkJNh0vVKNcQQUt/IJ3lSgVuH5AVe3g6dDlZUjINjddO7sQ9ibt
         gHYU3GpJ4MyZstetcnp0XDoF6jPAQo2y3DyDRx+Da3QAVz1ERSicy8Sm+0CsFr8itY1u
         zxd2ACmFOyKk4RmaGeD/1dITqjhtBq0K6DNA/vv1y0V0neO8OTG52Hlg/nXO0ZCvOC8q
         xROA==
X-Gm-Message-State: AOJu0YwT+WgzOUsTqqeIb77bszLDvR1IQ5f9NSNRb2qacBe0IvKzppM/
	kBklhs2JaB796rSFiMEChZNaUuWccogaxyjvLeg=
X-Google-Smtp-Source: AGHT+IFXVTeygQBZ5WqFDviTAyScDc6kwCpO2sxV6obVI8I3L4lq0/tas8iFFvdaiQ+b66DptRuS8sEkykkzUC4JJmg=
X-Received: by 2002:a05:6214:49:b0:66d:327:bf8f with SMTP id
 c9-20020a056214004900b0066d0327bf8fmr63053qvr.30.1700499945330; Mon, 20 Nov
 2023 09:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120101424.2201480-1-amir73il@gmail.com> <20231120165646.GA1606827@perftesting>
In-Reply-To: <20231120165646.GA1606827@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Nov 2023 19:05:34 +0200
Message-ID: <CAOQ4uxhNhmGrb7_Lwp9pt-hyaBUQz9++PH0KR1r3=cjKVCJJfQ@mail.gmail.com>
Subject: Re: [PATCH] cachefiles: move kiocb_start_write() after error injection
To: Josef Bacik <josef@toxicpanda.com>
Cc: David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 6:56=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Mon, Nov 20, 2023 at 12:14:24PM +0200, Amir Goldstein wrote:
> > We want to move kiocb_start_write() into vfs_iocb_iter_write(), but
> > first we need to move it passed cachefiles_inject_write_error() and
> > prevent calling kiocb_end_write() if error was injected.
> >
> > We set the IOCB_WRITE flag after cachefiles_inject_write_error()
> > and use it as indication that kiocb_start_write() was called in the
> > cleanup/completion handler.
> >
> > Link: https://lore.kernel.org/r/CAOQ4uxihfJJRxxUhAmOwtD97Lg8PL8RgXw88rH=
1UfEeP8AtP+w@mail.gmail.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Sorry Amir I meant to respond on Saturday but I got busy with other thing=
s.
>
> I was thinking instead, for your series, you could do something like
>
> ret =3D cachefiles_inject_write_error();
> if (ret) {
>         /* Start kiocb so the error handling is done below. */
>         kiocb_start_write(&ki->iocb);
> } else {
>         ret =3D vfs_iocb_iter_write(file, &ki->iocb, iter);
> }
>
> which seems a bit cleaner than messing with the flags everywhere.

I think that both our options are pretty ugly ;-)

I'll use whatever the maintainers of cachefiles and vfs prefer.

Thanks,
Amir.

