Return-Path: <linux-fsdevel+bounces-6004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CA4812042
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 21:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7271F2187F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 20:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75AB7E57C;
	Wed, 13 Dec 2023 20:54:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8C49C;
	Wed, 13 Dec 2023 12:54:45 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so51651075e9.0;
        Wed, 13 Dec 2023 12:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702500883; x=1703105683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uERSlmWABCloqqWZmq7G8mc4+2oSuJMPRYaQZcqODM8=;
        b=WRR6pfC63xOLdCDt0ZYKZmVodlCqKIzNr1h3S1BHOA1SvmuRldey2vOYiW4jbIH7mz
         1mTAvF1AuxWiEP+0e2IYQkLyXbJzaO6QOLkTlyim83KQNr94CTVobSsEyAPbRKUwSLva
         IK4Azpc06FR2hKqRYEgU0CTqBhhsZTSJeBgqoJDxOKbATTWkIK2qwKEQitQ5X7P4Xm6M
         U0XPNg3kR13YgsryggZ0IHP1Y2I/3sGFiAIZJA2KqHV10TWUJWUFaNHkDyZaBhsAEqOB
         chQv2aWt4NNIjtQKk+EzrGN7m5ztd5UrMwptO3gS3POE4gF+vXxlq2CngRxDsZb7q1ix
         AJPA==
X-Gm-Message-State: AOJu0YwCnrf+cy5mUO2fUA76UbxeEcLd0QpTOlGcPF3mlRucLmL+QzjU
	1CNMe9q81rCeRIVwuVUFOL3lYSA2IYKHew==
X-Google-Smtp-Source: AGHT+IFugTNGnl0Qu9btbrBMpylz/sK9luUWzvyHxx7L23FEz2CDJEcjHWIBeO62L/7fMxpNdntTLA==
X-Received: by 2002:a05:600c:3b9f:b0:40c:2878:35ec with SMTP id n31-20020a05600c3b9f00b0040c287835ecmr4656224wms.131.1702500882927;
        Wed, 13 Dec 2023 12:54:42 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id vh9-20020a170907d38900b00a1d18c142eesm8393448ejc.59.2023.12.13.12.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 12:54:42 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55226029d17so1417898a12.0;
        Wed, 13 Dec 2023 12:54:42 -0800 (PST)
X-Received: by 2002:a50:d657:0:b0:54c:f9e6:e40f with SMTP id
 c23-20020a50d657000000b0054cf9e6e40fmr4717255edj.7.1702500882554; Wed, 13 Dec
 2023 12:54:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213040018.73803-1-ebiggers@kernel.org> <20231213040018.73803-4-ebiggers@kernel.org>
In-Reply-To: <20231213040018.73803-4-ebiggers@kernel.org>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 13 Dec 2023 15:54:05 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9K=i80N7-UpJG=XUMVtA_c5bv6DscXw+326wANLvXV2w@mail.gmail.com>
Message-ID: <CAEg-Je9K=i80N7-UpJG=XUMVtA_c5bv6DscXw+326wANLvXV2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] fs: move fscrypt keyring destruction to after ->put_super
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:01=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> btrfs has a variety of asynchronous things we do with inodes that can
> potentially last until ->put_super, when we shut everything down and
> clean up all of our async work.  Due to this we need to move
> fscrypt_destroy_keyring() to after ->put_super, otherwise we get
> warnings about still having active references on the master key.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/super.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/super.c b/fs/super.c
> index 076392396e724..faf7d248145d2 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -674,34 +674,34 @@ void generic_shutdown_super(struct super_block *sb)
>                 /* Evict all inodes with zero refcount. */
>                 evict_inodes(sb);
>
>                 /*
>                  * Clean up and evict any inodes that still have referenc=
es due
>                  * to fsnotify or the security policy.
>                  */
>                 fsnotify_sb_delete(sb);
>                 security_sb_delete(sb);
>
> -               /*
> -                * Now that all potentially-encrypted inodes have been ev=
icted,
> -                * the fscrypt keyring can be destroyed.
> -                */
> -               fscrypt_destroy_keyring(sb);
> -
>                 if (sb->s_dio_done_wq) {
>                         destroy_workqueue(sb->s_dio_done_wq);
>                         sb->s_dio_done_wq =3D NULL;
>                 }
>
>                 if (sop->put_super)
>                         sop->put_super(sb);
>
> +               /*
> +                * Now that all potentially-encrypted inodes have been ev=
icted,
> +                * the fscrypt keyring can be destroyed.
> +                */
> +               fscrypt_destroy_keyring(sb);
> +
>                 if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes),
>                                 "VFS: Busy inodes after unmount of %s (%s=
)",
>                                 sb->s_id, sb->s_type->name)) {
>                         /*
>                          * Adding a proper bailout path here would be har=
d, but
>                          * we can at least make it more likely that a lat=
er
>                          * iput_final() or such crashes cleanly.
>                          */
>                         struct inode *inode;
>
> --
> 2.43.0
>
>

This makes sense to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

