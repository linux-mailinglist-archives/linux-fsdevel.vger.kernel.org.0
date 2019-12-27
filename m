Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6138112BB9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 23:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfL0WdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 17:33:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:65380 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfL0WdE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 17:33:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 14:33:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,364,1571727600"; 
   d="gz'50?scan'50,208,50";a="223834496"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Dec 2019 14:33:02 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ikyAI-00006O-1v; Sat, 28 Dec 2019 06:33:02 +0800
Date:   Sat, 28 Dec 2019 06:32:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     kbuild-all@lists.01.org,
        Linux Filesystem Development List 
        <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] memcg: fix a crash in wb_workfn when a device disappears
Message-ID: <201912280602.fO5HZ5FQ%lkp@intel.com>
References: <20191227194829.150110-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vbiywd53zwtknk5j"
Content-Disposition: inline
In-Reply-To: <20191227194829.150110-1-tytso@mit.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--vbiywd53zwtknk5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Theodore,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on linus/master v5.5-rc3 next-20191220]
[cannot apply to tytso-fscrypt/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Theodore-Ts-o/memcg-fix-a-crash-in-wb_workfn-when-a-device-disappears/20191228-035221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 1f676247f36a4bdea134de5e8bc5041db9678c4e
config: nds32-allnoconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from mm/fadvise.c:16:
   include/linux/backing-dev.h: In function 'bdi_dev_name':
>> include/linux/backing-dev.h:513:9: error: implicit declaration of function 'dev_name' [-Werror=implicit-function-declaration]
     513 |  return dev_name(bdi->dev);
         |         ^~~~~~~~
>> include/linux/backing-dev.h:513:9: warning: returning 'int' from a function with return type 'const char *' makes pointer from integer without a cast [-Wint-conversion]
     513 |  return dev_name(bdi->dev);
         |         ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/perf_event.h:50,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:85,
                    from mm/fadvise.c:20:
   include/linux/device.h: At top level:
   include/linux/device.h:1370:27: error: conflicting types for 'dev_name'
    1370 | static inline const char *dev_name(const struct device *dev)
         |                           ^~~~~~~~
   In file included from mm/fadvise.c:16:
   include/linux/backing-dev.h:513:9: note: previous implicit declaration of 'dev_name' was here
     513 |  return dev_name(bdi->dev);
         |         ^~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from fs/super.c:32:
   include/linux/backing-dev.h: In function 'bdi_dev_name':
>> include/linux/backing-dev.h:513:9: error: implicit declaration of function 'dev_name' [-Werror=implicit-function-declaration]
     513 |  return dev_name(bdi->dev);
         |         ^~~~~~~~
>> include/linux/backing-dev.h:513:9: warning: returning 'int' from a function with return type 'const char *' makes pointer from integer without a cast [-Wint-conversion]
     513 |  return dev_name(bdi->dev);
         |         ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/dev_name +513 include/linux/backing-dev.h

   508	
   509	static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
   510	{
   511		if (!bdi || !bdi->dev)
   512			return bdi_unknown_name;
 > 513		return dev_name(bdi->dev);
   514	}
   515	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--vbiywd53zwtknk5j
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vbiywd53zwtknk5j--
