Return-Path: <linux-fsdevel+bounces-3032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422457EF5BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4B280E61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE43716A;
	Fri, 17 Nov 2023 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B534AA;
	Fri, 17 Nov 2023 07:56:19 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9becde9ea7bso654107866b.0;
        Fri, 17 Nov 2023 07:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236578; x=1700841378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oexZKi4jraVZMBko6mtbaiC7v5lb9xeMULv/R6WBNzs=;
        b=jit75G0yw5bafT70oA///ru6t2isK3BcPtA3w0b9/+N9nJu7xilpv7PmBc8P+pvdin
         Zw+axdAFQvAYXJVh6WHYC/nWkDHlpZy7sVq+fxHOxBFdiQihTaSYJlR8ZfEkl/PqPvir
         do0jHbZQdJfdP+aumg0IGUDIVfxZugWBqsYcAd9hYqkjAGqtPbwca67Fe9hXJH+zt100
         JUTIgDRJbMFgY0QuiMRR7CPi8hy3THKRrc3nKMRYg9o4/cO+tQJlKWIoZf+/Tt7QP23d
         6EGl4DNZFCJLkNn3kbVRrGpBeSdC+6+5xYG81x4yHIm7MAesmBUyysJ181ztwwsWtIw/
         IEqg==
X-Gm-Message-State: AOJu0Yy3seeNQ8BQGsJ7Moeevc1Q/Cgr1ammdjLr9qRD9k2YJMDEkfFB
	/JiaXDgKidRCl5XCoVPN20CVqz9L7hw5TQ==
X-Google-Smtp-Source: AGHT+IFNuQzkhKpalczv/PK5PjOQ9FMyCZenJlyg4h9yi4U9ZDcfKIa7T79iYRZeUTlHbrOU4AVkEA==
X-Received: by 2002:a17:906:fcc2:b0:9ad:8a9e:23ee with SMTP id qx2-20020a170906fcc200b009ad8a9e23eemr4989418ejb.13.1700236577705;
        Fri, 17 Nov 2023 07:56:17 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id gt2-20020a170906f20200b009aa292a2df2sm903782ejb.217.2023.11.17.07.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 07:56:17 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9df8d0c2505so411706066b.0;
        Fri, 17 Nov 2023 07:56:17 -0800 (PST)
X-Received: by 2002:a17:907:7e94:b0:9f2:859f:713e with SMTP id
 qb20-20020a1709077e9400b009f2859f713emr5983220ejc.3.1700236577239; Fri, 17
 Nov 2023 07:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116155312.156593-1-dhowells@redhat.com> <20231116155312.156593-6-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-6-dhowells@redhat.com>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Fri, 17 Nov 2023 11:56:05 -0400
X-Gmail-Original-Message-ID: <CAB9dFds=jqwytP=F=RYD2AnOXBj9bBLc6wuO+yCy3m9308o6iw@mail.gmail.com>
Message-ID: <CAB9dFds=jqwytP=F=RYD2AnOXBj9bBLc6wuO+yCy3m9308o6iw@mail.gmail.com>
Subject: Re: [PATCH 5/5] afs: Mark a superblock for an R/O or Backup volume as SB_RDONLY
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:53=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Mark a superblock that is for for an R/O or Backup volume as SB_RDONLY wh=
en
> mounting it.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index e95fb4cb4fcd..a01a0fb2cdbb 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -407,8 +407,10 @@ static int afs_validate_fc(struct fs_context *fc)
>                         return PTR_ERR(volume);
>
>                 ctx->volume =3D volume;
> -               if (volume->type !=3D AFSVL_RWVOL)
> +               if (volume->type !=3D AFSVL_RWVOL) {
>                         ctx->flock_mode =3D afs_flock_mode_local;
> +                       fc->sb_flags |=3D SB_RDONLY;
> +               }
>         }
>
>         return 0;

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc

