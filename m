Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9AE6F0804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 17:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbjD0PN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243211AbjD0PN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:13:58 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C0735A6;
        Thu, 27 Apr 2023 08:13:57 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-42e6ac0cd5aso2337292137.1;
        Thu, 27 Apr 2023 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682608436; x=1685200436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsYFGE3T+wPNxqowDsqxfAeBdox4B+59dgv0ikGZXmc=;
        b=Dc5BzzDlLxqjvkUQsDQMsO7xgHGjLsHNO7apl9jvpiI0msz/glWDFN7EMxyE+tICC5
         SN75oFom8mwMCQQfEopU61rRWyXkVn+2eZFbmscaTZITRH9HbTS/547jbWjaQdd9YVU+
         pMMRn4RCi2pt0iFjWe7EXTupqG3wINzOK/v7mmWjtW3lBVFgTC0/iJgBFOuAW/Ih/Q18
         2oHAg3MDkM/utDHIff81OYKjy1HlZmCHO09ZtKQHQEGCATi2Xe94UB3EowWVTr2rjfow
         y+jansbTqVubQO+qL+YF2ZyAAC/T9/z6roSaHmsQTOuGvApizIBwF+poXfpEvxVvYkfG
         z9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682608436; x=1685200436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsYFGE3T+wPNxqowDsqxfAeBdox4B+59dgv0ikGZXmc=;
        b=RJ+hBgbVD4gVwxnuaOvvnRe8zfF99U9GHcidbaBqIqyZoKMF1ebeIPPzkwYyy2eo1a
         2lYUJ0p1qP/T/uuwMzx3ehcHmD8immGwh5QGgvl8KKduq2PXrXtI3EOMKC/xjp6F69Qr
         SSSow7inz3p41VPqrL/dMEV5pvSYXLcTdem5H7DluLQ0OZjoL+mMx+v5dD+A1euxY2gZ
         pwX/bORrpIM59I5rMZ+PS+nHKmjiUIYWT8b2aQGboxPm4VvmJAPFms5kwashJ9YcOH6u
         in7zntsl5XKC55cowc8oi6gZoQQtqSajtUMY7Fnm/5CvuA6kIKjpSEgynnJBqaae0cCi
         VlTA==
X-Gm-Message-State: AC+VfDySPBCeZUwnPeJrMgFbnG1+ras2F/y2L7FO51+IJPwzdDOptvxu
        tOS6fG8U9fLF5ftlSTWFIfEo5xlqkXU3pHQOj8ygbOJhFIU=
X-Google-Smtp-Source: ACHHUZ78d30eGm1nPMsPRg0F2BbMsyGGJjylZrHaqUnn76BLE7iBCC92aQxahckIl5JuSwQd9kKYgs9dDTs4wXYW2N4=
X-Received: by 2002:a67:f695:0:b0:42e:4324:d084 with SMTP id
 n21-20020a67f695000000b0042e4324d084mr1113196vso.20.1682608436487; Thu, 27
 Apr 2023 08:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230425130105.2606684-1-amir73il@gmail.com> <20230425130105.2606684-3-amir73il@gmail.com>
 <9118c0e6b03357942d38b9f2badb5be2708bdb5b.camel@kernel.org>
