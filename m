Return-Path: <linux-fsdevel+bounces-6337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EC0815D44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 04:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1D32847E3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829215CE;
	Sun, 17 Dec 2023 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1s1Pqq2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3EE1878
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Dec 2023 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702782559; x=1734318559;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g5CURWEQkF62VIh3RmQCQJr90Pr0jMlBh2UMAiR5UDM=;
  b=f1s1Pqq297NSibEks9NFkqdhlDwKPOK6fCTabgljP/Aai3hDxZNbU25n
   5Yef8zlUhL+0MMZeBc9GIDRlgE4isAO6cKZzIGSayz3cflOZm4C7oJD5Q
   2AS0gORWVLk8cd5wEyIriLtgfeyLQbJ1Pfshkn0Vtm0aD/GnRfqzUIXgw
   Xe85XcBDVl39hA0XbQBbTpzq+ezegQNkQFXf3h7IHXZquxGDJ0WI82rEK
   qaO1h5BC8i6U5UJDMWfiZNLqfmVbjucPakNKs7HrDHqqoFxLMk0L6i4XO
   /Xxcl6wlRO3L7yO511btPdhElT4tcNyCe7r5SizoV/g+FzjGXfP3XF+ub
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="2250059"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="2250059"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 19:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="751367419"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="751367419"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2023 19:09:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEhWj-0002YX-1Q;
	Sun, 17 Dec 2023 03:09:13 +0000
Date: Sun, 17 Dec 2023 11:08:26 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:headers.unaligned 2/2] tools/arch/x86/lib/insn.c:16:10:
 fatal error: '../include/linux/unaligned.h' file not found
Message-ID: <202312171105.MC5EGJ0W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Al,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git headers.unaligned
head:   3169da8e80dfca2bcbfb6e998e2f36bcdcd5895a
commit: 3169da8e80dfca2bcbfb6e998e2f36bcdcd5895a [2/2] move asm/unaligned.h to linux/unaligned.h
config: i386-randconfig-002-20231217 (https://download.01.org/0day-ci/archive/20231217/202312171105.MC5EGJ0W-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171105.MC5EGJ0W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171105.MC5EGJ0W-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/tools/insn_sanity.c:19:
>> tools/arch/x86/lib/insn.c:16:10: fatal error: '../include/linux/unaligned.h' file not found
   #include "../include/linux/unaligned.h" /* __ignore_sync_check__ */
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +16 tools/arch/x86/lib/insn.c

  > 16	#include "../include/linux/unaligned.h" /* __ignore_sync_check__ */
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

