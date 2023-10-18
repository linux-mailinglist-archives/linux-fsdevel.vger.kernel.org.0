Return-Path: <linux-fsdevel+bounces-661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889377CE0CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870EA1C20D68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A8F38BAF;
	Wed, 18 Oct 2023 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW8nRn+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954037CA4
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:11:16 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB900BA;
	Wed, 18 Oct 2023 08:11:14 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d332f23e4so32332606d6.0;
        Wed, 18 Oct 2023 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697641874; x=1698246674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FpvFnukoeHY6S5Dy9p7ld3NtJ9RPldAXr0YchJyUBY=;
        b=nW8nRn+Utpa1IBTAL2f1QeKoPeRjjBm4N9qhUQHEDIgLFr6D5qwgxL1nuoAoNLS5s0
         23kTnq/ljn0izfQ9VWadURuulqI4bRSoBIyAA7Rs2gokPvcDz4WJxkn/DVnvJwF70hiV
         E3V/CJxqGVRUlJmKvIonebOVsbgvUiw+HsAgJya+5OtWUAQAOHCI4oNR3ItsBecuIInG
         ixbu6h9c2qweu0vM72TJgpyoA5/gCngSBCBfLZyL0FYD4Z9+QDFXZquV9dVHO72Qy3hp
         ah+Xatwh5hgPQUV5Udra9zPVMV/F6YkHwV84JalcqolDl9RVUnRv1FGLBDC1FlUpczeo
         5WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697641874; x=1698246674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FpvFnukoeHY6S5Dy9p7ld3NtJ9RPldAXr0YchJyUBY=;
        b=Rc5SiAzHpu/tbvqqSMMdOVE9jpAtDmVxjMWbsh32pK8hZIE7zVE+zzLjUXe/Ug+YwZ
         rFsSAOEc5wynaIOP9B2nph+l9WgC9nDRvgVFSIi8WfpHKfruYY21WhE9yckQQu35qPSK
         fIUACfrscMU8RzlXxzcn6eoBpapYPo4uUrhZmYKyZEpMFWWn6YBwE+vjcOmc1uQYZNCa
         n6YX/lJJs+mbW+G3RI8FWwAV7ia5gpYV0K/De63mn+7WHkYgC84Bh+8jdKw8NPvP/HsZ
         UFQhLIHfTLf6MBRZMcompHMZV52m3NAeygvjt9toXZK5AQI5nVAHagANaj7esU16aUP9
         orvQ==
X-Gm-Message-State: AOJu0Yz6S7Ae7tsxZv2zDlfL64Shu0L2T4zUuYYOniTeATyvDpZ5WLEt
	/72SXIHlPJNKFMuzZt6M4szhU6UZ8AGofD5MhenWfzeWOHI=
X-Google-Smtp-Source: AGHT+IFrGJ/TfN5PQ6lELsQlBM8ybbEpwJ747yNpZotHnbE1XIdgrKLRBAa5UaRrRMB1npZ5yaSVnAW1c4YrLq3+AZc=
X-Received: by 2002:a05:6214:628:b0:66d:15de:329c with SMTP id
 a8-20020a056214062800b0066d15de329cmr6713329qvx.43.1697641873488; Wed, 18 Oct
 2023 08:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018100000.2453965-1-amir73il@gmail.com> <20231018100000.2453965-6-amir73il@gmail.com>
 <f4f27df2a26605a01b2e7f62a8ec6d946695e1d6.camel@kernel.org>
In-Reply-To: <f4f27df2a26605a01b2e7f62a8ec6d946695e1d6.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Oct 2023 18:11:02 +0300
Message-ID: <CAOQ4uxjbg_46xKp6NzDfm=5=ght+a3hcH1Bqsf6kq+54nxSm7w@mail.gmail.com>
Subject: Re: [PATCH 5/5] exportfs: support encoding non-decodeable file
 handles by default
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 5:28=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2023-10-18 at 13:00 +0300, Amir Goldstein wrote:
> > AT_HANDLE_FID was added as an API for name_to_handle_at() that request
> > the encoding of a file id, which is not intended to be decoded.
> >
> > This file id is used by fanotify to describe objects in events.
> >
> > So far, overlayfs is the only filesystem that supports encoding
> > non-decodeable file ids, by providing export_operations with an
> > ->encode_fh() method and without a ->decode_fh() method.
> >
> > Add support for encoding non-decodeable file ids to all the filesystems
> > that do not provide export_operations, by encoding a file id of type
> > FILEID_INO64_GEN from { i_ino, i_generation }.
> >
> > A filesystem may that does not support NFS export, can opt-out of
> > encoding non-decodeable file ids for fanotify by defining an empty
> > export_operations struct (i.e. with a NULL ->encode_fh() method).
> >
> > This allows the use of fanotify events with file ids on filesystems
> > like 9p which do not support NFS export to bring fanotify in feature
> > parity with inotify on those filesystems.
> >
> > Note that fanotify also requires that the filesystems report a non-null
> > fsid.  Currently, many simple filesystems that have support for inotify
> > (e.g. debugfs, tracefs, sysfs) report a null fsid, so can still not be
> > used with fanotify in file id reporting mode.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/exportfs/expfs.c      | 30 +++++++++++++++++++++++++++---
> >  include/linux/exportfs.h | 10 +++++++---
> >  2 files changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> > index 30da4539e257..34e7d835d4ef 100644
> > --- a/fs/exportfs/expfs.c
> > +++ b/fs/exportfs/expfs.c
> > @@ -383,6 +383,30 @@ int generic_encode_ino32_fh(struct inode *inode, _=
_u32 *fh, int *max_len,
> >  }
> >  EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
> >
> > +/**
> > + * exportfs_encode_ino64_fid - encode non-decodeable 64bit ino file id
> > + * @inode:   the object to encode
> > + * @fid:     where to store the file handle fragment
> > + * @max_len: maximum length to store there
> > + *
> > + * This generic function is used to encode a non-decodeable file id fo=
r
> > + * fanotify for filesystems that do not support NFS export.
> > + */
> > +static int exportfs_encode_ino64_fid(struct inode *inode, struct fid *=
fid,
> > +                                  int *max_len)
> > +{
> > +     if (*max_len < 3) {
> > +             *max_len =3D 3;
> > +             return FILEID_INVALID;
> > +     }
> > +
> > +     fid->i64.ino =3D inode->i_ino;
> > +     fid->i64.gen =3D inode->i_generation;
>
> Note that i_ino is unsigned long and so is a 32-bit value on 32-bit
> arches. If the backend storage uses 64-bit inodes, then we usually end
> up hashing them down to 32-bits first. e.g. see nfs_fattr_to_ino_t().
> ceph has some similar code.
>
> The upshot is that if you're relying on i_ino, the value can change
> between different arches, even when they are dealing with the same
> backend filesystem.
>
> Since this is expected to be used by filesystems that don't set up
> export operations, then that may just be something they have to deal
> with. I'm not sure what else you can use in lieu of i_ino in this case.
>

True. That is one more justification for patch [1/5].

If we only support watching inodes when the reported fid is
{i_ino, i_generation}, then the likelihood of collision drops
considerably compared to watching sb/mount.

Because watcher cannot decode fid, watcher must use
name_to_handle_at() when setting up the inode watch and
store it in some index, so it knows how to map from event->fid
to inode later.

This means that even if there is a fid collision between two inodes,
then the watcher can detect the collision when setting up the
inode watch.

Thanks,
Amir.

