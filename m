Return-Path: <linux-fsdevel+bounces-7128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F46821F6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 17:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3471F2303A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C1414F72;
	Tue,  2 Jan 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="IBgCl/6S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8814F6E
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbd721384c0so7762938276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1704212746; x=1704817546; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjrvt43eUxDbjYkOtMd56Xtm4TWENol61R3rS+X29Ik=;
        b=IBgCl/6SgN7nVmtYt/LMmt7mpH9flZipTFwMyyYKhLNooe3TQQq1LdxezQMe5ddrFW
         AIbqy3+XmldL3Ul1JASs8yiDsi82aRvzsFJ5CgtLfpnOEvN8e7E9HrcZfNVwLlZ8rL7C
         GORmGDrAlfQh3/zKVbbmPK6RnIvpfGFFpGExII37O5QrZbzJsiqxOxHc0Lo6gtYBXEcA
         pr0hXuP3uFfz4guajwqU4kxapEeTlh/8wCCP4icDq3UqGjZbEeBKOvvf9c8HRPR8aAI9
         NWjOJMBDyR9KMgy/1wEYbUCU8a8ONp6xe4DvJOUoZe3rzsEITSjCBfql6zFVxnfVuO2K
         /uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704212746; x=1704817546;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjrvt43eUxDbjYkOtMd56Xtm4TWENol61R3rS+X29Ik=;
        b=sh2t3UK7RK8RPHDi4mdWIrzTO0Rkq7cb8ri/q6fUZDu1kFuKS7AdBzi2/fhwZmLkiG
         u7HYJOmToPHumCGiaJR+BRQ6HZewPKvVVbuqvwKKNg3N+PmnWjlamVe5SldyTTLzLQ/D
         vgD811elBsgb5rxzaDmT9osoQV123pWSZYjAj72OmFCTlvQUa6xOhhoAufnYap5kiHEv
         hWwIaoAbPmaYlI373qsHEMXz9YwBAXPO/wONN2FQIH5fvWNvAYyAUlEbXET6n4i6vbjl
         ZcPCR2tqLJEzggq3N6HnuLIsQLxiOGu49qcnVIr38fctSs1EF6lX59Cy4i9vUoxQfmw8
         I4tw==
X-Gm-Message-State: AOJu0YwvAcZVYwZgNJ1mPuenlPT4mLGXPPTJgt1NqfzXoYpklPipLfOF
	Se7xZ3pYw0pH+FPxowLV+cBRaRpcWuNyvBoUSiT8n9hAPPZvbR4cVzg0xZqzlw==
X-Google-Smtp-Source: AGHT+IHif4OwX29X+zB4A53zmWkbIC0JdUXihe7lrh9+jb7Xvdt5em8i/REKHTatrh0lEdoDLrbhZzHhCUXIr2Y2PbY=
X-Received: by 2002:a5b:f50:0:b0:dbd:f0c7:891d with SMTP id
 y16-20020a5b0f50000000b00dbdf0c7891dmr5959520ybr.19.1704212746518; Tue, 02
 Jan 2024 08:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220051348.GY1674809@ZenIV> <20231220053238.GT1674809@ZenIV> <CAOg9mSR0KtsdkZ+32n4EtMegw-YOO6o11CNPpotPGDw4F+4Kvw@mail.gmail.com>
In-Reply-To: <CAOg9mSR0KtsdkZ+32n4EtMegw-YOO6o11CNPpotPGDw4F+4Kvw@mail.gmail.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 2 Jan 2024 11:25:35 -0500
Message-ID: <CAOg9mSQc-9-BEGPY5RCR3=nP10QA+5rGXtOi+_BVib723yhLug@mail.gmail.com>
Subject: Re: [PATCH 21/22] orangefs: saner arguments passing in readdir guts
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al... without going into detail about me being clumsy,
there is no new regression. There is a problem I found
in orangefs and have sent it up to Walt Ligon. I had
then excluded that test from my xfstests runs and lost that
particular exclusion when I recently pulled/updated my
xfstests.

So... I have tested your patch and I think it is good.

Some parts of the motorcycle ride were chilly...

https://hubcapsc.com/misc/madison_georgia_motel_frost.jpg

-Mike

On Wed, Dec 27, 2023 at 7:05=E2=80=AFAM Mike Marshall <hubcap@omnibond.com>=
 wrote:
>
> Howdy Al... I applied your orangefs patch to 6.7.0-rc6 and found one
> xfstests failure that was not there when I ran against
> xfstests-6.7.0-rc5. (generic/438)
>
> I'm about to hit the road for a several day motorcycle ride in an hour
> or so, I just wanted to give feedback before Ieft. I'll look into it
> further when I get back.
>
> -Mike
>
> On Wed, Dec 20, 2023 at 12:33=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> >
> > orangefs_dir_fill() doesn't use oi and dentry arguments at all
> > do_readdir() gets dentry, uses only dentry->d_inode; it also
> > gets oi, which is ORANGEFS_I(dentry->d_inode) (i.e. ->d_inode -
> > constant offset).
> > orangefs_dir_mode() gets dentry and oi, uses only to pass those
> > to do_readdir().
> > orangefs_dir_iterate() uses dentry and oi only to pass those to
> > orangefs_dir_fill() and orangefs_dir_more().
> >
> > The only thing it really needs is ->d_inode; moreover, that's
> > better expressed as file_inode(file) - no need to go through
> > ->f_path.dentry->d_inode.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  fs/orangefs/dir.c | 32 ++++++++++++--------------------
> >  1 file changed, 12 insertions(+), 20 deletions(-)
> >
> > diff --git a/fs/orangefs/dir.c b/fs/orangefs/dir.c
> > index 9cacce5d55c1..6d1fbeca9d81 100644
> > --- a/fs/orangefs/dir.c
> > +++ b/fs/orangefs/dir.c
> > @@ -58,10 +58,10 @@ struct orangefs_dir {
> >   * first part of the part list.
> >   */
> >
> > -static int do_readdir(struct orangefs_inode_s *oi,
> > -    struct orangefs_dir *od, struct dentry *dentry,
> > +static int do_readdir(struct orangefs_dir *od, struct inode *inode,
> >      struct orangefs_kernel_op_s *op)
> >  {
> > +       struct orangefs_inode_s *oi =3D ORANGEFS_I(inode);
> >         struct orangefs_readdir_response_s *resp;
> >         int bufi, r;
> >
> > @@ -87,7 +87,7 @@ static int do_readdir(struct orangefs_inode_s *oi,
> >         op->upcall.req.readdir.buf_index =3D bufi;
> >
> >         r =3D service_operation(op, "orangefs_readdir",
> > -           get_interruptible_flag(dentry->d_inode));
> > +           get_interruptible_flag(inode));
> >
> >         orangefs_readdir_index_put(bufi);
> >
> > @@ -158,8 +158,7 @@ static int parse_readdir(struct orangefs_dir *od,
> >         return 0;
> >  }
> >
> > -static int orangefs_dir_more(struct orangefs_inode_s *oi,
> > -    struct orangefs_dir *od, struct dentry *dentry)
> > +static int orangefs_dir_more(struct orangefs_dir *od, struct inode *in=
ode)
> >  {
> >         struct orangefs_kernel_op_s *op;
> >         int r;
> > @@ -169,7 +168,7 @@ static int orangefs_dir_more(struct orangefs_inode_=
s *oi,
> >                 od->error =3D -ENOMEM;
> >                 return -ENOMEM;
> >         }
> > -       r =3D do_readdir(oi, od, dentry, op);
> > +       r =3D do_readdir(od, inode, op);
> >         if (r) {
> >                 od->error =3D r;
> >                 goto out;
> > @@ -238,9 +237,7 @@ static int fill_from_part(struct orangefs_dir_part =
*part,
> >         return 1;
> >  }
> >
> > -static int orangefs_dir_fill(struct orangefs_inode_s *oi,
> > -    struct orangefs_dir *od, struct dentry *dentry,
> > -    struct dir_context *ctx)
> > +static int orangefs_dir_fill(struct orangefs_dir *od, struct dir_conte=
xt *ctx)
> >  {
> >         struct orangefs_dir_part *part;
> >         size_t count;
> > @@ -304,15 +301,10 @@ static loff_t orangefs_dir_llseek(struct file *fi=
le, loff_t offset,
> >  static int orangefs_dir_iterate(struct file *file,
> >      struct dir_context *ctx)
> >  {
> > -       struct orangefs_inode_s *oi;
> > -       struct orangefs_dir *od;
> > -       struct dentry *dentry;
> > +       struct orangefs_dir *od =3D file->private_data;
> > +       struct inode *inode =3D file_inode(file);
> >         int r;
> >
> > -       dentry =3D file->f_path.dentry;
> > -       oi =3D ORANGEFS_I(dentry->d_inode);
> > -       od =3D file->private_data;
> > -
> >         if (od->error)
> >                 return od->error;
> >
> > @@ -342,7 +334,7 @@ static int orangefs_dir_iterate(struct file *file,
> >          */
> >         while (od->token !=3D ORANGEFS_ITERATE_END &&
> >             ctx->pos > od->end) {
> > -               r =3D orangefs_dir_more(oi, od, dentry);
> > +               r =3D orangefs_dir_more(od, inode);
> >                 if (r)
> >                         return r;
> >         }
> > @@ -351,17 +343,17 @@ static int orangefs_dir_iterate(struct file *file=
,
> >
> >         /* Then try to fill if there's any left in the buffer. */
> >         if (ctx->pos < od->end) {
> > -               r =3D orangefs_dir_fill(oi, od, dentry, ctx);
> > +               r =3D orangefs_dir_fill(od, ctx);
> >                 if (r)
> >                         return r;
> >         }
> >
> >         /* Finally get some more and try to fill. */
> >         if (od->token !=3D ORANGEFS_ITERATE_END) {
> > -               r =3D orangefs_dir_more(oi, od, dentry);
> > +               r =3D orangefs_dir_more(od, inode);
> >                 if (r)
> >                         return r;
> > -               r =3D orangefs_dir_fill(oi, od, dentry, ctx);
> > +               r =3D orangefs_dir_fill(od, ctx);
> >         }
> >
> >         return r;
> > --
> > 2.39.2
> >
> >

