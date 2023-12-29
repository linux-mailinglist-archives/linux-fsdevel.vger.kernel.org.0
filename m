Return-Path: <linux-fsdevel+bounces-7024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668FD8200ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 18:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222A5282203
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73EC12B89;
	Fri, 29 Dec 2023 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR8ns4NI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176012B6B;
	Fri, 29 Dec 2023 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67f8a5ed1a0so46052326d6.2;
        Fri, 29 Dec 2023 09:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703871872; x=1704476672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7p7Ge5//CaATuecPJm+siWFiqUIutH8iUGl04+JepRo=;
        b=mR8ns4NIFzmSNWfkJ5YHYCgGjpfS/ILKkUJjg9iJ50IHkkz1aexmOTQ8d9jVXcwkcv
         oL4YqSz2UQ1dJ/x7c5scmJmsPR9oN8cOOUMXdEozoz235O+3ILdbN5kWXLmfFH6Ttjbp
         xekUhxXo0q7UaZeT/aOrCL8U6va7rvT8mlOz9zU9ej5Jwjhb5lCob4ZHeitsnf9gNml6
         ElMpDcUrqwNz1eSgp+RAzcXvtWbhl662ExryfXP8zlLN/g/5rbqyLgs/2nWuD/IWiJzM
         gTWZ9L8Ln240dOu887NWa2lRhgVH/zHAkqIm4YyWdJnlmQIudTQsjaOOmcFNrCHBARm1
         ewbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703871872; x=1704476672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7p7Ge5//CaATuecPJm+siWFiqUIutH8iUGl04+JepRo=;
        b=r3UOcD8gEqjG9QB2n8RirX+sPmHz1hvXbdsH4zC05CKBvTIZX1mv1mvnInSrMjSf4W
         8DC8I0caxDCpgLgZzV/vbvGS0fdAxGazFBBawpV275jekT7drozizs+4+CfASY0xM+Y+
         7ugqxz0XWfhpA7DSXd8IOgAEb9q79ZTlXRO2MXXScwHTSEtq4Dv+LORFZWpS03SxzdJF
         7+rMUw6R+GuB0WhhTcNarXfu8q4vWzuog2ygzh4MTjDFgyjkBVcRqCxTRNJgt6Rr9DoX
         ed/xZszfYIvJLAJVnt5MtiJytkHoxR9pX+YUi4xldxyuacvq38OZ1vVF3NsgpoQGYgqG
         uajA==
X-Gm-Message-State: AOJu0Yyto0/flHMBC4CazbZO+C7uKgqDyjxmbkzozAqI8zAYzXQUn14+
	jLts9wx1DtgZsNGqIXu6bAoq0Vod+BjcvIusGPo=
X-Google-Smtp-Source: AGHT+IEhVXtDA1d9sEa4PrSLmN8G1UeQzUvwOvA3Vcu2tvjISWD0gUCiss1RiPgUrNLHWJpUA/lfcYEMoaShjB37WKQ=
X-Received: by 2002:a05:6214:e63:b0:67e:afec:e114 with SMTP id
 jz3-20020a0562140e6300b0067eafece114mr14394087qvb.63.1703871871905; Fri, 29
 Dec 2023 09:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228201510.985235-1-trondmy@kernel.org> <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
 <ZY7ZC9q8dGtoC2U/@tissot.1015granger.net>
In-Reply-To: <ZY7ZC9q8dGtoC2U/@tissot.1015granger.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Dec 2023 19:44:20 +0200
Message-ID: <CAOQ4uxh1VDPVq7a82HECtKuVwhMRLGe3pvL6TY6Xoobp=vaTTw@mail.gmail.com>
Subject: Re: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
To: Chuck Lever <chuck.lever@oracle.com>
Cc: trondmy@kernel.org, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 4:35=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Fri, Dec 29, 2023 at 07:46:54AM +0200, Amir Goldstein wrote:
> > [CC: fsdevel, viro]
>
> Thanks for picking this up, Amir, and for copying viro/fsdevel. I
> was planning to repost this next week when more folks are back, but
> this works too.
>
> Trond, if you'd like, I can handle review changes if you don't have
> time to follow up.
>
>
> > On Thu, Dec 28, 2023 at 10:22=E2=80=AFPM <trondmy@kernel.org> wrote:
> > >
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > >
> > > The fallback implementation for the get_name export operation uses
> > > readdir() to try to match the inode number to a filename. That filena=
me
> > > is then used together with lookup_one() to produce a dentry.
> > > A problem arises when we match the '.' or '..' entries, since that
> > > causes lookup_one() to fail. This has sometimes been seen to occur fo=
r
> > > filesystems that violate POSIX requirements around uniqueness of inod=
e
> > > numbers, something that is common for snapshot directories.
> >
> > Ouch. Nasty.
> >
> > Looks to me like the root cause is "filesystems that violate POSIX
> > requirements around uniqueness of inode numbers".
> > This violation can cause any of the parent's children to wrongly match
> > get_name() not only '.' and '..' and fail the d_inode sanity check afte=
r
> > lookup_one().
> >
> > I understand why this would be common with parent of snapshot dir,
> > but the only fs that support snapshots that I know of (btrfs, bcachefs)
> > do implement ->get_name(), so which filesystem did you encounter
> > this behavior with? can it be fixed by implementing a snapshot
> > aware ->get_name()?
> >
> > > This patch just ensures that we skip '.' and '..' rather than allowin=
g a
> > > match.
> >
> > I agree that skipping '.' and '..' makes sense, but...
>
> Does skipping '.' and '..' make sense for file systems that do

It makes sense because if the child's name in its parent would
have been "." or ".." it would have been its own parent or its own
grandparent (ELOOP situation).
IOW, we can safely skip "." and "..", regardless of anything else.

> indeed guarantee inode number uniqueness? Given your explanation
> here, I'm wondering whether the generic get_name() function is the
> right place to address the issue.
>
>
> > > Fixes: 21d8a15ac333 ("lookup_one_len: don't accept . and ..")
> >
> > ...This Fixes is a bit odd to me.
>
> Me too, but I didn't see a more obvious choice. Maybe drop the
> specific Fixes: tag in favor of just Cc: stable.
>

Yeh, that'd be fine.

Thanks,
Amir.

