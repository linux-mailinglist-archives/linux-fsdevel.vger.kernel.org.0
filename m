Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D808F12544
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 01:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEBX5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 19:57:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:10841 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfEBX5W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 19:57:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 16:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,423,1549958400"; 
   d="gz'50?scan'50,208,50";a="167186677"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 May 2019 16:57:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hMLZn-000HrN-GU; Fri, 03 May 2019 07:57:19 +0800
Date:   Fri, 3 May 2019 07:56:45 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [vfs:work.mount-syscalls 1/10] <stdin>:1388:2: warning: #warning
 syscall open_tree not implemented
Message-ID: <201905030743.YhWB3r4A%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-syscalls
head:   f1b5618e013af28b3c78daf424436a79674423c0
commit: a07b20004793d8926f78d63eb5980559f7813404 [1/10] vfs: syscall: Add open_tree(2) to reference or clone a mount
config: c6x-evmc6678_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a07b20004793d8926f78d63eb5980559f7813404
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=c6x 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> <stdin>:1388:2: warning: #warning syscall open_tree not implemented [-Wcpp]

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--qDbXVdCdHGoSgWSk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4jbaV0gAAA==

--qDbXVdCdHGoSgWSk--
