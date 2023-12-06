Return-Path: <linux-fsdevel+bounces-5039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5358077D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E3228216E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC86EB70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imwbZiJ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82209139;
	Wed,  6 Dec 2023 10:19:40 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3333131e08dso89859f8f.2;
        Wed, 06 Dec 2023 10:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701886779; x=1702491579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0AdZDhqAN/XgQvGDwwSCCEG0AHGtA6Ed5Kjj8dpgxs=;
        b=imwbZiJ++3WQdaBX+N9kdkeidScCuKxUlt8+UZ+WQgLhulomzFoXlSSUAaT5Uro0Ff
         AV3SxitS6yrB26xDHyEg1PrRFCGsNmX5zbEgJRZl6lFlZ7ohCcqVhi1c/og6amm5Ei5e
         kMOzrBV592oCjKwVl8hV9KPejnksO752Fky0LfxO5OL2275FckdcSk3JDooX8XmmfsOR
         fy3wQL9BiXPcuYz1KMKVBCnFbhKJ6HWagIlGSXKsoGgT/KwkAdv44PqzUXbdJVkr4OdU
         dlsptx/qYtBMuvKhOrImVWIaNpbQVw1iijGL9dAzMPeR/9bQJJpWmg430VEP0kSTKlFr
         8egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886779; x=1702491579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0AdZDhqAN/XgQvGDwwSCCEG0AHGtA6Ed5Kjj8dpgxs=;
        b=wYwr0NaFX47M/z+9hyk73hwx6i5/oHYRt86JW422qNAjoMyq2xTuU9v+iHFvTO1XlT
         GZmgukrVoFm7GOsHRxmD3meUyamLLbI1oJfgwRtiPcO6vkvnhR2v48nkWK+SE+z2zF3i
         ijyw56dmA+2uui3ng8m2pTE6aRGrU+4azrvVVK7K+X23ernADgek8+Efekevr6glc6Q5
         0Mcj+VjArb+wnWCAghn+hlzSoJwaBMwVX//UyqOHRQa0mY3dUtR1lXtVHN3j8b1xQbi3
         k3Ofn0vUY57JKnhdjLE8cBGvoHOQYRWestDMXFXBt4Wjx0amf/10gS1rT7Fm+CmQM6lk
         JjNg==
X-Gm-Message-State: AOJu0Yxui1Pw0p+hn2lnb4D8/rCVddMSzeI+dfYobem9rXcE/je1ObOs
	CS3I6SHnsvURUE0/T9xQVyGZz0oXiJW5qxo/nAc=
X-Google-Smtp-Source: AGHT+IEMEo3QMgv4pf5c1TqQ2+CfAzRoErCFhD6SK5oG+dKGaVzAcGQwY6pt170rMKMiN5G4PJohE7vLzkVDnEDSHyM=
X-Received: by 2002:a5d:6107:0:b0:333:2fd2:2ed0 with SMTP id
 v7-20020a5d6107000000b003332fd22ed0mr786814wrt.73.1701886778658; Wed, 06 Dec
 2023 10:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130185229.2688956-1-andrii@kernel.org> <20231130185229.2688956-4-andrii@kernel.org>
In-Reply-To: <20231130185229.2688956-4-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Dec 2023 10:19:27 -0800
Message-ID: <CAADnVQLbxWPM1njsE141dQjw2+USd8Ggv80QgY+PgsGRd6FoVA@mail.gmail.com>
Subject: Re: [PATCH v12 bpf-next 03/17] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kees Cook <keescook@chromium.org>, 
	Kernel Team <kernel-team@meta.com>, Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:57=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>   *
> @@ -901,6 +931,8 @@ enum bpf_cmd {
>         BPF_ITER_CREATE,
>         BPF_LINK_DETACH,
>         BPF_PROG_BIND_MAP,
> +       BPF_TOKEN_CREATE,
> +       __MAX_BPF_CMD,
>  };

Not an issue with this commit. I just noticed that
commit f2e10bff16a0 ("bpf: Add support for BPF_OBJ_GET_INFO_BY_FD for bpf_l=
ink")
added MAX_BPF_LINK_TYPE to enum bpf_link_type.
While this commit is correctly adding __MAX_BPF_CMD that
is consistent with old __MAX_BPF_ATTACH_TYPE (added in 2016)
and __MAX_BPF_REG (added in 2014).
I think it would be good to follow up with adding two underscores
to MAX_BPF_LINK_TYPE just to keep things consistent in bpf.h.

