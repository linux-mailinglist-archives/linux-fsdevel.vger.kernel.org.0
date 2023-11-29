Return-Path: <linux-fsdevel+bounces-4247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FD7FE122
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 21:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93BA1C204D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 20:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610858AAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KlNzTNzv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE87D7D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 12:03:08 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1fa619735c1so53393fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701288187; x=1701892987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFOuz3/DxdhVTy2MXC00IZ5cc+fO6ZXycOtXt73BBek=;
        b=KlNzTNzvrho3FAS6n7EIxzUiMs/vl/iQeM0QDdJkEjtS4cSXhxLsY19IKKemyE5A8c
         /pBj/iSWEDglOfunWlf+rdxaJq+x/0XQl2Uyk0fvUDk791ilQsfe3HWXbzEdTcPALQYT
         g/aVLcaMnYCLRD0rV7sQjULwgL1hR6Mof3bYBxvaj15JF5qBtmWF1oZoLuW6nV61s14i
         6Vv7dedA5rotbHw71gnDEqtcDlEZHcwb60BySZC5ronuR3Bgo8ZxfPNuWFpbzwzjfrl8
         4iUwrdOUO0FZwchQlhgUQOM8pS0h/OjsOZO84JlsBH6vV81K0Acx+0eXA8xhOgLX23XK
         6w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288187; x=1701892987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFOuz3/DxdhVTy2MXC00IZ5cc+fO6ZXycOtXt73BBek=;
        b=w54PulT7S2laIH0wqjaQ5X7FoBfHgBIkyejzsnEngXS780Y3ukBaSrZEe+P01MMLyZ
         V0EEz7P//MDWQmRPXdNLHnE9oXA9LKRb/d52ujbfEcAWgW8ydpn1tEU3iGZFhr2WhwpH
         6R9Rm2wHjJge7CS4uWx6Wps9T0HSXr83CyyBhxQKarUhddlNFPXrTnbWN0FcmXJRJADF
         gL6hLw0FI7AkRZygclrLSRGlHw1lqLvXOScrH8sfAPqKeHvABqludN1oiMaPpJF6wxTq
         UOa+Rw2wize8/j9VvEyoCGgBnFNzYwRH+dY/EgU5euaoT34v15pEXjgBUDg+yjY5QvNk
         l6ew==
X-Gm-Message-State: AOJu0YxaaKuydh4B4ixC/h9tt26oX7abRPxFzN0pFh/D4Q/75iHhvT1n
	1TZfu6NuTnRnWc+b+t59XbgjNg==
X-Google-Smtp-Source: AGHT+IHhptM9jGiKnASdRwicfnuRd8rDMhOAWz7BQW7PJi3eFPiHvWovE7BfQ4zpeMeNVsilXqTyVQ==
X-Received: by 2002:a05:6870:6c0b:b0:1f9:571e:f80f with SMTP id na11-20020a0568706c0b00b001f9571ef80fmr27454829oab.13.1701288187396;
        Wed, 29 Nov 2023 12:03:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id s12-20020a056830438c00b006ce2f0818d3sm2098526otv.22.2023.11.29.12.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:03:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8Qm1-005pNS-Mg;
	Wed, 29 Nov 2023 16:03:05 -0400
Date: Wed, 29 Nov 2023 16:03:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Robin Murphy <robin.murphy@arm.com>, akpm@linux-foundation.org,
	alex.williamson@redhat.com, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jasowang@redhat.com,
	jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
	m.szyprowski@samsung.com, netdev@vger.kernel.org,
	paulmck@kernel.org, rdunlap@infradead.org, samuel@sholland.org,
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
	thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
	will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH 08/16] iommu/fsl: use page allocation function provided
 by iommu-pages.h
Message-ID: <20231129200305.GI1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-9-pasha.tatashin@soleen.com>
 <1c6156de-c6c7-43a7-8c34-8239abee3978@arm.com>
 <CA+CK2bCOtwZxTUS60PHOQ3szXdCzau7OpopgFEbbC6a9Frxafg@mail.gmail.com>
 <20231128235037.GC1312390@ziepe.ca>
 <52de3aca-41b1-471e-8f87-1a77de547510@arm.com>
 <CA+CK2bCcfS1Fo8RvTeGXj_ejPRX9--sh5Jz8nzhkZnut4juDmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCcfS1Fo8RvTeGXj_ejPRX9--sh5Jz8nzhkZnut4juDmg@mail.gmail.com>

On Wed, Nov 29, 2023 at 02:45:03PM -0500, Pasha Tatashin wrote:

> > same kind of big systems where IOMMU pagetables would be of any concern.
> > I believe some of the some of the "serious" NICs can easily run up
> > hundreds of megabytes if not gigabytes worth of queues, SKB pools, etc.
> > - would you propose accounting those too?
> 
> Yes. Any kind of kernel memory that is proportional to the workload
> should be accountable. Someone is using those resources compared to
> the idling system, and that someone should be charged.

There is a difference between charged and accounted

You should be running around adding GFP_KERNEL_ACCOUNT, yes. I already
did a bunch of that work. Split that out from this series and send it
to the right maintainers.

Adding a counter for allocations and showing in procfs is a very
different question. IMHO that should not be done in micro, the
threshold to add a new counter should be high.

There is definately room for a generic debugging feature to break down
GFP_KERNEL_ACCOUNT by owernship somehow. Maybe it can already be done
with BPF. IDK

Jason

