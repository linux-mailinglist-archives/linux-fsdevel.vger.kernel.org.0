Return-Path: <linux-fsdevel+bounces-4393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C755D7FF2B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D47EB20FDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF5151006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNST6ohY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AD51722
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 05:47:01 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d3c7ef7b31so15127b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701352020; x=1701956820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWWZHpRpLbi/UkKJ0KuLH66OlUq4z+GDBS+zNfYvrIg=;
        b=DNST6ohYz2qPG8ScqYY9q2CWys6QTwguH5BInhvGR4gUX1y48lpH4KCxNAmISevzb9
         QM5tUFlE5e7LFdglbMRH8DQ4p6iVqM19kZRTxDsyqC8CJcIgtuqyj2CVnakoNybalMvc
         gSyqFnK4Tc85h43qHOoqttqEg0XWJcSNTsNCFOebL92nJNqcRVjIbf/M5GoualIAWURJ
         TbmfNxHCkuEQ2R9GWttSiXr4/tS2DOKkmzAPm/HsWllWrQuzkvFA2K6NlxWKCz7myv5X
         mgIoephQfPklcuJ4g9WXRqw79USo+k/4Ia15dw4Ph5vnRImRqquK5qQjG+d+GYnsIh2u
         uCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352020; x=1701956820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWWZHpRpLbi/UkKJ0KuLH66OlUq4z+GDBS+zNfYvrIg=;
        b=ZB4Svq2dl1b6zO+Aqlepgx+PWsfS2iWEZ8oLZX6mU+5cTmbQziHyAfznG6xviphG3s
         hDYnACYSaQARvssW6hnUpUHmlK+iMAsD/ApJQ0RdG5K3O2VQmkzNiPeV2AUwD/VdHBBl
         juod9+HmiZuJTSbIpGM/cvoDMuMKEpchf9bVgtEOcLpj1cDFvu0RaQcF2EsFEcv+3uxJ
         Sx3lNV3fFIVszTA1tcWvD168Gf2r9MKrgT8PoSQpFKjAvuEbXDhySji/S2L7Sl4fm0D/
         MpV3o1PzaKxLt9R5t3IgMGiPZScJxVOTBjQM/VyOfyqIsDt240lOhkKFWwZ1gR8YGXnU
         4Rwg==
X-Gm-Message-State: AOJu0YxkCslf9Bxq7xNCuK2tZN88ZADUUgBIeFEDjnX1bhaavT2MmOb0
	DguEpgMgRWYLOP5wW+c59upH94hvujieXOs9Dx8=
X-Google-Smtp-Source: AGHT+IH0aEdTVLUMCcT122thJ8ukibkhK8M/OYn/ElbSSC9681OdYfy1Uaw/lmn6K/jsxZVz+w3O/loUb3L1YzXFQOQ=
X-Received: by 2002:a0d:cf83:0:b0:5cd:de71:f765 with SMTP id
 r125-20020a0dcf83000000b005cdde71f765mr20500005ywd.13.1701352020132; Thu, 30
 Nov 2023 05:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129200709.3154370-1-amir73il@gmail.com> <CAOQ4uxhCC+ZpULkBf_WfsyRBToNxksesBAk5nCsGYWkuNFu6JA@mail.gmail.com>
 <CAOQ4uxhcYXzaeV=gymHN3-N-Mn30+_==5KRFzyp7Xs_nuBoMZw@mail.gmail.com> <20231130133703.f4xt6n53raenxgoj@quack3>
In-Reply-To: <20231130133703.f4xt6n53raenxgoj@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 15:46:49 +0200
Message-ID: <CAOQ4uxgRsQdEmEfL-QTyEFEvCjOktijPyTM1NjB0OmVM480abg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Avert possible deadlock with splice() and fanotify
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 3:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 30-11-23 12:07:23, Amir Goldstein wrote:
> > On Thu, Nov 30, 2023 at 10:32=E2=80=AFAM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > >
> > > On Wed, Nov 29, 2023 at 10:07=E2=80=AFPM Amir Goldstein <amir73il@gma=
il.com> wrote:
> > > >
> > > > Christian,
> > > >
> > > > Josef has helped me see the light and figure out how to avoid the
> > > > possible deadlock, which involves:
> > > > - splice() from source file in a loop mounted fs to dest file in
> > > >   a host fs, where the loop image file is
> > > > - fsfreeze on host fs
> > > > - write to host fs in context of fanotify permission event handler
> > > >   (FAN_ACCESS_PERM) on the splice source file
> > > >
> > > > The first patch should not be changing any logic.
> > > > I only build tested the ceph patch, so hoping to get an
> > > > Acked-by/Tested-by from Jeff.
> > > >
> > > > The second patch rids us of the deadlock by not holding
> > > > file_start_write() while reading from splice source file.
> > > >
> > >
> > > OOPS, I missed another corner case:
> > > The COPY_FILE_SPLICE fallback of server-side-copy in nfsd/ksmbd
> > > needs to use the start-write-safe variant of do_splice_direct(),
> > > because in this case src and dst can be on any two fs.
> > > Expect an extra patch in v2.
> > >
> >
> > For the interested, see server-side-copy patch below.
> > Pushed to branch start-write-safe [1], but will wait with v2 until
> > I get comments on v1.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://github.com/amir73il/linux/commits/start-write-safe
> >
> > Author: Amir Goldstein <amir73il@gmail.com>
> > Date:   Thu Nov 30 11:42:50 2023 +0200
> >
> >     fs: use do_splice_direct() for nfsd/ksmbd server-side-copy
> >
> >     nfsd/ksmbd call vfs_copy_file_range() with flag COPY_FILE_SPLICE to
> >     perform kernel copy between two files on any two filesystems.
> >
> >     Splicing input file, while holding file_start_write() on the output=
 file
