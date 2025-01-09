Return-Path: <linux-fsdevel+bounces-38689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB963A06A58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 02:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E450188715C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF13A8D2;
	Thu,  9 Jan 2025 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJ7z2xfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175E2629D;
	Thu,  9 Jan 2025 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736386477; cv=none; b=CPCoCCTfzUG+50ltEBgKuSPFtuzo1EQsaT1i6/erYMAmpwxFVUowGd5wDE9VL/fdvCFl3yk2MADz4AhyPRNI4YKjU723VedYLH8D4jG+LIGLt682fbpMEEhRvGvvr8QJQ59FKMFBT1RaUEsv50cqfix2WL9Z1X+V4xLyYlZ1exA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736386477; c=relaxed/simple;
	bh=RER8xEkbtZJunXd1DrZR4xiCOceE1iPmaLstar6K/Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMKnnPXChjs/0B0GHyh0gxaLoJIDuY9Ovs5cEOWhnx09HEbQHEtvaKMzMF2/1ckClBkdWIAg0rnpTUtJyS0YdRI4Az+gv+OeLFh9GHBkLlFO9p7ZLUXpbShwxo4HpcV8wNS2zTtUPZ0wdhYZ9iy/mq7ZfRC+VWHMPB8qmSv0NNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJ7z2xfp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736386475; x=1767922475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RER8xEkbtZJunXd1DrZR4xiCOceE1iPmaLstar6K/Ws=;
  b=HJ7z2xfpq3HIkCajFTpaJdrlZyGaNCgBl4XDsM9Mj+HQ8Q3zpR/qjBhy
   7k6GXEs6Vs66yVj5Osrnn8TOeNQhua9MOurpe4UskxgJlYoZ9rBbhgiJ1
   WR9gNhZNeCb2x35MZx7IPUzA32Y7lUhycRUe7iMoavgwfHQ7UJp0hSaMx
   LCDCxyWcW0zeTRSlkf3ypB5S+TCNNHYyXraOGf+RJDOU3kv+84IJHRLVB
   YFnpRtH9dWOLpvDwgnckl24J5cBq/k224yMB/gOPHR+SOm98TYJdqNX7w
   MTT13Z4+TceTM9u8DNYs96ehOLy3nAjDj16EDqJLcwyhRwyh3kOdXooVu
   w==;
X-CSE-ConnectionGUID: uVNnNOfZT0GcSnoqRsp8mQ==
X-CSE-MsgGUID: D24oJ0fRRkyl4rfXJhdoXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40313991"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="40313991"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 17:34:35 -0800
X-CSE-ConnectionGUID: Hc5lWmCDRcOCp4HuSUdhaQ==
X-CSE-MsgGUID: 8EZhG4KIQciXTPEzWMApnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107305857"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.65])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 17:34:32 -0800
Date: Wed, 8 Jan 2025 17:34:30 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, linux-mm@kvack.org,
	lina@asahilina.net, zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com
Subject: Re: [PATCH v5 00/25] fs/dax: Fix ZONE_DEVICE page reference counts
Message-ID: <Z38npigJajz_gm-5@aschofie-mobl2.lan>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>

On Tue, Jan 07, 2025 at 02:42:16PM +1100, Alistair Popple wrote:
> Main updates since v4:
> 
>  - Removed most of the devdax/fsdax checks in fs/proc/task_mmu.c. This
>    means smaps/pagemap may contain DAX pages.
> 
>  - Fixed rmap accounting of PUD mapped pages.
> 
>  - Minor code clean-ups.
> 
> Main updates since v3:
> 
>  - Rebased onto next-20241216.

Hi Alistair-

This set passes the ndctl/dax unit tests when applied to next-20241216

Tested-by: Alison Schofield <alison.schofield@intel.com>

-- snip



