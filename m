Return-Path: <linux-fsdevel+bounces-71363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEBBCBF49D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38AF4300F592
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 17:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34A316182;
	Mon, 15 Dec 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZ8v6LPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1C2DA76A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765820893; cv=none; b=Hv1KJsfvSu4fmcKEW9CXGWdXb6u9DNgXU03Y54iM/3cLY7/Vahg3LvYV5oTYRaftZPsW5jkisfh7R3csy1M/pdkLiZ93KxfM3lVrz5HdImDm2QzbLgjAXCOZOCjcJ9WaD9pbfNePotkuCjGKqSz0lXm26NK8zyLj4g+OLk+Q5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765820893; c=relaxed/simple;
	bh=mw+YjId+31VUUwZ3enkF8sOfK0DXNsT9kNSFUhBdcM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QU/YhMSYiJSA0E+PzVUywh6dHqRf3yz9YedeAAfAqqGuRNZavO9KFiC6DZCJVcmZ95cU6hBNO2srxGBJid00HbXWSywfiJPKRvefEDG9KCAztFQMm4BdG+pZxVXElL0S2usSRmPs9JQR10Z+kDYsHnJC4kB9hHqENMdXVc08PCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZ8v6LPP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765820891; x=1797356891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mw+YjId+31VUUwZ3enkF8sOfK0DXNsT9kNSFUhBdcM0=;
  b=DZ8v6LPP9VWG5IG19LUi6cYaPiNgc3x2YEAczFLLEkXM9KRXzmySknYG
   r2fcQCkglspSwcXIv+yTsw+TFXlOy9EagzW1NnZmRoBbjtldTPLdX6ahs
   DzSDjHa2GOG6CXBNQ9zMG6cENIs6ihgKj0Fv481HxbuQl3FPRsBro+ydp
   /AJIn5f64r/3z7NTTr3LrckJIm2SPIVp+qylhimpXrDbiwyLlxONHhunS
   XIeO6R+fjoQ8MWDPFxb4pnpdo2wBZBi3l0m9x9RdfjkfCnT/V+G1ukfqC
   Rp18AuOvbWYSmEzn/56ZTspI6AJlIoVBNR9zAMtjbvBsh8XICyLk8I5f1
   w==;
X-CSE-ConnectionGUID: O6QPf5EzRka4V2amrZ1U4Q==
X-CSE-MsgGUID: TKhL8K5VRNaS5xMLHenIBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67765755"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="67765755"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 09:48:06 -0800
X-CSE-ConnectionGUID: e+tSqgysQb+JFBSdDgJ+Mw==
X-CSE-MsgGUID: oNnZQRVoQyuWL7NB4Rxwpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="202888508"
Received: from lkp-server02.sh.intel.com (HELO 034c7e8e53c3) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 15 Dec 2025 09:48:05 -0800
Received: from kbuild by 034c7e8e53c3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVCfy-000000000ZZ-3fTv;
	Mon, 15 Dec 2025 17:48:02 +0000
Date: Tue, 16 Dec 2025 01:47:49 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.filename 32/59] fs/namespace.c:4993:38: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202512160139.1lFETtvW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.filename
head:   c62b87e860d133e9d1ac10da92eb4359f6d13c52
commit: 2bc5a98f47c0329ca2e8eef172500d49eb7c98c2 [32/59] mount_setattr(2): don't mess with LOOKUP_EMPTY
config: um-randconfig-r133-20251215 (https://download.01.org/0day-ci/archive/20251216/202512160139.1lFETtvW-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251216/202512160139.1lFETtvW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512160139.1lFETtvW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/namespace.c:700:5: sparse: sparse: context imbalance in 'sb_prepare_remount_readonly' - different lock contexts for basic block
   fs/namespace.c:684:9: sparse: sparse: context imbalance in 'setup_mnt' - wrong count at exit
   fs/namespace.c:1354:17: sparse: sparse: context imbalance in 'mntput_no_expire_slowpath' - unexpected unlock
   fs/namespace.c:1395:13: sparse: sparse: context imbalance in 'mntput_no_expire' - different lock contexts for basic block
   fs/namespace.c:1972:6: sparse: sparse: context imbalance in '__detach_mounts' - wrong count at exit
   fs/namespace.c:2333:6: sparse: sparse: context imbalance in 'has_locked_children' - wrong count at exit
   fs/namespace.c:3777:6: sparse: sparse: context imbalance in 'mnt_set_expiry' - wrong count at exit
   fs/namespace.c:3789:6: sparse: sparse: context imbalance in 'mark_mounts_for_expiry' - different lock contexts for basic block
   fs/namespace.c:4093:22: sparse: sparse: context imbalance in 'copy_mnt_ns' - different lock contexts for basic block
   fs/namespace.c:4488:6: sparse: sparse: context imbalance in 'path_is_under' - wrong count at exit
>> fs/namespace.c:4993:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *p @@     got char const [noderef] __user *path @@
   fs/namespace.c:4993:38: sparse:     expected char const *p
   fs/namespace.c:4993:38: sparse:     got char const [noderef] __user *path
   fs/namespace.c: note: in included file (through include/uapi/linux/aio_abi.h, include/linux/syscalls.h):
>> include/linux/fs.h:2529:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const [noderef] __user * @@     got char const *p @@
   include/linux/fs.h:2529:1: sparse:     expected char const [noderef] __user *
   include/linux/fs.h:2529:1: sparse:     got char const *p
   fs/namespace.c:6024:6: sparse: sparse: context imbalance in 'put_mnt_ns' - different lock contexts for basic block
   fs/namespace.c:6091:42: sparse: sparse: context imbalance in 'current_chrooted' - wrong count at exit

vim +4993 fs/namespace.c

  4961	
  4962	SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
  4963			unsigned int, flags, struct mount_attr __user *, uattr,
  4964			size_t, usize)
  4965	{
  4966		int err;
  4967		struct path target;
  4968		struct mount_kattr kattr;
  4969		unsigned int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
  4970	
  4971		if (flags & ~(AT_EMPTY_PATH |
  4972			      AT_RECURSIVE |
  4973			      AT_SYMLINK_NOFOLLOW |
  4974			      AT_NO_AUTOMOUNT))
  4975			return -EINVAL;
  4976	
  4977		if (flags & AT_NO_AUTOMOUNT)
  4978			lookup_flags &= ~LOOKUP_AUTOMOUNT;
  4979		if (flags & AT_SYMLINK_NOFOLLOW)
  4980			lookup_flags &= ~LOOKUP_FOLLOW;
  4981	
  4982		kattr = (struct mount_kattr) {
  4983			.lookup_flags	= lookup_flags,
  4984		};
  4985	
  4986		if (flags & AT_RECURSIVE)
  4987			kattr.kflags |= MOUNT_KATTR_RECURSE;
  4988	
  4989		err = wants_mount_setattr(uattr, usize, &kattr);
  4990		if (err <= 0)
  4991			return err;
  4992	
> 4993		CLASS(filename_uflags, name)(path, flags);
  4994		err = filename_lookup(dfd, name, kattr.lookup_flags, &target, NULL);
  4995		if (!err) {
  4996			err = do_mount_setattr(&target, &kattr);
  4997			path_put(&target);
  4998		}
  4999		finish_mount_kattr(&kattr);
  5000		return err;
  5001	}
  5002	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

