Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E043A125E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 03:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfECBF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 21:05:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:44118 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfECBF0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 21:05:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 18:05:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,423,1549958400"; 
   d="gz'50?scan'50,208,50";a="140843634"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 May 2019 18:05:22 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hMMde-000FYB-7M; Fri, 03 May 2019 09:05:22 +0800
Date:   Fri, 3 May 2019 09:04:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [vfs:work.mount-syscalls 5/10] <stdin>:1394:2: warning: #warning
 syscall fsopen not implemented
Message-ID: <201905030945.jqNRNYJ2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-syscalls
head:   f1b5618e013af28b3c78daf424436a79674423c0
commit: 24dcb3d90a1f67fe08c68a004af37df059d74005 [5/10] vfs: syscall: Add fsopen() to prepare for superblock creation
config: c6x-evmc6678_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 24dcb3d90a1f67fe08c68a004af37df059d74005
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=c6x 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   <stdin>:1388:2: warning: #warning syscall open_tree not implemented [-Wcpp]
   <stdin>:1391:2: warning: #warning syscall move_mount not implemented [-Wcpp]
>> <stdin>:1394:2: warning: #warning syscall fsopen not implemented [-Wcpp]

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--5vNYLRcllDrimb99
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--5vNYLRcllDrimb99--
