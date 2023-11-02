Return-Path: <linux-fsdevel+bounces-1805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9537DEFE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369E91C20EA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9613AE6;
	Thu,  2 Nov 2023 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTcFdT6D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3879F6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 10:27:50 +0000 (UTC)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7DC189;
	Thu,  2 Nov 2023 03:27:47 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7ba962d534eso335714241.3;
        Thu, 02 Nov 2023 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698920866; x=1699525666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sT5XHbj1Zpwf41XiMIHE+g9/5pteqhB4IA+ksFC5ZY=;
        b=TTcFdT6DFvX6uIKFKovf8kp+Y0hJs7FDoYMnw2emiG2NwHujXNeSazqd/OcO8ngoLL
         4gpswp+tjwI4lX+kkTqz32MQuy7uijTU40qK5nSPE5TXnvm0oeUPXZd6GyL2WhdtRB/n
         nXmRpfPA3EosHJytEEfxThytLytLd7CQH/ZaCCH5+9gBizgYmyfqV9d8V5wuVNfbiXnn
         eqEH5Er1oVjTrYXNgXlfFTIokJgH1gukNvvcd0LmNdeltmxuXmTzgMsmT1af5jPsolMg
         VaU+XKHpjcZ6bSgv3E5XVq426qr2xNRIwFjiSu19uIxG9yBpBYL3v8P6SnpABKGcH5zN
         wNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698920866; x=1699525666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sT5XHbj1Zpwf41XiMIHE+g9/5pteqhB4IA+ksFC5ZY=;
        b=g80A8XUftaJKSQwCz8RtMyKXP+5eLb7K7hi0V8ktc6yejtjYMYp5bSNVgm/+Efc9Sn
         Lc5aGYmiTTtWKm2K+D/J4Sh70FJQ6W3+HqReqsYE0OSrOIGCDtdE7ZcPAZpVpbwMkyZr
         1LcOoyygeaNLEg7mnQSTSEqHgiLK7eoqDnfk7LCDotVLlPQIJqP9qfcAKHxmPM0F/V+9
         rY+zAd+vFm2RacfdJJPd9IjZ6I90X2//YNmEYa272/G2NYWQ//TzP6wt2Q+W1QrdFAaX
         LG9KdCcH+xMc/4HhaVdrlqycytNTF0sDY5lFsnsX/BsSsfr2rksSO7yVQT5cygezxqZO
         hgeA==
X-Gm-Message-State: AOJu0YxjKzfhbFJHIV8kCbSA1sWbBcTx5Ekphl7svEdddAHAu4W3A5zO
	7K4vslDGlSotTF62jgWFrD8ZDGW5LD51ODhSCuU=
X-Google-Smtp-Source: AGHT+IGfhSMAQnAmwLC2LwBFtVyVHvMCGpPNJUXypOgmT+sfq1Rq7XG4jJWEep4XIQIVbnNp/nkwE7SSwRchWTlQQRg=
X-Received: by 2002:a67:e047:0:b0:457:c415:a495 with SMTP id
 n7-20020a67e047000000b00457c415a495mr15388078vsl.10.1698920866565; Thu, 02
 Nov 2023 03:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101172739.8676-1-jack@suse.cz>
In-Reply-To: <20231101172739.8676-1-jack@suse.cz>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 2 Nov 2023 19:27:30 +0900
Message-ID: <CAKFNMokAS4VoJ6tUbK0fP+zr4taBxCRLgP_Q2g-VQpNbeXTg-A@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: simplify device handling
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 2:27=E2=80=AFAM Jan Kara wrote:
>
> We removed all codepaths where s_umount is taken beneath open_mutex and
> bd_holder_lock so don't make things more complicated than they need to
> be and hold s_umount over block device opening.
>
> CC: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> CC: linux-nilfs@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/nilfs2/super.c | 8 --------
>  1 file changed, 8 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

I had missed that cleanup patch set.  Thank you!

>
> Hi Christian, I think you've missed this simplification in your cleanup
> patches. Can you merge it please?

Thank you in advance, Christian.

Ryusuke Konishi

>
> diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
> index a5d1fa4e7552..df8674173b22 100644
> --- a/fs/nilfs2/super.c
> +++ b/fs/nilfs2/super.c
> @@ -1314,15 +1314,7 @@ nilfs_mount(struct file_system_type *fs_type, int =
flags,
>                 return ERR_CAST(s);
>
>         if (!s->s_root) {
> -               /*
> -                * We drop s_umount here because we need to open the bdev=
 and
> -                * bdev->open_mutex ranks above s_umount (blkdev_put() ->
> -                * __invalidate_device()). It is safe because we have act=
ive sb
> -                * reference and SB_BORN is not set yet.
> -                */
> -               up_write(&s->s_umount);
>                 err =3D setup_bdev_super(s, flags, NULL);
> -               down_write(&s->s_umount);
>                 if (!err)
>                         err =3D nilfs_fill_super(s, data,
>                                                flags & SB_SILENT ? 1 : 0)=
;
> --
> 2.35.3
>

