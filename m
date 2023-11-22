Return-Path: <linux-fsdevel+bounces-3448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70507F4A39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 16:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604042810EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BFD4EB5B;
	Wed, 22 Nov 2023 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2DPGwpQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5079118D
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 07:25:46 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f5d7db4dcbso2430731fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700666745; x=1701271545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZf6HHsUMXMgG9Aa+8RY5MU4+QRb5dG6BKn0vp9FS0Y=;
        b=W2DPGwpQf/uhYQ44YCNBjFZ3ZQkwFYtCVn0eLM1cz9R0k4Dia7ZK3PFQ1c6ycDrn4E
         l0z4lsL90xsbqM8hs8crCMpd1hlmiJlQSmo/qY50FSaKsxXlN5bX9bwIHF+b3hX+lcrd
         x9xOd6a8QaVC+ifZ5K2Uyhca7GEC8PDm2Enmm7jxiDKzfqax7oyWgQWqjqurBgUYptjc
         FLHqrsMCW/5W+ZF/EL7FBgVkDuIypsj0I7Zdyh5mcUKglYxrB7dL3ssPgGBpMN8qeDR2
         5sujBCXEqnjacIHEl49JL6q+vnyOdQD6GMEaeMWAbx75VW1TQW66bspT5n8tyL7G5gpM
         iUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700666745; x=1701271545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZf6HHsUMXMgG9Aa+8RY5MU4+QRb5dG6BKn0vp9FS0Y=;
        b=CW8zatEWINay9GA2AY8fy+h5AF7TvEKSnpkhOvpyeq64CWKxdBeBiHMVh7eNRgnn8i
         iQAnoIvPD+kma1uXqCCk7QMl8deetkW4jhi3omlLydiSqQPsQOde/V2Vvlgd2xub6cij
         lcMHQI6UJM/a1BJpqG5LgjywfFuS9PKdTOAuM3K+I8wUn6kV2sZMjJxo7jIe3izbxNrQ
         2kLjOq2t4WU0pEUa7DdNSc7aPEyu6KlblR3fDpYftpJEBGb5X3fqDE0UPqUlv0Y5/U8/
         CCLL1KVGRbkmie2iGJpL+r0rm/DhyaD2xPgUAeK91RgXNjo1fxl+rF/SmUvWbelEs2LM
         yTow==
X-Gm-Message-State: AOJu0Yy1xw/OJTxxRrGWXKuicI6vIJD+OuDyYfGIdnT5ur8Q07HtHAZW
	k88EljWm32kYzYl9+eHlMD/y6XkuUZ+Rf1n9cU7NiFwVgyY=
X-Google-Smtp-Source: AGHT+IHMUs5bjNkES19lEJt7n0P1b+X9UG13YYT2adNsy0a1sJCgbJ3CjV0pygHqiHN+62EeQkYwVHpDDt2HYYpW3dU=
X-Received: by 2002:a05:6870:aa89:b0:1e9:8ab9:11cd with SMTP id
 gr9-20020a056870aa8900b001e98ab911cdmr3774422oab.45.1700666745286; Wed, 22
 Nov 2023 07:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122715.2561213-1-amir73il@gmail.com> <20231122122715.2561213-12-amir73il@gmail.com>
 <20231122-vorrecht-truhe-701aae42b61f@brauner>
In-Reply-To: <20231122-vorrecht-truhe-701aae42b61f@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Nov 2023 17:25:33 +0200
Message-ID: <CAOQ4uxixFv-yOmYFrs9hNPwSt4i16bdgM_oMxkvrunPwHpKRRA@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fs: move permission hook out of do_iter_write()
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:34=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > -     ret =3D import_iovec(ITER_SOURCE, vec, vlen, ARRAY_SIZE(iovstack)=
, &iov, &iter);
> > -     if (ret >=3D 0) {
> > -             file_start_write(file);
> > -             ret =3D do_iter_write(file, &iter, pos, flags);
> > -             file_end_write(file);
> > -             kfree(iov);
> > -     }
> > +     if (!(file->f_mode & FMODE_WRITE))
> > +             return -EBADF;
> > +     if (!(file->f_mode & FMODE_CAN_WRITE))
> > +             return -EINVAL;
> > +
> > +     ret =3D import_iovec(ITER_SOURCE, vec, vlen, ARRAY_SIZE(iovstack)=
, &iov,
> > +                        &iter);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     tot_len =3D iov_iter_count(&iter);
> > +     if (!tot_len)
> > +             goto out;
>
> Fwiw, the logic is slightly changed here. This now relies on
> import_iovec() >=3D 0 then iov_iter_count() >=3D 0.
>
> If that's ever changed and iov_iter_count() can return an error even
> though import_iovec() succeeded we'll be returning the number of
> imported bytes even though nothing was written and also generate a
> fsnotify event because ret still points to the number of imported bytes.
>
> The way it was written before it didn't matter because this was hidden
> in a function call that returned 0 and initialized ret again.

Good catch!

> Anyway, I
> can just massage that in-tree if that's worth it. Nothing to do for you.

Thank you!
Amir.

