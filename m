Return-Path: <linux-fsdevel+bounces-141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57A7C61C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 02:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E372828B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 00:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF50809;
	Thu, 12 Oct 2023 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWvk7xqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2E655;
	Thu, 12 Oct 2023 00:31:10 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE683C0;
	Wed, 11 Oct 2023 17:30:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so407298a12.0;
        Wed, 11 Oct 2023 17:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697070652; x=1697675452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHLUOXGRgv70grupvOlRAwcra1ndxpp85X2gzbRnMYo=;
        b=gWvk7xqxuNFkk8k6dsZga6YX37c+nsksou2oszuXuQbxicPnkg65o1/llCA9lgpi9i
         4zufgenRjV75HlCiyh7asJXkmUXg47ziFou9kmvjhSkM8xGFOTGUBm9y8nxOVJOpgRAg
         HdUc4FSi6iqBBMft4ojxbjDgU7oePRN2aAmcDqm9NZOCFKrfaSNRS9VhgFVvjX2cYaai
         T6pooKVnQjEZ4cbUdyZnbOBHXIvDoCqMOA7sgB2xRN45xVdKDC+LiLdm0rIVaJhG5KLc
         tUeXkAxFjvupipBvOgD1KUKgJhUz4CIy9wTZFKnVwn3XZmoJVMdhueO53bNiRuLBq7cl
         3XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070652; x=1697675452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHLUOXGRgv70grupvOlRAwcra1ndxpp85X2gzbRnMYo=;
        b=RfIwUn9QcdyxW/jcoiYeyMQyQGgBqtJiRR8OMeHB7r4fqBPAjyP0zCioObOBJzOKXE
         jXf0Tktkl4egT2srMYteGmvFXU9+EYZffu/VePd4/ObXY+PTRldZPZe1aOss8LzGNjAO
         zuolNRc6vyVh3z0osc5GTFvvOwr91KVg4gqRbIjnoFZrZZ7I6XNN/7HF+cSei8SsrlrU
         4pG6rhT3kwJW6ydzkqOn+/L4kjGnH5lsVKGtoVGOuYgyD3KmyzqSicUNjX2q4a3pHdbX
         kSOVdYIFpyj6/qlciAhrU3BIlo96g1AQFeNde6WtQNFzANTJt8dHenChvsnOxKAvKZK0
         A02g==
X-Gm-Message-State: AOJu0YxMqhLK+/s1wMcZ6rHBAGx+yo5hYqGxD8eBS7jzO2+tXZrjz9Ab
	clRT1qkpLz8Vd4lHCED8Fyion32MG4U7A/dkwHc=
X-Google-Smtp-Source: AGHT+IHILym3JQev+GuI8riMltJD3GlU/vIaZDwjbXAdyxG5lkm4BpMx7HtzkF6oa2jOTydfRnyOCOiXra8zguRfwXA=
X-Received: by 2002:a05:6402:785:b0:523:ae0a:a446 with SMTP id
 d5-20020a056402078500b00523ae0aa446mr22494874edy.24.1697070651466; Wed, 11
 Oct 2023 17:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927225809.2049655-1-andrii@kernel.org> <20230927225809.2049655-5-andrii@kernel.org>
 <ZSUM5A+dJHptbRSx@krava>
In-Reply-To: <ZSUM5A+dJHptbRSx@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Oct 2023 17:30:40 -0700
Message-ID: <CAEf4BzbK4u5SrvskwxkzOvcNCA5tnHNw6HWts2ri9mH2=8EcHw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 04/13] bpf: add BPF token support to
 BPF_MAP_CREATE command
To: Jiri Olsa <olsajiri@gmail.com>
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

