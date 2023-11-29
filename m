Return-Path: <linux-fsdevel+bounces-4259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F87FE366
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FCD1C20AD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AE23B1BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HJAXN7iB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED69A
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 13:49:47 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cc44736f2so1437931cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 13:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701294586; x=1701899386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cpfJU5sAguyt0/G2iahMIWT2bpNq5anO26/F530wIyY=;
        b=HJAXN7iBuM+uFe3zpc3uYLzvOrZnIW7Rgobqx2d537etXTr6TuiIL3TGjesui2UVtu
         ym9h1km+8brtg4+qvFbTJ/KGkB99nz+J6BlPVefUjP75DT0T/iqdEU+11sUDRcgH3HJ7
         +4Klj115UftA0kmoj7LInHKSZYOWoxkXk74aDAVJeXJYH/g4lbTzhcqpJfAn+0kxnqI6
         6ZIMCtFpmruYQfbTX7FbF8JoNHYNSbkrGeodxLLP4hU6ZiF/yZoFz3lefYVEoGFGYl6I
         zYtXzMAoNccvxhAZjunXzc3FpJAW2TyZSzZiRTwxPfJkj2eXwSkRa9IMyH1vfOM/YI6j
         7icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294586; x=1701899386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpfJU5sAguyt0/G2iahMIWT2bpNq5anO26/F530wIyY=;
        b=CuDxkNe2gH0sHgyUJw3IVfWgVWdkSe1VpeWO9u8GpbunePogI/gXy0csepCNeHh21M
         bFSRgEQrMKguZY7iJ0hRPElkcNdx+E2HGjghk8hvPrbPeXufj+wmHzkalSWWI1GmBR3D
         YWFUw6LHYQ9Jq3q39lWWmB3ZKu7umMhI3fUhIRbmuA10lXLw1Tm/ZmTyq+PsEdfP6sza
         E1h4QzG2rs8Oym92oMUHeIID37+hY6ucC8IZHyhFkRbVvogbrzjbxTX0sK8EpL7BljRn
         R+FTb2Zn0u5rWJr2JgMWxSAaQjjCz/xLyUSCF+TWBKBQ1siLqQbr6sbrPTP5m8oYBHnQ
         TH1A==
X-Gm-Message-State: AOJu0YxXd6ITGWnXvZdabCb9GtyEPTwGMohJpaFIO50osE3RoPLDMN54
	DVmxy9XKZPO47nG11JqyzUXytR2JCkd4M0aNgvvKyw==
X-Google-Smtp-Source: AGHT+IHQGnPttzbf2bAdb5gwZpT0Nh8amOSeNRZF+eb1/SrYiR5d7rhV+9FkDuUK6ClQ83baR1dhxHx1LVYRiRyKJoI=
X-Received: by 2002:a05:622a:34c:b0:41e:213d:3c8e with SMTP id
 r12-20020a05622a034c00b0041e213d3c8emr22630747qtw.32.1701294586528; Wed, 29
 Nov 2023 13:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-5-pasha.tatashin@soleen.com> <ca7a025d-8154-4509-b8ab-2a17e53ccbef@app.fastmail.com>
In-Reply-To: <ca7a025d-8154-4509-b8ab-2a17e53ccbef@app.fastmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Nov 2023 16:49:10 -0500
Message-ID: <CA+CK2bB-TMCgpjvuXRigNaaA2Zmj=r3PHTQMaqs5W-9FkE3roQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] iommu/io-pgtable-dart: use page allocation function
 provided by iommu-pages.h
To: Janne Grunau <j@jannau.net>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, David Woodhouse <dwmw2@infradead.org>, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, krzysztof.kozlowski@linaro.org, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	lizefan.x@bytedance.com, Hector Martin <marcan@marcan.st>, mhiramat@kernel.org, 
	mst@redhat.com, m.szyprowski@samsung.com, netdev@vger.kernel.org, 
	paulmck@kernel.org, rdunlap@infradead.org, 
	Robin Murphy <robin.murphy@arm.com>, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	Sven Peter <sven@svenpeter.dev>, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, virtualization@lists.linux.dev, 
	wens@csie.org, Will Deacon <will@kernel.org>, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

> Reviewed-by: Janne Grunau <j@jannau.net>

Thank you,
Pasha

