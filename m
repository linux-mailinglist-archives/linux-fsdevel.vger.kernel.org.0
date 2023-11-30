Return-Path: <linux-fsdevel+bounces-4391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850DD7FF2AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D53B210B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560F51007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDgcYFec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE56131
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 05:38:09 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77896da2118so49185885a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 05:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701351489; x=1701956289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCMurWTdmQH+ICWDtXEiW3xQ4nE2C+AL6mW3gjh5FMY=;
        b=KDgcYFec7YPc7GDDwwriAHT1P1xcb9RETNvA1vsopW6CgCVal6dQ9PCxYfA/+aNAEY
         ErKSpK+vpLbUYTafqdDZL85oyQIHZh/WHpP7GRG9oS/1rDBr9Qqqh0XOUr5utwuFNRGX
         Gl9BkhJSYyf91wS0F9FJD/KuLYtsfovGvPFqrrDEG8p4cWOlH39xXel8XqiuxTb6RX+B
         UR+ezohcY4BGRb+AhdN5vb0Crn76VBIrgS+dtShwBftPmXRTRlhVpCGsA5jHUbTgOwHR
         65BNIcQQ9zSY9E4Bls+c4CwrqUHiD8/5Nb6i4eKjmjyJFPbxAMtiM7vQ9xMf2bNCxtDw
         HXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351489; x=1701956289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCMurWTdmQH+ICWDtXEiW3xQ4nE2C+AL6mW3gjh5FMY=;
        b=anlKf3okPScE0ngby+0+QJyWaSyskwFFNQhBaF6I66Gnn2zEvpBHAvq0rBw1ewl8TA
         TqAgP/JqJUPkylnx0I6YD6kwQk2sEbHRnPpWWIxTnuEBEZdN+E1KObnn/F4C5Rw+mBsF
         Xv3jjr7d117J7d5Y4zfLT1p+f63woiUBCw/H6uh7EsfHelIkpCSnc8tKvGlaLd8118Re
         IsBN9Co5fnaIgn0zfRisi+Uok8a/ci8nuOx1WZ+c/4hsM3jmISXZN8JIlGPeQ5wfrhSy
         4Z+pcLWC78PZwlSvX+oZ3zql6PS82zdrpiBf32RPhU52N8KPfMKBPD+wSDzufmopi9cJ
         Lazg==
X-Gm-Message-State: AOJu0YwQ8ECfqnrxrsnGgJ0ObTE2qEMd41FW5CHb+byl2yhLDgpWuzfs
	vsnGh6o5HEhGwThNLa8eBDYydPZ/9SP1Cwb9cmQ=
X-Google-Smtp-Source: AGHT+IFzXhoC6+2y9wLBjR4+UzZo5ipI+5w1+AxOEtO5HJAp9NcCAEf5Lab30kG8sOx2a8viiX2HmUTB+75Q3HM63AY=
X-Received: by 2002:a05:6214:930:b0:67a:8ed9:ca2 with SMTP id
 dk16-20020a056214093000b0067a8ed90ca2mr281349qvb.57.1701351488903; Thu, 30
 Nov 2023 05:38:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129200709.3154370-1-amir73il@gmail.com> <20231129200709.3154370-2-amir73il@gmail.com>
 <20231130-mollig-koproduktion-6c80ebb98b5f@brauner>
