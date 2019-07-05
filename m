Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA20A60C14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfGEUMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:12:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:5611 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfGEUMJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:12:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 13:12:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,456,1557212400"; 
   d="scan'208";a="363673907"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2019 13:12:07 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hjUYw-000BFR-Ls; Sat, 06 Jul 2019 04:12:06 +0800
Date:   Sat, 6 Jul 2019 04:11:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org
Subject: [vfs:next-merge-candidate 54/91] init/do_mounts.c:388:30: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <201907060437.oVdBfXTr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/viro/vfs.git next-merge-candidate
head:   095c2233958cdefe6f28aa1120e96f55fe9a7f46
commit: 33488845f211afcdb7e5c00a3152890e06cdc78e [54/91] constify ksys_mount() string arguments
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 33488845f211afcdb7e5c00a3152890e06cdc78e
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> init/do_mounts.c:388:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *dev_name @@    got n:1> *dev_name @@
>> init/do_mounts.c:388:30: sparse:    expected char const [noderef] <asn:1> *dev_name
   init/do_mounts.c:388:30: sparse:    got char *name
>> init/do_mounts.c:388:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected char const [noderef] <asn:1> *dir_name @@    got n:1> *dir_name @@
>> init/do_mounts.c:388:36: sparse:    expected char const [noderef] <asn:1> *dir_name
   init/do_mounts.c:388:36: sparse:    got char *
>> init/do_mounts.c:388:45: sparse: sparse: incorrect type in argument 3 (different address spaces) @@    expected char const [noderef] <asn:1> *type @@    got n:1> *type @@
>> init/do_mounts.c:388:45: sparse:    expected char const [noderef] <asn:1> *type
   init/do_mounts.c:388:45: sparse:    got char *fs
   init/do_mounts.c:388:56: sparse: sparse: incorrect type in argument 5 (different address spaces) @@    expected void [noderef] <asn:1> *data @@    got n:1> *data @@
   init/do_mounts.c:388:56: sparse:    expected void [noderef] <asn:1> *data
   init/do_mounts.c:388:56: sparse:    got void *data
   init/do_mounts.c:392:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts.c:392:20: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts.c:392:20: sparse:    got char *
   init/do_mounts.h:19:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *pathname @@    got n:1> *pathname @@
   init/do_mounts.h:19:21: sparse:    expected char const [noderef] <asn:1> *pathname
   init/do_mounts.h:19:21: sparse:    got char *name
   init/do_mounts.h:20:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts.h:20:27: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts.h:20:27: sparse:    got char *name
   init/do_mounts.c:624:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *dev_name @@    got n:1> *dev_name @@
   init/do_mounts.c:624:20: sparse:    expected char const [noderef] <asn:1> *dev_name
   init/do_mounts.c:624:20: sparse:    got char *
   init/do_mounts.c:624:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected char const [noderef] <asn:1> *dir_name @@    got n:1> *dir_name @@
   init/do_mounts.c:624:25: sparse:    expected char const [noderef] <asn:1> *dir_name
   init/do_mounts.c:624:25: sparse:    got char *
   init/do_mounts.c:625:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts.c:625:21: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts.c:625:21: sparse:    got char *
--
   init/do_mounts_initrd.c:52:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts_initrd.c:52:19: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts_initrd.c:52:19: sparse:    got char *
   init/do_mounts_initrd.c:56:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts_initrd.c:56:20: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts_initrd.c:56:20: sparse:    got char *
>> init/do_mounts_initrd.c:57:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *dev_name @@    got n:1> *dev_name @@
>> init/do_mounts_initrd.c:57:20: sparse:    expected char const [noderef] <asn:1> *dev_name
   init/do_mounts_initrd.c:57:20: sparse:    got char *
