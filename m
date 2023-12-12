Return-Path: <linux-fsdevel+bounces-5598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F43480DFD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895E81F21BF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 00:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC4128F5;
	Tue, 12 Dec 2023 00:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEGQGlbk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0CCB5;
	Mon, 11 Dec 2023 16:05:39 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so27538285e9.3;
        Mon, 11 Dec 2023 16:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702339538; x=1702944338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJqm47oqUAVnwI0gY1OnvcZG19zRvJLcZGKPSZ1E03Y=;
        b=GEGQGlbkE/9YJtCnfwCBzLVV0KrsKMQhm1yyS3lQu2MFyxjcl35vTlxqYD59b3SdYI
         TCrSpdU7c+Zhfg8YY31KzDaxXXDH0OHwpUp6eypMmnOdiB1oHl/tCLJZyecMvAfzUUDl
         cqWTEIygdUJUZmN6vViMa9PJjZBWl7HfT5haBISNW9PHeoTzEqTG7xZdRFl5G4Yjpa3I
         xtCRtWTaDd9HZcOyfPhtToQ21+n1uxL1syF8GtV9J9+uC/ab1/KXA32PVZxAWHHgRgWf
         LuTyCR0n50UwAwKT02IdzXMWfZ+yyW90f9tUKTHZ32Wk3WJdwHP+RR+dm1+CMH3UhDfB
         1gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702339538; x=1702944338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJqm47oqUAVnwI0gY1OnvcZG19zRvJLcZGKPSZ1E03Y=;
        b=vNLxlgn8bPH3IActdnpKOYrtiL69xg0vO7VcAB+XJxbKXmqbjlK32DMBNasjl+3fFz
         /YPkhh4slr++qh25XzOtkCVGxf9xDLgK7/XDilICUWjWfeyI+q92oEbaxkmgT3qTswQa
         wnS0I3ZFZAjcIzHLyUgn+KDtMkUvASg+IV9aVSrmT5oSetbGXBV3kPBLR9TaShnXQAvv
         fda/eztR4SV66tLqclB8rcHFKIwREImfQeklh+lOupI6QXg06n2UfWXKAHGXrvkJPH3r
         Wx7TVdMMo90/6HuD1xH7v3EHaZOrHyN1exOi9Zf1Q883ShvnyVgUoNWBO5NKnlHZFEl5
         Q43g==
X-Gm-Message-State: AOJu0Yx7RpoLIxvPNDd2TRRbvPWC42Yizlzqg0kVOrhsPWcHYNRe+rTD
	zViES9fkkqDF4q7uuLA6iw0yAnElEVq36xjSL84=
X-Google-Smtp-Source: AGHT+IHBooLx9JZdnzqTgpOW1++87YfMPROsWkvI+ymWpFlksGqOsrK4I+NSJlBRspuQp2tNC+WUceA43OZfE/1K+Z8=
X-Received: by 2002:a05:600c:204b:b0:40c:38dc:f6c8 with SMTP id
 p11-20020a05600c204b00b0040c38dcf6c8mr2788461wmg.172.1702339537910; Mon, 11
 Dec 2023 16:05:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207185443.2297160-1-andrii@kernel.org> <20231207185443.2297160-7-andrii@kernel.org>
 <657793942699a_edaa208bc@john.notmuch>
