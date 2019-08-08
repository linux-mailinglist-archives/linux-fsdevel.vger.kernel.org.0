Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FDA868C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 20:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfHHSaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 14:30:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:55356 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHSaH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:30:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 11:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="374243644"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2019 11:30:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvnAq-000HZa-VX; Fri, 09 Aug 2019 02:30:04 +0800
Date:   Fri, 9 Aug 2019 02:29:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org
Subject: [vfs:work.dcache 8/12] include/linux/spinlock.h:378:9: sparse:
 sparse: context imbalance in 'dput_to_list' - unexpected unlock
Message-ID: <201908090222.4XW5YtMa%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/viro/vfs.git work.dcache
head:   792981c25a104e3e0c2c469ece8aafd80d85a6e3
commit: a99d7580f66e737c7769350315872bc3b3e8bb18 [8/12] Teach shrink_dcache_parent() to cope with mixed-filesystem shrink lists
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout a99d7580f66e737c7769350315872bc3b3e8bb18
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   include/linux/rculist_bl.h:24:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:24:33: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:24:33: sparse:    struct hlist_bl_node *
   include/linux/rculist_bl.h:24:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:24:33: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:24:33: sparse:    struct hlist_bl_node *
   include/linux/rculist_bl.h:17:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:17:9: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:17:9: sparse:    struct hlist_bl_node *
   include/linux/rculist_bl.h:17:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:17:9: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:17:9: sparse:    struct hlist_bl_node *
   include/linux/spinlock.h:378:9: sparse: sparse: context imbalance in '__dentry_kill' - unexpected unlock
   fs/dcache.c:622:9: sparse: sparse: context imbalance in '__lock_parent' - wrong count at exit
   fs/dcache.c:686:9: sparse: sparse: context imbalance in 'dentry_kill' - wrong count at exit
   fs/dcache.c:859:17: sparse: sparse: context imbalance in 'dput' - unexpected unlock
>> include/linux/spinlock.h:378:9: sparse: sparse: context imbalance in 'dput_to_list' - unexpected unlock
   include/linux/spinlock.h:338:9: sparse: sparse: context imbalance in 'd_prune_aliases' - different lock contexts for basic block
   fs/dcache.c:1055:13: sparse: sparse: context imbalance in 'shrink_lock_dentry' - different lock contexts for basic block
   include/linux/compiler.h:194:9: sparse: sparse: context imbalance in 'shrink_dentry_list' - different lock contexts for basic block
   fs/dcache.c:1124:24: sparse: sparse: context imbalance in 'dentry_lru_isolate' - wrong count at exit
   fs/dcache.c:1205:24: sparse: sparse: context imbalance in 'dentry_lru_isolate_shrink' - wrong count at exit
   fs/dcache.c:1267:13: sparse: sparse: context imbalance in 'd_walk' - different lock contexts for basic block
   fs/dcache.c:1501:24: sparse: sparse: context imbalance in 'select_collect2' - different lock contexts for basic block
   include/linux/rcupdate.h:645:9: sparse: sparse: context imbalance in 'shrink_dcache_parent' - unexpected unlock
   fs/dcache.c:2674:6: sparse: sparse: context imbalance in 'd_add' - different lock contexts for basic block
   include/linux/spinlock.h:378:9: sparse: sparse: context imbalance in '__d_move' - unexpected unlock
   fs/dcache.c:3044:16: sparse: sparse: context imbalance in 'd_splice_alias' - different lock contexts for basic block

vim +/dput_to_list +378 include/linux/spinlock.h

c2f21ce2e31286 Thomas Gleixner 2009-12-02  375  
3490565b633c70 Denys Vlasenko  2015-07-13  376  static __always_inline void spin_unlock(spinlock_t *lock)
c2f21ce2e31286 Thomas Gleixner 2009-12-02  377  {
c2f21ce2e31286 Thomas Gleixner 2009-12-02 @378  	raw_spin_unlock(&lock->rlock);
c2f21ce2e31286 Thomas Gleixner 2009-12-02  379  }
c2f21ce2e31286 Thomas Gleixner 2009-12-02  380  

:::::: The code at line 378 was first introduced by commit
:::::: c2f21ce2e31286a0a32f8da0a7856e9ca1122ef3 locking: Implement new raw_spinlock

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
