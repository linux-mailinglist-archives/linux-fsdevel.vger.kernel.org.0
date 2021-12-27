Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828FE4802AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 18:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhL0RT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 12:19:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:9874 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhL0RT6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 12:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640625598; x=1672161598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HGrUp3wJgJu8GbXl17s3CzPoGZmLvMjysUYz4XudtJ8=;
  b=TQWEYqe+FbQzegfE66CoDbjMJGafGH9Kv7R0QXOXgtfeiABXK6+4lGsS
   XwKQzEFIl6nSu/22c3+brdTKNh66HNdLW9m2JignH9x94mBJrc24ypZLq
   Lu5UUc5qtTgdoQTvu2HFvWHNZE1Awrpc/vSTGH83umkKCGcuV+Y0ueds9
   3TkUBO4GDgMOeXjW0PvuQ9n+iiOCrnsLhYsMG4aSAJ1SIBhz6poKmSlWe
   ZvKk3WrFm6u29yfPG8gPAKxu5HotrRAYj5ds0fqUBae9UVIkn0Hh20cHS
   J/YCZ2ZtGgqUsqEXZoI7PWCKnOam09btC5ZsDVn56vZkjAUMaQcywzUCw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="240023791"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="240023791"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 09:18:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="686343731"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Dec 2021 09:18:31 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1tdm-0006dR-Np; Mon, 27 Dec 2021 17:18:30 +0000
Date:   Tue, 28 Dec 2021 01:17:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com
Subject: Re: [PATCH v1 12/23] erofs: implement fscache-based metadata read
Message-ID: <202112280132.0kJ8Vjql-lkp@intel.com>
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
config: x86_64-randconfig-a014-20211227 (https://download.01.org/0day-ci/archive/20211228/202112280132.0kJ8Vjql-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/c3453b91df3b4e89c3336453437f761d6cb6bca3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
        git checkout c3453b91df3b4e89c3336453437f761d6cb6bca3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: do_machine_check()+0x89f: call to queue_task_work() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x59: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   ld: fs/erofs/fscache.o: in function `erofs_issue_op':
   fs/erofs/fscache.c:27: undefined reference to `netfs_subreq_terminated'
   ld: fs/erofs/fscache.o: in function `erofs_readpage_from_fscache':
>> fs/erofs/fscache.c:59: undefined reference to `netfs_readpage'


vim +59 fs/erofs/fscache.c

    35	
    36	struct page *erofs_readpage_from_fscache(struct erofs_cookie_ctx *ctx,
    37						 pgoff_t index)
    38	{
    39		struct folio *folio;
    40		struct page *page;
    41		struct super_block *sb = ctx->inode->i_sb;
    42		int ret;
    43	
    44		page = find_or_create_page(ctx->inode->i_mapping, index, GFP_KERNEL);
    45		if (unlikely(!page)) {
    46			erofs_err(sb, "failed to allocate page");
    47			return ERR_PTR(-ENOMEM);
    48		}
    49	
    50		/* The content is already buffered in the address space */
    51		if (PageUptodate(page)) {
    52			unlock_page(page);
    53			return page;
    54		}
    55	
    56		/* Or a new page cache is created, then read the content from fscache */
    57		folio = page_folio(page);
    58	
  > 59		ret = netfs_readpage(NULL, folio, &erofs_req_ops, ctx->cookie);
    60		if (unlikely(ret || !PageUptodate(page))) {
    61			erofs_err(sb, "failed to read from fscache");
    62			return ERR_PTR(-EINVAL);
    63		}
    64	
    65		return page;
    66	}
    67	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
