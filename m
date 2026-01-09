Return-Path: <linux-fsdevel+bounces-73097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71401D0C6FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 23:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C263044B90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B803A345CA0;
	Fri,  9 Jan 2026 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMXpLroF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5628B7DB
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767996947; cv=none; b=phvadXQS1GbFUf+Ey0MFQEU72HPzPl3oLrJmxEsIwrZ5Ejzpm6KJB5Q7x1hESLUAUmE3NHmkPlY6UpOp/2BtdsZPxTZWc+2B2Iq/ftgi0Qi+851VLKLvtzOvOlBlBOF9psfEfvxo2+0zMFxnyjqeRVt3DBvLD9kuAmcCadUyVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767996947; c=relaxed/simple;
	bh=ItWZAUGEh6tnK87R9qTzUtVy5c9G5IfgZOB7PdDx76w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxDyXWXe26Jdh2EdYueAmyx+Rt6fuVMc+bEaECF4gGpl4n86mB0s7wgE1Hss8XxU6p4vCNXn58Ti+kGUjWLYq2Dt1RBNaNclDt4eu965HhGhpmXtlDp9ex3seKikGuo5NOeDyeObXuClTzs+Esicvq/tjl8uObh1CJGVFgLDnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMXpLroF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3f0d1a39cabso3264863fac.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 14:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767996943; x=1768601743; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsInap0TYjUJhuIYgyTfNATp9iw0wN/wAynfp2rVoTg=;
        b=dMXpLroF8PiS/q6OaGYYMm7s19cCP8DG9l4Id36oG9nNOpwnLJQ+9lagttQ1lj4MvL
         VPVgixf9RhQ9onGvpsOvkjJCNlfk1ZLAGJlQwJyOFDi2q0WwSyZnft88s4yDqfO9a8tp
         J1ya9WTkabqYIuYZ9Hz2SYkrVINDaG96oA4NLDxFadB09TJ/WARmYlrZhKFehE7yua67
         8XP1CnsoBk5v+3lT0OJ3CbZdkC3KULHDyTe8DjYFz0p5YP+WcQFtUYlxCe+PC9DM9B3q
         yPXCtKcZwl8EWsk7Z4PHXjFk6MpfURcvGlbj2Ubz3RWH69TptJBVG4uhl7F2P4i8/HtZ
         UGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767996943; x=1768601743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsInap0TYjUJhuIYgyTfNATp9iw0wN/wAynfp2rVoTg=;
        b=XHR7b0VBcWSE2qnX26qfDVA28qVY8UgNWDnmrXdKQr+i3m9jB8j8t9WjdK7HhUKlmp
         ZcgMjHXt7xqeahXVY2MrxyE1k21vwaM6WqIQ5Bvxu4YMh2MVv8emxE0OYpq0QIzw/G/w
         6o43xugoaKnLic7VcArP7HGWYVFOC9I2myF6SL2v+c3Ng44avzh4LlxcH9Qp3rkuowIo
         NHhrRL5gHlgE8qk1V98A2tbhrPcGwz/pedwUIcEbGc+9HUmq1wix/kp2tY+bauUTSHKg
         UU6n2XYy4NgDN64ES5ttRagWnxk+9kqaK0eQRFCP82h/3cqjkiv4Z2kJrU7WHmjZ9MTs
         f7sg==
X-Forwarded-Encrypted: i=1; AJvYcCUoqEP9TBW0VQ+y31A9OxY65eoKc7lhIRY+TaGXv0H87twg3gJZ6jRxnzNbPwHOStkrK3cyrzSNiKsOI8/K@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9stWoImMUi9ZWLuphD09bl0ZI5t5MKuujGO6Pbt4o+0BeygS
	ogENnUwnyLy0xOt2tNjhqPwsTsfYQJ57J6Eg/unT1pa/GldUxcytANtq
X-Gm-Gg: AY/fxX646xNv4FQuUnLTN8iOCQDDTlxxmm2hBJdWI4Hm8xrHS3k9MbdTSnQofiW+BOk
	Dep6kaBvXJHJEQjIlVDyU6nXouGNODe8YkK/HvxZpXAPKRTn3vMFZvGrMCzdr95RuJWUJnA+XEm
	fDXe9OXPZoApI+wWVwvD+r8CkxmCxLeGPJkjpWRwpxTpjH0dH/T0FpSLKg8RLk+VQCKAQcb5MnR
	PspXMhD9WnvMEAhSHxpcpNyBFJZUMYcTNkPKcKHqPUBXYPXtJmaNUci8/VYkpxzD0Fl08LoOQ54
	WyxLKan2WIfgekkOzy9KWRtafkBotYXm0MRnpkG1CEEB91IOrOlVEI5VCTx7T9OrO7BW8KnwXyq
	YWvo1MYSVVrdx2cVmKD91mJ9JChKAKNuY8WKtutLhp3NL2vYoLp9ESPWTnqzra3Do6ewUhbs7Uq
	zmd00kgD1SPMaOasAWsOP9gQZLkUYWLQ==
X-Google-Smtp-Source: AGHT+IGeIXb/5HKhuPRt53VlHxR5e7TkKbTUESMzGZMkoiJYjOXEnJCEIvTH/DLOMpN4vbxz+vu/YA==
X-Received: by 2002:a05:6870:708c:b0:3ec:41eb:6e38 with SMTP id 586e51a60fabf-3ffc0b18aeemr5749038fac.38.1767996943253;
        Fri, 09 Jan 2026 14:15:43 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:184d:823f:1f40:e229])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4e3af4csm7798614fac.7.2026.01.09.14.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 14:15:42 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 9 Jan 2026 16:15:40 -0600
