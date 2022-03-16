Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC894DBA60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 22:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358179AbiCPVxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 17:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbiCPVxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:53:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF9011C18;
        Wed, 16 Mar 2022 14:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647467558; x=1679003558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oaJPU3mzsyrhJU2vCb6iuLnJLW5/DsmXT3TMUmBnOB8=;
  b=LZ5E/fJUe2mmsGjG5AhN2lpJBHQeqq1VMHjcH6EPNraRsf3uIBLiL7yP
   R7zxJY3BHUXtAbsikTS4kLrHi0fKm5tDFIjVF98o1WarDKweqWtrYM+zl
   JNEmuVqsPklMIK59S6NLi/Js1wVS7tMfEFMSDUJSlbh4Ke0iEMMf4YUUj
   dwzaSj2H7y0ow1eZdbgJE0M/IH7duxkL52CzCzUQOAySP5NcSUKE8Drzg
   DDM9JmtTbYT7f/nSIUJRIB8VrvZc53Lzpyd39mcOGUNSH1vLUH6AYhym7
   Qq3YI+x1Rqng4zYXHyMbnK+4g+81QCOvzHl7Z7ke4ltpLCoGejSF4agFD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="238884185"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="238884185"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="646820651"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 14:52:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUbZI-000Cyl-AM; Wed, 16 Mar 2022 21:52:32 +0000
Date:   Thu, 17 Mar 2022 05:52:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 11/22] erofs: register global fscache volume
Message-ID: <202203170512.Se1LRa68-lkp@intel.com>
References: <20220316131723.111553-12-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316131723.111553-12-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeffle,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on rostedt-trace/for-next linus/master v5.17-rc8]
[cannot apply to xiang-erofs/dev-test dhowells-fs/fscache-next next-20220316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220316-214711
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: hexagon-randconfig-r041-20220313 (https://download.01.org/0day-ci/archive/20220317/202203170512.Se1LRa68-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f52882624bb750e533d0ffa591c3903f08f6d8bb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220316-214711
        git checkout f52882624bb750e533d0ffa591c3903f08f6d8bb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __fscache_relinquish_volume
   >>> referenced by fscache.c
   >>> erofs/fscache.o:(erofs_exit_fscache) in archive fs/built-in.a
   >>> referenced by fscache.c
   >>> erofs/fscache.o:(erofs_exit_fscache) in archive fs/built-in.a
--
>> ld.lld: error: undefined symbol: __fscache_acquire_volume
   >>> referenced by fscache.c
   >>> erofs/fscache.o:(erofs_init_fscache) in archive fs/built-in.a
   >>> referenced by fscache.c
   >>> erofs/fscache.o:(erofs_init_fscache) in archive fs/built-in.a

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
