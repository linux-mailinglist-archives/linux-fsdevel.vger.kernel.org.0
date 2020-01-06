Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E2130CA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 04:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgAFD7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 22:59:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:22244 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbgAFD67 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:58:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2020 19:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,401,1571727600"; 
   d="scan'208";a="222725351"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2020 19:58:57 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ioJXc-000FrL-Vr; Mon, 06 Jan 2020 11:58:56 +0800
Date:   Mon, 6 Jan 2020 11:58:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 2/6] configfd: add generic file descriptor based
 configuration parser
Message-ID: <202001061105.Mud6qLqi%lkp@intel.com>
References: <20200104201432.27320-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104201432.27320-3-James.Bottomley@HansenPartnership.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi James,

I love your patch! Perhaps something to improve:

[auto build test WARNING on s390/features]
[also build test WARNING on linus/master v5.5-rc4 next-20191220]
[cannot apply to arm64/for-next/core tip/x86/asm arm/for-next ia64/next m68k/for-next hp-parisc/for-next powerpc/next sparc-next/master]
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

>> fs/configfd.c:53:30: sparse: sparse: symbol 'configfd_context_fops' was not declared. Should it be static?
>> fs/configfd.c:96:25: sparse: sparse: symbol 'configfd_context_alloc' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
