Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A976553FD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 03:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355328AbiFVBBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 21:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiFVBBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:01:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B90031903
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655859684; x=1687395684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/8Ay8SE6vdamgHyU3COJjdiwNfO/DBJ5aQMwG+8gXBw=;
  b=LVcKDCwynsfkbJcwbsX9kkBpI2bu4Xl2B2mwPLRL23iY8b6Je5c2OUMU
   gWTtPnn19/udhcwtXyf3YORjB5Qapl0OqBkl6gK9nriNUlRGayVqstrbl
   IFOMXwXnr3pUURdPnQ4jqNECjI1ZTFhuTVcmQSd0T/JpZjRnfe8PtuA0z
   wUvAuIhKFsJkKHSJVKHO8fFxG2onW0hwNr9A+Q8I9cY6sadHMTtAc/824
   IFMWBXopNkiB8IL5KVB/o3nSCAvZHGT5ZTI92E6elmWioVEFA5gLUAi7z
   Zr/HtiSM2fNy48V78IZVJ3y/YCwWKfFv8R0lDy3YYUvt50lFyvi9wFNH8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263312559"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="263312559"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 18:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="585501515"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Jun 2022 18:01:22 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3okD-0000e0-TQ;
        Wed, 22 Jun 2022 01:01:21 +0000
Date:   Wed, 22 Jun 2022 09:00:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.iov_iter_get_pages 32/34] fs/splice.c:1170:24: error:
 implicit declaration of function 'iov_iter_get_pages'; did you mean
 'iov_iter_get_pages2'?
Message-ID: <202206220856.nKdUIClR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter_get_pages
head:   a2a7ea71b10083f1b6250f653c448f863d9212c6
commit: 221976dde0b1cce11d9f8af3148ba147ec859c5f [32/34] get rid of non-advancing variants
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220622/202206220856.nKdUIClR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?id=221976dde0b1cce11d9f8af3148ba147ec859c5f
        git remote add viro-vfs https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
        git fetch --no-tags viro-vfs work.iov_iter_get_pages
        git checkout 221976dde0b1cce11d9f8af3148ba147ec859c5f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/splice.c: In function 'iter_to_pipe':
>> fs/splice.c:1170:24: error: implicit declaration of function 'iov_iter_get_pages'; did you mean 'iov_iter_get_pages2'? [-Werror=implicit-function-declaration]
    1170 |                 left = iov_iter_get_pages(from, pages, ~0UL, 16, &start);
         |                        ^~~~~~~~~~~~~~~~~~
         |                        iov_iter_get_pages2
   cc1: some warnings being treated as errors


vim +1170 fs/splice.c

ee6e00c868221f5 Jens Axboe 2020-10-22  1152  
79fddc4efd5d4de Al Viro    2016-09-17  1153  static int iter_to_pipe(struct iov_iter *from,
79fddc4efd5d4de Al Viro    2016-09-17  1154  			struct pipe_inode_info *pipe,
79fddc4efd5d4de Al Viro    2016-09-17  1155  			unsigned flags)
912d35f86781e64 Jens Axboe 2006-04-26  1156  {
79fddc4efd5d4de Al Viro    2016-09-17  1157  	struct pipe_buffer buf = {
79fddc4efd5d4de Al Viro    2016-09-17  1158  		.ops = &user_page_pipe_buf_ops,
79fddc4efd5d4de Al Viro    2016-09-17  1159  		.flags = flags
79fddc4efd5d4de Al Viro    2016-09-17  1160  	};
79fddc4efd5d4de Al Viro    2016-09-17  1161  	size_t total = 0;
79fddc4efd5d4de Al Viro    2016-09-17  1162  	int ret = 0;
79fddc4efd5d4de Al Viro    2016-09-17  1163  
8db7e158dc8b1b2 Al Viro    2022-06-09  1164  	while (iov_iter_count(from)) {
79fddc4efd5d4de Al Viro    2016-09-17  1165  		struct page *pages[16];
8db7e158dc8b1b2 Al Viro    2022-06-09  1166  		ssize_t left;
db85a9eb2e364e2 Al Viro    2016-09-17  1167  		size_t start;
8db7e158dc8b1b2 Al Viro    2022-06-09  1168  		int i, n;
db85a9eb2e364e2 Al Viro    2016-09-17  1169  
8db7e158dc8b1b2 Al Viro    2022-06-09 @1170  		left = iov_iter_get_pages(from, pages, ~0UL, 16, &start);
8db7e158dc8b1b2 Al Viro    2022-06-09  1171  		if (left <= 0) {
8db7e158dc8b1b2 Al Viro    2022-06-09  1172  			ret = left;
79fddc4efd5d4de Al Viro    2016-09-17  1173  			break;
79fddc4efd5d4de Al Viro    2016-09-17  1174  		}
db85a9eb2e364e2 Al Viro    2016-09-17  1175  
8db7e158dc8b1b2 Al Viro    2022-06-09  1176  		n = DIV_ROUND_UP(left + start, PAGE_SIZE);
8db7e158dc8b1b2 Al Viro    2022-06-09  1177  		for (i = 0; i < n; i++) {
8db7e158dc8b1b2 Al Viro    2022-06-09  1178  			int size = min_t(int, left, PAGE_SIZE - start);
8db7e158dc8b1b2 Al Viro    2022-06-09  1179  
8db7e158dc8b1b2 Al Viro    2022-06-09  1180  			buf.page = pages[i];
79fddc4efd5d4de Al Viro    2016-09-17  1181  			buf.offset = start;
79fddc4efd5d4de Al Viro    2016-09-17  1182  			buf.len = size;
79fddc4efd5d4de Al Viro    2016-09-17  1183  			ret = add_to_pipe(pipe, &buf);
79fddc4efd5d4de Al Viro    2016-09-17  1184  			if (unlikely(ret < 0)) {
8db7e158dc8b1b2 Al Viro    2022-06-09  1185  				iov_iter_revert(from, left);
8db7e158dc8b1b2 Al Viro    2022-06-09  1186  				// this one got dropped by add_to_pipe()
8db7e158dc8b1b2 Al Viro    2022-06-09  1187  				while (++i < n)
8db7e158dc8b1b2 Al Viro    2022-06-09  1188  					put_page(pages[i]);
8db7e158dc8b1b2 Al Viro    2022-06-09  1189  				goto out;
79fddc4efd5d4de Al Viro    2016-09-17  1190  			}
8db7e158dc8b1b2 Al Viro    2022-06-09  1191  			total += ret;
8db7e158dc8b1b2 Al Viro    2022-06-09  1192  			left -= size;
8db7e158dc8b1b2 Al Viro    2022-06-09  1193  			start = 0;
912d35f86781e64 Jens Axboe 2006-04-26  1194  		}
912d35f86781e64 Jens Axboe 2006-04-26  1195  	}
8db7e158dc8b1b2 Al Viro    2022-06-09  1196  out:
79fddc4efd5d4de Al Viro    2016-09-17  1197  	return total ? total : ret;
912d35f86781e64 Jens Axboe 2006-04-26  1198  }
912d35f86781e64 Jens Axboe 2006-04-26  1199  

:::::: The code at line 1170 was first introduced by commit
:::::: 8db7e158dc8b1b2aca1a1b33cda0ac91b12b29c5 iter_to_pipe(): switch to advancing variant of iov_iter_get_pages()

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
