Return-Path: <linux-fsdevel+bounces-4353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC947FED0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E3FB20981
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4893C071
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tpz44FXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A99E10C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 02:09:21 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d36fddbe3cso2554547b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701338960; x=1701943760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aECGERGoIk4vtQyZu2/xOwQNv0oFSa6y+7BF/qe9Kk=;
        b=Tpz44FXHdMOCdoEuMCS3ZT0Z//ste9BsW/RuU10L4QrzmqmcW8z6oT37orx3DKC1ho
         DJ/j/NzEKQetGMbxATPePst563SI4AMMilnoJWmD5ImEjwhqeLuhid8GAVGkZK3WfAoL
         PknANcU7al2HSoqI2eU6EE/SwDfyLUKRtKMk5vO/KIaa2gT3tFxS+ZFX93pFHzhEVU8L
         19x7Z3ad7ZQaRKHZ0He3flo+k/jccg1jsXkaFmOJJvjh5Ivv+bWEEdDcARH/J/9n8Jhc
         FBiGrs5RJBEEt2kcsSHC4Fsfw+tgL9b32DDIDL2m+s4O+jda/h2gjh4nPfu/6qTdDuuS
         f/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338960; x=1701943760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aECGERGoIk4vtQyZu2/xOwQNv0oFSa6y+7BF/qe9Kk=;
        b=Ky672879TpWcPBmRnCVUCtfJK1HPJTRMA6KzKB/obFsaQ6XDi167fkrYLsG3/3Jfn0
         kgkRm1A4Whxc06iwQ2yTqJSibN0qy0zeYLIJ+6PyvhpH0SbAqgGFO8PmXwwOTnOi0tHR
         VdyCHGM++KRj3DzIY8A295Vku3duqxFwtHcKTezSUQsuqgOOqt2n5nt4y5gxKfdtrPyD
         MxCbOBbPQT1ihmTnoobNv4jgZAGdaz7sFTmFOmD+r1r2h7tDJR8j1AuI/Aws7kig5Wmj
         u2x9bqjJ9wwqGaSrE1Yhev8bvTCNyluOYE7VC5XdB1y6psCR+Hjk4t/otq5DDeP++//k
         gY5A==
X-Gm-Message-State: AOJu0YyGXvni+EXQQxU7tk1h9UkmDXjnp4lgiVmuLwAQlpNm602CKblm
	enceOmvix2tjAi55rn6YMVPv/l7VVs5THlX9KLI=
X-Google-Smtp-Source: AGHT+IF7QZnCArhrvjHrZai8ZS34v7d6f8g8bTwzOh32wQ5w85PzIC7w0LXCaetP6upmGtaWkVAEOd1Ecx3VNUk/EdU=
X-Received: by 2002:a0d:cfc3:0:b0:5cd:de71:f76c with SMTP id
 r186-20020a0dcfc3000000b005cdde71f76cmr21108228ywd.13.1701338960111; Thu, 30
 Nov 2023 02:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129200709.3154370-1-amir73il@gmail.com> <20231129200709.3154370-2-amir73il@gmail.com>
