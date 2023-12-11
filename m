Return-Path: <linux-fsdevel+bounces-5549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A314980D533
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CFF1C212DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E371251032;
	Mon, 11 Dec 2023 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViKZ+o1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6EB8;
	Mon, 11 Dec 2023 10:21:20 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso6276053e87.3;
        Mon, 11 Dec 2023 10:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702318879; x=1702923679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpsaqKnd+pPts/gd5y5S69XF9tufJC8/px+eEOaxdHE=;
        b=ViKZ+o1I2Cp1bEYtpw6mCUY1pf2HfBeCO6k+ABygrnfagsPmo5aVsiwKfh43VQXeH8
         GxLEW1V1Udtnoa2YMHbNyva+sfKbNv8r9ioAdZ47Vx8FE4d0s3GyFMhBAMAWcpRKXY6o
         raSJ7hqcSURM7IgUMAEZP093lKAvIhLc7775AP+VMfw+SPIDq4OaHNVj+QEShRYW31mi
         fnIZnDYHVo2Fki4AQbtO5s8pqruTJHbnhdz9SpYjFE5LCkgdlv0vBrVI4/pSF/+LOCUW
         Dy9+aWzVJVaYlPe4jv+5AotnhGY7kjqLn1k8T2e8SxNTt+46BeKImMdxLrZssAwP7xjT
         xgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318879; x=1702923679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpsaqKnd+pPts/gd5y5S69XF9tufJC8/px+eEOaxdHE=;
        b=NJx8RlJXy3WXqx6tMN3ysU0wNGpC5Fh0wDQpcOk4f7czG3RvPCLU2HacE9Pdx9Ux8H
         MQIAyv0drJUJ+pvDbewiM0G50RIe+P1IEdVENknm36FBDoXBW6JBMnUYi1ojaVoq3N1v
         MRUxuZfvFzdQRmKSXG3pILW6t2WX7a7rPY3L5JZ00FuIJyc58lMSkRG/X7zzAVZHXKzD
         KglGG90mIvO6BLw2mDFxV4jALnDF2YeOfHDojJh4++Ww7B1UibeJRyiyuA8usl9jXoz7
         dGtcgyfsraLomN3FkSj4Lewfuv2Q7zx8SmSSwQqlA3blNC/Esio7WFBw51ZGbGqInXKo
         C66A==
X-Gm-Message-State: AOJu0Yx2gnQXh7rBq/WgsnPRF7PFGTr105m6WV9bvEEg6Mmju03hX6/p
	wKRqgTaIpyWFd4lbwVjeVVZrlJYjbkmaPnJi90UEb9a+
X-Google-Smtp-Source: AGHT+IEcMP6tBKofMsp4cOByDFMjivgzVIFHNHHRtBouyZZnhRJI0XYlxG5iXLYRPAvI8EvWxSHRhv77qfRVUCM7uzk=
X-Received: by 2002:a19:8c45:0:b0:50c:f12:6dc0 with SMTP id
 i5-20020a198c45000000b0050c0f126dc0mr2485624lfj.21.1702318858166; Mon, 11 Dec
 2023 10:20:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207185443.2297160-1-andrii@kernel.org> <20231207185443.2297160-4-andrii@kernel.org>
 <bbf5098d5ff81bf9d65315522e9999a818ae25a3.camel@gmail.com>
In-Reply-To: <bbf5098d5ff81bf9d65315522e9999a818ae25a3.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Dec 2023 10:20:45 -0800
Message-ID: <CAEf4BzYJHaQH+zL-GabJ1jMwof7W9PNn_yVVAJE6G3SPFc_Zew@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/8] libbpf: further decouple feature checking
 logic from bpf_object
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 7:31=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a6b8d6f70918..af5e777efcbd 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -637,6 +637,7 @@ struct elf_state {
> >  };
> >
> >  struct usdt_manager;
> > +struct kern_feature_cache;
>
> Nit: this forward declaration is not necessary.
>
>

true, we have it in libbpf_internal.h now, will drop

