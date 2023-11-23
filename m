Return-Path: <linux-fsdevel+bounces-3551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5882A7F6468
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 17:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E2DB2101D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32553E480;
	Thu, 23 Nov 2023 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds5PwlSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFA2101
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 08:54:11 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58ceabd7cdeso555405eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 08:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700758451; x=1701363251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC5ab+aapTW6lbry5H7V57VoJ5KNrSMIolfIaIMsjo0=;
        b=ds5PwlSd0UD3osZg3a+izq49/kdHVh+ETFV8buD/adchMf9IRa8NGnItxFfGO1BU5M
         AWbYW5vRWoAqhyyeyAJrwHJav1PyC4zsvITv7WR3CV3VJUhopSTJZ3d0lpnYcDx1UeOl
         sI8gSP42SNvuRuGAsydBktb7CuYgeqMcKlpvqgP8gBMeB5y47Er1hwF69LO/LJnzmOzv
         hnwcDCtxar/HtiK6knljhXSnv0SIfTHeGmsBEmIZVQgEiNOLGewLBJ3VXwFFjV/WeR8E
         4HzdMJRdKl6NcmXnN1G8tEKAwGjs06ypBFXn+7hlJadXWZUIGpdsmh0GRtqNqeMbZtji
         6BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700758451; x=1701363251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC5ab+aapTW6lbry5H7V57VoJ5KNrSMIolfIaIMsjo0=;
        b=a7kCEbPR8wgyepc8AXI1qzhs3d6ygNtM/gjJiTogc3lRs//oa9x62MeSudgfi4ECfV
         nGeaI+HAm3omvCUSvJSfeWv72ggzm+ld1HOyBE7Jk0OSy3P662un4gQ6iW3NPshtVDSZ
         agHDg4YWT/DSS5qig6tQwTphoXSG1gbZQhyCGWq0/HFGtMWJ/r3zJWk5Aa17nrgX/Q0A
         x/eqOSkxRHlyxWqy+97Z8GXtPjVec5hLhe8A5VO5PPzw0PsQPKke4J2qqlX1x1Rkmd22
         6mrBHefrM6xKwyB1X7NVg2bJyMijL9jg/f22bPVyewjfkkK6NeKPmnNbm/jXqzrZY6Io
         e7XQ==
X-Gm-Message-State: AOJu0YzHwOfu33waIS0dXlhSnj+/aIwxMS7Kas0BwXycib8YKmi53MSh
	Qi9U5PuRW16w16D+1KIJNXaLH/92M2V0VNlxhP4=
X-Google-Smtp-Source: AGHT+IHW6xQUxo0A93bqVx7i0FascGU2+nR6o/e9oVAgPQEEc/W7ahYaaA1YH1Z+UvB5FNPk870KrQm/NhcOvzk2WBU=
X-Received: by 2002:a05:6358:720d:b0:16b:f8f5:e20 with SMTP id
 h13-20020a056358720d00b0016bf8f50e20mr7317970rwa.30.1700758450982; Thu, 23
 Nov 2023 08:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122715.2561213-1-amir73il@gmail.com> <20231122122715.2561213-6-amir73il@gmail.com>
 <ZV8Dk7UOLejEhzQN@infradead.org> <CAOQ4uxhxG_G6pjVTikakuUpru1XfaJoKWs4+HwNxCE5PxGTq_Q@mail.gmail.com>
 <ZV9sTfUfM9PU1IFw@infradead.org> <CAOQ4uxiDbGCn3vB4VwQyzdE9k8JjCeMGOqsVN=J5=-KCkvuQ2g@mail.gmail.com>
 <20231123-geboren-deutlich-b5efc843f530@brauner>
In-Reply-To: <20231123-geboren-deutlich-b5efc843f530@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Nov 2023 18:53:59 +0200
Message-ID: <CAOQ4uxhteMfu+mo1Y-mpF8+92X4MwXw0CNajoCDhBQLP02GYTA@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] splice: remove permission hook from iter_file_splice_write()
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 6:22=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > > diff --git a/fs/splice.c b/fs/splice.c
> > > index d983d375ff1130..982a0872fa03e9 100644
> > > --- a/fs/splice.c
> > > +++ b/fs/splice.c
> > > @@ -684,6 +684,7 @@ iter_file_splice_write(struct pipe_inode_info *pi=
pe, struct file *out,
> > >
> > >         splice_from_pipe_begin(&sd);
> > >         while (sd.total_len) {
> > > +               struct kiocb kiocb;
> > >                 struct iov_iter from;
> > >                 unsigned int head, tail, mask;
> > >                 size_t left;
> > > @@ -733,7 +734,10 @@ iter_file_splice_write(struct pipe_inode_info *p=
ipe, struct file *out,
> > >                 }
> > >
> > >                 iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_=
len - left);
> > > -               ret =3D vfs_iter_write(out, &from, &sd.pos, 0);
> > > +               init_sync_kiocb(&kiocb, out);
> > > +               kiocb.ki_pos =3D sd.pos;
> > > +               ret =3D out->f_op->write_iter(&kiocb, &from);
> > > +               sd.pos =3D kiocb.ki_pos;
> > >                 if (ret <=3D 0)
> > >                         break;
> > >
> >
> > Are we open coding call_write_iter() now?
> > Is that a trend that I am not aware of?
>
> I'll fold that in as-is but I'll use call_write_iter() for now.
> We can remove that later. For now consistency matters more.

Stating the obvious - please don't forget to edit the commit message
removing mention of the helper.

Thanks,
Amir.

