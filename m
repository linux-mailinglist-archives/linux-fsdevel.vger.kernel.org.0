Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C51654B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 02:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBTB4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 20:56:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:4076 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgBTB4P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:56:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 17:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="gz'50?scan'50,208,50";a="269403483"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Feb 2020 17:56:08 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j4b4S-0000qe-MG; Thu, 20 Feb 2020 09:56:08 +0800
Date:   Thu, 20 Feb 2020 08:53:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] ext4: Add example fsinfo information [ver #16]
Message-ID: <202002200815.T8BgfrUC%lkp@intel.com>
References: <158204563445.3299825.13575924510060131783.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <158204563445.3299825.13575924510060131783.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20200219]
[cannot apply to tip/x86/asm nfs/linux-next ext4/dev linus/master v5.6-rc2 v5.6-rc1 v5.5 v5.6-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/David-Howells/VFS-Filesystem-information-and-notifications-ver-16/20200220-072538
base:    1d7f85df0f9c0456520ae86dc597bca87980d253
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/ext4/super.c:1480:3: error: 'const struct super_operations' has no member named 'fsinfo_attributes'
     .fsinfo_attributes = ext4_fsinfo_attributes,
      ^~~~~~~~~~~~~~~~~

vim +1480 fs/ext4/super.c

  1466	
  1467	static const struct super_operations ext4_sops = {
  1468		.alloc_inode	= ext4_alloc_inode,
  1469		.free_inode	= ext4_free_in_core_inode,
  1470		.destroy_inode	= ext4_destroy_inode,
  1471		.write_inode	= ext4_write_inode,
  1472		.dirty_inode	= ext4_dirty_inode,
  1473		.drop_inode	= ext4_drop_inode,
  1474		.evict_inode	= ext4_evict_inode,
  1475		.put_super	= ext4_put_super,
  1476		.sync_fs	= ext4_sync_fs,
  1477		.freeze_fs	= ext4_freeze,
  1478		.unfreeze_fs	= ext4_unfreeze,
  1479		.statfs		= ext4_statfs,
> 1480		.fsinfo_attributes = ext4_fsinfo_attributes,
  1481		.remount_fs	= ext4_remount,
  1482		.show_options	= ext4_show_options,
  1483	#ifdef CONFIG_QUOTA
  1484		.quota_read	= ext4_quota_read,
  1485		.quota_write	= ext4_quota_write,
  1486		.get_dquots	= ext4_get_dquots,
  1487	#endif
  1488		.bdev_try_to_free_page = bdev_try_to_free_page,
  1489	};
  1490	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--nFreZHaLTZJo0R7j
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
BDzeDIQAAA==

--nFreZHaLTZJo0R7j--
