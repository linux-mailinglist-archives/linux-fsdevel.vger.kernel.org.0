Return-Path: <linux-fsdevel+bounces-767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621FC7CFDBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 17:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B16C2820BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE5E2FE28;
	Thu, 19 Oct 2023 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0Uk+E7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133092747A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 15:22:56 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F97911F;
	Thu, 19 Oct 2023 08:22:55 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66cfd874520so52084986d6.2;
        Thu, 19 Oct 2023 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697728974; x=1698333774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTokfEhHW21by/jO57PLAHs5gEsNWQ+7mMyGsbJSujo=;
        b=Q0Uk+E7uwUjGflczioeyrUni/DzpQn6ki8ZeJEmhpPRN+FCs7pA+iEW1vXz6cQBtOD
         tlW2s7Y5k2kydfVHlMD7l7gMcPmoqR5LdthziBfljecf+SGw2qDAqwMJvBZtNQNY193T
         LNiz3CfsjrjTYxiusqHPDCNujr4PFbDBu2MOHVugEcEqBzsSeVvMKBMBoINNPjGHXyD6
         ggDwj8WJ20Rp2Wa7vJVSOZ1qvcEQCbq8tgeHY7wNWP7bqmIr27M2HzF66H5EaLM/heKN
         0kTOKdezw2MLtgRjhWlCr+j8+pAFr4sFw+M2+4trnQHupkhpdWU/IT5oRjeVnr7u9J6t
         qp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697728974; x=1698333774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTokfEhHW21by/jO57PLAHs5gEsNWQ+7mMyGsbJSujo=;
        b=uvI8Fz2LnlpYbYt8mDKzrkbMoNOCftGgC9Y3zelIzXFC06Rk7YBr9eXZti7opsmD0D
         AOaLANKHmlc7mQVMR7TXmzR12BDlrb9FwclpGGdviso2u4qxhffHvI6TB6t+iYe0hF5k
         GQipYJicC74IfNHqMluBxQFOoaisqplqzskjEyzOpQzNvnTXc4y6+VBTa4QqyTEVDYc6
         2LK/M7yNDOQcAx8GqEMWhDQL1IIR2UviVlUk06JqczC2WsejsgqkKdPLRBzv1tLPgIxz
         YRAXAtU68GsJV6KObm9RRpL8tUBY1NnMzEjJ1OlkYlKTW/6uV09mCzeukQRwARcRfHG5
         YnMA==
X-Gm-Message-State: AOJu0YxfjH4+r474FYKVYjnGVAjq+cUeA0ffmCmO7y7ifaRHoBlUxUwO
	aeJdOkRTmFmBwUepoke1xtTMfZI1vvP41cUNqR4=
X-Google-Smtp-Source: AGHT+IGxYXaVkCUPqjQ6sPtaF4WKbhk6BNsMVFo2fphnEMh0pPdOudjijcRm+Qso+5or7eNgr6CvMfy5kxG371LrFI4=
X-Received: by 2002:ad4:5f05:0:b0:66d:17a2:34cc with SMTP id
 fo5-20020ad45f05000000b0066d17a234ccmr2617117qvb.64.1697728974033; Thu, 19
 Oct 2023 08:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018100000.2453965-1-amir73il@gmail.com> <20231018100000.2453965-4-amir73il@gmail.com>
 <20231019144026.2qypsldg5hlca5zc@quack3>
In-Reply-To: <20231019144026.2qypsldg5hlca5zc@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Oct 2023 18:22:42 +0300
Message-ID: <CAOQ4uxirRaQj8ix3aEA+SfUgXa55zaCQM3Rq+U26iqxjqnJZbA@mail.gmail.com>
Subject: Re: [PATCH 3/5] exportfs: make ->encode_fh() a mandatory method for
 NFS export
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Anton Altaparmakov <anton@tuxera.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Steve French <sfrench@samba.org>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Evgeniy Dushistov <dushistov@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 5:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 18-10-23 12:59:58, Amir Goldstein wrote:
> > export_operations ->encode_fh() no longer has a default implementation =
to
> > encode FILEID_INO32_GEN* file handles.
> >
> > Rename the default helper for encoding FILEID_INO32_GEN* file handles t=
o
> > generic_encode_ino32_fh() and convert the filesystems that used the
> > default implementation to use the generic helper explicitly.
> >
> > This is a step towards allowing filesystems to encode non-decodeable fi=
le
> > handles for fanotify without having to implement any export_operations.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Just one typo cleanup. Also I agree we need a "nop" variant of
> generic_encode_ino32_fh() or move this to fs/libfs.c like e.g.
> generic_fh_to_dentry().
>

I did this:

 /*
  * Generic helpers for filesystems.
  */
+#ifdef CONFIG_EXPORTFS
+int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
+                           struct inode *parent);
+#else
+#define generic_encode_ino32_fh NULL
+#endif

I like it better than moving to fs/libfs.c, because if CONFIG_EXPORTFS
is not defined, no code should be calling generic_encode_ino32_fh().

It might be a good idea to define exportfs_can_*() helpers to false
when CONFIG_EXPORTFS is not defined, but at least for fanotify,
this is not relevant because fanotify selects EXPORTFS.

> > diff --git a/Documentation/filesystems/porting.rst b/Documentation/file=
systems/porting.rst
> > index 4d05b9862451..197ef78a5014 100644
> > --- a/Documentation/filesystems/porting.rst
> > +++ b/Documentation/filesystems/porting.rst
> > @@ -1045,3 +1045,12 @@ filesystem type is now moved to a later point wh=
en the devices are closed:
> >  As this is a VFS level change it has no practical consequences for fil=
esystems
> >  other than that all of them must use one of the provided kill_litter_s=
uper(),
> >  kill_anon_super(), or kill_block_super() helpers.
> > +
> > +---
> > +
> > +**mandatory**
> > +
> > +export_operations ->encode_fh() no longer has a default implementation=
 to
> > +encode FILEID_INO32_GEN* file handles.
> > +Fillesystems that used the default implementation may use the generic =
helper
>    ^^^ Filesystems
>

Thanks!
Amir.

