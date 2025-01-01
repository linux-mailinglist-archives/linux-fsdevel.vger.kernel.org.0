Return-Path: <linux-fsdevel+bounces-38311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ACB9FF2C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 04:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1A418828FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 03:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8657FEACE;
	Wed,  1 Jan 2025 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gC2DwQrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BA10F7
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jan 2025 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735703492; cv=none; b=VxUbWRWs3YNzn9YgikYaBu8wdyjoK0IcKxuqc3WrJZDgBr4pcN4QUIBIFJu+HMcQAoZdruHQI5T5IwBTMnJHcKfcCZLc4NA5Z1uOONxUo2jBE/KPdpY+jp6jSM6o8+32MjVaEaFhjonEMBcirq8CFLDCZ8BTqvYRFCAbSZDf0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735703492; c=relaxed/simple;
	bh=Ar9EXi84cqAA9J2Z+GuokX9NHXTEilVAdGsUO0pBV84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A4FsfCMSbZLGlreE5bU7cLCcH0oeBW36UIyo1W5q6YyrMqBbH3ejdmlZvXOXYMMtKPfPZBbgQ0PFnHBtXa2pS6wx9f77zc1tRFmr4uRXbPEeiEgHHIyLcGKYek7kK5Eb7/kKH4N+Lyq88EIScs0ZaLBs1jz2YR4QJQP3kAk2urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gC2DwQrD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735703490; x=1767239490;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ar9EXi84cqAA9J2Z+GuokX9NHXTEilVAdGsUO0pBV84=;
  b=gC2DwQrD7ZlMGiBlxFLXcU8Oxc1N0Cw+h4aZfmlB/JNSfUGrMhSVM4sF
   KE+cot5CZSAyUuS6AWTR26sJ6n+ExLspZYypNkuVXqd3u2diYRYOwuspE
   PSvf2v9/eQwtHudhxP3g+L//bC96fAXe0Kpmz3fE+qEAl9VlaJwcI6CnC
   Syf4teaIWatvuXNe61K9DgTsKeB2/NPrbtDQmVZDn+I8R/bl1SQLZZFZA
   /90Cz++ssQLhkMsbyW4bhTtrsCDGMsCIB64VMdbVFVZlYRczoc+0x6vpd
   02+baeDe0HAnwIQJ7j3cw5V+ZZ3ZC2S41nG9M3U/F94a9cVmB/EzywTj1
   g==;
X-CSE-ConnectionGUID: WC86bVvWS9GSLGqJUCC+aA==
X-CSE-MsgGUID: +16Fz4deRCeF/hSjma2nWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="35216450"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="35216450"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 19:51:29 -0800
X-CSE-ConnectionGUID: v05cLbamTsGsmg7JqteeLA==
X-CSE-MsgGUID: fQVlsqVhQWCw11ZOJWQskg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101358434"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 31 Dec 2024 19:51:28 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tSplW-0007bz-00;
	Wed, 01 Jan 2025 03:51:26 +0000
Date: Wed, 1 Jan 2025 11:50:57 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.debugfs 9/20]
 drivers/net/wireless/broadcom/b43legacy/debugfs.c:308:34: error: variable
 has incomplete type 'struct debugfs_short_fops'
Message-ID: <202501011134.jCj6Z1gL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.debugfs
head:   7346de606ecf837810eb4f5cb7aca73beaba43bf
commit: a444dfe1f8508714a93fd5e7aed69d737bc6aa5f [9/20] b43legacy: make use of debugfs_get_aux()
config: powerpc-pmac32_defconfig (https://download.01.org/0day-ci/archive/20250101/202501011134.jCj6Z1gL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 319b89197348b7cad1215e235bdc7b5ec8f9b72c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250101/202501011134.jCj6Z1gL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501011134.jCj6Z1gL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/broadcom/b43legacy/debugfs.c:308:34: error: variable has incomplete type 'struct debugfs_short_fops'
     308 | static struct debugfs_short_fops debugfs_ops = {
         |                                  ^
   drivers/net/wireless/broadcom/b43legacy/debugfs.c:308:15: note: forward declaration of 'struct debugfs_short_fops'
     308 | static struct debugfs_short_fops debugfs_ops = {
         |               ^
   1 error generated.


vim +308 drivers/net/wireless/broadcom/b43legacy/debugfs.c

   307	
 > 308	static struct debugfs_short_fops debugfs_ops = {
   309		.read	= b43legacy_debugfs_read,
   310		.write	= b43legacy_debugfs_write,
   311		.llseek = generic_file_llseek
   312	};
   313	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

