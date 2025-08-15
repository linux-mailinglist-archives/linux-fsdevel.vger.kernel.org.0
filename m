Return-Path: <linux-fsdevel+bounces-58000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA4CB27F9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0DA583739
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43102FC86D;
	Fri, 15 Aug 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkNloPq8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BEA935;
	Fri, 15 Aug 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258755; cv=none; b=Z4I7RDMTRa+EYemnB0YRIyOMnsUVYneIWdhJmHuW+ep7uYCqsQ1yzv5xFXn4D/dsaVCZ7/DAQkXy6U5SJ5v0EvfGRxEKjIhi2Ho6qryyjj4Xb5U2BD8kIIkIWo0bKeE+YA6ZEONB/sBjhijoggOSy0XwTNEAmTpIMxRke4CKPeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258755; c=relaxed/simple;
	bh=QoHIeopxEhpq2ChQcz3Nzrt37RnVLChpjO8YwmFloBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlgLy5Kk/g7+UHfh6ruukiW3GE5d1QBiQDjlOeZkP58J3uaMi9xn1Lnolw/W6TX3OZNT9WjrQt5NvlaptsRKDkF38ukb6oUKxICTapfzhkEmYsfi9gQpcXwRw/ckreinnlNi9K547dWAQz5Y5R7jf+lHqvahYsuH2XqkOhiJxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkNloPq8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755258753; x=1786794753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QoHIeopxEhpq2ChQcz3Nzrt37RnVLChpjO8YwmFloBk=;
  b=NkNloPq8Qzgt+JLpf067EcYImUPJUGOh36dxS1sD/F5wpftDyN3yp51Q
   8Yc/RYd/V7ol8a9cDTo3zYVqpHGg1TtXGUTG6PSyzprZrvPWTPccU9pPD
   nM2IaaXz8UmFjwR045OHD+3s2eUPkAa1Esg3/wPJbW7UgsIy863u4iPh2
   Bx1u/hhvNNDZXEAenRZNq923K/7/rzvrUpHO1NLSaOrzcbz1s7AnAOT+4
   vqZSK2Ct7Wceq2POfE1mrp9iASeZt6oBRGFVq4t2F8VOmpfAXsaWvC+OX
   PMLkWtQOcgfxUzp/1AW2OOopLlJkiUbekXYyWxEsPRR8FePpZGsLpyD33
   Q==;
X-CSE-ConnectionGUID: kKb9tz6LSL2VhqTKOOqUEA==
X-CSE-MsgGUID: oSxG/SSCQ+6ZwaXfNWFKcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57535016"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57535016"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 04:52:33 -0700
X-CSE-ConnectionGUID: Oo6mS44cRLmOnjVzPZ/rOw==
X-CSE-MsgGUID: PEe7H3AbTpeEjMbr/RWSxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171244567"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 15 Aug 2025 04:52:30 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umsyx-000Bw0-2K;
	Fri, 15 Aug 2025 11:52:27 +0000
Date: Fri, 15 Aug 2025 19:52:00 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Theodore Tso <tytso@mit.edu>,
	Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v5 6/9] ovl: Set case-insensitive dentry operations for
 ovl sb
Message-ID: <202508151941.VDMlemUG-lkp@intel.com>
References: <20250814-tonyk-overlayfs-v5-6-c5b80a909cbd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250814-tonyk-overlayfs-v5-6-c5b80a909cbd@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/fs-Create-sb_encoding-helper/20250815-013213
base:   0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
patch link:    https://lore.kernel.org/r/20250814-tonyk-overlayfs-v5-6-c5b80a909cbd%40igalia.com
patch subject: [PATCH v5 6/9] ovl: Set case-insensitive dentry operations for ovl sb
config: i386-buildonly-randconfig-003-20250815 (https://download.01.org/0day-ci/archive/20250815/202508151941.VDMlemUG-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151941.VDMlemUG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151941.VDMlemUG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/overlayfs/super.c:1347:17: warning: unused variable 'ofs' [-Wunused-variable]
    1347 |         struct ovl_fs *ofs = sb->s_fs_info;
         |                        ^~~
   1 warning generated.


vim +/ofs +1347 fs/overlayfs/super.c

  1344	
  1345	static void ovl_set_d_op(struct super_block *sb)
  1346	{
> 1347		struct ovl_fs *ofs = sb->s_fs_info;
  1348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

