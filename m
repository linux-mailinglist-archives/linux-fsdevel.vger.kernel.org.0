Return-Path: <linux-fsdevel+bounces-928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493B7D388B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 15:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E416B20AF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8C51A72D;
	Mon, 23 Oct 2023 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiNWZqb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC911CAC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 13:55:54 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB59101;
	Mon, 23 Oct 2023 06:55:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cd444d9d0so19161601cf.2;
        Mon, 23 Oct 2023 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698069351; x=1698674151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPMGAbfbGK+qnLdNLN/64hlEEDrMuPiSA0pG5FYaVUE=;
        b=fiNWZqb3fACXY82aLv4gCbe2BznksQYTpAiG1HNd3f6awoNGzmIyVb5FAYJN80Xusx
         ZfBsHatYCsIOWEVDUKroW5nKgManZVXbA8Mya7kZQa/OJbU8kNtzGSTIJpHFxCgfof7e
         J+YKaa6yEfBtCC5dA5AO0pnUy58UUVzpsitrnVg954Vg/gBEaZXuq0YoUZYZBs5xMFgM
         iiUbIuv32lGR7Ydu0PECDSTrQk1cJmTnoPLXfH9hd9jWVOLXsMylRFB13tw35QuDdu2K
         qfvgTM2835clJ9OQeBrf31dxElTF52x1m5FAEWgI9fisV6Qn5uqh8XgsXCVzQRlaVCAP
         90bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698069351; x=1698674151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPMGAbfbGK+qnLdNLN/64hlEEDrMuPiSA0pG5FYaVUE=;
        b=imTm/5ptaZOu/Gv/hohxEUy3bOWuf0Q+QmXGSVudjrvBW52CNGvNYH8NivpSy0xrzn
         TnDdwa3LXXVVrYvPsladGzMBOoLUnsXthvdxwNdEkR72ZqzV5lVvI25j6h5hr1YLUmCd
         KUNt9jHJvAMc6ZBZQpo1phMZ/h4M4z/3zFvaYvR6xFae7idbuFeUlofFjWv4P+JE5Jkw
         zDoCZdlZDzP8MHCGW3Z67eVD4maxP1ceo5wLsqJU9eN7SUGU65onXmUnqSgdd/nFbmr2
         MxQ5PRvdNVNdbzxbtLH2T7tFCNpl0qoG6N9+2qLhPFjFJ0GnteVPVLksQ9tSUo82LL9F
         wcQQ==
X-Gm-Message-State: AOJu0Yw+1RQnMPJgWnbFKgyY8ZBoP+aaCA7FAQKfctmymaZupFxsrw0F
	OnxbkBga897XkdxGgCuCLOYOfqKpp4bmYLRtAzU=
X-Google-Smtp-Source: AGHT+IFbl2Pn1JNaoh2hAr9EDzPf6M9UPdOvN2Abps+ScggKZIhxy3ScvMSwdLXnoLZ2NnMuUP/y6X/DZROGYU/83/A=
X-Received: by 2002:a05:6214:19ed:b0:66d:1e8f:bb98 with SMTP id
 q13-20020a05621419ed00b0066d1e8fbb98mr9957696qvc.59.1698069351488; Mon, 23
 Oct 2023 06:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018100000.2453965-1-amir73il@gmail.com> <20231018100000.2453965-6-amir73il@gmail.com>
In-Reply-To: <20231018100000.2453965-6-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Oct 2023 16:55:40 +0300
Message-ID: <CAOQ4uxhiRU2nNnYtuXUaURMCuYjssC9Rn=ORWW=MmVyMD1H6Rg@mail.gmail.com>
Subject: Re: [PATCH 5/5] exportfs: support encoding non-decodeable file
 handles by default
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 1:00=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> AT_HANDLE_FID was added as an API for name_to_handle_at() that request
> the encoding of a file id, which is not intended to be decoded.
>
> This file id is used by fanotify to describe objects in events.
>
> So far, overlayfs is the only filesystem that supports encoding
> non-decodeable file ids, by providing export_operations with an
> ->encode_fh() method and without a ->decode_fh() method.
>
> Add support for encoding non-decodeable file ids to all the filesystems
> that do not provide export_operations, by encoding a file id of type
> FILEID_INO64_GEN from { i_ino, i_generation }.
>
> A filesystem may that does not support NFS export, can opt-out of
> encoding non-decodeable file ids for fanotify by defining an empty
> export_operations struct (i.e. with a NULL ->encode_fh() method).
>
> This allows the use of fanotify events with file ids on filesystems
> like 9p which do not support NFS export to bring fanotify in feature
> parity with inotify on those filesystems.
>
> Note that fanotify also requires that the filesystems report a non-null
> fsid.  Currently, many simple filesystems that have support for inotify
> (e.g. debugfs, tracefs, sysfs) report a null fsid, so can still not be
> used with fanotify in file id reporting mode.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Hi Jan,