>> init/do_mounts_initrd.c:57:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected char const [noderef] <asn:1> *dir_name @@    got n:1> *dir_name @@
>> init/do_mounts_initrd.c:57:25: sparse:    expected char const [noderef] <asn:1> *dir_name
   init/do_mounts_initrd.c:57:25: sparse:    got char *
   init/do_mounts_initrd.c:58:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts_initrd.c:58:21: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts_initrd.c:58:21: sparse:    got char *
   init/do_mounts.h:19:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *pathname @@    got n:1> *pathname @@
   init/do_mounts.h:19:21: sparse:    expected char const [noderef] <asn:1> *pathname
   init/do_mounts.h:19:21: sparse:    got char *name
   init/do_mounts.h:20:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts.h:20:27: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts.h:20:27: sparse:    got char *name
   init/do_mounts_initrd.c:74:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *pathname @@    got n:1> *pathname @@
   init/do_mounts_initrd.c:74:20: sparse:    expected char const [noderef] <asn:1> *pathname
   init/do_mounts_initrd.c:74:20: sparse:    got char *
   init/do_mounts_initrd.c:75:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts_initrd.c:75:20: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts_initrd.c:75:20: sparse:    got char *
   init/do_mounts_initrd.c:92:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *dev_name @@    got n:1> *dev_name @@
   init/do_mounts_initrd.c:92:20: sparse:    expected char const [noderef] <asn:1> *dev_name
   init/do_mounts_initrd.c:92:20: sparse:    got char *
   init/do_mounts_initrd.c:92:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected char const [noderef] <asn:1> *dir_name @@    got n:1> *dir_name @@
   init/do_mounts_initrd.c:92:26: sparse:    expected char const [noderef] <asn:1> *dir_name
   init/do_mounts_initrd.c:92:26: sparse:    got char *
   init/do_mounts_initrd.c:94:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts_initrd.c:94:21: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts_initrd.c:94:21: sparse:    got char *
   init/do_mounts_initrd.c:97:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts_initrd.c:97:28: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts_initrd.c:97:28: sparse:    got char *
   init/do_mounts_initrd.c:101:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts_initrd.c:101:20: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts_initrd.c:101:20: sparse:    got char *
   init/do_mounts_initrd.c:106:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *dev_name @@    got n:1> *dev_name @@
   init/do_mounts_initrd.c:106:28: sparse:    expected char const [noderef] <asn:1> *dev_name
   init/do_mounts_initrd.c:106:28: sparse:    got char *
   init/do_mounts_initrd.c:106:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected char const [noderef] <asn:1> *dir_name @@    got n:1> *dir_name @@
   init/do_mounts_initrd.c:106:36: sparse:    expected char const [noderef] <asn:1> *dir_name
   init/do_mounts_initrd.c:106:36: sparse:    got char *
   init/do_mounts_initrd.c:110:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts_initrd.c:110:36: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts_initrd.c:110:36: sparse:    got char *
   init/do_mounts_initrd.c:116:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char [noderef] <asn:1> *name @@    got n:1> *name @@
   init/do_mounts_initrd.c:116:29: sparse:    expected char [noderef] <asn:1> *name
   init/do_mounts_initrd.c:116:29: sparse:    got char *
   init/do_mounts.h:19:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *pathname @@    got n:1> *pathname @@
   init/do_mounts.h:19:21: sparse:    expected char const [noderef] <asn:1> *pathname
   init/do_mounts.h:19:21: sparse:    got char *name
   init/do_mounts.h:20:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/do_mounts.h:20:27: sparse:    expected char const [noderef] <asn:1> *filename
   init/do_mounts.h:20:27: sparse:    got char *name
   init/do_mounts_initrd.c:139:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *pathname @@    got n:1> *pathname @@
   init/do_mounts_initrd.c:139:37: sparse:    expected char const [noderef] <asn:1> *pathname
   init/do_mounts_initrd.c:139:37: sparse:    got char *
   init/do_mounts_initrd.c:144:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *pathname @@    got n:1> *pathname @@
   init/do_mounts_initrd.c:144:21: sparse:    expected char const [noderef] <asn:1> *pathname
   init/do_mounts_initrd.c:144:21: sparse:    got char *

vim +388 init/do_mounts.c

^1da177e4 Linus Torvalds       2005-04-16  384  
^1da177e4 Linus Torvalds       2005-04-16  385  static int __init do_mount_root(char *name, char *fs, int flags, void *data)
^1da177e4 Linus Torvalds       2005-04-16  386  {
d8c9584ea Al Viro              2011-12-07  387  	struct super_block *s;
312db1aa1 Dominik Brodowski    2018-03-11 @388  	int err = ksys_mount(name, "/root", fs, flags, data);
^1da177e4 Linus Torvalds       2005-04-16  389  	if (err)
^1da177e4 Linus Torvalds       2005-04-16  390  		return err;
^1da177e4 Linus Torvalds       2005-04-16  391  
447016e96 Dominik Brodowski    2018-03-11  392  	ksys_chdir("/root");
d8c9584ea Al Viro              2011-12-07  393  	s = current->fs->pwd.dentry->d_sb;
d8c9584ea Al Viro              2011-12-07  394  	ROOT_DEV = s->s_dev;
80cdc6dae Mandeep Singh Baines 2011-03-22  395  	printk(KERN_INFO
80cdc6dae Mandeep Singh Baines 2011-03-22  396  	       "VFS: Mounted root (%s filesystem)%s on device %u:%u.\n",
d8c9584ea Al Viro              2011-12-07  397  	       s->s_type->name,
bc98a42c1 David Howells        2017-07-17  398  	       sb_rdonly(s) ? " readonly" : "",
d8c9584ea Al Viro              2011-12-07  399  	       MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
^1da177e4 Linus Torvalds       2005-04-16  400  	return 0;
^1da177e4 Linus Torvalds       2005-04-16  401  }
^1da177e4 Linus Torvalds       2005-04-16  402  

:::::: The code at line 388 was first introduced by commit
:::::: 312db1aa1dc7bff133d95c92efcc5e42b57cefa6 fs: add ksys_mount() helper; remove in-kernel calls to sys_mount()

:::::: TO: Dominik Brodowski <linux@dominikbrodowski.net>
:::::: CC: Dominik Brodowski <linux@dominikbrodowski.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
