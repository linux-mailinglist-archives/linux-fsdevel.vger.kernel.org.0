Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2EF107F26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2019 16:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKWPxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Nov 2019 10:53:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:11746 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfKWPxE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Nov 2019 10:53:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2019 07:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,233,1571727600"; 
   d="scan'208";a="197946288"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Nov 2019 07:53:02 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iYXiX-000GGu-Lh; Sat, 23 Nov 2019 23:53:01 +0800
Date:   Sat, 23 Nov 2019 23:52:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, gregkh@linuxfoundation.org,
        valdis.kletnieks@vt.edu, hch@lst.de, linkinjeon@gmail.com,
        Markus.Elfring@web.de, sj1557.seo@samsung.com, dwagner@suse.de,
        nborisov@suse.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: Re: [PATCH v4 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Message-ID: <201911232350.vY9u3EPj%lkp@intel.com>
References: <20191121052618.31117-13-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121052618.31117-13-namjae.jeon@samsung.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Namjae,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20191121]
[also build test WARNING on v5.4-rc8]
[cannot apply to linus/master v5.4-rc8 v5.4-rc7 v5.4-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Namjae-Jeon/add-the-latest-exfat-driver/20191122-084735
base:    9942eae47585ee056b140bbfa306f6a1d6b8f383

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> fs/exfat/file.c:50:10-11: WARNING: return of 0/1 in function 'exfat_allow_set_time' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
