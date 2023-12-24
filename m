Return-Path: <linux-fsdevel+bounces-6882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD1181DC8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 22:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FF7281BD9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 21:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A4FFC19;
	Sun, 24 Dec 2023 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogjD8IM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8A107A0
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-35ffc781b3bso58175ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 13:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703453674; x=1704058474; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TfM2Ozc84jVU4EjDuheFZr1xJI8bldYDvajnMAoQpG8=;
        b=ogjD8IM8k6nG6i47WrDOpIVa5tb0zEcbectB6OzBQjfO6QQf+gJbNgemrWecQ4KZ+a
         Bd+NB0HK6TKsTJx25uPuM4c/VQ3W45XIQPfpjcRCqsgQikg2qFPtR4HSj3W8ndYmEbwt
         U3AXQmq3EgFXeqc2JxLdn7OVbRN2vYlSbnDNDiVPkRP+88dXmM5NLIN9sfdFfXpDarxe
         cZ7KIz37Pmd3cx6uMT6jU0nL1RxkMEJUebyc7URqXzA0TlfinE/1pcTDP4uy2uMJFom0
         e9ClyTGGDsU6Z1qlbquIGe/0CqkMZ/wbYDWO/yanq0sFeH7QN8cxG1gyYU4eDF51jHEY
         b0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703453674; x=1704058474;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfM2Ozc84jVU4EjDuheFZr1xJI8bldYDvajnMAoQpG8=;
        b=X6eFymrnDGQqUe73ahK/iiyOk+o4yEsHvOaiiP9rIcYF7vRf8OCw0sFOdugco8EI9U
         hPEozTkQF5LEI1+51aGrEaxgyHJgq+ipIsi5LsbDbJDnoj6MwJFFdRDX6Ex/eab3Lbc+
         itY2qE3oL2i5ZbfYXb0P0wChfv8htzvxdJgvL4VlNKnIv9tj4EKNvyOsgAFPP8ce6oEC
         p82xeufNUCCOlM6zDjuxDAlOSTGF+ZeV3V+Cp81d0c01iZlH/efLF0ve7rLgVWbh91yH
         JCb8U77sfQhdxXF7mxf5CMvKtctr8tCqg4vRKGJg7IxkfNAV6TT7UeMmJyeZRNMgctVU
         AotQ==
X-Gm-Message-State: AOJu0YysDIX8Ov7nO+ofxwkxL8j6rpozwm0vmJkmmi51hR87HJqGdle5
	nK9lsP1wUmUIT3dJNuTDQjjbSjt+BV5n
X-Google-Smtp-Source: AGHT+IG3cVdgoPXJNOP0FoX9QP3AtXmf/dh4TZ34AQ57wFrWDSmH4MJwWcFfrokVe6jo4lwlGVdhWA==
X-Received: by 2002:a92:6802:0:b0:35f:ff76:2d40 with SMTP id d2-20020a926802000000b0035fff762d40mr25383ilc.28.1703453673759;
        Sun, 24 Dec 2023 13:34:33 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id h16-20020aa79f50000000b006d9ab1e15c3sm2281753pfr.129.2023.12.24.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:34:33 -0800 (PST)
Date: Sun, 24 Dec 2023 13:34:32 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
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
    suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
    thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
    vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 03/10] iommu/io-pgtable-arm: use page allocation
 function provided by iommu-pages.h
In-Reply-To: <20231130201504.2322355-4-pasha.tatashin@soleen.com>
Message-ID: <f36a5a1e-f28f-c25b-337b-8c67ccd46943@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-4-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Convert iommu/io-pgtable-arm.c to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>

