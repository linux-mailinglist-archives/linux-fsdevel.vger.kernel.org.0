Return-Path: <linux-fsdevel+bounces-6079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E7B81339D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 15:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CEF283177
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98E5B5AC;
	Thu, 14 Dec 2023 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Anlf8Y5Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3C3BD;
	Thu, 14 Dec 2023 06:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702565557; x=1734101557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODhwqCqXmS7joN9elVUFunOPRQ2tuEhEQcIHRfDVNIw=;
  b=Anlf8Y5QTdEFA0K+y66RMzPgbU4pgWWyOX+hp/ysaFtBKwCc0VdkRHpq
   4LFX6+6+re3tAblSma4c5ZOC6PXBkFMl4a032Cz7FeLLH82yRFJFZYW9p
   N6oNIPpGF6le85ljn8Hng/rnbcS2SbmyOhtKY55SD+cbf0SNyOxRtOnuw
   pHZda6/FJfE+IWXJ0hbU59OW8oxkrG/Y40+ULapGrCZUc+ZMIAMywhLXH
   F7K4EYk1TDALGnsC1jl7dkFWV6K+1Ygi/WO/PIIpWn09R03QYEuljnGCz
   +Rkys7lr814WUdmenAT2sGstW80AyMxkTUxNcOYPtts5al1imE4784nqt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392303420"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="392303420"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:52:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892491877"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="892491877"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2023 06:52:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDn4i-000MBk-1f;
	Thu, 14 Dec 2023 14:52:32 +0000
Date: Thu, 14 Dec 2023 22:51:39 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
	ebiggers@kernel.org, jaegeuk@kernel.org, tytso@mit.edu
Cc: oe-kbuild-all@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: Re: [PATCH 8/8] fscrypt: Move d_revalidate configuration back into
 fscrypt
Message-ID: <202312142213.uyrNJniX-lkp@intel.com>
References: <20231213234031.1081-9-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213234031.1081-9-krisman@suse.de>

Hi Gabriel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jaegeuk-f2fs/dev-test]
[also build test WARNING on jaegeuk-f2fs/dev tytso-ext4/dev linus/master v6.7-rc5 next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/dcache-Add-helper-to-disable-d_revalidate-for-a-specific-dentry/20231214-074322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20231213234031.1081-9-krisman%40suse.de
patch subject: [PATCH 8/8] fscrypt: Move d_revalidate configuration back into fscrypt
config: x86_64-randconfig-123-20231214 (https://download.01.org/0day-ci/archive/20231214/202312142213.uyrNJniX-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312142213.uyrNJniX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312142213.uyrNJniX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/libfs.c:1778:39: warning: unused variable 'generic_encrypted_dentry_ops' [-Wunused-const-variable]
   static const struct dentry_operations generic_encrypted_dentry_ops = {
                                         ^
   1 warning generated.


vim +/generic_encrypted_dentry_ops +1778 fs/libfs.c

608af703519a58 Daniel Rosenberg 2020-11-19  1776  
608af703519a58 Daniel Rosenberg 2020-11-19  1777  #ifdef CONFIG_FS_ENCRYPTION
608af703519a58 Daniel Rosenberg 2020-11-19 @1778  static const struct dentry_operations generic_encrypted_dentry_ops = {
608af703519a58 Daniel Rosenberg 2020-11-19  1779  	.d_revalidate = fscrypt_d_revalidate,
608af703519a58 Daniel Rosenberg 2020-11-19  1780  };
608af703519a58 Daniel Rosenberg 2020-11-19  1781  #endif
608af703519a58 Daniel Rosenberg 2020-11-19  1782  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