In-Reply-To: <657793942699a_edaa208bc@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Dec 2023 16:05:25 -0800
Message-ID: <CAEf4BzYZ0Xkme8pwWoXE5wvQhp+DzUixn3ueJMFmDqUk9Dox7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/8] libbpf: wire up BPF token support at BPF
 object level
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 2:56=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Andrii Nakryiko wrote:
> > Add BPF token support to BPF object-level functionality.
> >
> > BPF token is supported by BPF object logic either as an explicitly
> > provided BPF token from outside (through BPF FS path or explicit BPF
> > token FD), or implicitly (unless prevented through
> > bpf_object_open_opts).
> >
> > Implicit mode is assumed to be the most common one for user namespaced
> > unprivileged workloads. The assumption is that privileged container
> > manager sets up default BPF FS mount point at /sys/fs/bpf with BPF toke=
n
> > delegation options (delegate_{cmds,maps,progs,attachs} mount options).
> > BPF object during loading will attempt to create BPF token from
> > /sys/fs/bpf location, and pass it for all relevant operations
> > (currently, map creation, BTF load, and program load).
> >
> > In this implicit mode, if BPF token creation fails due to whatever
> > reason (BPF FS is not mounted, or kernel doesn't support BPF token,
> > etc), this is not considered an error. BPF object loading sequence will
> > proceed with no BPF token.
> >
> > In explicit BPF token mode, user provides explicitly either custom BPF
> > FS mount point path or creates BPF token on their own and just passes
> > token FD directly. In such case, BPF object will either dup() token FD
> > (to not require caller to hold onto it for entire duration of BPF objec=
t
> > lifetime) or will attempt to create BPF token from provided BPF FS
> > location. If BPF token creation fails, that is considered a critical
> > error and BPF object load fails with an error.
> >
> > Libbpf provides a way to disable implicit BPF token creation, if it
> > causes any troubles (BPF token is designed to be completely optional an=
d
> > shouldn't cause any problems even if provided, but in the world of BPF
> > LSM, custom security logic can be installed that might change outcome
> > dependin on the presence of BPF token). To disable libbpf's default BPF
> > token creation behavior user should provide either invalid BPF token FD
> > (negative), or empty bpf_token_path option.
> >
> > BPF token presence can influence libbpf's feature probing, so if BPF
> > object has associated BPF token, feature probing is instructed to use
> > BPF object-specific feature detection cache and token FD.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/btf.c             |   7 +-
> >  tools/lib/bpf/libbpf.c          | 120 ++++++++++++++++++++++++++++++--
> >  tools/lib/bpf/libbpf.h          |  28 +++++++-
> >  tools/lib/bpf/libbpf_internal.h |  17 ++++-
> >  4 files changed, 160 insertions(+), 12 deletions(-)
> >
>
> ...
>
> >
> > +static int bpf_object_prepare_token(struct bpf_object *obj)
> > +{
> > +     const char *bpffs_path;
> > +     int bpffs_fd =3D -1, token_fd, err;
> > +     bool mandatory;
> > +     enum libbpf_print_level level =3D LIBBPF_DEBUG;
>
> redundant set on level?
>

yep, removed initialization

> > +
> > +     /* token is already set up */
> > +     if (obj->token_fd > 0)
> > +             return 0;
> > +     /* token is explicitly prevented */
> > +     if (obj->token_fd < 0) {
> > +             pr_debug("object '%s': token is prevented, skipping...\n"=
, obj->name);
> > +             /* reset to zero to avoid extra checks during map_create =
and prog_load steps */
> > +             obj->token_fd =3D 0;
> > +             return 0;
> > +     }
> > +
> > +     mandatory =3D obj->token_path !=3D NULL;
> > +     level =3D mandatory ? LIBBPF_WARN : LIBBPF_DEBUG;
> > +
> > +     bpffs_path =3D obj->token_path ?: BPF_FS_DEFAULT_PATH;
> > +     bpffs_fd =3D open(bpffs_path, O_DIRECTORY, O_RDWR);
> > +     if (bpffs_fd < 0) {
> > +             err =3D -errno;
> > +             __pr(level, "object '%s': failed (%d) to open BPF FS moun=
t at '%s'%s\n",
> > +                  obj->name, err, bpffs_path,
> > +                  mandatory ? "" : ", skipping optional step...");
> > +             return mandatory ? err : 0;
> > +     }
> > +
> > +     token_fd =3D bpf_token_create(bpffs_fd, 0);
>
> Did this get tested on older kernels? In that case TOKEN_CREATE will
> fail with -EINVAL.

yep, I did actually test, it will generate expected *debug*-level
"failed to create BPF token" message

>
> > +     close(bpffs_fd);
> > +     if (token_fd < 0) {
> > +             if (!mandatory && token_fd =3D=3D -ENOENT) {
> > +                     pr_debug("object '%s': BPF FS at '%s' doesn't hav=
e BPF token delegation set up, skipping...\n",
> > +                              obj->name, bpffs_path);
> > +                     return 0;
> > +             }
>
> Isn't there a case here we should give a warning about?  If BPF_TOKEN_CRE=
ATE
> exists and !mandatory, but default BPFFS failed for enomem, or eperm reas=
ons?
> If the user reall/y doesn't want tokens here they should maybe override w=
ith
> -1 token? My thought is if you have delegations set up then something on =
the
> system is trying to configure this and an error might be ok? I'm asking j=
ust
> because I paused on it for a bit not sure either way at the moment. I mig=
ht
> imagine a lazy program not specifying the default bpffs, but also really
> thinking its going to get a valid token.

Interesting perspective! I actually came from the direction that BPF
token is not really all that common and expected thing, and so in
majority of cases (at least for some time) we won't be expecting to
have BPF FS with delegation options. So emitting a warning that
"something something BPF token failed" would be disconcerting to most
users.

What's the worst that would happen if BPF token was expected but we
failed to instantiate it? You'll get a BPF object load failure with
-EPERM, so it will be a pretty clear signal that whatever delegation
was supposed to happen didn't happen.

Also, if a user wants a BPF token for sure, they can explicitly set
bpf_token_path =3D "/sys/fs/bpf" and then it becomes mandatory.

So tl;dr, my perspective is that most users won't know or care about
BPF tokens. If sysadmin set up BPF FS correctly, it should just work
without the BPF application being aware. But for those rare cases
where a BPF token is expected and necessary, explicit bpf_token_path
or bpf_token_fd is the way to fail early, if something is not set up
the way it is expected.

>
>
> > +             __pr(level, "object '%s': failed (%d) to create BPF token=
 from '%s'%s\n",
> > +                  obj->name, token_fd, bpffs_path,
> > +                  mandatory ? "" : ", skipping optional step...");
> > +             return mandatory ? token_fd : 0;
> > +     }
> > +
> > +     obj->feat_cache =3D calloc(1, sizeof(*obj->feat_cache));
> > +     if (!obj->feat_cache) {
> > +             close(token_fd);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     obj->token_fd =3D token_fd;
> > +     obj->feat_cache->token_fd =3D token_fd;
> > +
> > +     return 0;
> > +}
> > +
> >  static int
> >  bpf_object__probe_loading(struct bpf_object *obj)
> >  {
> > @@ -4601,6 +4664,7 @@ bpf_object__probe_loading(struct bpf_object *obj)
> >               BPF_EXIT_INSN(),
> >       };
> >       int ret, insn_cnt =3D ARRAY_SIZE(insns);
> > +     LIBBPF_OPTS(bpf_prog_load_opts, opts, .token_fd =3D obj->token_fd=
);
> >
> >       if (obj->gen_loader)
> >               return 0;
> > @@ -4610,9 +4674,9 @@ bpf_object__probe_loading(struct bpf_object *obj)
> >               pr_warn("Failed to bump RLIMIT_MEMLOCK (err =3D %d), you =
might need to do it explicitly!\n", ret);
> >
> >       /* make sure basic loading works */
> > -     ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", i=
nsns, insn_cnt, NULL);
> > +     ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", i=
nsns, insn_cnt, &opts);
> >       if (ret < 0)
> > -             ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GP=
L", insns, insn_cnt, NULL);
> > +             ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GP=
L", insns, insn_cnt, &opts);
> >       if (ret < 0) {
> >               ret =3D errno;
> >               cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> > @@ -4635,6 +4699,9 @@ bool kernel_supports(const struct bpf_object *obj=
, enum kern_feature_id feat_id)
> >                */
> >               return true;
> >
> > +     if (obj->token_fd)
> > +             return feat_supported(obj->feat_cache, feat_id);
>
> OK that answers feat_supported() non null from earlier patch. Just
> was reading in order.
>

yep, no worries, that's what I assumed :)

> > +
> >       return feat_supported(NULL, feat_id);
> >  }
>
> ...
>
> >       btf_fd =3D bpf_object__btf_fd(obj);
> > @@ -7050,10 +7119,10 @@ static int bpf_object_init_progs(struct bpf_obj=
ect *obj, const struct bpf_object
> >  static struct bpf_object *bpf_object_open(const char *path, const void=
 *obj_buf, size_t obj_buf_sz,
> >                                         const struct bpf_object_open_op=
ts *opts)
> >  {
> > -     const char *obj_name, *kconfig, *btf_tmp_path;
> > +     const char *obj_name, *kconfig, *btf_tmp_path, *token_path;
> >       struct bpf_object *obj;
> >       char tmp_name[64];
> > -     int err;
> > +     int err, token_fd;
> >       char *log_buf;
> >       size_t log_size;
> >       __u32 log_level;
> > @@ -7087,6 +7156,20 @@ static struct bpf_object *bpf_object_open(const =
char *path, const void *obj_buf,
> >       if (log_size && !log_buf)
> >               return ERR_PTR(-EINVAL);
> >
> > +     token_path =3D OPTS_GET(opts, bpf_token_path, NULL);
> > +     token_fd =3D OPTS_GET(opts, bpf_token_fd, -1);
> > +     /* non-empty token path can't be combined with invalid token FD *=
/
> > +     if (token_path && token_path[0] !=3D '\0' && token_fd < 0)
> > +             return ERR_PTR(-EINVAL);
> > +     if (token_path && token_path[0] =3D=3D '\0') {
> > +             /* empty token path can't be combined with valid token FD=
 */
> > +             if (token_fd > 0)
> > +                     return ERR_PTR(-EINVAL);
> > +             /* empty token_path is equivalent to invalid token_fd */
> > +             token_path =3D NULL;
> > +             token_fd =3D -1;
> > +     }
> > +
> >       obj =3D bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
> >       if (IS_ERR(obj))
> >               return obj;
> > @@ -7095,6 +7178,23 @@ static struct bpf_object *bpf_object_open(const =
char *path, const void *obj_buf,
> >       obj->log_size =3D log_size;
> >       obj->log_level =3D log_level;
> >
> > +     obj->token_fd =3D token_fd <=3D 0 ? token_fd : dup_good_fd(token_=
fd);
> > +     if (token_fd > 0 && obj->token_fd < 0) {
> > +             err =3D -errno;
> > +             goto out;
> > +     }
> > +     if (token_path) {
> > +             if (strlen(token_path) >=3D PATH_MAX) {
>
> small nit, might be cleaner to just have this up where the other sanity
> checks are done? e.g.
>
>    `token_path[0] !=3D` `\0` && token_path(token_path) < PATH_MAX`
>
> just to abort earlier. But not sure I care much.

yep, makes sense, I'll move ENAMETOOLONG up

>
> > +                     err =3D -ENAMETOOLONG;
> > +                     goto out;
> > +             }
> > +             obj->token_path =3D strdup(token_path);
> > +             if (!obj->token_path) {
> > +                     err =3D -ENOMEM;
> > +                     goto out;
> > +             }
> > +     }
> > +
> >       btf_tmp_path =3D OPTS_GET(opts, btf_custom_path, NULL);
> >       if (btf_tmp_path) {
> >               if (strlen(btf_tmp_path) >=3D PATH_MAX) {

[...]

