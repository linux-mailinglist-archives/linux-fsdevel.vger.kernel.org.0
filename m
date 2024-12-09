Return-Path: <linux-fsdevel+bounces-36722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 764B89E8A22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 05:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F02163393
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 04:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D3F15625A;
	Mon,  9 Dec 2024 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIqHzorF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511D3DBB6
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717230; cv=none; b=FD4EwgsgJ4NFH2yWZcnBSCN7ltPubUBFr8YAQOaZF6AShohznsJUfDuTAcKXuufkkYUNqVwNKIcAYE1cA5PbsF82ZgyNN15FFzLkiqJI7QVp3RExLXyyAP1M/1wU7A66l1E9HeFICy0+KgetqU9Spp9Q7TAuZVHMH7f1O4lSvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717230; c=relaxed/simple;
	bh=VeCCLjKhwMe3TBWX5T0F3Cido5RakX4k2QP+YRN0km8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rooCHnp5Z8FZZ8T2wmoH2Fk7oZrnvm199JSv4QiO32xX1FkQyPSfsLuQxPVz33O4BdwHC3kBH4AEtzB1Zp/exG4SyZeeQItDJ7MrVrS8vYoQowcyngw/mdH5tKJKTeyc4LuavSOSxdU5k5xsWGZprXfVa8YOca48Ysc0suFRqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIqHzorF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733717229; x=1765253229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VeCCLjKhwMe3TBWX5T0F3Cido5RakX4k2QP+YRN0km8=;
  b=nIqHzorFYrY4lGyIGAKwIIFeQ+Z1tu1K5fJqEVlKL24zXeSVCtspNNNW
   9Dz8d60lUUEhbSMS+djer9TkKwbZhqhewkbTHejUoWmqde7Eh3UG2WsEf
   CgX3e/S2FbRHxT8tPoMinLxHyX5sIfQbbGIJq4cAYs3FaQRp8zCtxpuj1
   1wI2AveJfCnow7HPyaxgzHlAK0k0bs3bcDP3154mJna53QLSEULQEgq4k
   Sr2F8+0DUz1nlu/GxwJl85TIt3t+7t/nigI+rVpCNAzlprepTJ1HZUyS6
   DvLsBiY3YxTxDx0kZtETZuuRlsOMw2jYSwrhT7Fx5rQtHRDfMYFt1qYpy
   w==;
X-CSE-ConnectionGUID: MnLMyQ/eQ1ym+xbOmzPwNA==
X-CSE-MsgGUID: mLDaths3RrWdIHAuqw7pdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33347012"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="33347012"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:07:08 -0800
X-CSE-ConnectionGUID: WFQ9HID4RUmhoCXJk7f2iw==
X-CSE-MsgGUID: XKTDHwwFSqGO3eXoXJUjEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="125793753"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Dec 2024 20:07:06 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKV30-0003n3-2r;
	Mon, 09 Dec 2024 04:07:02 +0000
Date: Mon, 9 Dec 2024 12:06:57 +0800
From: kernel test robot <lkp@intel.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <202412071154.l5pE0H0S-lkp@intel.com>
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
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20241207/202412071154.l5pE0H0S-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412071154.l5pE0H0S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071154.l5pE0H0S-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/open.c:12:
>> include/linux/fsnotify.h:258:20: error: redefinition of 'fsnotify_mntns_delete'
     258 | static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/fsnotify.h:15:
   include/linux/fsnotify_backend.h:914:20: note: previous definition of 'fsnotify_mntns_delete' with type 'void(struct mnt_namespace *)'
     914 | static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   include/linux/fsnotify.h: In function 'fsnotify_mntns_delete':
>> include/linux/fsnotify.h:260:9: error: implicit declaration of function '__fsnotify_mntns_delete'; did you mean 'fsnotify_mntns_delete'? [-Wimplicit-function-declaration]
     260 |         __fsnotify_mntns_delete(mntns);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         fsnotify_mntns_delete
--
   In file included from fs/namespace.c:22:
>> include/linux/fsnotify.h:258:20: error: redefinition of 'fsnotify_mntns_delete'
     258 | static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/fsnotify.h:15:
   include/linux/fsnotify_backend.h:914:20: note: previous definition of 'fsnotify_mntns_delete' with type 'void(struct mnt_namespace *)'
     914 | static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   include/linux/fsnotify.h: In function 'fsnotify_mntns_delete':
>> include/linux/fsnotify.h:260:9: error: implicit declaration of function '__fsnotify_mntns_delete'; did you mean 'fsnotify_mntns_delete'? [-Wimplicit-function-declaration]
     260 |         __fsnotify_mntns_delete(mntns);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         fsnotify_mntns_delete
   fs/namespace.c: In function 'queue_notify':
>> fs/namespace.c:1126:15: error: 'struct mnt_namespace' has no member named 'n_fsnotify_marks'
    1126 |         if (ns->n_fsnotify_marks)
         |               ^~


vim +/fsnotify_mntns_delete +258 include/linux/fsnotify.h

   257	
 > 258	static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
   259	{
 > 260		__fsnotify_mntns_delete(mntns);
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

