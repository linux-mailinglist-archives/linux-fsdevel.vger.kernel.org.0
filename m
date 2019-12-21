Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96878128AD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 19:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfLUSgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 13:36:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:12751 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfLUSgq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 13:36:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2019 10:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,340,1571727600"; 
   d="scan'208";a="213565121"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Dec 2019 10:36:43 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iijcI-000EZQ-Q5; Sun, 22 Dec 2019 02:36:42 +0800
Date:   Sun, 22 Dec 2019 02:36:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     kbuild-all@lists.01.org, Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] vfs: Handle file systems without ->parse_params better
Message-ID: <201912220244.6ohMQ4WK%lkp@intel.com>
References: <20191212213604.19525-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212213604.19525-1-labbott@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Laura,

I love your patch! Perhaps something to improve:

[auto build test WARNING on vfs/for-next]
[cannot apply to dhowells-fs/fscache-next linus/master v5.5-rc2 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Laura-Abbott/vfs-Handle-file-systems-without-parse_params-better/20191216-053622
base:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/fs_context.c:119:39: sparse: sparse: symbol 'generic_fs_parameters' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
