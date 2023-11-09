Return-Path: <linux-fsdevel+bounces-2468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E656E7E6398
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9436F281189
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA6D2E5;
	Thu,  9 Nov 2023 06:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEK8mvLR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C96D27D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:14:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3150C2587;
	Wed,  8 Nov 2023 22:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699510461; x=1731046461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lckBfTuMmgvgDrE6pOvFCArKZAwwbxnPo0ivG4mnKeo=;
  b=mEK8mvLRGYBD+VEMXIj3vOmab/GbTLImR6zU2MBKSY8k1HL0VZ0jz+4H
   u80R5okZjwmgM/kOVU0s4jtbY/qfvckv7MXSt0NCOo7izsGgeqM4Uhdcn
   T1WB5niSjXvWS14pmsXswHhuscEEnsLytxYiWJ3oe347/nFHg/THese3A
   BK/dBpMpnVTKAdUkAEjijwyYoHwHiOFfDNZzTvUzHU9Hm8zFGeRYjU3qi
   RedpKn52uPQcWOFNeN2YCQ3RDlFt72pZ7YAN5bIz5bIm8WAkTqMhbhqAO
   SiJE9ifdUWiDUJZ/zsOFkcB7E8lEGPq/C+9pd8Ldl44MeGqpQ/IucSBrT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="388779931"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="388779931"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 22:14:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="11433456"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Nov 2023 22:14:18 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r0yIx-0008WO-1i;
	Thu, 09 Nov 2023 06:14:15 +0000
Date: Thu, 9 Nov 2023 14:13:45 +0800
From: kernel test robot <lkp@intel.com>
To: WoZ1zh1 <wozizhi@huawei.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
	jlayton@kernel.org, dchinner@redhat.com, cyphar@cyphar.com,
	shr@devkernel.io
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, wozizhi@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH -next V2] proc: support file->f_pos checking in mem_lseek
Message-ID: <202311091307.k2L6reDL-lkp@intel.com>
References: <20231109102658.2075547-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109102658.2075547-1-wozizhi@huawei.com>

Hi WoZ1zh1,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231108]

url:    https://github.com/intel-lab-lkp/linux/commits/WoZ1zh1/proc-support-file-f_pos-checking-in-mem_lseek/20231109-103353
base:   next-20231108
patch link:    https://lore.kernel.org/r/20231109102658.2075547-1-wozizhi%40huawei.com
patch subject: [PATCH -next V2] proc: support file->f_pos checking in mem_lseek
config: arc-randconfig-001-20231109 (https://download.01.org/0day-ci/archive/20231109/202311091307.k2L6reDL-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311091307.k2L6reDL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311091307.k2L6reDL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/proc/base.c: In function 'mem_lseek':
>> fs/proc/base.c:911:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
     911 |                 offset += file->f_pos;
         |                 ~~~~~~~^~~~~~~~~~~~~~
   fs/proc/base.c:912:9: note: here
     912 |         case SEEK_SET:
         |         ^~~~


vim +911 fs/proc/base.c

   903	
   904	loff_t mem_lseek(struct file *file, loff_t offset, int orig)
   905	{
   906		loff_t ret = 0;
   907	
   908		spin_lock(&file->f_lock);
   909		switch (orig) {
   910		case SEEK_CUR:
 > 911			offset += file->f_pos;
   912		case SEEK_SET:
   913			/* to avoid userland mistaking f_pos=-9 as -EBADF=-9 */
   914			if ((unsigned long long)offset >= -MAX_ERRNO)
   915				ret = -EOVERFLOW;
   916			break;
   917		default:
   918			ret = -EINVAL;
   919		}
   920		if (!ret) {
   921			if (offset < 0 && !(unsigned_offsets(file))) {
   922				ret = -EINVAL;
   923			} else {
   924				file->f_pos = offset;
   925				ret = file->f_pos;
   926				force_successful_syscall_return();
   927			}
   928		}
   929	
   930		spin_unlock(&file->f_lock);
   931		return ret;
   932	}
   933	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

