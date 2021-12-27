Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA27480296
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 18:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhL0RHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 12:07:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:58422 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhL0RHh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 12:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640624857; x=1672160857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nM84cc11HFk2HmUjcmlzoeZWzGPg6p3uhxB1YO8OS50=;
  b=fe5FweHCXP6tlIOfmlhVftgeMET3CoLMQqLdJzpNbbXW/R2J83jD5mnf
   e7u84dQlki7qDq/AL/yqkZX9aFHRfKb+ky372lydse11lthSMn7Q+RW/f
   oEtAoGwCWPKH2aZQFcs7zstmD3MSo5swYoaHpI9szf8n4XQfMTzMxn0HI
   23j6v1JAePesBugiTgRvOtxUXqSLXZGtLk3N2n50B/6gLlBsGQuIjiv89
   76wIV9PCe6XcMGaj2hb2DXHelmd0NCVkTdZCmeI3bhR+eaJ7cGB1K8spo
   AtI73Co8FJyY8BH9+fFEhsurwUP6Zqau8f5JxFCzUy7Qc4LEPsE9UBSFh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="241452740"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="241452740"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 09:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="553852120"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2021 09:07:31 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1tT8-0006cY-B8; Mon, 27 Dec 2021 17:07:30 +0000
Date:   Tue, 28 Dec 2021 01:07:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com
Subject: Re: [PATCH v1 12/23] erofs: implement fscache-based metadata read
Message-ID: <202112280115.O0H8Ow1Q-lkp@intel.com>
References: <20211227125444.21187-13-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227125444.21187-13-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeffle,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on dhowells-fs/fscache-next]
[cannot apply to xiang-erofs/dev-test ceph-client/for-linus linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-next
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20211228/202112280115.O0H8Ow1Q-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c3453b91df3b4e89c3336453437f761d6cb6bca3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
        git checkout c3453b91df3b4e89c3336453437f761d6cb6bca3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "netfs_subreq_terminated" [fs/erofs/erofs.ko] undefined!
>> ERROR: modpost: "netfs_readpage" [fs/erofs/erofs.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
