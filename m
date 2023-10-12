Return-Path: <linux-fsdevel+bounces-140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBA07C61BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 02:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB26E1C20FE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 00:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32031806;
	Thu, 12 Oct 2023 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erj0gbLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3B46AB;
	Thu, 12 Oct 2023 00:30:33 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1497B7;
	Wed, 11 Oct 2023 17:30:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50437c618b4so531147e87.2;
        Wed, 11 Oct 2023 17:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697070629; x=1697675429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOQKGKgrEKtwHvDcFP3a3XVxI7lgT518seuCIoqgo2o=;
        b=erj0gbLyRA1uGaCPDtpjN5Y8M7i8Z/dndbAF4v97d/J1ZGGSEkO3zXXK0Nulr+JseD
         l/7ha232R9NSAHnhqpp+ivKyOeEIcABUah657SG/dQiQTuY136CxVmxSSZVwepuPYD61
         Q5MEuMAVU6gMo/FsZFshUTP6FoSVKnsw99sE2hdy9Fu2uvinSsXMPckJnG/j9rC+g77v
         E2+nzAy1yjZerTtDVMTW6eBnyWGiXcCqHiquwTmitsW4minNhgca758x+ifB1vr5NTlM
         LE2xwU93zbbMUtOawGWz43S3ro0uzNf2ggGVS/+LKfNwwcvrpO7urHJAB8l8JAJv8N3p
         5ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070629; x=1697675429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOQKGKgrEKtwHvDcFP3a3XVxI7lgT518seuCIoqgo2o=;
        b=G8z181EIIDBLg5xnicOFczP9m1gsDZhKqELaKwuOEgUeKQhIE07zsLjTvFbvTn1tGx
         zOiIU1VmQp5HLGEjI7/Yo3i8Xm2d1Mzwzc810yGDcbUpjwZH7wW3XcbLDJJFd83dLa2d
         +spUqu8pr5Qr+5utPg3obHQSIBEI0+fhUhHz8uxojNRBQxhpjyXuBqCazIZ8FgpRtcl0
         pN2+efbn1m08NOU1kDlChkfiwUNtBv2s2EVwKtp+fbkNxXOW6+A47e+/Gjv3b6wp1x/p
         Abmad8UFZ9Ol/KiEAnoMmCAxihou2tKZ9hJMdc7pYUSlmxwZvz8u+Ro3+UOif0pU9hQt
         f2Sg==
X-Gm-Message-State: AOJu0Yxs0wu9BgUOghEnJwn6PJ4adXEBIanAZw8DSKNq4rXFnTF5eHoj
	mFmX2ounxnLvnPX0g8sB4p6DK8J/OMIGXTH/gEI=
X-Google-Smtp-Source: AGHT+IHwX+1erUQkcTYNpLy9PQ+yQBU4hzsvlqyDqFZZhjr+6cYworstpjzmrHc33wh5hnDbO33nVi/csu2P12XNvsI=
X-Received: by 2002:ac2:4570:0:b0:502:d86d:6b26 with SMTP id
 k16-20020ac24570000000b00502d86d6b26mr15552375lfm.50.1697070628754; Wed, 11
 Oct 2023 17:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927225809.2049655-1-andrii@kernel.org> <20230927225809.2049655-3-andrii@kernel.org>
 <02a63a35-7a0c-503b-eb24-774300e86841@huaweicloud.com>
