Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1E361FA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbhDPMVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 08:21:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:50075 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235322AbhDPMVN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:21:13 -0400
IronPort-SDR: 75pAvI0eT6TWT7aQw+cVYG7SoHLgrFXsJfEBROqXvr/mD3Ymua+nwzVAasi/slXgjE7Ial/NT8
 OGa13gb7aCrA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="280350166"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="gz'50?scan'50,208,50";a="280350166"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 05:20:48 -0700
IronPort-SDR: uj6Jq2im4QH3rRDgeQExMLJMA227CFP1VsbvWw7c//Zj6ap7u3roMwNEL2x3V9c+MQ0bTTH+HB
 sLzP/r4T1caA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="gz'50?scan'50,208,50";a="419098732"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2021 05:20:45 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXNSm-00004v-T0; Fri, 16 Apr 2021 12:20:44 +0000
Date:   Fri, 16 Apr 2021 20:20:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Enderborg <peter.enderborg@sony.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <202104162040.x9HAP7ot-lkp@intel.com>
References: <20210416093719.6197-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20210416093719.6197-1-peter.enderborg@sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.12-rc7 next-20210415]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Peter-Enderborg/dma-buf-Add-DmaBufTotal-counter-in-meminfo/20210416-174133
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5e46d1b78a03d52306f21f77a4e4a144b6d31486
config: arc-alldefconfig (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0549b4e26c5fc079bdec725b55fc031a5db388c5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Peter-Enderborg/dma-buf-Add-DmaBufTotal-counter-in-meminfo/20210416-174133
        git checkout 0549b4e26c5fc079bdec725b55fc031a5db388c5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: fs/proc/meminfo.o: in function `meminfo_proc_show':
   meminfo.c:(.text+0x2b2): undefined reference to `dma_buf_get_size'
>> arc-elf-ld: meminfo.c:(.text+0x2b2): undefined reference to `dma_buf_get_size'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--5mCyUwZo2JvN/JJP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--5mCyUwZo2JvN/JJP--
