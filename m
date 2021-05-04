Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075F6372B62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 15:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEDNyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 09:54:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:17665 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhEDNyW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 09:54:22 -0400
IronPort-SDR: ceaqAVd4hBk9zh0lN1cft/kw3J4GcLkstZLiP+ne8ORi6Xqof3BiKdUTbx1og1Llai1+QqrfTZ
 mjMEEPqs69Nw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="261931529"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="261931529"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 06:53:27 -0700
IronPort-SDR: 9IBzdtR05XNcA+WaFIt/dtBkcayAdn9/W4aqRzZ0upjmBbxoSR5geYnQn4XbjQdJDLxSX3MKNW
 cQ0UH5ZyOBrQ==
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="427779311"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 06:53:24 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ldvUH-009YPd-II; Tue, 04 May 2021 16:53:21 +0300
Date:   Tue, 4 May 2021 16:53:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 12/14] seq_file: Replace seq_escape() with inliner
Message-ID: <YJFR0atvema45xQs@smile.fi.intel.com>
References: <20210504102648.88057-13-andriy.shevchenko@linux.intel.com>
 <202105042134.dgC8x5iF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105042134.dgC8x5iF-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 04, 2021 at 09:17:35PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linux/master]
> [also build test WARNING on linus/master v5.12 next-20210504]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/lib-string_helpers-get-rid-of-ugly-_escape_mem_ascii/20210504-182828
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1fe5501ba1abf2b7e78295df73675423bd6899a0
> config: s390-randconfig-r033-20210504 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8f5a2a5836cc8e4c1def2bdeb022e7b496623439)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://github.com/0day-ci/linux/commit/047508aa8c09cb58cf304e9025283021731b3921
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andy-Shevchenko/lib-string_helpers-get-rid-of-ugly-_escape_mem_ascii/20210504-182828
>         git checkout 047508aa8c09cb58cf304e9025283021731b3921
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=s390 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/tty/vt/selection.c:36:9: warning: 'isspace' macro redefined [-Wmacro-redefined]
>    #define isspace(c)      ((c) == ' ')

Nice!
Also for the rest of redefinitions...

I'll prepare fixes.

-- 
With Best Regards,
Andy Shevchenko