From: John Groves <John@groves.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 11/21] famfs_fuse: Update macro
 s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX
Message-ID: <mqfmngk6qjxhmxrbbpluzfbhhf2pkvzaintdiyy2kjy2ezgtnv@pascmnqloczj>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-12-john@groves.net>
 <CAJnrk1ZxmryZQJhvesJET12xK8Hemir0uk6wojTty0NDvu1Xng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZxmryZQJhvesJET12xK8Hemir0uk6wojTty0NDvu1Xng@mail.gmail.com>

On 26/01/09 10:16AM, Joanne Koong wrote:
> On Wed, Jan 7, 2026 at 7:34 AM John Groves <John@groves.net> wrote:
> >
> > Virtio_fs now needs to determine if an inode is DAX && not famfs.
> 
> nit: it was unclear to me why this patch changed the macro to take in
> a struct fuse_inode until I looked at patch 14. it might be useful
> here to add a line about that

Thanks Joanne; I beefed up the comment, and also added a dummy
fuse_file_famfs() macro so the new FUSE_IS_VIRTIO_DAX() macro shows
what it's gonna do. I should have done a better commit message...
Next rev will have a better one.

> 
> >
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/dir.c    |  2 +-
> >  fs/fuse/file.c   | 13 ++++++++-----
> >  fs/fuse/fuse_i.h |  6 +++++-
> >  fs/fuse/inode.c  |  4 ++--
> >  fs/fuse/iomode.c |  2 +-
> >  5 files changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 4b6b3d2758ff..1400c9d733ba 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -2153,7 +2153,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >                 is_truncate = true;
> >         }
> >
> > -       if (FUSE_IS_DAX(inode) && is_truncate) {
> > +       if (FUSE_IS_VIRTIO_DAX(fi) && is_truncate) {
> >                 filemap_invalidate_lock(mapping);
> >                 fault_blocked = true;
> >                 err = fuse_dax_break_layouts(inode, 0, -1);
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 01bc894e9c2b..093569033ed1 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -252,7 +252,7 @@ static int fuse_open(struct inode *inode, struct file *file)
> >         int err;
> >         bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
> >         bool is_wb_truncate = is_truncate && fc->writeback_cache;
> > -       bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
> > +       bool dax_truncate = is_truncate && FUSE_IS_VIRTIO_DAX(fi);
> >
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> > @@ -1812,11 +1812,12 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >         struct file *file = iocb->ki_filp;
> >         struct fuse_file *ff = file->private_data;
> >         struct inode *inode = file_inode(file);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> >
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> >
> > -       if (FUSE_IS_DAX(inode))
> > +       if (FUSE_IS_VIRTIO_DAX(fi))
> >                 return fuse_dax_read_iter(iocb, to);
> >
> >         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> > @@ -1833,11 +1834,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >         struct file *file = iocb->ki_filp;
> >         struct fuse_file *ff = file->private_data;
> >         struct inode *inode = file_inode(file);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> >
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> >
> > -       if (FUSE_IS_DAX(inode))
> > +       if (FUSE_IS_VIRTIO_DAX(fi))
> >                 return fuse_dax_write_iter(iocb, from);
> >
> >         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> > @@ -2370,10 +2372,11 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
> >         struct fuse_file *ff = file->private_data;
> >         struct fuse_conn *fc = ff->fm->fc;
> >         struct inode *inode = file_inode(file);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> >         int rc;
> >
> >         /* DAX mmap is superior to direct_io mmap */
> > -       if (FUSE_IS_DAX(inode))
> > +       if (FUSE_IS_VIRTIO_DAX(fi))
> >                 return fuse_dax_mmap(file, vma);
> >
> >         /*
> > @@ -2934,7 +2937,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
> >                 .mode = mode
> >         };
> >         int err;
> > -       bool block_faults = FUSE_IS_DAX(inode) &&
> > +       bool block_faults = FUSE_IS_VIRTIO_DAX(fi) &&
> >                 (!(mode & FALLOC_FL_KEEP_SIZE) ||
> >                  (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7f16049387d1..17736c0a6d2f 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1508,7 +1508,11 @@ void fuse_free_conn(struct fuse_conn *fc);
> >
> >  /* dax.c */
> >
> > -#define FUSE_IS_DAX(inode) (IS_ENABLED(CONFIG_FUSE_DAX) && IS_DAX(inode))
> > +/* This macro is used by virtio_fs, but now it also needs to filter for
> > + * "not famfs"
> > + */
> 
> Did you mean to add this comment to "patch 14/21: famfs_fuse: Plumb
> the GET_FMAP message/response" instead? it seems like that's the patch
> that adds the "&& !fuse_file_famfs(fuse_inode))" part to this.

The idea I was going for is for this commit to substitute the new macro name
(FUSE_IS_VIRTIO_DAX()) without otherwise changing functionality - and then
to plumb the famfs test later. 

The revised version of this commit adds a dummy test (fuse_file_famfs(inode)), so
it's more apparent what this commit is trying to do. So I hope it will make
more sense ;)
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> 
> Thanks,
> Joanne

Thanks Joanne!

John

