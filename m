Return-Path: <linux-fsdevel+bounces-6921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED6881E8D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 19:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913021C21489
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 18:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE293524DA;
	Tue, 26 Dec 2023 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WGfkpTYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A851C32
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-427dcdebf8fso10437191cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703614172; x=1704218972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7PfHDnomUiobG04nKM0XGBe44UinAFtZn/zdJlhx7E=;
        b=WGfkpTYbYKwsawLhGVUs88J8E9PpfIAdGL0f4RrzvURO37J5oxa+ojsPFWrNoldhjW
         AFKJj6/PhbSN8E9EVKYyWKbB0zCoXpyJNN9tPW1sJ5pCL3FanhfJSK4n9tmqcvJkOAh1
         DJsKERu5uhxFPXh5NEFcgXCmMT3T1nojeLpXGA6RCGxE8n86j3lp8ldFEVOEwcjFtRBo
         8XmzQXTsgWKBGbCWiwADMKJ3AKqgxu9qr5wesyf+UHufVf3CTZGKQh49yBxKjVOvH6pw
         Gp+T/9wB6npkP0wZVNtQBzh4Ak5H2vZW1/EqsZkGqHazjN1J3SbSApPpkn6W1PSQeZnO
         eBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703614172; x=1704218972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7PfHDnomUiobG04nKM0XGBe44UinAFtZn/zdJlhx7E=;
        b=luwKs13D/mGT80wD4cTIfSAe8VOkQnXsuHQ2mkJAfLlspwvScQjDFRK8D9945A9zrB
         UVLfZNcKabGsFbNKE9NhpNX08S+llFJ/TUR86G9hLvJoZgskd5j6/savPFFNsFqCkx64
         Ka61Kj/DQguzJZBCIzTeKs2S+F3DJVDAK22mP24uIyGox/BudxvBGcKUETu74APajoHd
         52GwcLOzE3imPMVvpfCYhbsbJpxA+wq4G+i+bp4FjWelz9oOpCygArbHHkwrJUId8OPT
         C3pPpGc2kIz7WeRISddF1Z1M36XChyC0nGCyLUnu2g2USBS0p+R+lyJJFky8EqKiAAdt
         K8ew==
X-Gm-Message-State: AOJu0Yz+3lNw+JGEV59JhsmxEhJOLhb6VisXYAI0gIUNWWQBaQO7tb0U
	UGp9WVXoM4toYG6xicDGubwUC8xSPLDUK5vnuNajX/z2mwVNgw==
X-Google-Smtp-Source: AGHT+IEtGqiyCZMh5j3F5J6wchinmn9n9fLbR9QT0arAi9kviky2yh3yetb2CEZeXYs1U5tu4B71Z7W+qiWPVjn19sk=
X-Received: by 2002:ac8:5fcf:0:b0:427:8b8f:823a with SMTP id
 k15-20020ac85fcf000000b004278b8f823amr12805036qta.116.1703614172543; Tue, 26
 Dec 2023 10:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-5-pasha.tatashin@soleen.com> <0db8fdb5-26ee-5069-30d2-118595516926@google.com>
In-Reply-To: <0db8fdb5-26ee-5069-30d2-118595516926@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Dec 2023 13:08:56 -0500
Message-ID: <CA+CK2bBYXdbqTxmw4YxDudnb4+1PwtSbimpff98JFWi+GjnT+g@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] iommu/io-pgtable-dart: use page allocation
 function provided by iommu-pages.h
To: David Rientjes <rientjes@google.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 4:36=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Thu, 30 Nov 2023, Pasha Tatashin wrote:
>
> > Convert iommu/io-pgtable-dart.c to use the new page allocation function=
s
> > provided in iommu-pages.h.
> >
>
> ... and remove unnecessary struct io_pgtable_cfg formal to
> __dart_alloc_pages() while there :)

Added to the commit log.

>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Janne Grunau <j@jannau.net>
>
> Acked-by: David Rientjes <rientjes@google.com>

Thank you,
Pasha