In-Reply-To: <02a63a35-7a0c-503b-eb24-774300e86841@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Oct 2023 17:30:17 -0700
Message-ID: <CAEf4BzakCJHvPibso_bsPhYdXo9YyHuwPiLebLdvq0DonAFJ+Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 02/13] bpf: add BPF token delegation mount
 options to BPF FS
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 12:09=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
>
>
> On 9/28/2023 6:57 AM, Andrii Nakryiko wrote:
> > Add few new mount options to BPF FS that allow to specify that a given
> > BPF FS instance allows creation of BPF token (added in the next patch),
> > and what sort of operations are allowed under BPF token. As such, we ge=
t
> > 4 new mount options, each is a bit mask
> >   - `delegate_cmds` allow to specify which bpf() syscall commands are
> >     allowed with BPF token derived from this BPF FS instance;
> >   - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifies
> >     a set of allowable BPF map types that could be created with BPF tok=
en;
> >   - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifies
> >     a set of allowable BPF program types that could be loaded with BPF =
token;
> >   - if BPF_PROG_LOAD command is allowed, `delegate_attachs` specifies
> >     a set of allowable BPF program attach types that could be loaded wi=
th
> >     BPF token; delegate_progs and delegate_attachs are meant to be used
> >     together, as full BPF program type is, in general, determined
> >     through both program type and program attach type.
> >
> > Currently, these mount options accept the following forms of values:
> >   - a special value "any", that enables all possible values of a given
> >   bit set;
> >   - numeric value (decimal or hexadecimal, determined by kernel
> >   automatically) that specifies a bit mask value directly;
> >   - all the values for a given mount option are combined, if specified
> >   multiple times. E.g., `mount -t bpf nodev /path/to/mount -o
> >   delegate_maps=3D0x1 -o delegate_maps=3D0x2` will result in a combined=
 0x3
> >   mask.
> >
> SNIP
> >       return 0;
> > @@ -740,10 +786,14 @@ static int populate_bpffs(struct dentry *parent)
> >  static int bpf_fill_super(struct super_block *sb, struct fs_context *f=
c)
> >  {
> >       static const struct tree_descr bpf_rfiles[] =3D { { "" } };
> > -     struct bpf_mount_opts *opts =3D fc->fs_private;
> > +     struct bpf_mount_opts *opts =3D sb->s_fs_info;
> >       struct inode *inode;
> >       int ret;
> >
> > +     /* Mounting an instance of BPF FS requires privileges */
> > +     if (fc->user_ns !=3D &init_user_ns && !capable(CAP_SYS_ADMIN))
> > +             return -EPERM;
> > +
> >       ret =3D simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
> >       if (ret)
> >               return ret;
> > @@ -765,7 +815,10 @@ static int bpf_get_tree(struct fs_context *fc)
> >
> >  static void bpf_free_fc(struct fs_context *fc)
> >  {
> > -     kfree(fc->fs_private);
> > +     struct bpf_mount_opts *opts =3D fc->s_fs_info;
> > +
> > +     if (opts)
> > +             kfree(opts);
> >  }
> >
>
> The NULL check is not needed here, use kfree(fc->s_fs_info) will be enoug=
h.

yep, dropped the check


> >  static const struct fs_context_operations bpf_context_ops =3D {
> > @@ -787,17 +840,32 @@ static int bpf_init_fs_context(struct fs_context =
*fc)
> >
> >       opts->mode =3D S_IRWXUGO;
> >
> > -     fc->fs_private =3D opts;
> > +     /* start out with no BPF token delegation enabled */
> > +     opts->delegate_cmds =3D 0;
> > +     opts->delegate_maps =3D 0;
> > +     opts->delegate_progs =3D 0;
> > +     opts->delegate_attachs =3D 0;
> > +
> > +     fc->s_fs_info =3D opts;
> >       fc->ops =3D &bpf_context_ops;
> >       return 0;
> >  }
> >
> > +static void bpf_kill_super(struct super_block *sb)
> > +{
> > +     struct bpf_mount_opts *opts =3D sb->s_fs_info;
> > +
> > +     kill_litter_super(sb);
> > +     kfree(opts);
> > +}
> > +
> >  static struct file_system_type bpf_fs_type =3D {
> >       .owner          =3D THIS_MODULE,
> >       .name           =3D "bpf",
> >       .init_fs_context =3D bpf_init_fs_context,
> >       .parameters     =3D bpf_fs_parameters,
> > -     .kill_sb        =3D kill_litter_super,
> > +     .kill_sb        =3D bpf_kill_super,
> > +     .fs_flags       =3D FS_USERNS_MOUNT,
> >  };
> >
> >  static int __init bpf_init(void)
>
>

