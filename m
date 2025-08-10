Return-Path: <linux-fsdevel+bounces-57206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D9B1F8E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 09:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB75189429C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032701F0994;
	Sun, 10 Aug 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fS/ADF9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448711F949;
	Sun, 10 Aug 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811288; cv=none; b=QrgPvqguAplYEnzXoFG9GG3ERgQwuA3sivaAqHBSXYUl61O+rjzDbHzweUczA6WTFkrnJoJtz8Xg3cFWlhfisT3IhtEK97au+Mb0kKETOFucGaAVMqyWVJnTuxtJXpkt6aB9V/z92cA/vUBQTK1m7s7BRXq/wrAZIVPK1XjpFRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811288; c=relaxed/simple;
	bh=1cnftV9ZF3Q0R7+yHIXJwFiDFygelUCOChgiGCzpd9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEfF9yX6GtMw0oULhwJf6arl8GmJ5nzCLL+OdeZ2TMbwhH/vSvtd7gcx6726A5avBj+dASnsOAvxS0BmISxpg3M91mb5BPEKY+5XmhvaquCv1LehjFVrqcPLPRHHoZZ3Lx/2KWD6FrWT2EsNk50MTRIFQGbTIpsbZyAzP2Vj8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fS/ADF9i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754811286; x=1786347286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1cnftV9ZF3Q0R7+yHIXJwFiDFygelUCOChgiGCzpd9o=;
  b=fS/ADF9iJrwY9VJdcDR0jyCPhBUDJKWHmrXFFL04VFhAOR0C1N98q1Bq
   wlNTDtmu6adOjqOqoYSw6WfFXUbWCueTi/gGRkILsBU4OGsiWyWccsPgQ
   Qze9jbIhnh1LDaxgJN6QkstO3+uIGQwV2Xm/k3VauTpAm2GVLt/fsOzkd
   uekgG7iECekrLk9qq1SK/ai/N7WYsXU9h7jbtHy1d9Vhaw3bwrWJwRhds
   SsZv/p/ALLshBvpJwivQPMqGAbsxrrCX4vuqHOBa59+d7hSLW0t0tJsjb
   TNdY8LNc1pCaLaTBM/hmjAjZoFv4xJwY4Dn2nodFtOcNoLxrOy0xzPWzG
   Q==;
X-CSE-ConnectionGUID: wYyFtBxgS5KghE6SkHaETQ==
X-CSE-MsgGUID: 2nhrbJyCSj6uvmJ31f2hYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11516"; a="60895634"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60895634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 00:34:42 -0700
X-CSE-ConnectionGUID: TZqLbC++SD+IeYgbQNusng==
X-CSE-MsgGUID: FtxuO/2zTHWGCFX0FSdDiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196470041"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 10 Aug 2025 00:34:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ul0ZP-0005Cu-1J;
	Sun, 10 Aug 2025 07:34:27 +0000
Date: Sun, 10 Aug 2025 15:33:04 +0800
From: kernel test robot <lkp@intel.com>
To: alexjlzheng@gmail.com, brauner@kernel.org, djwong@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH 4/4] iomap: don't abandon the whole thing with
 iomap_folio_state
Message-ID: <202508101530.0ER4QBD7-lkp@intel.com>
References: <20250810044806.3433783-5-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810044806.3433783-5-alexjlzheng@tencent.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master next-20250808]
[cannot apply to v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alexjlzheng-gmail-com/iomap-make-sure-iomap_adjust_read_range-are-aligned-with-block_size/20250810-125014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250810044806.3433783-5-alexjlzheng%40tencent.com
patch subject: [PATCH 4/4] iomap: don't abandon the whole thing with iomap_folio_state
config: xtensa-allnoconfig (https://download.01.org/0day-ci/archive/20250810/202508101530.0ER4QBD7-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250810/202508101530.0ER4QBD7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508101530.0ER4QBD7-lkp@intel.com/

All errors (new ones prefixed by >>):

   xtensa-linux-ld: fs/iomap/buffered-io.o: in function `zero_user_segments':
   buffered-io.c:(.text+0x538): undefined reference to `__moddi3'
>> xtensa-linux-ld: buffered-io.c:(.text+0x5c2): undefined reference to `__moddi3'
   xtensa-linux-ld: buffered-io.c:(.text+0x607): undefined reference to `__moddi3'
   xtensa-linux-ld: fs/iomap/buffered-io.o: in function `iomap_read_inline_data':
   buffered-io.c:(.text+0xfa7): undefined reference to `__moddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

