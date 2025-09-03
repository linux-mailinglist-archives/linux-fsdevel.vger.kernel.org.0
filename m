Return-Path: <linux-fsdevel+bounces-60121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D933BB41455
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 07:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592DD17EEF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 05:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513CE2D6629;
	Wed,  3 Sep 2025 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MI3hIWVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04852D63F4;
	Wed,  3 Sep 2025 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756877209; cv=none; b=MeUbLvEkTKJ6VG+EAhPy+J6FDhZ/Fa4nhrXIzFwatDptpPsoa42+2jxjth889x9pRnPl1gKg/fjhJSoIuTbBpKF/KoWuaBeEE+iKqQ7ptZcA3R/J6AL/LxyS93O+ekOwoydh1v0ATiLh0Ayp1e+bVKlLLad+wN2Zs+J9p8/56SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756877209; c=relaxed/simple;
	bh=+U/qyUVufuO9/Wxc0OWe61I/W1hyzeIS2pBPmz4WWRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOgY5xG3rfb7VQVZ8BaZl2KvB3fEGZTlKDx8nh+mMm9ydKlpcl42gxKL7du1UVLLUciBOKFmtrN0QGCJFakyvdq1ZCVHBhK9FK+nnOlW04S6YkogCCdLjkOFhpdLrTH5c+1QDlACo834sDyb/Bnx3TtHFd5WdjN1B1qGt8Mn5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MI3hIWVb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756877208; x=1788413208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+U/qyUVufuO9/Wxc0OWe61I/W1hyzeIS2pBPmz4WWRg=;
  b=MI3hIWVbBpG0OBI19jADcPMh4H6LxJnjop562fIfTQPhnoMfRUUjTCTS
   W012YYi9qGXXCETqXTBDuZMIgmBUkx/Ae+61i+P9zRk2JpvMkvTMNF7Y1
   jzh95ngoUmfmncmt6yES1ZrC0YqwZna8/Lu6fHJT1Ml9PXwHbkYYVG71z
   N8iPDnV33fQkJndiYgNJVsw6pFghDPAkb+Xdap0+J8N5WR4BzPincl42y
   PZZ4acjDTh4VDWmky8MhsdT3GdLHIhdhkWkTCbnroH3ZxRrRcxb3TiQ4D
   ZxI4Av9vhq0nUd0EAK4YAd8hmVajoD5wuA3PkhTNtrDV01MXgGkDwNaMH
   w==;
X-CSE-ConnectionGUID: f17OpPJiTNCcGxSg0KFOkw==
X-CSE-MsgGUID: P1gozppEQDKpNQTfTjZ+Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59092865"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59092865"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 22:26:47 -0700
X-CSE-ConnectionGUID: wIW/+0vBT3Oa/imtc797sg==
X-CSE-MsgGUID: ucQq6avgRw2qGrKoH2kdIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171865325"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2025 22:26:43 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utg12-0003NX-2f;
	Wed, 03 Sep 2025 05:26:40 +0000
Date: Wed, 3 Sep 2025 13:25:47 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: do not assume file == vma->vm_file in
 compat_vma_mmap_prepare()
Message-ID: <202509031346.N6FpuQIA-lkp@intel.com>
References: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-do-not-assume-file-vma-vm_file-in-compat_vma_mmap_prepare/20250902-184946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250902104533.222730-1-lorenzo.stoakes%40oracle.com
patch subject: [PATCH] mm: do not assume file == vma->vm_file in compat_vma_mmap_prepare()
config: i386-buildonly-randconfig-001-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031346.N6FpuQIA-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031346.N6FpuQIA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509031346.N6FpuQIA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/util.c:1145 function parameter 'f_op' not described in '__compat_vma_mmap_prepare'
>> Warning: mm/util.c:1145 function parameter 'file' not described in '__compat_vma_mmap_prepare'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

