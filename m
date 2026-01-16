Return-Path: <linux-fsdevel+bounces-74114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0E2D302E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 12:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA02630119B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2536922F;
	Fri, 16 Jan 2026 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAX1SSy+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103F3195E8;
	Fri, 16 Jan 2026 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562041; cv=none; b=Kl7pQvdYFPEd3pmG43abQ3hPhOUCzNAMl6az8wT7AhlpJKsAfpJWLf0LwffFr6G0pz1rqVUXS6YEKwJu0DaiduJVNyLVyxGdFDM0Qet2chBOwi/AwCZQVgvDD9jiSy2uLLHJQ4iDwykRD+t/q7597U/DXZ8FBN1a6Lq8iuuI0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562041; c=relaxed/simple;
	bh=7m7TLs5ms8SsBuRtmgorzV61ohfwt2E3J/DzXKAkq0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ohpglvC1nIkj5eQTxslNNHpBhUYIV6qESx/jYOLPUk9pafLyh3xITshySB7lsRT2xXA8W9N9T/OiPo6dLP1Ouf86/mCE/xhT2v5aQVRMXRzZQessF1rRMpqwF9Bhcm4/VtKbvZxJEZquxJVqmw1n0LWiKQJfWxIvsdazhP+Zjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAX1SSy+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768562040; x=1800098040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7m7TLs5ms8SsBuRtmgorzV61ohfwt2E3J/DzXKAkq0s=;
  b=BAX1SSy+zUHYIhkwai28utCCptRsNXOiw3G+3C6VPXfzGyKnZPerG//G
   K9wgFn9zyjH/ziYSfo/1S/NNlFH/7cneMxGye0o1gd60OsPUc+9Skgr+s
   3Tzn1B1fK8L5wzKbLuBI+c7DxGLujt5z6bKcC3C767DUMd8lrOt3dFMkp
   tIHeP27sm+DgqC//TvJVQjZVWyS2LBqeDfDhBV6dOYwbgTgsVC/HbCvU1
   PIFMmcFM71HgkWX9uDQGKb+dnfXINoGdrqC0SqCsF9LLkOgbZM51HPX5v
   WKRHFkgQkXv3oLTyreDehQEypjZ8a+DmFKU1V1CfKnjmcAZIxQMVZmGbH
   w==;
X-CSE-ConnectionGUID: jbo5ZEEBSqKUgBNM2Fv9aA==
X-CSE-MsgGUID: /XfkoD1IQjCAZYX60wbtSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69930619"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="69930619"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 03:13:59 -0800
X-CSE-ConnectionGUID: uIPeeNCuTXKTNMh3SaLJKw==
X-CSE-MsgGUID: 0lzYBIZ5TcqNem+zWWjj8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="209713339"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO fdugast-desk.home) ([10.245.245.100])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 03:13:48 -0800
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Francois Dugast <francois.dugast@intel.com>,
	Zi Yan <ziy@nvidia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 0/5] Enable THP support in drm_pagemap
Date: Fri, 16 Jan 2026 12:10:15 +0100
Message-ID: <20260116111325.1736137-1-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use Balbir Singh's series for device-private THP support [1] and previous
preparation work in drm_pagemap [2] to add 2MB/THP support in xe. This leads
to significant performance improvements when using SVM with 2MB pages.

[1] https://lore.kernel.org/linux-mm/20251001065707.920170-1-balbirs@nvidia.com/
[2] https://patchwork.freedesktop.org/series/151754/

v2:
- rebase on top of multi-device SVM
- add drm_pagemap_cpages() with temporary patch
- address other feedback from Matt Brost on v1

v3:
The major change is to remove the dependency to the mm/huge_memory
helper migrate_device_split_page() that was called explicitely when
a 2M buddy allocation backed by a large folio would be later reused
for a smaller allocation (4K or 64K). Instead, the first 3 patches
provided by Matthew Brost ensure large folios are split at the time
of freeing.

v4:
- add order argument to folio_free callback
- send complete series to linux-mm and MM folks as requested (Zi Yan
  and Andrew Morton) and cover letter to anyone receiving at least
  one of the patches (Liam R. Howlett)

v5:
- update zone_device_page_init() in patch #1 to reinitialize large
  zone device private folios

v6:
- fix drm_pagemap change in patch #1 to allow applying to 6.19 and
  add some comments

Cc: Zi Yan <ziy@nvidia.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Mika Penttilä <mpenttil@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-pci@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org

Francois Dugast (3):
  drm/pagemap: Unlock and put folios when possible
  drm/pagemap: Add helper to access zone_device_data
  drm/pagemap: Enable THP support for GPU memory migration

Matthew Brost (2):
  mm/zone_device: Reinitialize large zone device private folios
  drm/pagemap: Correct cpages calculation for migrate_vma_setup

 arch/powerpc/kvm/book3s_hv_uvmem.c       |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |   2 +-
 drivers/gpu/drm/drm_gpusvm.c             |   7 +-
 drivers/gpu/drm/drm_pagemap.c            | 158 ++++++++++++++++++-----
 drivers/gpu/drm/nouveau/nouveau_dmem.c   |   2 +-
 include/drm/drm_pagemap.h                |  15 +++
 include/linux/memremap.h                 |   9 +-
 lib/test_hmm.c                           |   4 +-
 mm/memremap.c                            |  35 ++++-
 9 files changed, 195 insertions(+), 39 deletions(-)

-- 
2.43.0


