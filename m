Return-Path: <linux-fsdevel+bounces-3969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DF67FA8C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 19:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32927B210AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D83DB84;
	Mon, 27 Nov 2023 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfDGvv4H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B23219A;
	Mon, 27 Nov 2023 10:18:30 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50baa7cdf6dso2968748e87.0;
        Mon, 27 Nov 2023 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701109109; x=1701713909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo6SKwc0bY8i8SUjlRjEpXwXn1ruEfDXTADvoI5y4Tk=;
        b=kfDGvv4HehLGMVOnFACiCBZJJAPVGppf7LezHDGbPARluIPVU3IVsBsALaGKqU+WKQ
         KU6Ppj5C+Ksxz+JdLvrpHvZsDuJqmhV4Fhz30U+mvdbmkIAP1sMLKZXfS5EsNjB0EX27
         rAjAR4jTqI/qtQ3VdQsfl04Gr8y+2MV3Jb2yLjHjg0DoibPFWaorpUaVoh7hg6QBUZIn
         RqdZZWB83Gm2OwP7w4s+obEsHJ/talAY/Ai3OjafUWPvW6CosBEQ6Zk71UcFWYdQGYbs
         aFcI4jIDQ2DzCrPkFQG6Bz69DCd7WShVqg414D4p+nKo/4DSwQxvduuRuHVT4mP7xvEP
         vBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109109; x=1701713909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jo6SKwc0bY8i8SUjlRjEpXwXn1ruEfDXTADvoI5y4Tk=;
        b=VweKnb6i3QsVSZQYe+fIOuyQP1Edrk2Tp2rGnhxuUVIR4Dc5yk3SiGPlt3EzOrIpmZ
         SEr7QmR5OK9t7pmARma4rp1X2Z0nI6Cfc5nugAl7F/qQftlqzwlABrTOr0wfhGOHpbx/
         CSwOZqL2yPErNm8FlYn/9+VZEqteUJP4Hw3jEC1ZQrgmo8ksBuQO6RddmXjwwRG603zp
         +HNVXrf14Ljao+zTmUcslh5GjfLGIi1b9PS3ypmN6M36M3k52psOmCOdRhWzXQgLn+j/
         a6DtIy5GEbeShs6dpNCQi5vjLvM9dzxWCeAPesdAH+jTYMdd9VTJy2qV2MAv+Zvo6qvh
         LVzQ==
X-Gm-Message-State: AOJu0Yz7XUUAMCgov0B6oSBegO0FVB47xV2jdkIx8cBxuwNb1QZxmP2H
	Sac/1+7tefEMvvgU+u6C1ovBu60O36VlpP7RIx4=
X-Google-Smtp-Source: AGHT+IHbvd9iyISjPAtVPzH7AFlFRQZGO/trLwfpSepF8cc826O3Jh5693WAfIpFxBMigSXJ0/jOl6h9J6g07yvqZn0=
X-Received: by 2002:a19:6d0a:0:b0:50a:10a6:1448 with SMTP id
 i10-20020a196d0a000000b0050a10a61448mr6893129lfc.59.1701109108576; Mon, 27
 Nov 2023 10:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110034838.1295764-1-andrii@kernel.org> <20231110034838.1295764-4-andrii@kernel.org>
 <20231127-anvertrauen-geldhahn-08f009fe1af1@brauner>
In-Reply-To: <20231127-anvertrauen-geldhahn-08f009fe1af1@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Nov 2023 10:18:16 -0800
Message-ID: <CAEf4BzZnumK6bzsP70EAZTeMmSYjbFkZSa0FNxX=wjC9+D2t0g@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 03/17] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 8:05=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > +     if (path.mnt->mnt_root !=3D path.dentry) {
>
> You want to verify that you can only create tokens from the root of the
> bpffs mount. So for
>
>   sudo mount -t bpf bpf /mnt
>
> you want bpf tokens to be creatable from:
>
>   fd =3D open("/mnt")
>
> or from bind-mounts of the fs root:
>
>   sudo mount --bind /mnt /srv
>   fd =3D open("/srv")
>
> but not from
>
>   sudo mount --bind /mnt/foo /opt
>   fd =3D open("/opt")
>
> But I think your current check allows for that because if you bind-mount
> /mnt/foo to /opt then fd =3D open("/opt")
>
>   path.mnt->mnt_root =3D=3D foo and path.dentry =3D=3D foo
>
> I think
>
> path.dentry !=3D path.mnt->mnt_sb->s_root
>
> should give you what you want.

Ah, subtle difference (for me :)). Yes, I'd like the actual root of
bpffs to be used, will adjust the check, thanks!

