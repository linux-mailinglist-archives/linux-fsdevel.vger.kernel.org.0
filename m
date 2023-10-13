Return-Path: <linux-fsdevel+bounces-350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE87C8FA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 23:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C271C211D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 21:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D542B5C9;
	Fri, 13 Oct 2023 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipyAs54/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35772B5C1;
	Fri, 13 Oct 2023 21:55:38 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6FACE;
	Fri, 13 Oct 2023 14:55:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso4573233a12.3;
        Fri, 13 Oct 2023 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697234135; x=1697838935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIsoon5ifapyRHJFHWDM6c5fi2ejPFzuYB8rlmAp+E4=;
        b=ipyAs54/+GsCk8OOtlvDe7OeTPzUwUccB2tNIm1ue+YjOu98ZTXVl162L7WgkJZo+P
         WoJZlgIqMacCliwLL79PaN4NLXaEZHvU8Rg8FoKxY7lRGy9hDlrXaLvGIZOu12r+Iwc0
         0ODhJFOfGZU1vKVqkVSsuFWXVVVvU6kBwfY3iop1WPwU0Nku6k5kjE/PwV1gP180OpEN
         cQh6oj6+ZsI9TgjHUSPHF9EU9vHjpaUuqVvDAwQgOIsSflrVK+JfagWN9a8Jzuy2NTd2
         gMzZNKQNT/EuuJJC6c69lyxKyJZJDbZXjWAgECzKE0seQHnpy6IC4y47HY4EP0wDAv8g
         PxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697234135; x=1697838935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIsoon5ifapyRHJFHWDM6c5fi2ejPFzuYB8rlmAp+E4=;
        b=PbpwYgKC0chNAeHkRimnW6A5YQqYTxRZN9/A9eIlw+imurdN1FFEYZKxzVikwgyrCd
         7fBOoUJywS5UukANQf4uOeavOnBrxbGuBsC7z0LWTWDwNhfYeUq6dqzDA7QVVecEVD9+
         0Sx2KTqyAyafgtebpdAvr5c9NTaySdIx0H/em5yXP5J6/kFZ5OimtutnrVMAvsNE2UWn
         gQ4qoO+UG+1wrPej1ZXbYzuaXUWKXhKjq9vNnWRLAk8MBsS5I2a8CdnHt+LtKs1CYihJ
         5B3bsj5QSOwMCuStAuFPfLpvJJ8aSyIsSpWiHU3jHAMdqlMmRjvzUjcOjAX0c4/8MjYh
         J6rA==
X-Gm-Message-State: AOJu0Yzo49JT/yH3hKXGAke33AIl7UYiglGxpXV4hSQ7wWZf4iRypbGd
	pzFwk25DeaEJy/tWHCqZw2ERw8GDPaoWmHdonJs=
X-Google-Smtp-Source: AGHT+IFRq0uCNp2DqUaQzM1voq5+iFisevdEN33yDgeV9vMFdHUgZLKLjCIYxV2ALVtrXgCkixX3qn+aEchlhlCXLQo=
X-Received: by 2002:a50:9fc1:0:b0:53e:2e0a:f5c6 with SMTP id
 c59-20020a509fc1000000b0053e2e0af5c6mr2895234edf.40.1697234135345; Fri, 13
 Oct 2023 14:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012222810.4120312-7-andrii@kernel.org> <f739928b1db9a9e45da89249c0389e85.paul@paul-moore.com>
