Return-Path: <linux-fsdevel+bounces-7027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C782022C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 23:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC701F22EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2A14283;
	Fri, 29 Dec 2023 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aP1vJwDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93FB14AA1
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Dec 2023 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so2709763b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Dec 2023 14:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703889080; x=1704493880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKuwmPo0DfBIWzAt1z512mSnZOucjghMMfliRHXEH1s=;
        b=aP1vJwDInt8gYlakcnK3OUNMmlxanL3bkhPp6jxwrknpA+SzJhpVBN16YEnkIXBHzf
         hXG7BxmOtAHopuef1ni8nAUK1jiJ1LnjDdPIjblVpVfke+zbKsA873ZbiOBpLkS3CEYT
         B4fRjJ8/nKwl5nP6HDh75QwiUY5ax09NGBiazXHLZisO+hDDxPvRybbWXxsuE7oNVx58
         2FJM/9D8VCvpG52TUKFfhWt3fNOtMrC1ZMxSPrm2Dq/xIO7v6uj9qftLfLlsi1IdvGca
         cnfI1f0pMrLLbbyUenmd8nIuJb8WH3JoXeLCWHSLSoEIGxrCW3kYLS78cPR94IXXYhop
         ml0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703889080; x=1704493880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKuwmPo0DfBIWzAt1z512mSnZOucjghMMfliRHXEH1s=;
        b=qkN7YliAHxh39fkBoS8ZetuIxrssxmry1aFn+Lsisl54gRhOZv5A7X3cfx51Hr5Ruf
         gL0gDKeO62lqtZR+qF4qEH0JLpBrVJMZ3bCMzFKJ9O3t9tQ+6G8ZOtTr6to9RSeGKxPy
         xaXQocMEfXOGsEi3ezWOfC6yHx1gPQB//IwO8/4KS8gyFv51DbP7XY6B3feO8KnHrvbf
         Zd/KTv5Hv/0P2lJoMSXm0egzMUoQYUZVzUfr/MOL335935AE1VGk5BF+poe5MaalRtJ9
         kSa8dmJRUj7YlvB9YVbog/18uy9NtW0hgoHX33VSBD8G645fyIP2F0GcR1b3379hdEj6
         jvIw==
X-Gm-Message-State: AOJu0Yxg+KMtKOTy5pKjBn5OesapfPznGTOQhzr0DFbIu6htXIBhT1Bv
	T6OpBDybmzA1XNqm9PBviRGr6hmyOr3RPySMNe08L3lTcQod
X-Google-Smtp-Source: AGHT+IH12p3W0EY0p2NLPuPUYmviE7rijb7+Yqlz23Ciy+fi2PqGwDl7fAvtLAZVWy+vn0LPl9k2jB9xmjX76ZOvJYg=
X-Received: by 2002:a05:6808:1206:b0:3bb:e0d4:9f29 with SMTP id
 a6-20020a056808120600b003bbe0d49f29mr1864931oil.44.1703889079797; Fri, 29 Dec
 2023 14:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de> <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner> <CAADnVQKeUmV88OfQOfiX04HjKbXq7Wfcv+N3O=5kdL4vic6qrw@mail.gmail.com>
 <20231216-vorrecht-anrief-b096fa50b3f7@brauner> <CAADnVQK7MDUZTUxcqCH=unrrGExCjaagfJFqFPhVSLUisJVk_Q@mail.gmail.com>
 <20231218-chipsatz-abfangen-d62626dfb9e2@brauner> <CAHC9VhSZDMWJ_kh+RaB6dsPLQjkrjDY4bVkqsFDG3JtjinT_bQ@mail.gmail.com>
 <f38ceaaf-916a-4e44-9312-344ed1b4c9c4@aisec.fraunhofer.de>
In-Reply-To: <f38ceaaf-916a-4e44-9312-344ed1b4c9c4@aisec.fraunhofer.de>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Dec 2023 17:31:08 -0500
Message-ID: <CAHC9VhT3dbFc4DWc8WFRavWY1M+_+DzPbHuQ=PumROsx0rY2vA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
To: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, gyroidos@aisec.fraunhofer.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 9:31=E2=80=AFAM Michael Wei=C3=9F
<michael.weiss@aisec.fraunhofer.de> wrote:
> Hi Paul, what would you think about if we do it as shown in the
> patch below (untested)?
>
> I have adapted Christians patch slightly in a way that we do let
> all LSMs agree on if device access management should be done or not.
> Similar to the security_task_prctl() hook.

I think it's worth taking a minute to talk about this proposed change
and the existing security_task_prctl() hook, as there is an important
difference between the two which is the source of my concern.

If you look at the prctl() syscall implementation, right at the top of
the function you see the LSM hook:

  SYSCALL_DEFINE(prctl, ...)
  {
    ...

    error =3D security_task_prctl(...);
    if (error !=3D -ENOSYS)
      return error;

    error =3D 0;

    ....
  }

While it is true that the LSM hook returns a "special" value, -ENOSYS,
from a practical perspective this is not significantly different from
the much more common zero value used to indicate no restriction from
the LSM layer.  However, the more important thing to note is that the
return value from security_task_prctl() does not influence any other
access controls in the caller outside of those implemented inside the
LSM; in fact the error code is reset to zero immediately after the LSM
hook.

More on this below ...

> diff --git a/fs/super.c b/fs/super.c
> index 076392396e72..6510168d51ce 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -325,7 +325,7 @@ static struct super_block *alloc_super(struct file_sy=
stem_type *type, int flags,
>  {
>         struct super_block *s =3D kzalloc(sizeof(struct super_block),  GF=
P_USER);
>         static const struct super_operations default_op;
> -       int i;
> +       int i, err;
>
>         if (!s)
>                 return NULL;
> @@ -362,8 +362,16 @@ static struct super_block *alloc_super(struct file_s=
ystem_type *type, int flags,
>         }
>         s->s_bdi =3D &noop_backing_dev_info;
>         s->s_flags =3D flags;
> -       if (s->s_user_ns !=3D &init_user_ns)
> +
> +       err =3D security_sb_device_access(s);
> +       if (err < 0 && err !=3D -EOPNOTSUPP)
> +               goto fail;
> +
> +       if (err && s->s_user_ns !=3D &init_user_ns)
>                 s->s_iflags |=3D SB_I_NODEV;
> +       else
> +               s->s_iflags |=3D SB_I_MANAGED_DEVICES;

This is my concern, depending on what the LSM hook returns, the
superblock's flags are set differently, affecting much more than just
a LSM-based security mechanism.

LSMs should not be able to undermine, shortcut, or otherwise bypass
access controls built into other parts of the kernel.  In other words,
a LSM should only ever be able to deny an operation, it should not be
able to permit an operation that otherwise would have been denied.

>         INIT_HLIST_NODE(&s->s_instances);
>         INIT_HLIST_BL_HEAD(&s->s_roots);
>         mutex_init(&s->s_sync_lock);

--=20
paul-moore.com