On Tue, Oct 10, 2023 at 1:35=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Sep 27, 2023 at 03:58:00PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > -#define BPF_MAP_CREATE_LAST_FIELD map_extra
> > +#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
> >  /* called via syscall */
> >  static int map_create(union bpf_attr *attr)
> >  {
> >       const struct bpf_map_ops *ops;
> > +     struct bpf_token *token =3D NULL;
> >       int numa_node =3D bpf_map_attr_numa_node(attr);
> >       u32 map_type =3D attr->map_type;
> >       struct bpf_map *map;
> > @@ -1157,14 +1158,32 @@ static int map_create(union bpf_attr *attr)
> >       if (!ops->map_mem_usage)
> >               return -EINVAL;
> >
> > +     if (attr->map_token_fd) {
> > +             token =3D bpf_token_get_from_fd(attr->map_token_fd);
> > +             if (IS_ERR(token))
> > +                     return PTR_ERR(token);
> > +
> > +             /* if current token doesn't grant map creation permission=
s,
> > +              * then we can't use this token, so ignore it and rely on
> > +              * system-wide capabilities checks
> > +              */
> > +             if (!bpf_token_allow_cmd(token, BPF_MAP_CREATE) ||
> > +                 !bpf_token_allow_map_type(token, attr->map_type)) {
> > +                     bpf_token_put(token);
> > +                     token =3D NULL;
> > +             }
> > +     }
> > +
> > +     err =3D -EPERM;
> > +
> >       /* Intent here is for unprivileged_bpf_disabled to block BPF map
> >        * creation for unprivileged users; other actions depend
> >        * on fd availability and access to bpffs, so are dependent on
> >        * object creation success. Even with unprivileged BPF disabled,
> >        * capability checks are still carried out.
> >        */
> > -     if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> > -             return -EPERM;
> > +     if (sysctl_unprivileged_bpf_disabled && !bpf_token_capable(token,=
 CAP_BPF))
> > +             goto put_token;
> >
> >       /* check privileged map type permissions */
> >       switch (map_type) {
> > @@ -1197,25 +1216,27 @@ static int map_create(union bpf_attr *attr)
> >       case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> >       case BPF_MAP_TYPE_STRUCT_OPS:
> >       case BPF_MAP_TYPE_CPUMAP:
> > -             if (!bpf_capable())
> > -                     return -EPERM;
> > +             if (!bpf_token_capable(token, CAP_BPF))
> > +                     goto put_token;
> >               break;
> >       case BPF_MAP_TYPE_SOCKMAP:
> >       case BPF_MAP_TYPE_SOCKHASH:
> >       case BPF_MAP_TYPE_DEVMAP:
> >       case BPF_MAP_TYPE_DEVMAP_HASH:
> >       case BPF_MAP_TYPE_XSKMAP:
> > -             if (!bpf_net_capable())
> > -                     return -EPERM;
> > +             if (!bpf_token_capable(token, CAP_NET_ADMIN))
> > +                     goto put_token;
> >               break;
> >       default:
> >               WARN(1, "unsupported map type %d", map_type);
> > -             return -EPERM;
> > +             goto put_token;
> >       }
> >
> >       map =3D ops->map_alloc(attr);
> > -     if (IS_ERR(map))
> > -             return PTR_ERR(map);
> > +     if (IS_ERR(map)) {
> > +             err =3D PTR_ERR(map);
> > +             goto put_token;
> > +     }
> >       map->ops =3D ops;
> >       map->map_type =3D map_type;
> >
> > @@ -1252,7 +1273,7 @@ static int map_create(union bpf_attr *attr)
> >               map->btf =3D btf;
> >
> >               if (attr->btf_value_type_id) {
> > -                     err =3D map_check_btf(map, btf, attr->btf_key_typ=
e_id,
> > +                     err =3D map_check_btf(map, token, btf, attr->btf_=
key_type_id,
> >                                           attr->btf_value_type_id);
> >                       if (err)
> >                               goto free_map;
>
> I might be missing something, but should we call bpf_token_put(token)
> on non-error path as well? probably after bpf_map_save_memcg call

Not missing anything. I used to keep token reference inside struct
bpf_map on success, but I ripped that out, so yes, token has to be put
properly even on success. Thanks for catching this!

And yes, right after bpf_map_save_memcg() seems like the best spot.


>
> jirka
>
> > @@ -1293,6 +1314,8 @@ static int map_create(union bpf_attr *attr)
> >  free_map:
> >       btf_put(map->btf);
> >       map->ops->map_free(map);
> > +put_token:
> > +     bpf_token_put(token);
> >       return err;
> >  }
> >
>
> SNIP

