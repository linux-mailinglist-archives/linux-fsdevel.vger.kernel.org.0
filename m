Return-Path: <linux-fsdevel+bounces-74371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E86E2D39EA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D33D1304392A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66023266B72;
	Mon, 19 Jan 2026 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6JfePMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409A26F29C;
	Mon, 19 Jan 2026 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804502; cv=none; b=secB3o9VBKKWASfFWt/S6SzggDvRzv3F+rEWMBAZ7N1lf1qyxkmaORlDQ2J4+e6y/LiBZrSFxXODYvtgCAln4pJ1bJ9dpcGdTZ/Y2PzPIK7xpb4zehSDkx93tj/GBNifAi1LXf/iAA+cl7GIRalgPDpiRsYHMQkMvP/9qOzd1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804502; c=relaxed/simple;
	bh=QbCHdqfLV2tvIBj/6ow9t/3s/bZUZIKilVJAAbBiIbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=schag5NSaldbC3J6B5FlK5hZb3uTdStxfgRlEiDc3JsD27PbVaA2KyRe2p0P7DSiwC5eIk9RehEOKZKbBFGAs3lPytjTVKfhDPhfK6zLgWZ32k9xNWoDfoPFeP1FrMQG/dxQDXYwkBrRNsEV3dJVBlbmhF9Z9zNb0iXi+hqXEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6JfePMo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768804500; x=1800340500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QbCHdqfLV2tvIBj/6ow9t/3s/bZUZIKilVJAAbBiIbI=;
  b=a6JfePMojcJRmp4u1/tlMqsjnyXPjIrWDKe754gYSjX1GM+WIzj0Vgwt
   dda/4CY3tcpPh7ETwuE0usndbiMqNnPFGe7D7SZPyPQ0E/APATzTVq5lS
   7x+pyLpH7rHVgW3Kmps16yEf/TQSwMgvfdtJUzKiykdj9UnJrA8MHjq8H
   LBWcLgitiIdVQhYv5M85N35pwR5XbEqAixTTL71TyeuWf3nro1POVDfwb
   8t8jlQaeVOroz7Me+jYcs1o2icVd/an1SsylcikfGWQbVnNsn40FYpCFP
   SZjZsOVp0ZNtiayArplTqIRPIewT9PgZ4MkcOWcx+nHNTpu0oc2f663Zd
   g==;
X-CSE-ConnectionGUID: PRvrYk43R26nimdRydiW9g==
X-CSE-MsgGUID: Jrs9mHc7RTye6MhRIJa48A==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="57565268"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="57565268"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 22:34:59 -0800
X-CSE-ConnectionGUID: 0bVwmciUSAmUnZHQAnEeKA==
X-CSE-MsgGUID: 3fhQ+SwdTeuNErHLrsRYEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205824245"
Received: from linux-pnp-server-15.sh.intel.com ([10.239.177.153])
  by orviesa007.jf.intel.com with ESMTP; 18 Jan 2026 22:34:54 -0800
From: Zhiguo Zhou <zhiguo.zhou@intel.com>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: willy@infradead.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	tianyou.li@intel.com,
	tim.c.chen@linux.intel.com,
	gang.deng@intel.com,
	Zhiguo Zhou <zhiguo.zhou@intel.com>
Subject: [PATCH 0/2] mm/readahead: batch folio insertion to improve performance
Date: Mon, 19 Jan 2026 14:50:23 +0800
Message-ID: <20260119065027.918085-1-zhiguo.zhou@intel.com>
X-Mailer: git-send-email 2.43.0
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


