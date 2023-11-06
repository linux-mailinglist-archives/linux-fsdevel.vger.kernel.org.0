Return-Path: <linux-fsdevel+bounces-2062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FB37E1E83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 11:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0150B1C20AD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D718026;
	Mon,  6 Nov 2023 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pndCcRPf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076617993
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 10:39:27 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE54AA4
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 02:39:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d2e6c8b542so627054366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 02:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1699267162; x=1699871962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pm0IGHA8IA+IDjsyiZ2a16PLhYx/oY+Z0BgLnBIjiAA=;
        b=pndCcRPfG/TI5Ii//xn5e+qwqtubrwzKlaOQGU7U71iqYLCB4HkMAwA6FT4RBVFXo2
         pmBFQuozUmNncJuer0HR3sJBEQ2tCzuaUmvWaL2+MyP/EoGyv6Bsi3EiaZo0aR9bUzNQ
         gcQi0e3xVDSwBVIZE92GPOBIdzhfULpv10i+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267162; x=1699871962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pm0IGHA8IA+IDjsyiZ2a16PLhYx/oY+Z0BgLnBIjiAA=;
        b=TMElV45B5HkWNsDGLwX7EPscezToLlEjt2t0SuIATDnalzYN//t6mrS2EjJie2u8Q0
         JaY2TOL68QRpj01FkcMBp2DKC3Xwy7hyq6kE0ySpJA67Fz9QGtIYwozIphdoh9TollnZ
         EtvFGP3AYpe1kOyQ41kIaxhKGPt5DGQ3ZgFcONvjaUh3cayOFmEYA+rkahKf5gLNO48N
         FQeKT+2n9cFkfSa7FNeZaJgUpzzsLRshL2+iyjJYQdVVQCrcuDk6zQdkbtu3Ck508/s5
         th9G3GoRdZ2y7pl/Ge3e7nljTSdpfSeNYLFVZsDoQhuhte0hmwqXAyDEpEm9qZySAMLb
         DZEA==
X-Gm-Message-State: AOJu0YyDRV7dxjZWHBhFIM/EucXP2khbb4CUOyYvkQYtW+V/t5M3Xs/7
	OEd+D8JnjuIM+F9nPzgDH3xD1RvBa5xh/Dqk2eNDKw==
X-Google-Smtp-Source: AGHT+IGLhw+8kr8nZIzoM382pgIEeVHnt0FExhnBuGj195lsuViqzurx/jK4+RsVcF3ItXr4UyiU2OQpAeDqHg4zhzg=
X-Received: by 2002:a17:906:b145:b0:9e0:5dab:a0f1 with SMTP id
 bt5-20020a170906b14500b009e05daba0f1mr1577966ejb.36.1699267162260; Mon, 06
 Nov 2023 02:39:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031144043.68534-1-winters.zc@antgroup.com>
 <CAJfpegtjNj+W1F4j_eBAij_yYLsC9A3=LgNvUymSykHR5EvvoA@mail.gmail.com> <2a2bf87a-87ba-40d2-8d10-c4960efbd11f@antgroup.com>
In-Reply-To: <2a2bf87a-87ba-40d2-8d10-c4960efbd11f@antgroup.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Nov 2023 11:39:10 +0100
Message-ID: <CAJfpegtZKrDz-NTq7-Edb7GSm7GSParoxBr7e7kEodfR8c8CMA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] fuse: Introduce sysfs APIs to flush or resend
 pending requests
To: =?UTF-8?B?6LW15pmo?= <winters.zc@antgroup.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Nov 2023 at 10:57, =E8=B5=B5=E6=99=A8 <winters.zc@antgroup.com> w=
rote:

> So, based on my understanding, resend is adequate, but flush can offer
> more convenience. I would like to inquire about your preference
> regarding the two APIs. Should I do some verification and remove the
> flush API, and then resend this patchset?

I think it would be best to make it easy for the server to flush all
requests using the resend API and discard the flush API.

One idea to make it easy to distinguish between normal and resent
requests is to set the high bit of unique.

Thanks,
Miklos