Did you get a chance to look at this patch?
I saw your review comments on the rest of the series, so was waiting
for feedback on this last one before posting v2.

BTW, I am going to post a complementary patch to add fsid support for
the simple filesystems.

Thanks,
Amir.

>  fs/exportfs/expfs.c      | 30 +++++++++++++++++++++++++++---
>  include/linux/exportfs.h | 10 +++++++---
>  2 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 30da4539e257..34e7d835d4ef 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -383,6 +383,30 @@ int generic_encode_ino32_fh(struct inode *inode, __u=
32 *fh, int *max_len,
>  }
>  EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
>
> +/**
> + * exportfs_encode_ino64_fid - encode non-decodeable 64bit ino file id
> + * @inode:   the object to encode
> + * @fid:     where to store the file handle fragment
> + * @max_len: maximum length to store there
> + *
> + * This generic function is used to encode a non-decodeable file id for
> + * fanotify for filesystems that do not support NFS export.
> + */
> +static int exportfs_encode_ino64_fid(struct inode *inode, struct fid *fi=
d,
> +                                    int *max_len)
> +{
> +       if (*max_len < 3) {
> +               *max_len =3D 3;
> +               return FILEID_INVALID;
> +       }
> +
> +       fid->i64.ino =3D inode->i_ino;
> +       fid->i64.gen =3D inode->i_generation;
> +       *max_len =3D 3;
> +
> +       return FILEID_INO64_GEN;
> +}
> +
>  /**
>   * exportfs_encode_inode_fh - encode a file handle from inode
>   * @inode:   the object to encode
> @@ -401,10 +425,10 @@ int exportfs_encode_inode_fh(struct inode *inode, s=
truct fid *fid,
>         if (!exportfs_can_encode_fh(nop, flags))
>                 return -EOPNOTSUPP;
>
> -       if (nop && nop->encode_fh)
> -               return nop->encode_fh(inode, fid->raw, max_len, parent);
> +       if (!nop && (flags & EXPORT_FH_FID))
> +               return exportfs_encode_ino64_fid(inode, fid, max_len);
>
> -       return -EOPNOTSUPP;
> +       return nop->encode_fh(inode, fid->raw, max_len, parent);
>  }
>  EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
>
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 21eeb9f6bdbd..6688e457da64 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -134,7 +134,11 @@ struct fid {
>                         u32 parent_ino;
>                         u32 parent_gen;
>                 } i32;
> -               struct {
> +               struct {
> +                       u64 ino;
> +                       u32 gen;
> +               } __packed i64;
> +               struct {
>                         u32 block;
>                         u16 partref;
>                         u16 parent_partref;
> @@ -246,7 +250,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, =
struct fid *fid,
>
>  static inline bool exportfs_can_encode_fid(const struct export_operation=
s *nop)
>  {
> -       return nop && nop->encode_fh;
> +       return !nop || nop->encode_fh;
>  }
>
>  static inline bool exportfs_can_decode_fh(const struct export_operations=
 *nop)
> @@ -259,7 +263,7 @@ static inline bool exportfs_can_encode_fh(const struc=
t export_operations *nop,
>  {
>         /*
>          * If a non-decodeable file handle was requested, we only need to=
 make
> -        * sure that filesystem can encode file handles.
> +        * sure that filesystem did not opt-out of encoding fid.
>          */
>         if (fh_flags & EXPORT_FH_FID)
>                 return exportfs_can_encode_fid(nop);
> --
> 2.34.1
>

