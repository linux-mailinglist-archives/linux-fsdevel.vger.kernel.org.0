Return-Path: <linux-fsdevel+bounces-6833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C669981D48F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 15:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B881F2203F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 14:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439BCDF4D;
	Sat, 23 Dec 2023 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdqSLjED"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA2ADDB3;
	Sat, 23 Dec 2023 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4259a275fa9so22542901cf.2;
        Sat, 23 Dec 2023 06:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703341712; x=1703946512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GntqsZ6O0h/Mg/8BW3/CX9yGWPjoS/jKoNzZV/bvFQs=;
        b=OdqSLjEDuvNE/OrvlQLrE1ryjbdmINQi3+IXz/00TJOu2E8fyEn/useWhmAjMC7ZtG
         +j9+f6fxXqNMkIU+33sT+S0wie1UrtzX1cSMO60OVQnr/1bPivJdENGhSQJHDMm6PQS/
         Zryuptt3c6BfSVWKrzjzp0OHNrkfIzHQUVP8QnOjytSu3iZoS+p7tXpHqEnIxDsB83c9
         KuwCshDg3oGhbPiEAgJ+yiqboLz7IudQ1HHDdgIL9eU0n5IWIKn4WQdzxg2ppp6DgA3t
         dsqWjNUmMgltQs7mCNO6/X3zLeOZeI5pUZKZGBfyGlEF184VLXRVxK0swNDerNwXZH+k
         D73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703341712; x=1703946512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GntqsZ6O0h/Mg/8BW3/CX9yGWPjoS/jKoNzZV/bvFQs=;
        b=Q0A423TNVRm3m8dEoiMvTiw7fFVuEHOZxRcZUMSqxlrFuLd5QQbqcSOX25J6SlOwVo
         U59/2lSncegdye9otaAlFkg29s2ZxTc3MP6sUoeE+xhTShmMNeVCOXgrqaBZhYk9wfZ8
         0NOV1ac9f2BfB+pXr3ArwE70VvTkVc4SyMJNe5xxwS3ULp872b1KT1fJeC9I2PflQ3rB
         GSHOCo6AkSOK1lnQM6W56c3/8CuZVk504O1Kytzvltkn4+2PIgjROYLjBcNjthM0pwQO
         Wprh58D40liuFfERd0u0FnG5LYXt2OfBH8fUgNm8XaeAghOHkhUNpudbW54bkZcwZ9t4
         yg2A==
X-Gm-Message-State: AOJu0YwibYBbxO1tyvKRGypd2gaVga9TS3GY6r6mmsnJlN+1LlmI4ODw
	ai4imXFZfNE4yWv5IsG3QWt3RyEQI576go0qfFI=
X-Google-Smtp-Source: AGHT+IFhfek1eX71/FSrzxYBHTG9RVXyqSvIfiB3uCp0iAUXyGrOj4QCTt988247rkhPiAiVh/FRuw6Vr18b+swBaQs=
X-Received: by 2002:a05:622a:1646:b0:427:7bb7:ed5b with SMTP id
 y6-20020a05622a164600b004277bb7ed5bmr4125626qtj.91.1703341712207; Sat, 23 Dec
 2023 06:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221095410.801061-1-amir73il@gmail.com> <20231221095410.801061-5-amir73il@gmail.com>
 <20231222-gespeichert-prall-3183a634baae@brauner> <CAOQ4uxiL=DckFZqq1APPUaWwWynH6mAJk+VcKO46dwGD521FYw@mail.gmail.com>
 <CAOQ4uxiLB4c4WXjvyAzQdvWD23YgMVQPuTd9Fp=oUNy_uGdGTQ@mail.gmail.com> <20231223-zerlegen-eidesstattlich-a1f309e30dbc@brauner>
In-Reply-To: <20231223-zerlegen-eidesstattlich-a1f309e30dbc@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 23 Dec 2023 16:28:20 +0200
Message-ID: <CAOQ4uxijw+ce1gbghJfoYq=1Rvy2b6Gca6ifiFagahm9UdvfXQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/4] fs: factor out backing_file_mmap() helper
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 3:04=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, Dec 23, 2023 at 08:56:08AM +0200, Amir Goldstein wrote:
> > On Sat, Dec 23, 2023 at 8:54=E2=80=AFAM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Fri, Dec 22, 2023 at 2:54=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > >
> > > > On Thu, Dec 21, 2023 at 11:54:10AM +0200, Amir Goldstein wrote:
> > > > > Assert that the file object is allocated in a backing_file contai=
ner
> > > > > so that file_user_path() could be used to display the user path a=
nd
> > > > > not the backing file's path in /proc/<pid>/maps.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >  fs/backing-file.c            | 27 +++++++++++++++++++++++++++
> > > > >  fs/overlayfs/file.c          | 23 ++++++-----------------
> > > > >  include/linux/backing-file.h |  2 ++
> > > > >  3 files changed, 35 insertions(+), 17 deletions(-)
> > > > >
> > > > > diff --git a/fs/backing-file.c b/fs/backing-file.c
> > > > > index 46488de821a2..1ad8c252ec8d 100644
> > > > > --- a/fs/backing-file.c
> > > > > +++ b/fs/backing-file.c
> > > > > @@ -11,6 +11,7 @@
> > > > >  #include <linux/fs.h>
> > > > >  #include <linux/backing-file.h>
> > > > >  #include <linux/splice.h>
> > > > > +#include <linux/mm.h>
> > > > >
> > > > >  #include "internal.h"
> > > > >
> > > > > @@ -284,6 +285,32 @@ ssize_t backing_file_splice_write(struct pip=
e_inode_info *pipe,
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(backing_file_splice_write);
> > > > >
> > > > > +int backing_file_mmap(struct file *file, struct vm_area_struct *=
vma,
> > > > > +                   struct backing_file_ctx *ctx)
> > > > > +{
> > > > > +     const struct cred *old_cred;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
> > > >
> > > > Couldn't that WARN_ON_ONCE() be in every one of these helpers in th=
is
> > > > series? IOW, when would you ever want to use a backing_file_*() hel=
per
> > > > on a non-backing file?
> > >
> > > AFAIK, the call chain below backing_file_splice*() and backing_file_*=
_iter()
> > > helpers never end up accessing file_user_path() or assuming that fd o=
f file
> > > is installed in fd table, so there is no strong reason to enforce thi=
s with an
> > > assertion.
>
> Yeah, but you do use an override_cred() call and you do have that
> backing_file_ctx. It smells like a bug if anyone would pass in a
> non-backing file.
>
> > >
> > > We can do it for clarity of semantics, in case one of the call chains=
 will
> > > start assuming a struct backing_file in the future. WDIT?
> >
> > Doh! WDYT?
>
> I'd add it as the whole series is predicated on this being used for
> backing files.

Sure. Will do.

Thanks,
Amir.

