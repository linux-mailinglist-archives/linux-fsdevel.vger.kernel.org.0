Return-Path: <linux-fsdevel+bounces-3786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C2F7F85AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 22:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988411C213CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 21:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C043C494;
	Fri, 24 Nov 2023 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuirzZON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C08B198D;
	Fri, 24 Nov 2023 13:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700862894; x=1732398894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jGRZBAZBF364mV5fItFOiFIV3VjaPOBDqkOVnrlj6us=;
  b=PuirzZONBttUV+TIE8CNigyCXNB86iwyH3Cf6FK8HdnKVWP+uq/NF01o
   vJHvxaUxDKFt/dYKOVNfOcVaxoT8by+RXjWr8Osm4GdHKqzqwQRmxqSTR
   HvzRKsHxU0xuT11H70pS0c/aRuL1S2eEsUSsbmqdBm4Cyzm5JHPe0RPAf
   WJaSri7am1LSAfORmhKbM9cjgDSNCKFQ1EScrzi3R+USQdaZ6MF35sGpd
   d64rCaW5MRrKrAstEGw8U5djjer++S8hQFR1OFn6wER/79oIpEOn8vjNf
   ZfpHCxtVDpntnkpay9anKjYAIJfOLpN8HJzdZPybW/O5IvrjVzI3L51M5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="391344092"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="391344092"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 13:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="802229620"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="802229620"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2023 13:54:50 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6e8N-0003Jb-30;
	Fri, 24 Nov 2023 21:54:47 +0000
Date: Sat, 25 Nov 2023 05:54:25 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, ebiggers@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	brauner@kernel.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
	amir73il@gmail.com, kpsingh@kernel.org, roberto.sassu@huawei.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH v13 bpf-next 6/6] selftests/bpf: Add test that uses
 fsverity and xattr to sign a file
Message-ID: <202311250314.KGxKh0fm-lkp@intel.com>
References: <20231123233936.3079687-7-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123233936.3079687-7-song@kernel.org>

Hi Song,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/bpf-Add-kfunc-bpf_get_file_xattr/20231124-074239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231123233936.3079687-7-song%40kernel.org
patch subject: [PATCH v13 bpf-next 6/6] selftests/bpf: Add test that uses fsverity and xattr to sign a file
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311250314.KGxKh0fm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311250314.KGxKh0fm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> progs/test_sig_in_xattr.c:36:26: error: invalid application of 'sizeof' to an incomplete type 'struct fsverity_digest'
      36 | char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) + SHA256_DIGEST_SIZE];
         |                          ^     ~~~~~~~~~~~~~~~~~~~~~~~~
   progs/test_sig_in_xattr.c:36:40: note: forward declaration of 'struct fsverity_digest'
      36 | char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) + SHA256_DIGEST_SIZE];
         |                                        ^
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

