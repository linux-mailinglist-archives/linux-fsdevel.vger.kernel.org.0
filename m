Return-Path: <linux-fsdevel+bounces-74242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 770BDD3886E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 22:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B396305CA8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 21:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7772C3033F1;
	Fri, 16 Jan 2026 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZGXnxqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E043298CBE;
	Fri, 16 Jan 2026 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768599446; cv=none; b=Sck5jhCZisMvrdGQTkIQ8/wfJm3rAYL1L28HCWVNWdlJo7ebWDN1q7ZuJIl2YlboS/HfbVEbIi+EsVPOO5g0vKizSGaBfx/td3WVnyyxZPLb6EQQ34ozfVGvqhFQBWEL8aeaqrvwDfnFOldqvCsXjsXgxNHUgF0Md/hoMaZXCaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768599446; c=relaxed/simple;
	bh=cXaYCWY+NFHrw2co2+VwRx7+jg87vo2na/i0pxgM5eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeR/gedjKowNp3rkmT+9+d0Zk0+2q1u9tRQMQpQCWHiVTRx9/ZwSXFNSH/0p61iavl6AwWEw467h04O3ks6mdLTaUrSvWk8qiOtdvMv0DgHaQeLdKrnbaB2gas5IdtnXg9nkh/Zwblicff8b95VvCUUY0Pz883A3JFC2QS4p6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZGXnxqb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768599445; x=1800135445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cXaYCWY+NFHrw2co2+VwRx7+jg87vo2na/i0pxgM5eM=;
  b=OZGXnxqbpzbBfy1H77TF0ubmBqdJ2XJWpkfXz67ShC3Kz0yVK+BfnrCF
   9rUyLponO/MsS6xkFHUUknVuQuj5wkacmoamXF8im5S56vaA64S7fdLlW
   8h+hTvWxKuuSKAapzsbF5Ke2Jbs0AOXODvNu2VxxBloDljU9WjFe8Mq2c
   1Beye2ehku94ibcyw58Hno3chc240/km4+l7rSKxY5H27FlNPRNnvfPyh
   XvVrdbgEE6cSyx5coxxuLJOtE2nkDiRxMbcC5QOj25aMFDlYXzKty0Y47
   6gQQ3D2SfFrdv3DRhd645AnxzF37VPo9zyCe+iGWk3NmxlVsh+fDSjK9Z
   w==;
X-CSE-ConnectionGUID: AUbno4EAT8q3RMbnuORIPw==
X-CSE-MsgGUID: DtJQ7/1BS+6tzmjX3UpBvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="92583829"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="92583829"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 13:37:25 -0800
X-CSE-ConnectionGUID: GpUlGRTFQl2vYTqKJRteGw==
X-CSE-MsgGUID: zFZj+0JbSQ27MRLUM31HiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="205401656"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Jan 2026 13:37:21 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgrVO-00000000LGU-33wE;
	Fri, 16 Jan 2026 21:37:18 +0000
Date: Sat, 17 Jan 2026 05:37:03 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Coddington <bcodding@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 2/4] nfsd: Add a key for signing filehandles
Message-ID: <202601170520.GITVT8Iy-lkp@intel.com>
References: <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bfd453acb5637b5df881cef4b21803344aa9e7ac]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/nfsd-Convert-export-flags-to-use-BIT-macro/20260116-223927
base:   bfd453acb5637b5df881cef4b21803344aa9e7ac
patch link:    https://lore.kernel.org/r/c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding%40hammerspace.com
patch subject: [PATCH v1 2/4] nfsd: Add a key for signing filehandles
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260117/202601170520.GITVT8Iy-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601170520.GITVT8Iy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601170520.GITVT8Iy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfsd/nfsctl.c:2282:50: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
    2282 |         trace_nfsd_ctl_fh_key_set((const char *)fh_key, ret);
         |                                                         ^~~
   fs/nfsd/nfsctl.c:2260:9: note: initialize the variable 'ret' to silence this warning
    2260 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +2282 fs/nfsd/nfsctl.c

  2254	
  2255	int nfsd_nl_fh_key_set_doit(struct sk_buff *skb, struct genl_info *info)
  2256	{
  2257		siphash_key_t *fh_key;
  2258		struct nfsd_net *nn;
  2259		int fh_key_len;
  2260		int ret;
  2261	
  2262		if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_FH_KEY))
  2263			return -EINVAL;
  2264	
  2265		fh_key_len = nla_len(info->attrs[NFSD_A_SERVER_FH_KEY]);
  2266		if (fh_key_len != sizeof(siphash_key_t))
  2267			return -EINVAL;
  2268	
  2269		/* Is the key already set? */
  2270		nn = net_generic(genl_info_net(info), nfsd_net_id);
  2271		if (nn->fh_key)
  2272			return -EEXIST;
  2273	
  2274		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
  2275		if (!fh_key)
  2276			return -ENOMEM;
  2277	
  2278		memcpy(fh_key, nla_data(info->attrs[NFSD_A_SERVER_FH_KEY]), sizeof(siphash_key_t));
  2279		nn = net_generic(genl_info_net(info), nfsd_net_id);
  2280		nn->fh_key = fh_key;
  2281	
> 2282		trace_nfsd_ctl_fh_key_set((const char *)fh_key, ret);
  2283		return ret;
  2284	}
  2285	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

