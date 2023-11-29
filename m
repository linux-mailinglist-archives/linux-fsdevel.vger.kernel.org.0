Return-Path: <linux-fsdevel+bounces-4121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C6B7FCBA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A728320A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA831863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyFGy8xp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C6119A7
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 16:25:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54b8a4d64b5so3086056a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 16:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701217542; x=1701822342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s79KKQuQOw+McryaEibHTjOFNeepmOvGc+6XuFBzp3c=;
        b=ZyFGy8xp8qD5QI9QwPDb+IhsSZRWf8AzRGUswbI12YDGc1xvIH0g+wLgQbCQ0MgByE
         7JaxlJ6LDrvTwD5v2u1BaaPpBH5R5YUNgb5xQN5Swj0XVMeLoAtP4ZQrlwUAhmY6b1f4
         lo4P74/huqLxXg4rQSkXW1y86RBYbZxCN4heVivo9RjTVn5xV88cmdZGNrBjexsDtvSV
         5HnfHukhNDWtzilONZrFm5fU8R7ZF8dU9NcWUXLUD8PtyHJZZPAj804uzq7F30DAe528
         xZNvGBU8xFyPrK3MZMejmdtbek7u0XA2xivLK10lXoEkODunFDDID+jqCIfmSYQFelmQ
         DpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217542; x=1701822342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s79KKQuQOw+McryaEibHTjOFNeepmOvGc+6XuFBzp3c=;
        b=GPp4ZeYNpP7j6FzN+Kx+cXMSn+s2S75A3rw/zBLt6IoTfjlTAwo99ZreiNOwjEsxff
         oswlMx4WqedfghC/P1sLZCyW/uH//teyLmZM6AffsYPMk7NKAV24l1CpOlHPCy1EjEQY
         EpS/O5yPhLL4Vg/aXAg7CzDguT4JbtLLSkHTheflcQ1FBm6hINn/HNqD6woTau3Y4+1T
         b5mhKtiN7WTSh23sJx6GDZDqvNA1gzf5wzCvyuqyxDhLm676VXjst8NgBnGkGnrDUROY
         +eqrFwmijKgGUuXysZDq38j91l0hAsTR4KRN6gGE6WhUtVKU9hQvakjwBEimS+txW/nW
         1Pag==
X-Gm-Message-State: AOJu0YxCENV7EYvGmWFtx2i9NhEGHuBJIitcgaEA+9f3Z3CIpDqFY53D
	ICLrC+CAlKTI8zlomIxQD3Le8GrNmYB9XtTti5izIQ==
X-Google-Smtp-Source: AGHT+IFhvJD8pcFDSUkXj7rCXo1krioxrjZU+Fh9ydxhF7LIckb5ecLVgf1lGuB42STpvzRSm1nEjeoSzXAsfJKhmOQ=
X-Received: by 2002:a17:906:1091:b0:a0c:c09f:65fe with SMTP id
 u17-20020a170906109100b00a0cc09f65femr7312731eju.38.1701217542589; Tue, 28
 Nov 2023 16:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
 <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
 <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com> <20231128235214.GD1312390@ziepe.ca>
In-Reply-To: <20231128235214.GD1312390@ziepe.ca>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 28 Nov 2023 16:25:03 -0800
Message-ID: <CAJD7tkbbq6bHtPn7yE3wSS693OSthh1eBDvF-_MWZfDMXDYPKw@mail.gmail.com>
Subject: Re: [PATCH 00/16] IOMMU memory observability
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org, 
	alex.williamson@redhat.com, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jasowang@redhat.com, jernej.skrabec@gmail.com, 
	jonathanh@nvidia.com, joro@8bytes.org, kevin.tian@intel.com, 
	krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
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

On Tue, Nov 28, 2023 at 3:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Nov 28, 2023 at 03:03:30PM -0800, Yosry Ahmed wrote:
> > > Yes, another counter for KVM could be added. On the other hand KVM
> > > only can be computed by subtracting one from another as there are onl=
y
> > > two types of secondary page tables, KVM and IOMMU:
> > >
> > > /sys/devices/system/node/node0/meminfo
> > > Node 0 SecPageTables:    422204 kB
> > >
> > >  /sys/devices/system/node/nodeN/vmstat
> > > nr_iommu_pages 105555
> > >
> > > KVM only =3D SecPageTables - nr_iommu_pages * PAGE_SIZE / 1024
> > >
> >
> > Right, but as I mention above, if userspace starts depending on this
> > equation, we won't be able to add any more classes of "secondary" page
> > tables to SecPageTables. I'd like to avoid that if possible. We can do
> > the subtraction in the kernel.
>
> What Sean had suggested was that SecPageTables was always intended to
> account all the non-primary mmu memory used by page tables. If this is
> the case we shouldn't be trying to break it apart into finer
> counters. These are big picture counters, not detailed allocation by
> owner counters.

Right, I agree with that, but if SecPageTables includes page tables
from multiple sources, and it is observed to be suspiciously high, the
logical next step is to try to find the culprit, right?

>
> Jason

