Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB314ECE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 14:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgAaNF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 08:05:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:57780 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgAaNFZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:05:25 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 05:05:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; 
   d="scan'208";a="224442854"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2020 05:05:24 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ixVz8-0003eQ-0W; Fri, 31 Jan 2020 21:05:22 +0800
Date:   Fri, 31 Jan 2020 21:04:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [linux-next:master 4531/12088] fs/fs_parser.c:191:5: sparse: sparse:
 symbol 'fs_param_bad_value' was not declared. Should it be static?
Message-ID: <202001312114.IkYUPqKR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   c8e31a0fc39797784e4b9acae3bd2e0c7bade36e
commit: 2552e0ea2d71360b76faf1cd4ffb58019c92f817 [4531/12088] turn fs_param_is_... into functions
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-154-g1dc00f87-dirty
        git checkout 2552e0ea2d71360b76faf1cd4ffb58019c92f817
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/fs_parser.c:191:5: sparse: sparse: symbol 'fs_param_bad_value' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