In-Reply-To: <20231129200709.3154370-2-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 12:09:09 +0200
Message-ID: <CAOQ4uxixp3YRE0xRDe5EkTmTvnRU_qeJ=R=MqxRWkqHRtLf+4A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: fork do_splice_copy_file_range() from do_splice_direct()
To: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 10:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> The new helper is meant to be called from context of ->copy_file_range()
> methods instead of do_splice_direct().
>
> Currently, the only difference is that do_splice_copy_file_range() does
> not take a splice flags argument and it asserts that file_start_write()
> was called.
>
> Soon, do_splice_direct() will be called without file_start_write() held.
>
> Use the new helper from __ceph_copy_file_range(), that was incorrectly
> passing the copy_file_range() flags argument as splice flags argument
> to do_splice_direct(). the value of flags was 0, so no actual bug fix.
>
> Move the definition of both helpers to linux/splice.h.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/ceph/file.c         |  9 ++---
>  fs/read_write.c        |  6 ++--
>  fs/splice.c            | 82 ++++++++++++++++++++++++++++++------------
>  include/linux/fs.h     |  2 --
>  include/linux/splice.h | 13 ++++---
>  5 files changed, 75 insertions(+), 37 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3b5aae29e944..7c2db78e2c6e 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -12,6 +12,7 @@
>  #include <linux/falloc.h>
>  #include <linux/iversion.h>
>  #include <linux/ktime.h>
> +#include <linux/splice.h>
>
>  #include "super.h"
>  #include "mds_client.h"
> @@ -3010,8 +3011,8 @@ static ssize_t __ceph_copy_file_range(struct file *=
src_file, loff_t src_off,
>                  * {read,write}_iter, which will get caps again.
>                  */
>                 put_rd_wr_caps(src_ci, src_got, dst_ci, dst_got);
> -               ret =3D do_splice_direct(src_file, &src_off, dst_file,
> -                                      &dst_off, src_objlen, flags);
> +               ret =3D do_splice_copy_file_range(src_file, &src_off, dst=
_file,
> +                                               &dst_off, src_objlen);
>                 /* Abort on short copies or on error */
>                 if (ret < (long)src_objlen) {
>                         doutc(cl, "Failed partial copy (%zd)\n", ret);
> @@ -3065,8 +3066,8 @@ static ssize_t __ceph_copy_file_range(struct file *=
src_file, loff_t src_off,
>          */
>         if (len && (len < src_ci->i_layout.object_size)) {
>                 doutc(cl, "Final partial copy of %zu bytes\n", len);
> -               bytes =3D do_splice_direct(src_file, &src_off, dst_file,
> -                                        &dst_off, len, flags);
> +               bytes =3D do_splice_copy_file_range(src_file, &src_off, d=
st_file,
> +                                                 &dst_off, len);
>                 if (bytes > 0)
>                         ret +=3D bytes;
>                 else
> diff --git a/fs/read_write.c b/fs/read_write.c
> index f791555fa246..555514cdad53 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1423,10 +1423,8 @@ ssize_t generic_copy_file_range(struct file *file_=
in, loff_t pos_in,
>                                 struct file *file_out, loff_t pos_out,
>                                 size_t len, unsigned int flags)
>  {
> -       lockdep_assert(file_write_started(file_out));
> -
> -       return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> -                               len > MAX_RW_COUNT ? MAX_RW_COUNT : len, =
0);
> +       return do_splice_copy_file_range(file_in, &pos_in, file_out, &pos=
_out,
> +                               len > MAX_RW_COUNT ? MAX_RW_COUNT : len);
>  }
>  EXPORT_SYMBOL(generic_copy_file_range);
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 3fce5f6072dd..3bb4936f8b70 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1158,8 +1158,15 @@ static int direct_splice_actor(struct pipe_inode_i=
nfo *pipe,
>  {
>         struct file *file =3D sd->u.file;
>
> -       return do_splice_from(pipe, file, sd->opos, sd->total_len,
> -                             sd->flags);
> +       return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->fl=
ags);
> +}
> +
> +static int copy_file_range_splice_actor(struct pipe_inode_info *pipe,
> +                                       struct splice_desc *sd)
> +{
> +       struct file *file =3D sd->u.file;
> +
> +       return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->fl=
ags);
>  }
>
>  static void direct_file_splice_eof(struct splice_desc *sd)
> @@ -1170,25 +1177,10 @@ static void direct_file_splice_eof(struct splice_=
desc *sd)
>                 file->f_op->splice_eof(file);
>  }
>
> -/**
> - * do_splice_direct - splices data directly between two files
> - * @in:                file to splice from
> - * @ppos:      input file offset
> - * @out:       file to splice to
> - * @opos:      output file offset
> - * @len:       number of bytes to splice
> - * @flags:     splice modifier flags
> - *
> - * Description:
> - *    For use by do_sendfile(). splice can easily emulate sendfile, but
> - *    doing it in the application would incur an extra system call
> - *    (splice in + splice out, as compared to just sendfile()). So this =
helper
> - *    can splice directly through a process-private pipe.
> - *
> - * Callers already called rw_verify_area() on the entire range.
> - */
> -long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
> -                     loff_t *opos, size_t len, unsigned int flags)
> +static long do_splice_direct_actor(struct file *in, loff_t *ppos,
> +                                  struct file *out, loff_t *opos,
> +                                  size_t len, unsigned int flags,
> +                                  splice_direct_actor *actor)
>  {
>         struct splice_desc sd =3D {
>                 .len            =3D len,
> @@ -1207,14 +1199,60 @@ long do_splice_direct(struct file *in, loff_t *pp=
os, struct file *out,
>         if (unlikely(out->f_flags & O_APPEND))
>                 return -EINVAL;
>
> -       ret =3D splice_direct_to_actor(in, &sd, direct_splice_actor);
> +       ret =3D splice_direct_to_actor(in, &sd, actor);
>         if (ret > 0)
>                 *ppos =3D sd.pos;
>
>         return ret;
>  }
> +/**
> + * do_splice_direct - splices data directly between two files
> + * @in:                file to splice from
> + * @ppos:      input file offset
> + * @out:       file to splice to
> + * @opos:      output file offset
> + * @len:       number of bytes to splice
> + * @flags:     splice modifier flags
> + *
> + * Description:
> + *    For use by do_sendfile(). splice can easily emulate sendfile, but
> + *    doing it in the application would incur an extra system call
> + *    (splice in + splice out, as compared to just sendfile()). So this =
helper
> + *    can splice directly through a process-private pipe.
> + *
> + * Callers already called rw_verify_area() on the entire range.
> + */
> +long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
> +                     loff_t *opos, size_t len, unsigned int flags)
> +{
> +       return do_splice_direct_actor(in, ppos, out, opos, len, flags,
> +                                     direct_splice_actor);
> +}
>  EXPORT_SYMBOL(do_splice_direct);
>
> +/**
> + * do_splice_copy_file_range - splices data for copy_file_range()
> + * @in:                file to splice from
> + * @ppos:      input file offset
> + * @out:       file to splice to
> + * @opos:      output file offset
> + * @len:       number of bytes to splice
> + *
> + * Description:
> + *    For use by generic_copy_file_range() and ->copy_file_range() metho=
ds.
> + *
> + * Callers already called rw_verify_area() on the entire range.
> + */
> +long do_splice_copy_file_range(struct file *in, loff_t *ppos, struct fil=
e *out,
> +                              loff_t *opos, size_t len)

FYI, I renamed do_splice_vfs_copy_file_range =3D> splice_file_range in v2
for brevity.

Thanks,
Amir.

