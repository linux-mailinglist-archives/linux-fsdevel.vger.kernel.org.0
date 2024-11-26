Return-Path: <linux-fsdevel+bounces-35863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8031D9D8F6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 01:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485DB164869
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 00:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD90F2107;
	Tue, 26 Nov 2024 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHtWPsj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394B161;
	Tue, 26 Nov 2024 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579575; cv=none; b=siBkNM+N3L3AS2Fww9k8Iww+OR1ih7PBvuWkxP/HlyPtoLHbnCh8sPbt1LDimCTS71RZXdfx6KzZzIHEGg6APz+BvT4w+lbdBcHmLYac3vVoSWx97RZ+FfSRth91rBOJZTC5eM3hR0mQZxChOyfLFedGOFZ1uRDhTM3Z/bMOzyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579575; c=relaxed/simple;
	bh=vrRKihhsrhqCl3rAoB+x53rxs7JaO8EdE8B7zyiayBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJfS4l2cSMDpUOS5TH6P7hLNaRnWRXaVqydrqc/PYxg+QcZ6l+/NmpeobpQ4Z7R8N/pSXP4ZqglgMXnzpRjZYqM2C18QWn6fZYwz6yWt/Y+6jdGFQittyEq93mgqebA/Wn1HzaH6+Ynx2wfhLThOvo5/qhIecJDrxY0AzX0RJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHtWPsj3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732579573; x=1764115573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vrRKihhsrhqCl3rAoB+x53rxs7JaO8EdE8B7zyiayBU=;
  b=NHtWPsj36I/MZ0WmrAF81YgBt76PvNXen6HCvJoolNNO9QS8xxSPbBcN
   z9Gy1sZd+VpFrLLJKQd5+/cNoQ81LH+T9g6oHmX0bqpjVle63JOX4Zc1k
   g74u0kPRKzvfstE8t2ZW6h/cXPiVmOtbmfqEVuBi+NaQ/UXZ1cKkEmIdO
   buhi165psLTrntOGrcZMzigARK+ZEiS+ihJMwmvPE9Dsf3NEjDcpIRkzR
   dJRP3MDbkgf+29qFiB68feh9o9wfUrkOprFCtzeoEFYeeukf6kEMUsd9N
   nKPUxbHYuCmocYZcTpMfenqUSTFTZGfZI/HDNbH9emprsVW5SJPN6up0y
   Q==;
X-CSE-ConnectionGUID: GhhPh86rSqeaLRRc8Rec3w==
X-CSE-MsgGUID: Zh3/kPVeTmWyZ7M4juQ8Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="35567880"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="35567880"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 16:06:12 -0800
X-CSE-ConnectionGUID: za6kESCNSF+4W0HO68MYwQ==
X-CSE-MsgGUID: 1wPFI6ZMQsy74p/HsKNWwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="122286713"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Nov 2024 16:06:07 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFj5f-0006ur-2T;
	Tue, 26 Nov 2024 00:06:03 +0000
Date: Tue, 26 Nov 2024 08:06:00 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@meta.com, andrii@kernel.org,
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 fanotify 1/2] fanotify: Introduce fanotify filter
Message-ID: <202411260746.XEdTrLMj-lkp@intel.com>
References: <20241122225958.1775625-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122225958.1775625-2-song@kernel.org>

Hi Song,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jack-fs/fsnotify]
[also build test WARNING on linus/master v6.12 next-20241125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/fanotify-Introduce-fanotify-filter/20241125-110818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
patch link:    https://lore.kernel.org/r/20241122225958.1775625-2-song%40kernel.org
patch subject: [PATCH v3 fanotify 1/2] fanotify: Introduce fanotify filter
config: x86_64-randconfig-123-20241125 (https://download.01.org/0day-ci/archive/20241126/202411260746.XEdTrLMj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241126/202411260746.XEdTrLMj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411260746.XEdTrLMj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/notify/fanotify/fanotify_filter.c:271:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct fanotify_filter_hook *filter_hook @@     got struct fanotify_filter_hook [noderef] __rcu *filter_hook @@
   fs/notify/fanotify/fanotify_filter.c:271:21: sparse:     expected struct fanotify_filter_hook *filter_hook
   fs/notify/fanotify/fanotify_filter.c:271:21: sparse:     got struct fanotify_filter_hook [noderef] __rcu *filter_hook
   fs/notify/fanotify/fanotify_filter.c: note: in included file (through include/linux/kobject.h, include/linux/fanotify.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
--
>> fs/notify/fanotify/fanotify.c:1015:63: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fanotify_filter_hook *filter_hook @@     got struct fanotify_filter_hook [noderef] __rcu *filter_hook @@
   fs/notify/fanotify/fanotify.c:1015:63: sparse:     expected struct fanotify_filter_hook *filter_hook
   fs/notify/fanotify/fanotify.c:1015:63: sparse:     got struct fanotify_filter_hook [noderef] __rcu *filter_hook

vim +271 fs/notify/fanotify/fanotify_filter.c

   262	
   263	/*
   264	 * fanotify_filter_del - Delete a filter from fsnotify_group.
   265	 */
   266	void fanotify_filter_del(struct fsnotify_group *group)
   267	{
   268		struct fanotify_filter_hook *filter_hook;
   269	
   270		fsnotify_group_lock(group);
 > 271		filter_hook = group->fanotify_data.filter_hook;
   272		if (!filter_hook)
   273			goto out;
   274	
   275		rcu_assign_pointer(group->fanotify_data.filter_hook, NULL);
   276		fanotify_filter_hook_free(filter_hook);
   277	
   278	out:
   279		fsnotify_group_unlock(group);
   280	}
   281	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

