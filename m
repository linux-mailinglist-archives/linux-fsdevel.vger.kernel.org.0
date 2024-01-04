Return-Path: <linux-fsdevel+bounces-7346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF60A823CD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 08:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112761C238CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 07:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F701F927;
	Thu,  4 Jan 2024 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTXn2NJx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E7E1EB3E;
	Thu,  4 Jan 2024 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-680d2ec3459so1649616d6.0;
        Wed, 03 Jan 2024 23:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704353955; x=1704958755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EWAPVYEGfDEzXBhsfGIhO6tsIxVY+kI+CEFXaRouqM=;
        b=MTXn2NJxw396Ai21f4hr9ZwBjcf1XRDubNZxiZJQ9JWck9FaWOKzbOkI9vpKE50UZr
         GiQh0M8Sl4Jpji2hEnmYw6gwA7hDLjP5iSQgu7Ebi9qOC+QfLfnXx3uKu2Ok59QC0TPi
         4edRxCwMTO1PGn1M9qWP1PuOGfJv7J4n6/EqZTPjZHLfoMIjQO5OZtYw2Zo2scyM8nCV
         y51pfTde4m+Xf2MLlWo1xZ6W296x2tEaeO8mJDc0LIoQogcovntF5TUgpMrSBpAvupM6
         9AhGlzTrfCyXcfvqyxDJO9WJtgd+cPmxhrqD4MLf7a6WAPq80aHYoxx3FtpQb/A5tSUq
         0R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704353955; x=1704958755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EWAPVYEGfDEzXBhsfGIhO6tsIxVY+kI+CEFXaRouqM=;
        b=skZVGwGy90urFxzmacRUQAyHyU4DTqRHNTVXiOKcNQk/Ug9ZBe9wQzyEwBIKG/g9b1
         SiSKhUQiPI/Vms5ArOJUDCO6SAtmgAC3B8dnugDw/6me3sLqbeGM4hAOu12wzdYySE6j
         qIefk38Iy4MAjRd1nAgk19bE0puLKx9ySHE6LRo6s4Zc7JichdCzeWnDCn2nwmUo00s6
         RkCWnulPjtot5XmpgNRQASAlyFFFGXdNQ8Yd0FLuMWXTjpAg38o2zPuUk/g9e35e06FJ
         ikNXSlHgFbgIrdYGC5bPgt60W6jWJ6Th6YNTeunA2LtYFlh+x0t+x0CHHONTslWaT8LG
         Ylsg==
X-Gm-Message-State: AOJu0YycGxZ62cgEKr1iFmlwSEthVftBX8FB/5fhK5ov4nfR9RKMOt4Z
	ekZ6MvCGlycXX8eaFUiYYdSJlPm1v/gp8bDgLBM=
X-Google-Smtp-Source: AGHT+IGFZjazJHMfufpHyl8QXOSzlmzdwzixVmsjeIgtg4Ypd2CFE8sQ+ADaiimNisML1L3EwhPh7m9AixRehamtrSw=
X-Received: by 2002:a05:6214:21eb:b0:680:d0b5:4b8f with SMTP id
 p11-20020a05621421eb00b00680d0b54b8fmr191890qvj.6.1704353955531; Wed, 03 Jan
 2024 23:39:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170429478711.50646.12675561629884992953.stgit@bazille.1015granger.net>
 <170429517779.50646.9656897459585544068.stgit@bazille.1015granger.net>
In-Reply-To: <170429517779.50646.9656897459585544068.stgit@bazille.1015granger.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Jan 2024 09:39:04 +0200
Message-ID: <CAOQ4uxgMLWGqqoSNvSgB=Qfmw6Brk2eO6yB7FZqX6p-DcTiUtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] exportfs: fix the fallback implementation of the
 get_name export operation
To: Chuck Lever <cel@kernel.org>
Cc: jlayton@redhat.com, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	trondmy@hammerspace.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 5:19=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> The fallback implementation for the get_name export operation uses
> readdir() to try to match the inode number to a filename. That filename
> is then used together with lookup_one() to produce a dentry.
> A problem arises when we match the '.' or '..' entries, since that
> causes lookup_one() to fail. This has sometimes been seen to occur for
> filesystems that violate POSIX requirements around uniqueness of inode
> numbers, something that is common for snapshot directories.
>
> This patch just ensures that we skip '.' and '..' rather than allowing a
> match.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/linux-nfs/CAOQ4uxiOZobN76OKB-VBNXWeFKVwLW_e=
K5QtthGyYzWU9mjb7Q@mail.gmail.com/
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/exportfs/expfs.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 3ae0154c5680..84af58eaf2ca 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -255,7 +255,9 @@ static bool filldir_one(struct dir_context *ctx, cons=
t char *name, int len,
>                 container_of(ctx, struct getdents_callback, ctx);
>
>         buf->sequence++;
> -       if (buf->ino =3D=3D ino && len <=3D NAME_MAX) {
> +       /* Ignore the '.' and '..' entries */
> +       if ((len > 2 || name[0] !=3D '.' || (len =3D=3D 2 && name[1] !=3D=
 '.')) &&
> +           buf->ino =3D=3D ino && len <=3D NAME_MAX) {


Thank you for creating the helper, but if you already went to this trouble,
I think it is better to introduce is_dot_dotdot() as a local helper already
in this backportable patch, so that stable kernel code is same as upstream
code (good for future fixes) and then dedupe the local helper with the rest
of the local helpers in patch 2?

Thanks,
Amir.

