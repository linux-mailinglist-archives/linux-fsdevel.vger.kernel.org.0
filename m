Return-Path: <linux-fsdevel+bounces-4255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E87FE362
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C8F1C20966
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FBE47A52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OExQ1cLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06C7D67
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 13:36:49 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-423f47eb13dso1463871cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701293809; x=1701898609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKdw1vp5oLSx4gO3m1/rl4eR0j44oWuSmpeWEj8OyEg=;
        b=OExQ1cLLwtG7+490nris8noYiYxSqXI4ie1YhzAm/VeuczmafNkSzFv5qw9D0HcErf
         ffPPn9sEPfg40Js8rnPoqm6IcpzTOTgPB/jswA+tpg/pJ5KrztQfCo7fsvLJA1skHJ4T
         Yt8NEPNif1go0SwFQYpEqCyd0fEz7D6QZBqhq+gAHOnWwnB4owKJhGROi7yWrwSiBZGS
         j7TrWhwDpwdt3UTK+XtFGEJ5vM2sYeDU7Qz9OlwbkKdaZ28zC4A0R/JYxs5DgNxTa26i
         RemFAI0Y90he8C4fmshjw22bDbsjE+K5y8NllC55xEQhe2wyuDKLxWvJpO9FKnkikNo2
         5P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293809; x=1701898609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKdw1vp5oLSx4gO3m1/rl4eR0j44oWuSmpeWEj8OyEg=;
        b=ZVGY9wjkrLaRw2GOyzaPdy8F4S92A+04CvOEL68gETgqckSVm+IOfJFiLz3fpC1L4Y
         cKoL6v1AAZIUC9F3brrqNl17QuPF/9p3v5kqOR9qYsfLfFsRooC4+BQdDCXdiTdgpp71
         Kxm2o/14SFEzwDsnwjRv6+07rfrJKsLUAUmh4TXXRVWoZftdreQAbvT431zZSfI4OfvB
         W8SAfkO4As1eO+VnFVejDxj3sxtXWZyxhSKtzGCmnsIOAqgYNoagC5ai9ZhB/voaw1hM
         LAQVnoQzO5JhKgUY+Ww2aoJN+Wp+Mp0vRgxs7Eh8HgpMWAW8XHiVfzhunpBA+r+w423P
         LB8w==
X-Gm-Message-State: AOJu0Yz+BOOwJB1PJVV4x4xx37yKsbVhsi1LZK7IQefVlgGXhpZeKP+s
	c0OtbEwUNJd2sCi2Je9Dk3b8OcwOlg/eRfQZo8o91A==
X-Google-Smtp-Source: AGHT+IH1s42XbpuMqfnRK8jqZvUrCxoQ7Or7Gzckcwkn35i1gPeN3cfJsGoJeMBusJpvpuIBcFrnBzJ4nZCRPQFGmZI=
X-Received: by 2002:ac8:5c0e:0:b0:423:6e2a:1c36 with SMTP id
 i14-20020ac85c0e000000b004236e2a1c36mr29092766qti.35.1701293808838; Wed, 29
 Nov 2023 13:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-17-pasha.tatashin@soleen.com> <20231128235357.GF1312390@ziepe.ca>
In-Reply-To: <20231128235357.GF1312390@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Nov 2023 16:36:12 -0500
Message-ID: <CA+CK2bBK=4qbHJG_6B=HSMOXe1vmg7D9TZmsJFhsqVmQau503g@mail.gmail.com>
Subject: Re: [PATCH 16/16] vfio: account iommu allocations
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

On Tue, Nov 28, 2023 at 6:53=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Nov 28, 2023 at 08:49:38PM +0000, Pasha Tatashin wrote:
> > iommu allocations should be accounted in order to allow admins to
> > monitor and limit the amount of iommu memory.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
>
> You should send the seperately and directly to Alex.

Thanks, I will.

>
> Jason

