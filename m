Return-Path: <linux-fsdevel+bounces-51048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF155AD2380
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6399B18831D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11717218821;
	Mon,  9 Jun 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiFkgMYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB77218589;
	Mon,  9 Jun 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485631; cv=none; b=mIF6uV8g8niizrWk1JSkOk58YHZtJ+8F4xS435XNThZNdfE3U34mLGHSmcQGiSdIlJL36OQ7Rpsnn+NjB2oZ1pE8GgZw4nZjlJaXzwChuUuPgfkytMGki1/DlRTXsQhNxbfsVV/ms/KqAgNpDUH6GjvgVRcmw8rVJtP2r0diiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485631; c=relaxed/simple;
	bh=rR5X4MhdvIVyHHfn1QvZMTSQHbXFh8cct9zLuRjGhQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJge7Ay8E01q10NzeGOoy9RWNfNBfxdSMSlgyOR6bD/VW5MweYiyGSiFC9A+ev7bhkl0C32+Yg4EhPAHMil46sJxJJ1JxiB55E7RAEUATrQc/zuEzhGQsGmKqwhQi26a8Dl5p4Tzf8jq2RMTbVayQ4zD6GIBV3ZBs2grCB03c+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiFkgMYR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749485630; x=1781021630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rR5X4MhdvIVyHHfn1QvZMTSQHbXFh8cct9zLuRjGhQ8=;
  b=JiFkgMYR1jjV2hfbnwl/dWixPI+2HZrZKPcoM2+EFLPyNiOYMY8TlPUl
   ss7mvRZOvbdLdnScf3ohFX+U6ZpLIUt8Q2lyQHkmTpvVD+gWwB+Xhg/uS
   lY3lWAVVLp9CsO6kEtFSGUJc0J320HK4twUeh3eMWK9dRfYGDFJMDvOJx
   If722hfJGNaqvKQ8fv4VxOQGg9Vo9rWyvWGTdS14hN65R2ryG5Yi43fBO
   zSJU58Gd7Dzknqv3DvH8Sik3cn43HQvFkLlmPXVgmQIuktkpvNUbOG1pE
   OTgTSG5nqM+zND1/PbkIyfv7cKgOcQJTPwQYTh/SNSg4dl2yi9lTREBVY
   g==;
X-CSE-ConnectionGUID: a+NtoKvSS6K6+8EyrzhngA==
X-CSE-MsgGUID: 4DCK3rRWQwKIyhRSpdrPpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69016323"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="69016323"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:13:21 -0700
X-CSE-ConnectionGUID: /cCuLQ/jTAaOqFSimUqDtw==
X-CSE-MsgGUID: ixdbVnAARwS6dpIYTG0jBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="147519132"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2025 09:13:19 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOf7b-0007BH-2c;
	Mon, 09 Jun 2025 16:13:15 +0000
Date: Tue, 10 Jun 2025 00:13:08 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <202506100000.34KZcoZ5-lkp@intel.com>
References: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-add-mmap_prepare-compatibility-layer-for-nested-file-systems/20250609-172628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250609092413.45435-1-lorenzo.stoakes%40oracle.com
patch subject: [PATCH] mm: add mmap_prepare() compatibility layer for nested file systems
config: arm-randconfig-002-20250609 (https://download.01.org/0day-ci/archive/20250610/202506100000.34KZcoZ5-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250610/202506100000.34KZcoZ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506100000.34KZcoZ5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: compat_vma_mmap_prepare
   >>> referenced by shm.c
   >>>               ipc/shm.o:(shm_mmap) in archive vmlinux.a
   >>> referenced by backing-file.c
   >>>               fs/backing-file.o:(backing_file_mmap) in archive vmlinux.a
   >>> referenced by nommu.c
   >>>               mm/nommu.o:(do_mmap) in archive vmlinux.a
   >>> referenced 2 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

