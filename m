Return-Path: <linux-fsdevel+bounces-74427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82481D3A39F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBEC9303A019
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922E305057;
	Mon, 19 Jan 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Il7vDESU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71727A92E;
	Mon, 19 Jan 2026 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816058; cv=none; b=aqbsCABwO45Nd4wbjhkO4Ne1qprCJiaTGGuHhqwFTi2bW/v+U8oz6wXH/fS7bG8TksXh/xzqg1wTMLBtf9SRJxX2T4JT5ycC2XE7fnVqed5tnye7c5UVut6M01XsqTw4CH305cS5ayzrirsf2APk+fLdLB4yBcM4X8kRc/oP9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816058; c=relaxed/simple;
	bh=QbCHdqfLV2tvIBj/6ow9t/3s/bZUZIKilVJAAbBiIbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1cH6edzBCZ3obYVIkOCgrGMjcaTasssPrgrS2CNYp0xlVV+5cEyderpeaZfT9ZFqOzAVPIbh297OQ3OB2+LQGYfW4iTutrBFSdoY72lsw2Y7zIDKTxNohn5+Y0Q1xmOf8XpzGGyqA6ihzOaYq1Kbo+xZ+tymq8i2z0Zrne3Axc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Il7vDESU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768816056; x=1800352056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QbCHdqfLV2tvIBj/6ow9t/3s/bZUZIKilVJAAbBiIbI=;
  b=Il7vDESU0w4YxhxWTi0VPE+5t0qLNQjrrj++ZL5CcGN56PWvYPKow1Tf
   o2aeDiMJCD+CwtXfg1O5VMDhX73xGK9zLEI+mcJ8z5BYdF1T5C7+rn9IT
   J6J7+BRTw7LFbMOE+tYWPqB3ux4p63Vc8Te3ax2wdt6M/avtHkoK9ZLNF
   5p8Ronnu+3K9CUIvkdAL94LGto0qQiqTkauw17YaXdkruK7sqp0DkTMq3
   Zdm8i34Ib4EcoE/DtJiN7f65ZTSXuL13d2Ztz5xrX8JIW9x4VyaR7bW1Q
   umR4dedT2Mt+xBIqeaSTdhMgvFa6ID6dADNY4kC2EpkRt9nxqZX6qs5Hy
   Q==;
X-CSE-ConnectionGUID: qYfPLoJsS+S242/onYz2Bw==
X-CSE-MsgGUID: UxenbatgRkuD00YUYyvblA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="70072760"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="70072760"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 01:47:35 -0800
X-CSE-ConnectionGUID: udMNvmChTgK/O6cOrLk3fg==
X-CSE-MsgGUID: OwYa3RcmQg+vQDP5kj86ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="204971967"
Received: from linux-pnp-server-15.sh.intel.com ([10.239.177.153])
  by orviesa006.jf.intel.com with ESMTP; 19 Jan 2026 01:47:31 -0800
From: Zhiguo Zhou <zhiguo.zhou@intel.com>
To: zhiguo.zhou@intel.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	gang.deng@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	tianyou.li@intel.com,
	tim.c.chen@linux.intel.com,
	vbabka@suse.cz,
	willy@infradead.org
Subject: [PATCH v2 0/2] mm/readahead: batch folio insertion to improve performance
Date: Mon, 19 Jan 2026 18:02:57 +0800
Message-ID: <20260119100301.922922-1-zhiguo.zhou@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119065027.918085-1-zhiguo.zhou@intel.com>
References: <20260119065027.918085-1-zhiguo.zhou@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series improves readahead performance by batching folio
insertions into the page cache's xarray, reducing the cacheline transfers,
and optimizing the execution efficiency in the critical section.

PROBLEM
=======
When the `readahead` syscall is invoked, `page_cache_ra_unbounded`
currently inserts folios into the page cache individually. Each insertion
requires acquiring and releasing the `xa_lock`, which can lead to:
1. Significant lock contention when running on multi-core systems
2. Cross-core cacheline transfers for the lock and associated data
3. Increased execution time due to frequent lock operations

These overheads become particularly noticeable in high-throughput storage
workloads where readahead is frequently used.

SOLUTION
========
This series introduces batched folio insertion for contiguous ranges in
the page cache. The key changes are:

Patch 1/2: Refactor __filemap_add_folio to separate critical section
- Extract the core xarray insertion logic into
  __filemap_add_folio_xa_locked()
- Allow callers to control locking granularity via a 'xa_locked' parameter
- Maintain existing functionality while preparing for batch insertion

Patch 2/2: Batch folio insertion in page_cache_ra_unbounded
- Introduce filemap_add_folio_range() for batch insertion of folios
- Pre-allocate folios before entering the critical section
- Insert multiple folios while holding the xa_lock only once
- Update page_cache_ra_unbounded to use the new batching interface
- Insert folios individually when memory is under pressure

PERFORMANCE RESULTS
===================
Testing was performed using RocksDB's `db_bench` (readseq workload) on a
32-vCPU Intel Ice Lake server with 256GB memory:

1. Throughput improved by 1.51x (ops/sec)
2. Latency:
   - P50: 63.9% reduction (6.15 usec → 2.22 usec)
   - P75: 42.1% reduction (13.38 usec → 7.75 usec)
   - P99: 31.4% reduction (507.95 usec → 348.54 usec)
3. IPC of page_cache_ra_unbounded (excluding lock overhead) improved by
   2.18x

TESTING DETAILS
===============
- Kernel: v6.19-rc5 (0f61b1, tip of mm.git:mm-stable on Jan 14, 2026)
- Hardware: Intel Ice Lake server, 32 vCPUs, 256GB RAM
- Workload: RocksDB db_bench readseq
- Command: ./db_bench --benchmarks=readseq,stats --use_existing_db=1
           --num_multi_db=32 --threads=32 --num=1600000 --value_size=8192
           --cache_size=16GB

IMPLEMENTATION NOTES
====================
- The existing single-folio insertion API remains unchanged for
  compatibility
- Hugetlb folio handling is preserved through the refactoring
- Error injection (BPF) support is maintained for __filemap_add_folio

Zhiguo Zhou (2):
  mm/filemap: refactor __filemap_add_folio to separate critical section
  mm/readahead: batch folio insertion to improve performance

 include/linux/pagemap.h |   4 +-
 mm/filemap.c            | 238 ++++++++++++++++++++++++++++------------
 mm/hugetlb.c            |   3 +-
 mm/readahead.c          | 196 ++++++++++++++++++++++++++-------
 4 files changed, 325 insertions(+), 116 deletions(-)

-- 
2.43.0


