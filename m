Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6412E550415
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 12:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiFRKyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 06:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiFRKyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 06:54:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313F10545
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 03:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655549657; x=1687085657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XVBj2xTWoIjiAu0XJ7omPdzCfVeMzAYy4QQ0PJzjJ8A=;
  b=cnj74v6/f+z/YhHTxPPbPZi4cRD+M5kdnixW+G4QeZg43IgG9Zw7z8Jz
   P4Er8NjrAUGLKAhNEtaOrWgUC1NNFLdP0FEb15ywyiZ4pGro2J5YZlPZw
   UFG6kMR839os2oXRbCfVJPfzMOT7vSdLYQVWeQ0mdsYrcVIij+vHIZa/x
   g9C7WldZn0BA+qj59v4/ZbuihI9i19JAChgthpEJXPFvDq0U0PyGriBma
   /BBP3KAFopNuwA4HxhUBSMW0NDN7Q2NYrbYyFDGNaytEEF78qCrTL6mUc
   3owhUAo6di7SXFTpf33s+fnWcIVnRJrSFeuFN1IFedgSPNTr6gQgzxRWo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341330776"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341330776"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 03:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619544494"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2022 03:54:15 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2W5m-000QGd-Cy;
        Sat, 18 Jun 2022 10:54:14 +0000
Date:   Sat, 18 Jun 2022 18:53:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.iov_iter_get_pages 21/33] lib/iov_iter.c:1392:24:
 warning: variable 'len' is uninitialized when used here
Message-ID: <202206181816.oFNEwB8K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter_get_pages
head:   eaf51d32a6d0a79ce7096996fd432ebb03b725e1
commit: 380244e4bdf81bb2e69ed68827d9718d5bfc1bb4 [21/33] iov_iter: massage calling conventions for first_{iovec,bvec}_segment()
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220618/202206181816.oFNEwB8K-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 91688716ba49942051dccdf7b9c4f81a7ec8feaf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?id=380244e4bdf81bb2e69ed68827d9718d5bfc1bb4
        git remote add viro-vfs https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
        git fetch --no-tags viro-vfs work.iov_iter_get_pages
        git checkout 380244e4bdf81bb2e69ed68827d9718d5bfc1bb4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/iov_iter.c:1392:24: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
                   return min_t(size_t, len, res * PAGE_SIZE - *start);
                                        ^~~
   include/linux/minmax.h:104:48: note: expanded from macro 'min_t'
   #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
                                                        ^
   include/linux/minmax.h:38:14: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                              ^
   include/linux/minmax.h:31:25: note: expanded from macro '__cmp_once'
                   typeof(x) unique_x = (x);               \
                                         ^
   lib/iov_iter.c:1361:12: note: initialize the variable 'len' to silence this warning
           size_t len;
                     ^
                      = 0
   1 warning generated.


vim +/len +1392 lib/iov_iter.c

  1356	
  1357	static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
  1358			   struct page ***pages, size_t maxsize,
  1359			   unsigned int maxpages, size_t *start)
  1360	{
  1361		size_t len;
  1362		int n, res;
  1363	
  1364		if (maxsize > i->count)
  1365			maxsize = i->count;
  1366		if (!maxsize)
  1367			return 0;
  1368		if (maxsize > LONG_MAX)
  1369			maxsize = LONG_MAX;
  1370	
  1371		if (likely(user_backed_iter(i))) {
  1372			unsigned int gup_flags = 0;
  1373			unsigned long addr;
  1374	
  1375			if (iov_iter_rw(i) != WRITE)
  1376				gup_flags |= FOLL_WRITE;
  1377			if (i->nofault)
  1378				gup_flags |= FOLL_NOFAULT;
  1379	
  1380			addr = first_iovec_segment(i, &maxsize, start);
  1381			n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
  1382			if (n > maxpages)
  1383				n = maxpages;
  1384			if (*pages) {
  1385				*pages = get_pages_array(n);
  1386				if (!*pages)
  1387					return -ENOMEM;
  1388			}
  1389			res = get_user_pages_fast(addr, n, gup_flags, *pages);
  1390			if (unlikely(res <= 0))
  1391				return res;
> 1392			return min_t(size_t, len, res * PAGE_SIZE - *start);
  1393		}
  1394		if (iov_iter_is_bvec(i)) {
  1395			struct page **p;
  1396			struct page *page;
  1397	
  1398			page = first_bvec_segment(i, &maxsize, start);
  1399			n = DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
  1400			if (n > maxpages)
  1401				n = maxpages;
  1402			p = *pages;
  1403			if (!p) {
  1404				*pages = p = get_pages_array(n);
  1405				if (!p)
  1406					return -ENOMEM;
  1407			}
  1408			for (int k = 0; k < n; k++)
  1409				get_page(*p++ = page++);
  1410			return min_t(size_t, maxsize, n * PAGE_SIZE - *start);
  1411		}
  1412		if (iov_iter_is_pipe(i))
  1413			return pipe_get_pages(i, pages, maxsize, maxpages, start);
  1414		if (iov_iter_is_xarray(i))
  1415			return iter_xarray_get_pages(i, pages, maxsize, maxpages,
  1416						     start);
  1417		return -EFAULT;
  1418	}
  1419	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
