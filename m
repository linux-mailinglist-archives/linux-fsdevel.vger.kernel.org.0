Return-Path: <linux-fsdevel+bounces-3545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01FA7F6334
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 16:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0F028193C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CCB3C6BB;
	Thu, 23 Nov 2023 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEW1gNK3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A1D6E
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 07:41:51 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41c157bbd30so5042311cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 07:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700754110; x=1701358910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5O2uyrNc1/GfxKQTWSXDwPdsyUasHkE2VTgt8/ybkk=;
        b=ZEW1gNK3ofZaUnw61FQOtr/C2aNxTfVsd6hK3Wdh7GwAM5CViUF1fd5250cxFdl/ty
         YDNfBtdxW2knG172KjVJ0CCFA5mdPIgzST9KmyOQ+u70rfQ/xIWlnHdnmZQGl0Rl/a0j
         LuWDR3Ps21rVz7RVycEz/oe3sivVtiOjrbH6TL/MprleoEtRTLZpWlUSl+gDVC1G5/GD
         EdsePJnSOgQozZZIaA9JvqFkaD14fn0Zgw705QQS+9NY3VjiKT55gCB+5ahb8sXOwzlR
         GPFtlA5JLYtSqpcYoZ5hDT1aIs6ynVX+9Cj5jczTXmXfLAwiNZ+wSPTajktS5jw3kcUj
         kJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700754110; x=1701358910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5O2uyrNc1/GfxKQTWSXDwPdsyUasHkE2VTgt8/ybkk=;
        b=Fykk4rkc4MM8md76HYmxHXJc6R68Ig0KW8A5uLCjwYtz6j/DLWzhwTqlaNQkZlVTAs
         l0HfYJT31E1+bIo0oD3X/ArlrUZOAZD+dql9t7gvQ8O5jbtE0Aq/O5pk1b225+mOaZUh
         ES1qWDnev25gG1D1rlLQuF4nrIsHhK2hQtYPRC8mKpaQecDbyAaKILjjeXMNg3apNneP
         GCFdUT5ByHZF4QD7PELv/ZMbdct1SHX000mIypwKuzaWivstbj7UkEViNY0mH/65P0M+
         NlzBMB7Etk9HJXh3ehr2vFGuYZTesywcKNd2QR40L5GqKjS59wtTcAkELqN05AvS0SGQ
         HnWg==
X-Gm-Message-State: AOJu0Yz9gziGTPkTbRByDSUFkeDhVDtM6G/eh1y0DguhcmkdIsEUD+A7
	S8TbAHRc5jam7wdET+jrqECoaxvNJRFn8Iex/Fw=
X-Google-Smtp-Source: AGHT+IHmyT+BDnubFUp+Jb0pLxC4Tb3pLu3TEyp2o6yRiGEHv+YErvP2L3tunjy/w5RykwGs1HV9ktjImy0DvAlRONg=
X-Received: by 2002:a05:622a:40d:b0:423:78f7:5c66 with SMTP id
 n13-20020a05622a040d00b0042378f75c66mr6534860qtx.34.1700754110305; Thu, 23
 Nov 2023 07:41:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122715.2561213-1-amir73il@gmail.com> <20231122122715.2561213-6-amir73il@gmail.com>
 <ZV8Dk7UOLejEhzQN@infradead.org> <CAOQ4uxhxG_G6pjVTikakuUpru1XfaJoKWs4+HwNxCE5PxGTq_Q@mail.gmail.com>
 <ZV9sTfUfM9PU1IFw@infradead.org>
In-Reply-To: <ZV9sTfUfM9PU1IFw@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Nov 2023 17:41:38 +0200
Message-ID: <CAOQ4uxiDbGCn3vB4VwQyzdE9k8JjCeMGOqsVN=J5=-KCkvuQ2g@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] splice: remove permission hook from iter_file_splice_write()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 5:14=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Nov 23, 2023 at 01:20:13PM +0200, Amir Goldstein wrote:
> > >  - first obviously the name, based on the other functions it probably
> > >    should be in the __kernel_* namespace unless I'm missing something=
.
> >
> > Not sure about the best name.
> > I just derived the name from do_iter_readv_writev(), which would be the
> > name of this helper if we split up do_iter_readv_writev() as you sugges=
ted.
>
> Well, I don't think do_iter_readv_writev is a particular good name
> even now, but certainly not once it is more than just a static helper
> with two callers.
>
> I can't say __kernel is an all that great name either, but it seems
> to match the existing ones.
>
> That being said - it just is a tiny wrapper anyway, what about just
> open coding it instead of bike shedding?  See below for a patch,
> this actually seems pretty reasonable and very readable.
>

Heh! avoiding bike shedding is a worthy cause :)

It works for me.
I will let Christian decide if he prefers this over the existing
small helper with meaningless name.

> ---
> diff --git a/fs/splice.c b/fs/splice.c
> index d983d375ff1130..982a0872fa03e9 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -684,6 +684,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, =
struct file *out,
>
>         splice_from_pipe_begin(&sd);
>         while (sd.total_len) {
> +               struct kiocb kiocb;
>                 struct iov_iter from;
>                 unsigned int head, tail, mask;
>                 size_t left;
> @@ -733,7 +734,10 @@ iter_file_splice_write(struct pipe_inode_info *pipe,=
 struct file *out,
>                 }
>
>                 iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len =
- left);
> -               ret =3D vfs_iter_write(out, &from, &sd.pos, 0);
> +               init_sync_kiocb(&kiocb, out);
> +               kiocb.ki_pos =3D sd.pos;
> +               ret =3D out->f_op->write_iter(&kiocb, &from);
> +               sd.pos =3D kiocb.ki_pos;
>                 if (ret <=3D 0)
>                         break;
>

Are we open coding call_write_iter() now?
Is that a trend that I am not aware of?

Thanks,
Amir.