> >     which is on a different sb, posses a risk for fanotify related dead=
locks.
> >
> >     We only need to call splice_file_range() from within the context of
> >     ->copy_file_range() filesystem methods with file_start_write() held=
.
> >
> >     To avoid the possible deadlocks, always use do_splice_direct() inst=
ead of
> >     splice_file_range() for the kernel copy fallback in vfs_copy_file_r=
ange()
> >     without holding file_start_write().
> >
> >     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index 0bc99f38e623..12583e32aa6d 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1565,11 +1565,18 @@ ssize_t vfs_copy_file_range(struct file
> > *file_in, loff_t pos_in,
> >          * and which filesystems do not, that will allow userspace tool=
s to
> >          * make consistent desicions w.r.t using copy_file_range().
> >          *
> > -        * We also get here if caller (e.g. nfsd) requested COPY_FILE_S=
PLICE.
> > +        * We also get here if caller (e.g. nfsd) requested COPY_FILE_S=
PLICE
> > +        * for server-side-copy between any two sb.
> > +        *
> > +        * In any case, we call do_splice_direct() and not splice_file_=
range(),
> > +        * without file_start_write() held, to avoid possible deadlocks=
 related
> > +        * to splicing from input file, while file_start_write() is hel=
d on
> > +        * the output file on a different sb.
> >          */
> > -       ret =3D generic_copy_file_range(file_in, pos_in, file_out, pos_=
out, len,
> > -                                     flags);
> > +       file_end_write(file_out);
> >
> > +       ret =3D do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> > +                              min_t(size_t, len, MAX_RW_COUNT), 0);
> >  done:
> >         if (ret > 0) {
> >                 fsnotify_access(file_in);
> > @@ -1581,8 +1588,6 @@ ssize_t vfs_copy_file_range(struct file
> > *file_in, loff_t pos_in,
> >         inc_syscr(current);
> >         inc_syscw(current);
> >
> > -       file_end_write(file_out);
> > -
>
> This file_end_write() is also used by the paths using ->copy_file_range()
> and ->remap_file_range() so you need to balance those...

You're right! already found that bug and fixed in my branch:

diff --git a/fs/read_write.c b/fs/read_write.c
index 0bc99f38e623..e0c2c1b5962b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1421,6 +1421,10 @@ ssize_t generic_copy_file_range(struct file
*file_in, loff_t pos_in,
                                struct file *file_out, loff_t pos_out,
                                size_t len, unsigned int flags)
 {
+       /* May only be called from within ->copy_file_range() methods */
+       if (WARN_ON_ONCE(flags))
+               return -EINVAL;
+
        return splice_file_range(file_in, &pos_in, file_out, &pos_out,
                                 min_t(size_t, len, MAX_RW_COUNT));
 }
@@ -1541,19 +1545,22 @@ ssize_t vfs_copy_file_range(struct file
*file_in, loff_t pos_in,
                ret =3D file_out->f_op->copy_file_range(file_in, pos_in,
                                                      file_out, pos_out,
                                                      len, flags);
-               goto done;
-       }
-
-       if (!splice && file_in->f_op->remap_file_range &&
-           file_inode(file_in)->i_sb =3D=3D file_inode(file_out)->i_sb) {
+       } else if (!splice && file_in->f_op->remap_file_range &&
+                  file_inode(file_in)->i_sb =3D=3D file_inode(file_out)->i=
_sb) {
                ret =3D file_in->f_op->remap_file_range(file_in, pos_in,
                                file_out, pos_out,
                                min_t(loff_t, MAX_RW_COUNT, len),
                                REMAP_FILE_CAN_SHORTEN);
-               if (ret > 0)
-                       goto done;
+               /* fallback to splice */
+               if (ret <=3D 0)
+                       splice =3D true;
        }

+       file_end_write(file_out);
+
+       if (!splice)
+               goto done;
+
        /*
         * We can get here for same sb copy of filesystems that do not impl=
ement
         * ->copy_file_range() in case filesystem does not support clone or=
 in
@@ -1565,11 +1572,16 @@ ssize_t vfs_copy_file_range(struct file
*file_in, loff_t pos_in,
         * and which filesystems do not, that will allow userspace tools to
         * make consistent desicions w.r.t using copy_file_range().
         *
-        * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLIC=
E.
+        * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLIC=
E
+        * for server-side-copy between any two sb.
+        *
+        * In any case, we call do_splice_direct() and not splice_file_rang=
e(),
+        * without file_start_write() held, to avoid possible deadlocks rel=
ated
+        * to splicing from input file, while file_start_write() is held on
+        * the output file on a different sb.
         */
-       ret =3D generic_copy_file_range(file_in, pos_in, file_out, pos_out,=
 len,
-                                     flags);
-
+       ret =3D do_splice_direct(file_in, &pos_in, file_out, &pos_out,
+                              min_t(size_t, len, MAX_RW_COUNT), 0);
 done:
        if (ret > 0) {
                fsnotify_access(file_in);
@@ -1581,8 +1593,6 @@ ssize_t vfs_copy_file_range(struct file
*file_in, loff_t pos_in,
        inc_syscr(current);
        inc_syscw(current);

-       file_end_write(file_out);
-
        return ret;
 }
 EXPORT_SYMBOL(vfs_copy_file_range);

