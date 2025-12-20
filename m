Return-Path: <linux-fsdevel+bounces-71802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 533CDCD3655
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 20:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DB5F30102B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 19:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3430EF95;
	Sat, 20 Dec 2025 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLRHlJn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE52D5946
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Dec 2025 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766260245; cv=none; b=AnHgVxqeLQKjItjv02ZTpOE5o2Nk34kJ982ZQY5u6Su4QCPWSwwiI4EZwMFTV6OST9VuKAZnE8TrVqYUIyVclmoVqSjJxyxItthBWC96TBbkQZWSQgOFlcNg8OKjclqZZGMsd/tIeOeDJu4f/0Qqb40HoIFzbl+drWbQcKjS2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766260245; c=relaxed/simple;
	bh=WqxM6zLHPNzcn2snxw14iGw1tX+zYn+RUvlE4Kj8hwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WB4sZ64b5wbuI1sr59BVyQMsp99osfZLrcKJoTk/fegw/qe1MWUN18DvqhmAKFvkrcriAbKDhEk0LINOos7KwvpZBATToz9ksiEgdYg9oA+umHFWS0auB5dtU9F9wdtFj0drF1VnHCMpZDzakmb+BbZNQ4ryO/cCSbBm/AIkkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLRHlJn2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766260244; x=1797796244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WqxM6zLHPNzcn2snxw14iGw1tX+zYn+RUvlE4Kj8hwQ=;
  b=NLRHlJn2Vb2kfJ8qc+ecYGzG5lCoeYj4PaULx+1GOmyfX9x7409NHPXB
   1V8PkTSoVcgCw9x0I4rLUmYAjYSFvgLuIHjKc2FjN93vA84xPVT2UMkxq
   WT/CId5+bEqy0LDbeAgRV70+57fcbu4Y9cTgHVxhTR9XhwjsY0vYJjfwh
   txAyBZUCp0iBNU4tzK0V3fUjncpqWsUx8z8j8b44nza7T84hNrrFcGu2l
   LzfYNZaLYWW2XMaCMew3mPgQy6OxduAP130jwc0tbJid4fFyzDgXkRDAl
   q2wuuWhQ4cvWgjpiGFd6+DJSghnNxwetIJ/4WM3J/nqLWKqO3pPFuhsYd
   A==;
X-CSE-ConnectionGUID: +o6UbjjBTSimMibwqGK/zQ==
X-CSE-MsgGUID: MM0/GZloT2+POcyxlMOzUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="55758017"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="55758017"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 11:50:43 -0800
X-CSE-ConnectionGUID: jNQpRRLzRzKGMxyH2JqwHQ==
X-CSE-MsgGUID: JrsdUGz9SEyRGDBMIrRHlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="236566135"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Dec 2025 11:50:42 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX2yN-0000000055J-3Z78;
	Sat, 20 Dec 2025 19:50:39 +0000
Date: Sun, 21 Dec 2025 03:50:11 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [viro-vfs:work.filename 16/59] fs/namei.c:142:16: sparse: sparse:
 cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
Message-ID: <202512210317.xkXbWT00-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.filename
head:   dad7ddf7689b35e27b947f9deca9c45358112bc6
commit: dd79605ddd3640c827a3906605ad0083106bebeb [16/59] fs: hide names_cache behind runtime const machinery
config: i386-randconfig-061-20251218 (https://download.01.org/0day-ci/archive/20251221/202512210317.xkXbWT00-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210317.xkXbWT00-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210317.xkXbWT00-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/namei.c:142:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/namei.c:142:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:147:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:897:25: sparse: sparse: context imbalance in 'leave_rcu' - unexpected unlock
   fs/namei.c:2608:19: sparse: sparse: context imbalance in 'path_init' - different lock contexts for basic block

vim +142 fs/namei.c

   139	
   140	static inline struct filename *alloc_filename(void)
   141	{
 > 142		return kmem_cache_alloc(names_cache, GFP_KERNEL);
   143	}
   144	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

