Return-Path: <linux-fsdevel+bounces-58955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC58B335AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CEC7A9930
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E190722758F;
	Mon, 25 Aug 2025 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOGhfvXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C763194C96
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097778; cv=none; b=fRZZnoFxlVcqRUaL8aWIG4KCXGUj/G0aW85KRYA75gkX4guk2JwFMs5wEo0kQiCZBd5fTR6AIA7d/JK/AnrdQIWULuuvbjTy0rQD0Dm6sq1OK3+54zCJKmXJPSnIzkbpofcp47YqxRezfwByWK+Do/JBvhEwdR+Mg7BjBa/XTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097778; c=relaxed/simple;
	bh=yD/4/GtdSSGMIHV32MZmfSinvuKhgCP3JnI6sOZx0+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ro1f5UixV7x2mUUqzfpPmb/6UyZUt7z/TyhpeawedLkLAm2SsEQxR9rnNJVJn+ZI5a1sI6/korkYEY4ZJY+tHUCkuFDrr+TURpBOzU60CbNXpvNSAjZwvZcElDnYTTqI3Pc/LTYFuLjD1YIAE0eJuqKtxdPLHMWTsd+msKS+Yvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOGhfvXq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756097776; x=1787633776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yD/4/GtdSSGMIHV32MZmfSinvuKhgCP3JnI6sOZx0+g=;
  b=JOGhfvXqrXtgKU/9QVkeFXRuXYbMXlSlnXZv5BHMhHvisZ80wr+zE4WX
   FOYPcvSua4vQRDqydKDT+FSn5oYlsr5oLVK9FcK8khrbkAxiUsLL9jwy/
   vtug8/+5+cIYKv/cq+AX9CiQACFuoGUE9WqIxYdosT95spkPrTH8ue33n
   Kb+WOe1/OAeBcS+OpJxg1jW3FwFU4ueoLR6m+PpCiGHBz5kdLEPTb0P/g
   VHlmdjBCkSAv8tcM2fWgBuJ8cfMI37gsWlASRsCezJlSivLJTmoSOKFrB
   F418CS/IDiK7SLy/uj4O3loV6lB0vdT2tWjf9n8HnVRKBTqLP98wQvy+N
   w==;
X-CSE-ConnectionGUID: 3d625sQnTKS6vzSJ6ERgIQ==
X-CSE-MsgGUID: 4xwv4+nRSYGf4GEQNBsMIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="75754175"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75754175"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 21:56:16 -0700
X-CSE-ConnectionGUID: 2Mg2yANFRneAEVHQFFu3qQ==
X-CSE-MsgGUID: MczH5WZAS0abVM2divR8CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169120774"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 24 Aug 2025 21:56:14 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqPFb-000NNF-3C;
	Mon, 25 Aug 2025 04:56:11 +0000
Date: Mon, 25 Aug 2025 12:55:47 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.mount 30/52] Warning: fs/namespace.c:2616 function
 parameter 'dest' not described in 'attach_recursive_mnt'
Message-ID: <202508251237.lxoKs2Su-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount
head:   8c371c607cea3ffbfcd655e6fc1b36343e03009e
commit: 892335f340ef10da4b58631594ae8068e2edef82 [30/52] graft_tree(), attach_recursive_mnt() - pass pinned_mountpoint
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20250825/202508251237.lxoKs2Su-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250825/202508251237.lxoKs2Su-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508251237.lxoKs2Su-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/namespace.c:2616 function parameter 'dest' not described in 'attach_recursive_mnt'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

