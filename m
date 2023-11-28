Return-Path: <linux-fsdevel+bounces-4093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0272E7FC9AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 23:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3493A1C20E37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EAD5024C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TWRnXEVX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7D41FFB
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:56 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67a18556e4aso29143766d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204595; x=1701809395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iygGvNb1KE298FiVkmeH8gdBVxeTTuJw4eGKIF/nIuM=;
        b=TWRnXEVXJruv36LJOKHOhLjpODPbkfmbkFVGiyOwKEshA3y7p2vwRpd/5C7W+qNM23
         D6nv4XMHyxnItPBrp6yg8UyDYHblV+lzf/h7za7iL8ugRhzV9JfxwzHqKyxe7Xk8Uh/q
         PfP1iVJT2M4KQ7WfHjfApsQ4nZZ5x/pPJmPNH0lUx2TYkwjM3yON0sY4b8BF3B3MuZSB
         Qt9E/+FEDDPITVyILclLHYXmH6fhFO7Gd2aA+9IIMCVoLtHGobMgBqUWIWUXm9UbZ2uR
         3PNpdpfkE6bslU98p/cRIQNaPtkG0vRMRtFyvh7U6nqZ2q0hT6WszqpUe9YACfO1iDi/
         Dbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204595; x=1701809395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iygGvNb1KE298FiVkmeH8gdBVxeTTuJw4eGKIF/nIuM=;
        b=cYGrVMDraqnDfD6YjzuLS9RDtZAO9G8+6xZ37gCZH5lV7dDmGeUcVSjTQ9Eiivt78O
         Vqp/31DYf74lOpm2t9hwFFhn2BJf/NbZxTUVhAE8fckdECXs12ely6B8WO8aE+ICWpW/
         m+QB3HbAZKrPXuWyWuVi3I//yvxEI5Tcv2GwqJ9vMJxYBEQTLkhy/TU0f7OdzMa1riZ7
         bXWanLVeMHkTuzTuitAv3/arq/EUWAjce6FdBtMSSSx8mgNWvGSx9QGMgir78iaDoWdf
         u/bINyx402hOa+rUI490EHV6SM8LTdhggdjrwAK2A6hOzYHT42PWwIjIil3iJxxI2rHV
         8EAQ==
X-Gm-Message-State: AOJu0Yz4yg1GPZ8RV7QtUgpWS6P1baUqt5GIzpR5Ub/oAG5Wd0tLRZKp
	83MW9Kn9qOnjjxhBmOkOVvCeYw==
X-Google-Smtp-Source: AGHT+IE0Jl3QLEggdMt0xv2T8AyvhzkahJgD3VRGmfbhI7sqHJ8Aa/AdHKiYq6E8wbv77IBFZbLYmg==
X-Received: by 2002:ad4:5dc6:0:b0:67a:21aa:6513 with SMTP id m6-20020ad45dc6000000b0067a21aa6513mr18119809qvh.17.1701204595440;
        Tue, 28 Nov 2023 12:49:55 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:54 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jasowang@redhat.com,
	jernej.skrabec@gmail.com,
	jgg@ziepe.ca,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	mst@redhat.com,
	m.szyprowski@samsung.com,
	netdev@vger.kernel.org,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	virtualization@lists.linux.dev,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com
Subject: [PATCH 15/16] vhost-vdpa: account iommu allocations
Date: Tue, 28 Nov 2023 20:49:37 +0000
Message-ID: <20231128204938.1453583-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu allocations should be accounted in order to allow admins to
monitor and limit the amount of iommu memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/vhost/vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index da7ec77cdaff..a51c69c078d9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -968,7 +968,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 			r = ops->set_map(vdpa, asid, iotlb);
 	} else {
 		r = iommu_map(v->domain, iova, pa, size,
-			      perm_to_iommu_flags(perm), GFP_KERNEL);
+			      perm_to_iommu_flags(perm),
+			      GFP_KERNEL_ACCOUNT);
 	}
 	if (r) {
 		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
-- 
2.43.0.rc2.451.g8631bc7472-goog