In-Reply-To: <20231130-mollig-koproduktion-6c80ebb98b5f@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 15:37:57 +0200
Message-ID: <CAOQ4uxjxn8d2VSxKXgCszoJVsWpBeJw1=OXdMPYxi7Rhegz_dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: fork do_splice_copy_file_range() from do_splice_direct()
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 3:18=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Nov 29, 2023 at 10:07:08PM +0200, Amir Goldstein wrote:
> > The new helper is meant to be called from context of ->copy_file_range(=
)
> > methods instead of do_splice_direct().
> >
> > Currently, the only difference is that do_splice_copy_file_range() does
> > not take a splice flags argument and it asserts that file_start_write()
> > was called.
> >
> > Soon, do_splice_direct() will be called without file_start_write() held=
.
> >
> > Use the new helper from __ceph_copy_file_range(), that was incorrectly
> > passing the copy_file_range() flags argument as splice flags argument
> > to do_splice_direct(). the value of flags was 0, so no actual bug fix.
> >
> > Move the definition of both helpers to linux/splice.h.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/ceph/file.c         |  9 ++---
> >  fs/read_write.c        |  6 ++--
> >  fs/splice.c            | 82 ++++++++++++++++++++++++++++++------------
> >  include/linux/fs.h     |  2 --
> >  include/linux/splice.h | 13 ++++---
> >  5 files changed, 75 insertions(+), 37 deletions(-)
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 3b5aae29e944..7c2db78e2c6e 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/falloc.h>
> >  #include <linux/iversion.h>
> >  #include <linux/ktime.h>
> > +#include <linux/splice.h>
> >
> >  #include "super.h"
> >  #include "mds_client.h"
> > @@ -3010,8 +3011,8 @@ static ssize_t __ceph_copy_file_range(struct file=
 *src_file, loff_t src_off,
> >                * {read,write}_iter, which will get caps again.
> >                */
> >               put_rd_wr_caps(src_ci, src_got, dst_ci, dst_got);
> > -             ret =3D do_splice_direct(src_file, &src_off, dst_file,
> > -                                    &dst_off, src_objlen, flags);
> > +             ret =3D do_splice_copy_file_range(src_file, &src_off, dst=
_file,
> > +                                             &dst_off, src_objlen);
> >               /* Abort on short copies or on error */
> >               if (ret < (long)src_objlen) {
> >                       doutc(cl, "Failed partial copy (%zd)\n", ret);
> > @@ -3065,8 +3066,8 @@ static ssize_t __ceph_copy_file_range(struct file=
 *src_file, loff_t src_off,
> >        */
> >       if (len && (len < src_ci->i_layout.object_size)) {
> >               doutc(cl, "Final partial copy of %zu bytes\n", len);
> > -             bytes =3D do_splice_direct(src_file, &src_off, dst_file,
> > -                                      &dst_off, len, flags);
> > +             bytes =3D do_splice_copy_file_range(src_file, &src_off, d=
st_file,
> > +                                               &dst_off, len);
> >               if (bytes > 0)
> >                       ret +=3D bytes;
> >               else
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index f791555fa246..555514cdad53 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1423,10 +1423,8 @@ ssize_t generic_copy_file_range(struct file *fil=
e_in, loff_t pos_in,
> >                               struct file *file_out, loff_t pos_out,
> >                               size_t len, unsigned int flags)
> >  {
>
> Hm, the low-level helper takes a @flags argument but it's completely
> ignored. I think that helper should remove it or it should check:
>
> if (flags)
>         return -EINVAL;
>

It's a good point.
The upstream code and in this v1, generic_copy_file_range() can actually
be called with flag COPY_FILE_SPLICE, but it is a mistake that
I fixed it in my branch for v2, so in v2 I can add this check.

> in case it's ever called from codepaths where @flags hasn't been
> sanitized imho.
>
> > -     lockdep_assert(file_write_started(file_out));
> > -
> > -     return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> > -                             len > MAX_RW_COUNT ? MAX_RW_COUNT : len, =
0);
> > +     return do_splice_copy_file_range(file_in, &pos_in, file_out, &pos=
_out,
> > +                             len > MAX_RW_COUNT ? MAX_RW_COUNT : len);
>
> clamp(len, 0, MAX_RW_COUNT)
>

It is a low level helper, so I don't want to worry about negative len value=
.
Already changed to min_t(size_t, len, MAX_RW_COUNT) in my branch.

Thanks!
Amir.

