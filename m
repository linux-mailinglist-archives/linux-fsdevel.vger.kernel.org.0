Return-Path: <linux-fsdevel+bounces-4160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D77E7FD106
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 09:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE72B21583
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9762125B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXwRA5iX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C9DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 23:25:39 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5cc77e23218so65701967b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 23:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701242738; x=1701847538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lSONWoysCxInbHL0ew+a2E5t5IMEcRP4niZQg4OcsY=;
        b=mXwRA5iXZRKxMvIAb/q3XfJ1LRFFT3gtYE4mdcRjvX05NcmCwy6tKEAl1eJaj+zqTG
         aB2+mxLjv0LlaDgM5G4xariHCVSvIbfnvrAK77E+BWnX+s+ZOt1XajUbJdKgxusB9QRR
         +vgqSK8BlZDI2x7xWr4FJ9HAIxIW9XBw4TyefGnM30/4MR7dj9YQqGDiGPo2qloifCF2
         wp8m/wQl3uEa7w9XonMpL8IzRg9rqpZRrZlOG12iS/Wui8EcyFEDjeVQqFLGVEyMDBn0
         oJPUxeB1iXKX9/uN9qDLBf8LLDlrMgFKaZvJH1trE8aREZjkcvhqt2gs22O2NXsDkvDU
         cUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701242738; x=1701847538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lSONWoysCxInbHL0ew+a2E5t5IMEcRP4niZQg4OcsY=;
        b=tUnKcTPfrAlLO6DXFU2A7ChYpFL8AYJdpZQFn8BvX6eQt6eQMZOFLiBMZkqmCdLXUx
         ysyNvKNdS/u3b3uhvTK8IN+RCIG86GdvIqpY2+bltkwyFrI3jO1sfWjzbro4Brk1yiX0
         zSic3MzTFbuh6hJQZBOn8J97bS9uxIVyQIYyDTTXt2H726O/etXrxxU/ItilRah1Hnlp
         iwzPr/VQHL03M7ZS9I+jHYD1gucnPHumX1IxUPHcmSKWt4Xc7euEg8sLmmdYUaKSxIkk
         OBOypZlIjZgB/qU5l8X5ZiVU3avM8d07sGDTTok+9mRRS+dE8ydaL7NPv7wU94JyZSq9
         3D/w==
X-Gm-Message-State: AOJu0YyCggnpWm9EEE2aaXcx0jsJb9PMkdMYQEdnx5aPKoCoBs2f1WZ7
	QEkZ8qnTp17Sp+cRkpgE5kLc86hcBpu5t4vZUD0=
X-Google-Smtp-Source: AGHT+IHe+FZsGWp68xM07sq2N1L7y+At7YlEMBUKE9znm3eW4P5RUCtiZYKUt2VMOIenbYhs9zoToT3uVAU7D3bpQmg=
X-Received: by 2002:a0d:dd04:0:b0:5ae:dff7:6159 with SMTP id
 g4-20020a0ddd04000000b005aedff76159mr19336830ywe.18.1701242738488; Tue, 28
 Nov 2023 23:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
 <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
 <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
 <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
 <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
 <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com> <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
In-Reply-To: <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Nov 2023 09:25:26 +0200
Message-ID: <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 4:42=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 1 Nov 2023 at 14:23, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > However, I can imagine users wanting to do passthrough for read-only
> > fd without doing passthrough for read-write fd, for example, if data is
> > never manipulated by the server, but it is inspected on write.
>
> Okay, that could make sense in a read-mostly use case.  But I think
> that special case could be enabled with FOPEN_DIRECT_IO since we have
> that anyway.  I.e. FOPEN_DIRECT_IO would override the per-inode state,
> which is what it does now.
>
> What doesn't make sense is to mix cached I/O with non-cached (direct
> or passthrough) I/O.
>

I now realized that FOPEN_DIRECT_IO still allows page cache read
and write-through via mmap.

That hinders the idea that disallowing a mix of cached+passthrough
opens on an inode is enough.

My proposed solution is to change the semantics with the init flag
FUSE_PASSTHROUGH to disallow mmap on FOPEN_DIRECT_IO
files.

So with a filesystem that supports FUSE_PASSTHROUGH,
FOPEN_DIRECT_IO files can only be used for direct read/write io and
mmap maps either the fuse inode pages or the backing inode pages.

This also means that FUSE_DIRECT_IO_RELAX conflicts with
FUSE_PASSTHROUGH.

Should we also deny mixing FUSE_HAS_INODE_DAX with
FUSE_PASSTHROUGH? Anything else from virtiofs?

While I have your attention, I am trying to consolidate the validation
of FOPEN_ mode vs inode state into fuse_finish_open().

What do you think about this partial patch that also moves
fuse_finish_open() to after fuse_release_nowrite().
Is it legit?

[patch to fuse_create_open() omitted for brevity]

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -195,8 +195,8 @@ static void fuse_link_write_file(struct file *file)
        spin_unlock(&fi->lock);
 }

-void fuse_finish_open(struct inode *inode, struct file *file)
+int fuse_finish_open(struct inode *inode, struct file *file)
 {
        struct fuse_file *ff =3D file->private_data;
        struct fuse_conn *fc =3D get_fuse_conn(inode);
@@ -215,6 +215,9 @@ void fuse_finish_open(struct inode *inode, struct
file *file,
                spin_unlock(&fi->lock);
                file_update_time(file);
                fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
+               truncate_pagecache(inode, 0);
+       } else if (!(ff->open_flags & FOPEN_KEEP_CACHE)) {
+               invalidate_inode_pages2(inode->i_mapping);
        }
        if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
                fuse_link_write_file(file);
        }
+
+       return 0;
 }
@@ -253,18 +256,16 @@ int fuse_open_common(struct inode *inode, struct
file *file, bool isdir)
                fuse_set_nowrite(inode);

        err =3D fuse_do_open(fm, get_node_id(inode), file, isdir);
-       if (!err)
-               fuse_finish_open(inode, file);

        if (is_wb_truncate || dax_truncate)
                fuse_release_nowrite(inode);
+
        if (!err) {
                struct fuse_file *ff =3D file->private_data;

-               if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC))
-                       truncate_pagecache(inode, 0);
-               else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
-                       invalidate_inode_pages2(inode->i_mapping);
+               err =3D fuse_finish_open(inode, file);
+               if (err)
+                       fuse_sync_release(get_fuse_inode(inode), ff, flags)=
;
        }
        if (dax_truncate)
                filemap_invalidate_unlock(inode->i_mapping);

