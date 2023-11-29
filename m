Return-Path: <linux-fsdevel+bounces-4277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8463E7FE34F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4066628222F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7BD47A4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UNFt8p/f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9774FC9
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 14:00:21 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-423dccefb68so11785681cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 14:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701295221; x=1701900021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiOfm5uGDMrP0UYnHwC5BRUcA0oU3b2DbcdcIFPiI/Q=;
        b=UNFt8p/fEXprRIha0J4eUYVKdi0rMA0hG/lMPhmctuPcjQJK6pEQ9RvLTiv8Kch8sH
         DmwAsrHbMES4yL1KDjQeRA+RNsyN36dikvvVwKZyg04i0/Y5jSjtVNFtzgx4xf57isnG
         8aS2PljASnxisy6dFJi89LsColXBx0oKXkEkkefCKjWRjwbeoBeu105E8AOy0pwcip5j
         zeh9l8zPvy1Dat+KfgtfVl2BkSgeEcaVJ3aqwdKM3BpStr4wjn0SvPmqg94RkJspa+fq
         oT+8Zjc2Ft7qT0u0d80xNtngesAUklPc6F2Nx4AXZaFm+ctalbeH6XBjIFjPqRHZF9eQ
         EUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295221; x=1701900021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiOfm5uGDMrP0UYnHwC5BRUcA0oU3b2DbcdcIFPiI/Q=;
        b=PmRUdT+rKPbsF1SWXfnCJPwjDegw+mdwY8xHze/wr5XGH/GttaLMIsRp4NUqMHdEz0
         2lNoTil59QPIudicv4TQCFeVbSxZv+KnNO7R0xYvv8v4/PZ+bomRzPC8NaR1IGDg+Jxg
         yPXwwZTc79y5Nk0JpDzoNBBlPEdrTY3sJtoR2uY8Dwn/g7JkMnZyKNeUTWGxSJkeMVLZ
         OXaqTePrmvgq9RuzbgEFBe+KMiLSvbjt2YedMRvYcRgkUmOq1sZX54XS4hpfynsuRNKf
         dM2M4oWMB4ovEUIVMa+uyy/MlkHEBaRD2zLGjua8UAT7IdP9xW+1/LRbkQB+KKaoPbtf
         dESg==
X-Gm-Message-State: AOJu0YwnPGvbWz6KL4yv3TpkbiCMuWD7n4Kkq39dGndEUappsrVidKtT
	MTbNU2A5e0umdG6gCvTAP/b3XoUUo+TiIKufS8NKeg==
X-Google-Smtp-Source: AGHT+IGmE/x/Q9wBAAP4WSVeu6Pzwkh80gJNXkwIoavJV9VXufokUhNCLXMfXFExg6GRm7Q1Y/p8TrFXYkay1vjqtA4=
X-Received: by 2002:ac8:5ac4:0:b0:41c:d62b:fb51 with SMTP id
 d4-20020ac85ac4000000b0041cd62bfb51mr39263562qtd.26.1701295220560; Wed, 29
 Nov 2023 14:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-10-pasha.tatashin@soleen.com> <20231128235254.GE1312390@ziepe.ca>
In-Reply-To: <20231128235254.GE1312390@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Nov 2023 16:59:43 -0500
Message-ID: <CA+CK2bC=vMU54wXz1GSzpOcLFCuX5vuE6tD49JF8cMbz4tis-g@mail.gmail.com>
Subject: Re: [PATCH 09/16] iommu/iommufd: use page allocation function
 provided by iommu-pages.h
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org, 
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com, 
	netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, virtualization@lists.linux.dev, 
	wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 6:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Nov 28, 2023 at 08:49:31PM +0000, Pasha Tatashin wrote:
> > Convert iommu/iommufd/* files to use the new page allocation functions
> > provided in iommu-pages.h.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  drivers/iommu/iommufd/iova_bitmap.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> This is a short term allocation, it should not be counted, that is why
> it is already not using GFP_KERNEL_ACCOUNT.

I made this change for completeness. I changed all calls to
get_free_page/alloc_page etc under driver/iommu to use the
iommu_alloc_* variants, this also helps future developers in this area
to use the right allocation functions.
The accounting is implemented using cheap per-cpu counters, so should
not affect the performance, I think it is OK to keep them here.

