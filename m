Return-Path: <linux-fsdevel+bounces-4329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456B57FE931
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 07:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017D22821C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08F920DD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj70Yu4M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769CE10F0;
	Wed, 29 Nov 2023 22:10:27 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db35caa1749so495518276.2;
        Wed, 29 Nov 2023 22:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701324626; x=1701929426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5XiZjen14/K+0w9luOMpmzkY5MJrhT/4bY/9yI/Mas=;
        b=Qj70Yu4MiOjzP8XVkEuB7py+zW/8F1ZeuRp4DXSxPncjXA/UOF1IhFx1cB5BpWrNEO
         r9/lsF5Wx6uuFO1GBR3NDGnzkvmaO+ki3GZGouNNTukv9ylFcUp6QtQ4CLFWa2/5z+Oe
         q7zcLXg6dbb+TL5Wtc9JvWuGvQix/rz4hcAU+qY8Vv6Qq+p4YfysuEtpjXF64qam9Muz
         4ReCzwdIr6iQhPWduEzR1HMTEAHCvhVaS9d87NJCzKW+UUEfM4wsmviTCrdvuP+YTuAa
         AItupIetdg5w4plDoGPgqTUr380OzyQvQDMYJlJUJPG3k1EjuvzdhU+RBszuE5GT86Go
         1Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701324626; x=1701929426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5XiZjen14/K+0w9luOMpmzkY5MJrhT/4bY/9yI/Mas=;
        b=HqCgz9hSxfpk7agIa4jErej74PHlYXkxb4sgoMT3pPG5cKNiLcT56TtzExaUXwlGzn
         zUxsisUOeDTJTrpWeiFEliLB6mQd+xp9RA5faMnqdIN0P7w4piARunM+NehYHiP6dJ44
         lRNuzgeCaTJ9Jl2qrcSmw108olO7cH6McbFgvdwTiyqNP1fkRawvG1mJGRrjMtLFODSI
         Fi5XplxaydIUJ/+5lClDY2tVbpn9/8h1YUjk3zX+VeISjBnK3jYczXzXyq+zwCGtnJ2S
         /Yn1EMxpLe6w9elXy3fbalT1Ic1JuTmN1N2LUS4rZrFO0DGg6kUbYpD9RDiqj4oHDbFe
         KNCA==
X-Gm-Message-State: AOJu0YwXl1IKcWJtChFQc5wnNH/2nZJKrBBY9+jWLfb10uBpqDeqttlT
	DuvvAA1ikBO/HGmdme+/WnGpH+SuVZzJF+aflss=
X-Google-Smtp-Source: AGHT+IFPm8IsiH5sKV0Ey2tYaUtFxy9F7Bg8OxPwkD3dpwJybG4qrzFtmrVhWXTUvKIjV5qtFCbjFDDzusV4A688rzU=
X-Received: by 2002:a25:d78b:0:b0:db5:3c77:4d5b with SMTP id
 o133-20020a25d78b000000b00db53c774d5bmr348961ybg.8.1701324626581; Wed, 29 Nov
 2023 22:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org> <20231129-idmap-fscap-refactor-v1-16-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-16-da5a26058a5b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 08:10:15 +0200
Message-ID: <CAOQ4uxhtJ89LknKjE=tiTgvZXbufmOaqHnhnrz348Ktq2H+yHA@mail.gmail.com>
Subject: Re: [PATCH 16/16] vfs: return -EOPNOTSUPP for fscaps from vfs_*xattr()
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:51=E2=80=AFPM Seth Forshee (DigitalOcean)
<sforshee@kernel.org> wrote:
>
> Now that the new vfs-level interfaces are fully supported and all code
> has been converted to use them, stop permitting use of the top-level vfs
> xattr interfaces for capabilities xattrs. Unlike with ACLs we still need
> to be able to work with fscaps xattrs using lower-level interfaces in a
> handful of places, so only use of the top-level xattr interfaces is
> restricted.

Can you explain why?
Is there an inherent difference between ACLs and fscaps in that respect
or is it just a matter of more work that needs to be done?

>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  fs/xattr.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 372644b15457..4b779779ad8c 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -540,6 +540,9 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *=
dentry,
>         const void  *orig_value =3D value;
>         int error;
>
> +       if (!strcmp(name, XATTR_NAME_CAPS))
> +               return -EOPNOTSUPP;
> +

It this is really not expected, then it should be an assert and
please use an inline helper like is_posix_acl_xattr():

if (WARN_ON_ONCE(is_fscaps_xattr(name)))

It wouldn't hurt to add those assertions to is_posix_acl_xattr()
cases as well, but that is unrelated to your change.

Thanks,
Amir.

