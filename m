Return-Path: <linux-fsdevel+bounces-3329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6787A7F34FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 18:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988331C20AFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D1D5B204;
	Tue, 21 Nov 2023 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhzywHVT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C3EC1;
	Tue, 21 Nov 2023 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700588013; x=1732124013;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OYanv+5lTPi2eNwGcNhRfKpcWpZhpcXv0NNhzmzR7BU=;
  b=lhzywHVThsn9FVEZtTJyBCCgu+DaGApm6UzxAfE/GODgVM2DW++uGnW0
   y4VwOpChiVaOI40M+a5I9geKxhAFtAmKeRcqBsG/DNU1I1vEKWot7asLW
   +JdxOKU465Oqlo02pEeFvjq3NaXBw3ACA2ik+/A1U+d+E4olhP5HeXec/
   UWD2Wu1lmrta4zaKPBrIiW77BWX+Go2W+RBfst9XYeYvIYldDdwlLpYAw
   fzlpIAoby3Hkr3O1fKhozbzFN2Cy07KLaT7f1UeEOyDfIO1QQduzuOyTQ
   mE/n7Q09OkCJPuz3Ea1QQVlFCZHQV3HN7sOnXKCE+pDoVq3KT0jRMSChe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10557396"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="10557396"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="766712754"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="766712754"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2023 09:33:30 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5Ucq-00085O-16;
	Tue, 21 Nov 2023 17:33:28 +0000
Date: Wed, 22 Nov 2023 01:33:01 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [viro-vfs:work.rename 10/10] htmldocs:
 Documentation/filesystems/directory-locking.rst:33: WARNING: Enumerated list
 ends without a blank line; unexpected unindent.
Message-ID: <202311220106.QLlI24Qn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.rename
head:   450e4154067593d27f3bf7e4a19206e00e40b5e6
commit: 450e4154067593d27f3bf7e4a19206e00e40b5e6 [10/10] rename(): avoid a deadlock in the case of parents having no common ancestor
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220106.QLlI24Qn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220106.QLlI24Qn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/filesystems/directory-locking.rst:33: WARNING: Enumerated list ends without a blank line; unexpected unindent.
>> Documentation/filesystems/directory-locking.rst:46: WARNING: Unexpected indentation.
>> Documentation/filesystems/directory-locking.rst:47: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/filesystems/directory-locking.rst:61: WARNING: Definition list ends without a blank line; unexpected unindent.

vim +33 Documentation/filesystems/directory-locking.rst

    27	
    28	4) link creation.  Locking rules:
    29		* lock the parent
    30		* check that the source is not a directory
    31		* lock the source
    32		* call the method.
  > 33	All locks are exclusive.
    34	
    35	5) rename() that is _not_ cross-directory.  Locking rules:
    36		* lock the parent
    37		* find the source and target.
    38		* decide which of the source and target need to be locked.
    39	The source needs to be locked if it's a non-directory, target - if it's
    40	a non-directory or about to be removed.  Take the locks that need to be
    41	taken, in inode pointer order if need to take both (that can happen only
    42	when both source and target are non-directories - the source because
    43	it wouldn't need to be locked otherwise and the target because mixing
    44	directory and non-directory is allowed only with RENAME_EXCHANGE, and
    45	that won't be removing the target).
  > 46		* call the method.
  > 47	All locks are exclusive.
    48	
    49	6) cross-directory rename.  The trickiest in the whole bunch.  Locking
    50	rules:
    51		* lock the filesystem
    52		* if the parents don't have a common ancestor, fail the operation.
    53		* lock the parents in "ancestors first" order. If neither is an
    54	ancestor of the other, lock the parent of source first.
    55		* find the source and target.
    56		* verify that the source is not a descendent of the target and
    57	target is not a descendent of source; fail the operation otherwise.
    58		* lock the subdirectories involved (source before target).
    59		* lock the non-directories involved, in inode pointer order.
    60		* call the method.
  > 61	All ->i_rwsem are taken exclusive.
    62	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

