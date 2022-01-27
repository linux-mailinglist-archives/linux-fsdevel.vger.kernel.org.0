Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF649E990
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 18:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiA0R7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 12:59:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:58392 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233778AbiA0R7v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306391; x=1674842391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MbebQvVeK/L5gHgjdvp87DSPXN0J04vX9FIoAyBipG8=;
  b=iDgMn4vCcgHemV/6jQuQ7b4fNmsd5zr7tWkk9+4JrN1g2Fuco0w3wpCQ
   CwzDd5HKWZJJUE4Xs2fHZlxzwTx1GfDyx7AGq7i5AcGHh7nfYuNADzsay
   QF536foCnX9Vqavg4bNn3NX8NxMfVmi1U34qnc+G90OrbIfWrgnigorYW
   WDAobG0XHu/pauRGjB6jorNC9GX+R9DibI8w/VWOiNsPCVkAQ9Vc+VDwo
   RMn851vG3bNg33CLH6cJhKITXiiHLTSsTShKi+LGuipPzw7YtRn6Arnjz
   eWRMpwAHDBUSwUxOPEbibt57FI5MCERNFSH2BLITqs+kXVudchJISDWWA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="227596793"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="227596793"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="480393272"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2022 09:57:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD918-000MtF-2I; Thu, 27 Jan 2022 17:57:06 +0000
Date:   Fri, 28 Jan 2022 01:56:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v10 8/9] xfs: Implement ->notify_failure() for XFS
Message-ID: <202201280101.4ECasWmD-lkp@intel.com>
References: <20220127124058.1172422-9-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127124058.1172422-9-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Shiyang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.17-rc1 next-20220127]
[cannot apply to xfs-linux/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220127-204239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: ia64-defconfig (https://download.01.org/0day-ci/archive/20220128/202201280101.4ECasWmD-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/cb7650562991fc273fbf4c53b6e3db4bb9bb0b5e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220127-204239
        git checkout cb7650562991fc273fbf4c53b6e3db4bb9bb0b5e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/xfs/xfs_buf.h:14,
                    from fs/xfs/xfs_linux.h:80,
                    from fs/xfs/xfs.h:22,
                    from fs/xfs/xfs_notify_failure.c:6:
   include/linux/dax.h:73:30: warning: 'struct dax_holder_operations' declared inside parameter list will not be visible outside of this definition or declaration
      73 |                 const struct dax_holder_operations *ops)
         |                              ^~~~~~~~~~~~~~~~~~~~~
   fs/xfs/xfs_notify_failure.c:220:14: error: variable 'xfs_dax_holder_operations' has initializer but incomplete type
     220 | const struct dax_holder_operations xfs_dax_holder_operations = {
         |              ^~~~~~~~~~~~~~~~~~~~~
   fs/xfs/xfs_notify_failure.c:221:10: error: 'const struct dax_holder_operations' has no member named 'notify_failure'
     221 |         .notify_failure         = xfs_dax_notify_failure,
         |          ^~~~~~~~~~~~~~
>> fs/xfs/xfs_notify_failure.c:221:35: warning: excess elements in struct initializer
     221 |         .notify_failure         = xfs_dax_notify_failure,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   fs/xfs/xfs_notify_failure.c:221:35: note: (near initialization for 'xfs_dax_holder_operations')
   fs/xfs/xfs_notify_failure.c:220:36: error: storage size of 'xfs_dax_holder_operations' isn't known
     220 | const struct dax_holder_operations xfs_dax_holder_operations = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +221 fs/xfs/xfs_notify_failure.c

   219	
   220	const struct dax_holder_operations xfs_dax_holder_operations = {
 > 221		.notify_failure		= xfs_dax_notify_failure,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
