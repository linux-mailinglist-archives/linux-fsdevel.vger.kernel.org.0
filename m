Return-Path: <linux-fsdevel+bounces-6817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F8A81D2CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 07:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E5F1C226F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 06:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10E579C5;
	Sat, 23 Dec 2023 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K50KmLO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE466FAF;
	Sat, 23 Dec 2023 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67f6272e7c6so17015336d6.1;
        Fri, 22 Dec 2023 22:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703314579; x=1703919379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4U8KaKVSJpuh7Rw7QL3fAuZwrDShZbZLQ1TxJQ7899E=;
        b=K50KmLO0Lvf+tXKaigk3oTDlbPjupNykOraR9JoxEhVMTO2E0kqGsuVGFrRosPLDrV
         YaDmbKc1203j8fKO32KOEETQUVYOcC3JQUG9jcdqUJJJLhg1KYC1KKgbJFMY6oSMN0iP
         Ih2DIpLY2enSRpfLr+0+rJx8t7CF89dZkchYYaWTe0It3xB8kERq3kmOgSO4O+PLesxs
         Un5t+CkRmmcoWmGmu1IcbHRMjZGRDjeYjj2zBeufnRVB0Zu64u1IdFDaZiktnWPuCUfR
         cbPhBKij9e9a4hM02dY/i5EHNRauHorMOPqHsuCcH4lmFuC9sOOmLfDKvVAui6dK/EXG
         Kiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703314579; x=1703919379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4U8KaKVSJpuh7Rw7QL3fAuZwrDShZbZLQ1TxJQ7899E=;
        b=naxrrtXPcKO0uqyB0ImfHKDLUMOjs0vapR5NnzgYlqrGW+foruCjksML5aCwen9xGT
         lB2k9sTUljoBvnDStpnJAjgUSrJ02Wg7hsJ0vvhOuhP3qsnSUz/pG/icydvN6Fpollpp
         vtndWOeCsv2O6KU93FYJEOb/J44UEzQlzG2gt5iX9f258BCwVe3KLpj/85O2p6AT9zyI
         YBPqIljs+CwZEHqy/1/Eqs8suQkmU9dkKI2ISMU12avTfMdh2uoCGFCOMfX51E4tsgx1
         RSCYsgrjM0N9RKulOE34Kop9om/fczxaZvP4GT7Ux9L9exS2ucZOzEmJjj+ATWcQABlX
         G7Bg==
X-Gm-Message-State: AOJu0Ywu4aMOFSt/bhAZzcUPB90Ht1GiKckJX2C2EH512Ojek+iYRze1
	7hokBb2V0ebd/eQtAdcWJSEPz7GxNhKIeroD5jQ=
X-Google-Smtp-Source: AGHT+IGw45Ew/WFwIQa42JCWSz7x1ecpoHT5Es/a8h1q1FQGXtYxGgYta87qohTvbwAciWd1IdJt99CM8EX6C2fYe1I=
X-Received: by 2002:a0c:f74d:0:b0:67f:b9df:17e8 with SMTP id
 e13-20020a0cf74d000000b0067fb9df17e8mr366211qvo.96.1703314579666; Fri, 22 Dec
 2023 22:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221095410.801061-1-amir73il@gmail.com> <20231221095410.801061-5-amir73il@gmail.com>
 <20231222-gespeichert-prall-3183a634baae@brauner> <CAOQ4uxiL=DckFZqq1APPUaWwWynH6mAJk+VcKO46dwGD521FYw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiL=DckFZqq1APPUaWwWynH6mAJk+VcKO46dwGD521FYw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 23 Dec 2023 08:56:08 +0200
Message-ID: <CAOQ4uxiLB4c4WXjvyAzQdvWD23YgMVQPuTd9Fp=oUNy_uGdGTQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/4] fs: factor out backing_file_mmap() helper
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 8:54=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Dec 22, 2023 at 2:54=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Thu, Dec 21, 2023 at 11:54:10AM +0200, Amir Goldstein wrote:
> > > Assert that the file object is allocated in a backing_file container
> > > so that file_user_path() could be used to display the user path and
> > > not the backing file's path in /proc/<pid>/maps.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/backing-file.c            | 27 +++++++++++++++++++++++++++
> > >  fs/overlayfs/file.c          | 23 ++++++-----------------
> > >  include/linux/backing-file.h |  2 ++
> > >  3 files changed, 35 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/fs/backing-file.c b/fs/backing-file.c
> > > index 46488de821a2..1ad8c252ec8d 100644
> > > --- a/fs/backing-file.c
> > > +++ b/fs/backing-file.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/fs.h>
> > >  #include <linux/backing-file.h>
> > >  #include <linux/splice.h>
> > > +#include <linux/mm.h>
> > >
> > >  #include "internal.h"
> > >
> > > @@ -284,6 +285,32 @@ ssize_t backing_file_splice_write(struct pipe_in=
ode_info *pipe,
> > >  }
> > >  EXPORT_SYMBOL_GPL(backing_file_splice_write);
> > >
> > > +int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
> > > +                   struct backing_file_ctx *ctx)
> > > +{
> > > +     const struct cred *old_cred;
> > > +     int ret;
> > > +
> > > +     if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
> >
> > Couldn't that WARN_ON_ONCE() be in every one of these helpers in this
> > series? IOW, when would you ever want to use a backing_file_*() helper
> > on a non-backing file?
>
> AFAIK, the call chain below backing_file_splice*() and backing_file_*_ite=
r()
> helpers never end up accessing file_user_path() or assuming that fd of fi=
le
> is installed in fd table, so there is no strong reason to enforce this wi=
th an
> assertion.
>
> We can do it for clarity of semantics, in case one of the call chains wil=
l
> start assuming a struct backing_file in the future. WDIT?

Doh! WDYT?

Thanks,
Amir.

