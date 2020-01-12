Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6825D1385D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 11:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbgALKfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 05:35:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:60162 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732600AbgALKfw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 05:35:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 02:35:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,424,1571727600"; 
   d="scan'208";a="247450886"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jan 2020 02:35:49 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iqaaz-000DDn-EX; Sun, 12 Jan 2020 18:35:49 +0800
Date:   Sun, 12 Jan 2020 18:35:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 6/6] fs: bind: add configfs type for bind mounts
Message-ID: <202001121839.DI9w9UxS%lkp@intel.com>
References: <20200104201432.27320-7-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104201432.27320-7-James.Bottomley@HansenPartnership.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi James,

I love your patch! Perhaps something to improve:

[auto build test WARNING on s390/features]
[also build test WARNING on linus/master v5.5-rc5]
[cannot apply to arm64/for-next/core tip/x86/asm arm/for-next ia64/next m68k/for-next hp-parisc/for-next powerpc/next sparc-next/master next-20200110]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/James-Bottomley/introduce-configfd-as-generalisation-of-fsconfig/20200105-080415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/bind.c:28:18: sparse: sparse: symbol 'to_bind_data' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
