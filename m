Return-Path: <linux-fsdevel+bounces-52239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F9FAE0816
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F11C1748B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685322618F;
	Thu, 19 Jun 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NviNWFEb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BDD25C818;
	Thu, 19 Jun 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341485; cv=none; b=bafcNK8YVB+tnqA7IfWTlMrqfkiQhGklmK8e8AA7bDdk7ulM9od0xQwt3b3m7X8YSwHbmBeNF10+LeL7fdfcnJiVILH093Ft012QgKILewMzzzm/S7gWKRdBKpvLiUJMHS6vpS4U9m1sOHvtY23nhez1SGGex2VsoU0zNPQxrkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341485; c=relaxed/simple;
	bh=wjLepEGEAGOgVFQXi2T6s0A59N+eqbjbHSQb5NCvhL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWigepfEcucDhjVvflt60HjVexDgmYpDOhp37Fx65NIZgaEUVpVFqtqxUZrxmSWF9+/Nej47CGgD8V0CTGFfEAJuybLnduptyPtwPpz/nR90t14uxHa/6Jzq57FTeehekwIgVJYlKaH4fJ3UVRKGQru66ubkyBxVKIZ1uT8Urvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NviNWFEb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750341484; x=1781877484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wjLepEGEAGOgVFQXi2T6s0A59N+eqbjbHSQb5NCvhL4=;
  b=NviNWFEb9Vki7i9CyMdLgXUmJGqSHtwiGuy/wD+ETEXtSrfpEJKm1AJS
   mE1K7mDKkXXRYdtHSALHxvwBQmlYxUfr0k7Vv9chFEiuhYNfXAvuqRKUF
   3gFxC06AHkQ07fil+EV7/C8/CLFY1TwU4AqlTjnB6eHBNCpnhVtbCcPFh
   craX2JeT6rDQLVRaUlABEt5VqWNfWRmdh7zJVt/nE6JqpOk81JIj+FyrU
   mzCJxy3saYUNWOEDXv61OJlgnh0bCdhj16zpOOkO4ALC4NpKwNt61ZTQO
   HhyezKDuis1hOn9FVS2hTiRGwclQUATTngqVvFm+C4izm9lgIXIistM/n
   g==;
X-CSE-ConnectionGUID: ezccr3QSS4C7Vixa/9iklg==
X-CSE-MsgGUID: x8cyZXA4QP+DLgDNruOCvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="62863203"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="62863203"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 06:58:04 -0700
X-CSE-ConnectionGUID: ECyZ/YiKTk+0IDKwKw/oxw==
X-CSE-MsgGUID: eRZz2kT1TCCY7JXJv6EIAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="150250014"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2025 06:57:59 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSFm8-000KnG-2h;
	Thu, 19 Jun 2025 13:57:56 +0000
Date: Thu, 19 Jun 2025 21:57:04 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@meta.com, andrii@kernel.org,
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, tj@kernel.org,
	daan.j.demeyer@gmail.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH bpf-next 1/4] kernfs: Add __kernfs_xattr_get for RCU
 protected access
Message-ID: <202506192154.T111naKp-lkp@intel.com>
References: <20250618233739.189106-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618233739.189106-2-song@kernel.org>

Hi Song,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/kernfs-Add-__kernfs_xattr_get-for-RCU-protected-access/20250619-074026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250618233739.189106-2-song%40kernel.org
patch subject: [PATCH bpf-next 1/4] kernfs: Add __kernfs_xattr_get for RCU protected access
config: m68k-randconfig-r122-20250619 (https://download.01.org/0day-ci/archive/20250619/202506192154.T111naKp-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250619/202506192154.T111naKp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506192154.T111naKp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/kernfs/inode.c:312:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/kernfs/inode.c:312:17: sparse:    struct kernfs_iattrs [noderef] __rcu *
   fs/kernfs/inode.c:312:17: sparse:    struct kernfs_iattrs *

vim +312 fs/kernfs/inode.c

   304	
   305	int __kernfs_xattr_get(struct kernfs_node *kn, const char *name,
   306			       void *value, size_t size)
   307	{
   308		struct kernfs_iattrs *attrs;
   309	
   310		WARN_ON_ONCE(!rcu_read_lock_held());
   311	
 > 312		attrs = rcu_dereference(kn->iattr);
   313		if (!attrs)
   314			return -ENODATA;
   315	
   316		return simple_xattr_get(&attrs->xattrs, name, value, size);
   317	}
   318	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

