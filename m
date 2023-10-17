Return-Path: <linux-fsdevel+bounces-513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E447CBFD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 11:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712162818FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57032405FB;
	Tue, 17 Oct 2023 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr+c6v55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D7381D8
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 09:45:52 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716F78E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 02:45:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d36b2a247so20379826d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697535950; x=1698140750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K8yTy9C12yEGh5lGBpdn6/HEaPH1gqB1lhG2qMrBfw=;
        b=Qr+c6v55lYnygwGPT2JgI99e2TXcCfwhdz7Tw4nWITlpLhVfl0q1MAgQFFZ2d0HKz/
         Jl1ZyOcqN0VT3adibxMdPqMcktn1UKPtilAwsD59CoV4XphA/Eb2dVCg8dlPH3EB+i8S
         JN5shirmgIRpMXRIsYhDrGGiwhRMP0QUcK8MVmHABUXfY6pCkLBB9B8FWWo0Jy+tOFw8
         LzP/GBz1cCz3+/IB34oJdmiO+imz/r9yFC3L/7NyY1Mte+pP5YA5ZdJ5OstPd/PZC5lr
         hkx/CJ/eZm0iHm1vnySsFtgHsGQMpImnm4IzdpCNNComBfj21e9zmpsb3X3bKZVcelfC
         1Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535950; x=1698140750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/K8yTy9C12yEGh5lGBpdn6/HEaPH1gqB1lhG2qMrBfw=;
        b=nYe9QNZ6Mq5pfWZGsiu/LanptXjFC98Gg203WvdQiUkHC6ZQ9ILMVEL5ZGL5t4/yW7
         3IiGpBAoMNeR3sjWHDqKg2yKfgYGTpAcaOp0GRdfJTs49oyDNJQO7dBMpWBPLmrl7gPN
         C9Yv4P2Jj+2SZVDHjEmbzJBGjWx74gSV1KBk9HYReoUuD5cOCEwFMgDo7RRR+CIdzIYa
         29vsJQfmREsMhPkFC7Fgy60pByR6BOZDwXVs+eECqBTORMx0vt9MfkaLIMAcYqade71r
         3/zyEaIFn6cxj3OyqOcG2SAVH1+J7uYgR1x138U9CV2GxZTTGmfqSZ8jMr2zU8vZ75YH
         AjIg==
X-Gm-Message-State: AOJu0YykUOXNAF0w/RyYJ4WV1LmYe6tS20MYrL9tXXd52aZKyzgi2n/E
	zNnaXbvGkiNtQeTd1mU315eAWaRO3Yhnol0Df6QPsFoTw90=
X-Google-Smtp-Source: AGHT+IHUuc3ID0kV+JzyDedjVffFxiC2l+8sgvzd3B0WRTYO/OG7MuGWg6VDA3rJyAZTh7AJreqTlbPrawQkjZKtYaI=
X-Received: by 2002:ad4:5f0f:0:b0:658:8f94:5e61 with SMTP id
 fo15-20020ad45f0f000000b006588f945e61mr2353789qvb.43.1697535950491; Tue, 17
 Oct 2023 02:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <20231016160902.2316986-9-amir73il@gmail.com>
In-Reply-To: <20231016160902.2316986-9-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Oct 2023 12:45:39 +0300
Message-ID: <CAOQ4uxijCjSb3gRd+qZ=gs-JvujFpCvJhJ=nXTkmP11LjU2TZQ@mail.gmail.com>
Subject: Re: [PATCH v14 08/12] fuse: implement ioctls to manage backing files
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 7:09=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> FUSE server calls the FUSE_DEV_IOC_BACKING_OPEN ioctl with a backing file
> descriptor.  If the call succeeds, a backing file identifier is returned.
>
> A later reply to OPEN request with the flag FOPEN_PASSTHROUGH will setup
> passthrough of file operations on the open FUSE file to the backing file
> associated with the id.  If there is no backing file associated with id,
> FOPEN_PASSTHROUGH flag is ignored.
>
> The FUSE server may call FUSE_DEV_IOC_BACKING_CLOSE ioctl to close the
> backing file by its id.
> If there is no backing file with that id, -ENOENT is returned.
>
> This can be done at any time, but if an open reply with FOPEN_PASSTHROUGH
> flag is still in progress, the open may or may not end up setting up the
> passthrough to the backing file.
>
> In any case, the backing file will be kept open by the FUSE driver until
> the last fuse_file that was setup to passthrough to that backing file is
> closed AND the FUSE_DEV_IOC_BACKING_CLOSE ioctl was called.
>
> Setting up backing files requires a server with CAP_SYS_ADMIN privileges.
> For the backing file to be successfully setup, the backing file must
> implement both read_iter and write_iter file operations.
>
> The limitation on the level of filesystem stacking allowed for the
> backing file is enforced before setting up the backing file.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

[...]

> +int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map=
)
> +{
> +       struct file *file;
> +       struct super_block *backing_sb;
> +       struct fuse_backing *fb =3D NULL;
> +       int res;
> +
> +       pr_debug("%s: fd=3D%d flags=3D0x%x\n", __func__, map->fd, map->fl=
ags);
> +
> +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> +       res =3D -EPERM;
> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +               goto out;
> +
> +       res =3D -EINVAL;
> +       if (map->flags)
> +               goto out;
> +
> +       file =3D fget(map->fd);
> +       res =3D -EBADF;
> +       if (!file)
> +               goto out;
> +
> +       res =3D -EOPNOTSUPP;
> +       if (!file->f_op->read_iter || !file->f_op->write_iter)
> +               goto out_fput;
> +

Miklos,

I need to clarify one thing regarding this patch.
Your suggestion was:

- mapping request is done with an O_PATH fd.
- fuse_open() always opens a backing file (just like overlayfs)

The reason I did not use fget_raw() to support O_PATH fd is
because I wanted to keep the EOPNOTSUPP check above
at ioctl time rather than deferring it to open/create reply time,
when the user has no feedback of failure reasons.

We could add O_PATH support later, but I think it is going to be
more important when we support passthrough to inode operations
and the limitation of requiring a non O_PATH fd is not is not that bad.
It also serves as a proof that the server user is allowed to open the
backing file for read/write and avoid the later permission failure of
backing_file_open().

Thanks,
Amir.