In-Reply-To: <9118c0e6b03357942d38b9f2badb5be2708bdb5b.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Apr 2023 18:13:45 +0300
Message-ID: <CAOQ4uxjtq0oZKrn6RZ6wQR88CZrDXsE5zdT4WP4n-k0ZpxvYCg@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/4] exportfs: add explicit flag to request
 non-decodeable file handles
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 6:00=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2023-04-25 at 16:01 +0300, Amir Goldstein wrote:
> > So far, all callers of exportfs_encode_inode_fh(), except for fsnotify'=
s
> > show_mark_fhandle(), check that filesystem can decode file handles, but
> > we would like to add more callers that do not require a file handle tha=
t
> > can be decoded.
> >
> > Introduce a flag to explicitly request a file handle that may not to be
> > decoded later and a wrapper exportfs_encode_fid() that sets this flag
> > and convert show_mark_fhandle() to use the new wrapper.
> >
> > This will be used to allow adding fanotify support to filesystems that
> > do not support NFS export.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  Documentation/filesystems/nfs/exporting.rst |  4 ++--
> >  fs/exportfs/expfs.c                         | 18 ++++++++++++++++--
> >  fs/notify/fanotify/fanotify.c               |  4 ++--
> >  fs/notify/fdinfo.c                          |  2 +-
> >  include/linux/exportfs.h                    | 12 +++++++++++-
> >  5 files changed, 32 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentatio=
n/filesystems/nfs/exporting.rst
> > index 0e98edd353b5..3d97b8d8f735 100644
> > --- a/Documentation/filesystems/nfs/exporting.rst
> > +++ b/Documentation/filesystems/nfs/exporting.rst
> > @@ -122,8 +122,8 @@ are exportable by setting the s_export_op field in =
the struct
> >  super_block.  This field must point to a "struct export_operations"
> >  struct which has the following members:
> >
> > - encode_fh  (optional)
> > -    Takes a dentry and creates a filehandle fragment which can later b=
e used
> > +  encode_fh (optional)
> > +    Takes a dentry and creates a filehandle fragment which may later b=
e used
> >      to find or create a dentry for the same object.  The default
> >      implementation creates a filehandle fragment that encodes a 32bit =
inode
> >      and generation number for the inode encoded, and if necessary the
> > diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> > index bf1b4925fedd..1b35dda5bdda 100644
> > --- a/fs/exportfs/expfs.c
> > +++ b/fs/exportfs/expfs.c
> > @@ -381,11 +381,25 @@ static int export_encode_fh(struct inode *inode, =
struct fid *fid,
> >       return type;
> >  }
> >
> > +/**
> > + * exportfs_encode_inode_fh - encode a file handle from inode
> > + * @inode:   the object to encode
> > + * @fid:     where to store the file handle fragment
> > + * @max_len: maximum length to store there
> > + * @flags:   properties of the requrested file handle
> > + */
> >  int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> > -                          int *max_len, struct inode *parent)
> > +                          int *max_len, struct inode *parent, int flag=
s)
> >  {
> >       const struct export_operations *nop =3D inode->i_sb->s_export_op;
> >
> > +     /*
> > +      * If a decodeable file handle was requested, we need to make sur=
e that
> > +      * filesystem can decode file handles.
> > +      */
> > +     if (nop && !(flags & EXPORT_FH_FID) && !nop->fh_to_dentry)
> > +             return -EOPNOTSUPP;
> > +
>
> If you're moving this check into this function, then it might be good to
> remove the same check from the callers that are doing this check now.
>

There are three types of callers:
1. nfsd and fanotify check nop->fh_to_dentry at export/setup time
    so I cannot remove those checks
2. in do_sys_name_to_handle() I could have removed the duplicate
    check but then -EFAULT/-EINVAL could be returned instead of
    -EOPNOTSUPP and I did not want to make that visible API change
3. show_mark_fhandle() does not check anything (*)

(*) The reason that show_mark_fhandle() exists originally is to aid CRIU
to restore inotify/fanotify watches on container restore.
Since CRIU cannot really do that without decoding file handles
it is somewhat questionable that show_mark_fhandle() does not check for
->fh_to_dentry and it looks like an oversight, but it has been like that fo=
r
too long to change this behavior IMO.

> >       if (nop && nop->encode_fh)
> >               return nop->encode_fh(inode, fid->raw, max_len, parent);
> >
> > @@ -416,7 +430,7 @@ int exportfs_encode_fh(struct dentry *dentry, struc=
t fid *fid, int *max_len,
> >               parent =3D p->d_inode;
> >       }
> >
> > -     error =3D exportfs_encode_inode_fh(inode, fid, max_len, parent);
> > +     error =3D exportfs_encode_inode_fh(inode, fid, max_len, parent, f=
lags);
> >       dput(p);
> >
> >       return error;
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotif=
y.c
> > index 29bdd99b29fa..d1a49f5b6e6d 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -380,7 +380,7 @@ static int fanotify_encode_fh_len(struct inode *ino=
de)
> >       if (!inode)
> >               return 0;
> >
> > -     exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> > +     exportfs_encode_inode_fh(inode, NULL, &dwords, NULL, 0);
> >       fh_len =3D dwords << 2;
> >
> >       /*
> > @@ -443,7 +443,7 @@ static int fanotify_encode_fh(struct fanotify_fh *f=
h, struct inode *inode,
> >       }
> >
> >       dwords =3D fh_len >> 2;
> > -     type =3D exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> > +     type =3D exportfs_encode_inode_fh(inode, buf, &dwords, NULL, 0);
> >       err =3D -EINVAL;
> >       if (!type || type =3D=3D FILEID_INVALID || fh_len !=3D dwords << =
2)
> >               goto out_err;
> > diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> > index 55081ae3a6ec..5c430736ec12 100644
> > --- a/fs/notify/fdinfo.c
> > +++ b/fs/notify/fdinfo.c
> > @@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, str=
uct inode *inode)
> >       f.handle.handle_bytes =3D sizeof(f.pad);
> >       size =3D f.handle.handle_bytes >> 2;
> >
> > -     ret =3D exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_=
handle, &size, NULL);
> > +     ret =3D exportfs_encode_fid(inode, (struct fid *)f.handle.f_handl=
e, &size);
> >       if ((ret =3D=3D FILEID_INVALID) || (ret < 0)) {
> >               WARN_ONCE(1, "Can't encode file handler for inotify: %d\n=
", ret);
> >               return;
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 2b1048238170..635e89e1dae7 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -136,6 +136,7 @@ struct fid {
> >  };
> >
> >  #define EXPORT_FH_CONNECTABLE        0x1
> > +#define EXPORT_FH_FID                0x2
>
> Please add comments about what these flags are intended to indicate.
>

OK.

Thanks,
Amir.
