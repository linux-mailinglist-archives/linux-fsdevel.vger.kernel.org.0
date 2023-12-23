Return-Path: <linux-fsdevel+bounces-6816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80181D2CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 07:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445AEB21ED0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DE463DF;
	Sat, 23 Dec 2023 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yoak/N53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31D9441;
	Sat, 23 Dec 2023 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67ad5b37147so15887686d6.2;
        Fri, 22 Dec 2023 22:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703314479; x=1703919279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmdtPFcINuZyhjOQPuZ+7rpBBqGEXk/l/OtCFZRb9Ig=;
        b=Yoak/N53wi5w59DpHFCe1vQXVyoeUs4zKK9OUuuHQKamWvNbd/qRQvUeTlpj1FEQRr
         sqlbxgXjKFUfGK6QKysTk4NqHUpyxh0nR+4I0uuoOANSq/faB8/LiEtLvGaY+2/i17W+
         IGBCN3EJzJuLmZ9/UO54BKKiGzcucXyfcd9E3sdmkRBfAjFmLavq4uDyidZIxxNblVFH
         pO8ItKKp0Kuzgm4vBfL9KL1qQj7aKPBzBYAh7VuVTSoriWwq1y6nGom8xnYkR7fvBlf0
         eDgvOZkfmoB69BWZ0LjSBMXPsnz717g/Rzlp0ghMhPEZwVgU+4X8nbcCDVqwNSvnjj0Y
         Bc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703314479; x=1703919279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmdtPFcINuZyhjOQPuZ+7rpBBqGEXk/l/OtCFZRb9Ig=;
        b=Y2cW5gJVWHXZXu1Enr26hAM3EYdswO7oXA3RD+1Z4J4CNEXH659CiJX6F3wKSd5nMD
         uToyNZNhqgsq8zeVwoKIot8bJDGicSEkoqpOsVCYpz/OObB2OHjKRS9wvz0f4vTWrucJ
         veRHiFtcSuO2k6cQVX3+Svy4yMg/80gC6vNXEL2EOpjc8mAC3ekWVkVaSvoSngNZMRMh
         UYRv8eXNZlZnLsBXUhaMiMcywML9dsvMZaJ7tqg5E1UcwIX4krvKSWoO/7mkyULa31PM
         8JPq7IGYxxIXGIZWYXyi+k/kV4BrQp+3l+wX6/mx3tJorVfr9s3zlb2APhtmjpSCu/wG
         417g==
X-Gm-Message-State: AOJu0YwYFq/7ArTGHiPjGgddtvnzzOvE/yw2qHaaCLtsEEX2nj8jmcy0
	rB2ciq6HTo6TpE1fDaWYqBqfr2vbw/9suC4vQAo=
X-Google-Smtp-Source: AGHT+IG5SPkLmm+ePgd+Tz7XX3f+m8+n86+rA/ZaY+zixX4lfNuAAgi35/2t8aUcFhBSkkOGqd7RE+Yqe/c+vK6NrBU=
X-Received: by 2002:ad4:5fc8:0:b0:67f:67ca:1173 with SMTP id
 jq8-20020ad45fc8000000b0067f67ca1173mr3082334qvb.107.1703314479110; Fri, 22
 Dec 2023 22:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221095410.801061-1-amir73il@gmail.com> <20231221095410.801061-5-amir73il@gmail.com>
 <20231222-gespeichert-prall-3183a634baae@brauner>
In-Reply-To: <20231222-gespeichert-prall-3183a634baae@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 23 Dec 2023 08:54:27 +0200
Message-ID: <CAOQ4uxiL=DckFZqq1APPUaWwWynH6mAJk+VcKO46dwGD521FYw@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/4] fs: factor out backing_file_mmap() helper
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 2:54=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Dec 21, 2023 at 11:54:10AM +0200, Amir Goldstein wrote:
> > Assert that the file object is allocated in a backing_file container
> > so that file_user_path() could be used to display the user path and
> > not the backing file's path in /proc/<pid>/maps.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/backing-file.c            | 27 +++++++++++++++++++++++++++
> >  fs/overlayfs/file.c          | 23 ++++++-----------------
> >  include/linux/backing-file.h |  2 ++
> >  3 files changed, 35 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/backing-file.c b/fs/backing-file.c
> > index 46488de821a2..1ad8c252ec8d 100644
> > --- a/fs/backing-file.c
> > +++ b/fs/backing-file.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/backing-file.h>
> >  #include <linux/splice.h>
> > +#include <linux/mm.h>
> >
> >  #include "internal.h"
> >
> > @@ -284,6 +285,32 @@ ssize_t backing_file_splice_write(struct pipe_inod=
e_info *pipe,
> >  }
> >  EXPORT_SYMBOL_GPL(backing_file_splice_write);
> >
> > +int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
> > +                   struct backing_file_ctx *ctx)
> > +{
> > +     const struct cred *old_cred;
> > +     int ret;
> > +
> > +     if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
>
> Couldn't that WARN_ON_ONCE() be in every one of these helpers in this
> series? IOW, when would you ever want to use a backing_file_*() helper
> on a non-backing file?

AFAIK, the call chain below backing_file_splice*() and backing_file_*_iter(=
)
helpers never end up accessing file_user_path() or assuming that fd of file
is installed in fd table, so there is no strong reason to enforce this with=
 an
assertion.

We can do it for clarity of semantics, in case one of the call chains will
start assuming a struct backing_file in the future. WDIT?

Thanks,
Amir.