In-Reply-To: <f739928b1db9a9e45da89249c0389e85.paul@paul-moore.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Oct 2023 14:55:24 -0700
Message-ID: <CAEf4BzZWDSZOyoVF+8pKBcvwjcpCC-XMG8J9kaJXXS=P+i5FmA@mail.gmail.com>
Subject: Re: [PATCH v7 6/18] bpf: add BPF token support to BPF_PROG_LOAD command
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 2:15=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Oct 12, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Add basic support of BPF token to BPF_PROG_LOAD. Wire through a set of
> > allowed BPF program types and attach types, derived from BPF FS at BPF
> > token creation time. Then make sure we perform bpf_token_capable()
> > checks everywhere where it's relevant.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h                           |  6 ++
> >  include/uapi/linux/bpf.h                      |  2 +
> >  kernel/bpf/core.c                             |  1 +
> >  kernel/bpf/inode.c                            |  6 +-
> >  kernel/bpf/syscall.c                          | 87 ++++++++++++++-----
> >  kernel/bpf/token.c                            | 27 ++++++
> >  tools/include/uapi/linux/bpf.h                |  2 +
> >  .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
> >  .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
> >  9 files changed, 110 insertions(+), 26 deletions(-)
>
> ...
>
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index a2c9edcbcd77..c6b00aee3b62 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2584,13 +2584,15 @@ static bool is_perfmon_prog_type(enum bpf_prog_=
type prog_type)
> >  }
> >
> >  /* last field in 'union bpf_attr' used by this command */
> > -#define      BPF_PROG_LOAD_LAST_FIELD log_true_size
> > +#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
> >
> >  static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uat=
tr_size)
> >  {
> >       enum bpf_prog_type type =3D attr->prog_type;
> >       struct bpf_prog *prog, *dst_prog =3D NULL;
> >       struct btf *attach_btf =3D NULL;
> > +     struct bpf_token *token =3D NULL;
> > +     bool bpf_cap;
> >       int err;
> >       char license[128];
> >
> > @@ -2606,10 +2608,31 @@ static int bpf_prog_load(union bpf_attr *attr, =
bpfptr_t uattr, u32 uattr_size)
> >                                BPF_F_XDP_DEV_BOUND_ONLY))
> >               return -EINVAL;
> >
> > +     bpf_prog_load_fixup_attach_type(attr);
> > +
> > +     if (attr->prog_token_fd) {
> > +             token =3D bpf_token_get_from_fd(attr->prog_token_fd);
> > +             if (IS_ERR(token))
> > +                     return PTR_ERR(token);
> > +             /* if current token doesn't grant prog loading permission=
s,
> > +              * then we can't use this token, so ignore it and rely on
> > +              * system-wide capabilities checks
> > +              */
> > +             if (!bpf_token_allow_cmd(token, BPF_PROG_LOAD) ||
> > +                 !bpf_token_allow_prog_type(token, attr->prog_type,
> > +                                            attr->expected_attach_type=
)) {
> > +                     bpf_token_put(token);
> > +                     token =3D NULL;
> > +             }
>
> At the start of this effort I mentioned how we wanted to have LSM
> control points when the token is created and when it is used.  It is
> for this reason that we still want a hook inside the
> bpf_token_allow_cmd() function as it allows us to enable/disable use
> of the token when its use is first attempted.  If the LSM decides to
> disallow use of the token in this particular case then the token is
> disabled (set to NULL) while the operation is still allowed to move
> forward, simply without the token.  It's a much cleaner and well
> behaved approach as it allows the normal BPF access controls to do
> their work.

I see, ok, so you want to be able to say "no BPF token for you", but
not just error out the entire operation. Makes sense.

>
> > +     }
> > +
> > +     bpf_cap =3D bpf_token_capable(token, CAP_BPF);
>
> Similar to the above comment, we want to a LSM control point in
> bpf_token_capable() so that the LSM can control the token's
> ability to delegate capability privileges when they are used.  Having
> to delay this access control point to security_bpf_prog_load() is not
> only awkward but it requires either manual synchronization between
> all of the different LSMs and the the capability checks in the
> bpf_prog_load() function or a completely different set of LSM
> permissions for a token-based BPF program load over a normal BPF
> program load.
>
> We really need these hooks Andrii, I wouldn't have suggested them if
> I didn't believe they were important.

No problem, I'll add both of them. I really didn't want to add hooks
for allow_{maps,progs,attachs} (which you agreed shouldn't be added,
so we are good), but I think allow_cmds and capable checks are fine.
Will add in the next revision.

>
> > +     err =3D -EPERM;
> > +
> >       if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
> >           (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
> > -         !bpf_capable())
> > -             return -EPERM;
> > +         !bpf_cap)
> > +             goto put_token;
> >

[...]

