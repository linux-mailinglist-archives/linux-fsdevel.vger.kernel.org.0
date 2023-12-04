Return-Path: <linux-fsdevel+bounces-4768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9068036E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED72B280E98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A583A28DD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWQLrBOl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67279AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 05:19:38 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67a9be1407aso20553936d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 05:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701695977; x=1702300777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwmI1Uj/XAKSzjXvl9cG5XxaeLYkuEdqLWwsWinn8uY=;
        b=gWQLrBOl0lhTfg5ZnSKocLVzqFIm8z/vS07lN6flBWWVzcgmZMrc9tjekids3hw8j4
         HPuhk3/QQQvX/FUZe7Emdf1bvkyhDKVqkN9vBeifQTxT5YRFElYBNawotbRYJ2K6TaRO
         vRqg6VDxKutH73BlLZxykOuUjy0VjRifoqYsSXISGVsVLcyhJQTawPMxKeSvI8Kiq6tB
         zIG3GYEEx1RPKkZ+1S6p8hUlAZNitSCxSwj4bAuQd5qt1S8Ktfioj0fQdtDd7O0jr8J2
         Rgffl6YOQVKWLOEstcg0jjFrIwLR71TrOYgQb+VFxF7YZ5iSKYLypLwu2n+kPKIntAtW
         h3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695977; x=1702300777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwmI1Uj/XAKSzjXvl9cG5XxaeLYkuEdqLWwsWinn8uY=;
        b=st7L16xZ4HI+sRdM18Yw8HnNO9zYa0QMSxGOuUNh+YSqhqUvW1wYHTrNzV40G7uNnX
         A21XnJlkfj9hNmyFtuqsLI/lRjw0Mh2FbihTvhW7C3YpVlPAGxp9h2rZqEGXWSIbanlD
         mtQ46UGwoh/bEICxxWD7BxpPMcBrDAATuzRWf8Pvxo9DEX2Ea/14177aPUhEI04QHXTx
         JwqFFutUqJ4aRWzVJOV7I0KyZomzSSIwRt6JwU4QJFDE7oRN8ChD0WGkW8tOTCdzj2PE
         YfIcYNEN0P6lPWZDFaRQL3WpwLjYIdMINUqln7XOMTC9hjzjlBe94z5fwBpuDboiPmkP
         sphQ==
X-Gm-Message-State: AOJu0Yw+zvBX6rTOYPM8zn3bmFl2OjNCfbM0OZ6ZzCsEs1ucFO9ER8E0
	osu789pK+vGhcOroe7yqsWPgPjLKaSflZEw6RyE=
X-Google-Smtp-Source: AGHT+IHQWnbi0DsSOUfwDP8SbipT5jux61KsGkP9xoAkervkFtPPert0kQ/+EkMXHE9tWd4dWlFpkN7/vqrop1VyaBM=
X-Received: by 2002:ad4:4d11:0:b0:67a:3dec:14d2 with SMTP id
 l17-20020ad44d11000000b0067a3dec14d2mr4794383qvl.23.1701695977469; Mon, 04
 Dec 2023 05:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130141624.3338942-1-amir73il@gmail.com> <20231130141624.3338942-4-amir73il@gmail.com>
 <20231204083952.GD32438@lst.de>
In-Reply-To: <20231204083952.GD32438@lst.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Dec 2023 15:19:26 +0200
Message-ID: <CAOQ4uxgUiC+TW9aCArHvvC3ODKGBoaTyM22pspdYsEaauP_ofg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs: use do_splice_direct() for nfsd/ksmbd server-side-copy
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 10:39=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Nov 30, 2023 at 04:16:24PM +0200, Amir Goldstein wrote:
> > nfsd/ksmbd call vfs_copy_file_range() with flag COPY_FILE_SPLICE to
> > perform kernel copy between two files on any two filesystems.
> >
> > Splicing input file, while holding file_start_write() on the output fil=
e
> > which is on a different sb, posses a risk for fanotify related deadlock=
s.
> >
> > We only need to call splice_file_range() from within the context of
> > ->copy_file_range() filesystem methods with file_start_write() held.
> >
> > To avoid the possible deadlocks, always use do_splice_direct() instead =
of
> > splice_file_range() for the kernel copy fallback in vfs_copy_file_range=
()
> > without holding file_start_write().
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> (although I wish do_splice_direct had a better name like
> vfs_splice_direct, espcially before growing more users)

I tried very hard in this series to add a little bit of consistency
for function names and indication of what it may be responsible for.

After this cleanup series, many of the file permission hooks and
moved from do_XXX() helpers to vfs_XXX() helpers, so I cannot in
good conscience rename do_splice_direct(), which does not have
file permission hooks to vfs_splice_direct().

I can rename it to splice_direct() as several other splice_XXX()
exported helpers in this file.

ok?

Thanks,
Amir.

