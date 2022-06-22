Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4328B553FA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 02:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiFVAu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 20:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFVAuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 20:50:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81352F640
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 17:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655859024; x=1687395024;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HYRjYJoxMg6c6cOtfOUTqLoFZMzyocZwiWmootbhLaE=;
  b=JB3dmakIPndIJPXNTzohYOvYxxG96bo9wG6cJcnSjV+HcH10OOAxtBJu
   bH+Qe/PVFz4u+DU7UfIcCWeX/cYy1kcGF07cBuruHh6UUHMBWWWN1kntQ
   t31LWD6dbj7ms8QjXzapO/p1G/o0LnTlpW7RXwirVZHjGOEs5vXHF58WF
   yMQQEt0r8+KrS5O6JFmtqi8J6iF+K4HRtmeGmm5L408+rWwWNqZCFHoC1
   ZphzQYv1CmnCdufHi1PqUZTRTKEQBEOLmm8+v7arAXSPwuX7Gokx6fvhm
   yy1sigGyOQiLcqwcEp9dZtXMp8P7lBICsQbYHd/3GBIPOe0rcwh9N1X+z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260098092"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="260098092"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 17:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="690215258"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2022 17:50:22 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3oZZ-0000dA-Dl;
        Wed, 22 Jun 2022 00:50:21 +0000
Date:   Wed, 22 Jun 2022 08:50:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.iov_iter_get_pages 33/34] lib/iov_iter.c:1225:58:
 error: passing argument 3 of 'append_pipe' from incompatible pointer type
Message-ID: <202206220821.geOiztBp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter_get_pages
head:   a2a7ea71b10083f1b6250f653c448f863d9212c6
commit: d8115c2f911696d202ba377c54421dc7c055de56 [33/34] pipe_get_pages(): switch to append_pipe()
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220622/202206220821.geOiztBp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?id=d8115c2f911696d202ba377c54421dc7c055de56
        git remote add viro-vfs https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
        git fetch --no-tags viro-vfs work.iov_iter_get_pages
        git checkout d8115c2f911696d202ba377c54421dc7c055de56
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/iov_iter.c: In function 'pipe_get_pages':
>> lib/iov_iter.c:1225:58: error: passing argument 3 of 'append_pipe' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1225 |                 struct page *page = append_pipe(i, left, &off);
         |                                                          ^~~~
         |                                                          |
         |                                                          unsigned int *
   lib/iov_iter.c:270:74: note: expected 'size_t *' {aka 'long unsigned int *'} but argument is of type 'unsigned int *'
     270 | static struct page *append_pipe(struct iov_iter *i, size_t size, size_t *off)
         |                                                                  ~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/append_pipe +1225 lib/iov_iter.c

  1205	
  1206	static ssize_t pipe_get_pages(struct iov_iter *i,
  1207			   struct page ***pages, size_t maxsize, unsigned maxpages,
  1208			   size_t *start)
  1209	{
  1210		unsigned int npages, off, count;
  1211		struct page **p;
  1212		ssize_t left;
  1213	
  1214		if (!sanity(i))
  1215			return -EFAULT;
  1216	
  1217		*start = off = pipe_npages(i, &npages);
  1218		if (!npages)
  1219			return -EFAULT;
  1220		count = want_pages_array(pages, maxsize, off, min(npages, maxpages));
  1221		if (!count)
  1222			return -ENOMEM;
  1223		p = *pages;
  1224		for (npages = 0, left = maxsize ; npages < count; npages++) {
> 1225			struct page *page = append_pipe(i, left, &off);
  1226			if (!page)
  1227				break;
  1228			get_page(*p++ = page);
  1229			if (left <= PAGE_SIZE - off)
  1230				return maxsize;
  1231			left -= PAGE_SIZE - off;
  1232		}
  1233		if (!npages)
  1234			return -EFAULT;
  1235		return maxsize - left;
  1236	}
  1237	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
