Return-Path: <linux-fsdevel+bounces-36723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D59E8A26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 05:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288B6163625
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 04:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA18157484;
	Mon,  9 Dec 2024 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mibf6DnS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C1156649
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717473; cv=none; b=o3rJ3miB09v0qSls2RmW6PtxTAUSbtU71ZS5SFslbMYfkav0CSEn4qquaygmJ18LLH/5ayr62yUMYbQ8P5UcRogrP+F/r8PTahfZdsR2aJui7wuiB1tB7DvZeUTBguw5EJ1h0v+9GfJHDOVk4PaACfjAOBdHGm/U4F+Jk1WTeq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717473; c=relaxed/simple;
	bh=LTeSiA4SAQvn0wFTNehmolPy+YuydOWG3ltyb5U6WNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJVwAEbcEwBiTcx9Z7m/doEl8p5LTB2psaACwHfvWtPfel1GPXiFlR4w8Z9X8zEaE/LtqgeI6imypjLJJ45852V5DfmwvwTrBaJci6gyLLfkI+7TbZPlKzF8hjy4C4PJ+aVvqvvOKWIwCN4DqyjlVdDxWIPoHhsriWK6jJW5UzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mibf6DnS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733717471; x=1765253471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LTeSiA4SAQvn0wFTNehmolPy+YuydOWG3ltyb5U6WNo=;
  b=Mibf6DnS98SSsNW/EUc3H5r5xfwbHszgmkMGKGLFtq+CrbxmfzEfV4Ce
   Zncy8mYuR2OkpQ4qYXzDJRTGG7Q6v7GNlZao/cZMF3+yofLEzU4gV5JkK
   8/n4KeTc3P7kc8EurmuDuNFU2cFkU/zi6+SFX5dbbHUbRuplJQ+Edfrf8
   oXZRadGtp7IdGPQnhF/lB3IgExfOAQ2GhP4LBxE+jKnm0vwQkyL/EMizX
   hOP17CqlqAoknOPCFrW5hKnWTpoUWrRu3khXKAdpFbHD7+4+ErptvhUg5
   CrCwBY+Oe1xtcald6PUSnNP0aurNGV0c2BcqXyDMH12mpUzaTMEildkZo
   w==;
X-CSE-ConnectionGUID: xUwvC0T7RiuDnf1FB0s5tw==
X-CSE-MsgGUID: ApgGIbvsRae1PPJJB8FZKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="21591003"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="21591003"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:11:10 -0800
X-CSE-ConnectionGUID: KkDDo+X0QG+MMTDLM0qZMA==
X-CSE-MsgGUID: QzP86d9nQG2hb8/goSCllw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="125841210"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Dec 2024 20:11:07 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKV6v-0003nn-0j;
	Mon, 09 Dec 2024 04:11:05 +0000
Date: Mon, 9 Dec 2024 12:10:51 +0800
From: kernel test robot <lkp@intel.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <202412071410.oxkaXcVR-lkp@intel.com>
References: <20241206151154.60538-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206151154.60538-1-mszeredi@redhat.com>

Hi Miklos,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.13-rc1]
[cannot apply to jack-fs/fsnotify pcmoore-selinux/next next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miklos-Szeredi/fanotify-notify-on-mount-attach-and-detach/20241206-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20241206151154.60538-1-mszeredi%40redhat.com
patch subject: [PATCH v2] fanotify: notify on mount attach and detach
config: hexagon-randconfig-001-20241207 (https://download.01.org/0day-ci/archive/20241207/202412071410.oxkaXcVR-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412071410.oxkaXcVR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071410.oxkaXcVR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/coredump.c:36:
   include/linux/fsnotify.h:258:20: error: redefinition of 'fsnotify_mntns_delete'
   static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
                      ^
   include/linux/fsnotify_backend.h:914:20: note: previous definition is here
   static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
                      ^
   In file included from fs/coredump.c:36:
>> include/linux/fsnotify.h:260:2: error: implicit declaration of function '__fsnotify_mntns_delete' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           __fsnotify_mntns_delete(mntns);
           ^
   include/linux/fsnotify.h:260:2: note: did you mean 'fsnotify_mntns_delete'?
   include/linux/fsnotify.h:258:20: note: 'fsnotify_mntns_delete' declared here
   static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
                      ^
   2 errors generated.
--
   In file included from fs/namespace.c:22:
   include/linux/fsnotify.h:258:20: error: redefinition of 'fsnotify_mntns_delete'
   static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
                      ^
   include/linux/fsnotify_backend.h:914:20: note: previous definition is here
   static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
                      ^
   In file included from fs/namespace.c:22:
>> include/linux/fsnotify.h:260:2: error: implicit declaration of function '__fsnotify_mntns_delete' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           __fsnotify_mntns_delete(mntns);
           ^
   include/linux/fsnotify.h:260:2: note: did you mean 'fsnotify_mntns_delete'?
   include/linux/fsnotify.h:258:20: note: 'fsnotify_mntns_delete' declared here
   static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
                      ^
>> fs/namespace.c:1126:10: error: no member named 'n_fsnotify_marks' in 'struct mnt_namespace'
           if (ns->n_fsnotify_marks)
               ~~  ^
   3 errors generated.


vim +/__fsnotify_mntns_delete +260 include/linux/fsnotify.h

   257	
 > 258	static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
   259	{
 > 260		__fsnotify_mntns_delete(mntns);
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

