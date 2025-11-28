Return-Path: <linux-fsdevel+bounces-70099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C79BAC90884
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A5D84E42A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4838261B91;
	Fri, 28 Nov 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKNqitI2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B381EA7EC;
	Fri, 28 Nov 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294593; cv=none; b=gAGymAzdwkoQ660T+eYregyO82Qv/Rg2jypbLG04nAz3nQv+kZiPi5Kt9oup2OYrgE9KI5ZN3dNcJGevvf4LEeVSGo44zan+w20JBsRs8px2C9MNs9Tf7EEQhoaFHRFtSi+gEfAYTbbRrC7G8j9dJ7dGLLfjkgGFJbMLVBAO0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294593; c=relaxed/simple;
	bh=Ezjf5cOt8h0dpJHTgbnsIsUwiE2lnG6zvSzKN3xPY98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2ck5C1BeL1IzMdJO7WCp74MIlu2+Q08WYSNwwqUu0WIfZonm77JDNI7tkk7tffkaeq+7PHJojA4o2Zp6wI6avhbgMh2rq1kRuJ7U1bb1z/4ePhaercQ9l/kkc+urZHAMrUYqX2xMHXyYJ5IxNqah5hL3fHWXf231oJ86Qaq16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKNqitI2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764294591; x=1795830591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ezjf5cOt8h0dpJHTgbnsIsUwiE2lnG6zvSzKN3xPY98=;
  b=oKNqitI2s3A2Iuc6RaDA9aWTWG9564gtg67uRxn8eaer43xSry0kBpRR
   AelpFwwiMyVaWipOePiX9idlg0tXrMsf8BgaQkxCOQWOWSo3bk8zlUB6i
   3c3PV6hVmZdc50T8c3uKZ+5p7QZzANzs0tH4eaC/BLtLjCvljnLY6IniC
   LbafMyKo8AUcxkbBa6MTnrKhOHwQtucX440mmOmF9GTfSPkOgzVFcbFDS
   rspZMjOX9OCbMD6T8nk0QRhXoGqCMcBjdctWi4hP97KiQTi0V6sNzN8vW
   ENuEHQFAup3RIJv+QPAOIQtkPEnSJ+Qz/Dac+uVvGG8JJr2mrre2dBmrO
   w==;
X-CSE-ConnectionGUID: EpBtr/bYTZCfheP7ierBmQ==
X-CSE-MsgGUID: aZXOIgr9SmO+pbnYO9GSpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="70193057"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="70193057"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 17:49:51 -0800
X-CSE-ConnectionGUID: UlmQkNXWT2SsmK62YWUM/g==
X-CSE-MsgGUID: oP+W/LHYSwCcz5Hhqvqx9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="224047453"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Nov 2025 17:49:48 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOncI-000000005uP-0xIY;
	Fri, 28 Nov 2025 01:49:46 +0000
Date: Fri, 28 Nov 2025 09:48:53 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: Re: [PATCH 1/3] ceph: handle InodeStat v8 versioned field in reply
 parsing
Message-ID: <202511280915.HZ1rLMsq-lkp@intel.com>
References: <20251127134620.2035796-2-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127134620.2035796-2-amarkuze@redhat.com>

Hi Alex,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ceph-client/for-linus]
[also build test WARNING on linus/master v6.18-rc7 next-20251127]
[cannot apply to ceph-client/testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Markuze/ceph-handle-InodeStat-v8-versioned-field-in-reply-parsing/20251127-214928
base:   https://github.com/ceph/ceph-client.git for-linus
patch link:    https://lore.kernel.org/r/20251127134620.2035796-2-amarkuze%40redhat.com
patch subject: [PATCH 1/3] ceph: handle InodeStat v8 versioned field in reply parsing
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20251128/202511280915.HZ1rLMsq-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251128/202511280915.HZ1rLMsq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511280915.HZ1rLMsq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ceph/mds_client.c:237:7: warning: variable 'v8_struct_v' set but not used [-Wunused-but-set-variable]
     237 |                         u8 v8_struct_v, v8_struct_compat;
         |                            ^
>> fs/ceph/mds_client.c:237:20: warning: variable 'v8_struct_compat' set but not used [-Wunused-but-set-variable]
     237 |                         u8 v8_struct_v, v8_struct_compat;
         |                                         ^
   2 warnings generated.


vim +/v8_struct_v +237 fs/ceph/mds_client.c

    97	
    98	/*
    99	 * parse individual inode info
   100	 */
   101	static int parse_reply_info_in(void **p, void *end,
   102				       struct ceph_mds_reply_info_in *info,
   103				       u64 features)
   104	{
   105		int err = 0;
   106		u8 struct_v = 0;
   107	
   108		if (features == (u64)-1) {
   109			u32 struct_len;
   110			u8 struct_compat;
   111			ceph_decode_8_safe(p, end, struct_v, bad);
   112			ceph_decode_8_safe(p, end, struct_compat, bad);
   113			/* struct_v is expected to be >= 1. we only understand
   114			 * encoding with struct_compat == 1. */
   115			if (!struct_v || struct_compat != 1)
   116				goto bad;
   117			ceph_decode_32_safe(p, end, struct_len, bad);
   118			ceph_decode_need(p, end, struct_len, bad);
   119			end = *p + struct_len;
   120		}
   121	
   122		ceph_decode_need(p, end, sizeof(struct ceph_mds_reply_inode), bad);
   123		info->in = *p;
   124		*p += sizeof(struct ceph_mds_reply_inode) +
   125			sizeof(*info->in->fragtree.splits) *
   126			le32_to_cpu(info->in->fragtree.nsplits);
   127	
   128		ceph_decode_32_safe(p, end, info->symlink_len, bad);
   129		ceph_decode_need(p, end, info->symlink_len, bad);
   130		info->symlink = *p;
   131		*p += info->symlink_len;
   132	
   133		ceph_decode_copy_safe(p, end, &info->dir_layout,
   134				      sizeof(info->dir_layout), bad);
   135		ceph_decode_32_safe(p, end, info->xattr_len, bad);
   136		ceph_decode_need(p, end, info->xattr_len, bad);
   137		info->xattr_data = *p;
   138		*p += info->xattr_len;
   139	
   140		if (features == (u64)-1) {
   141			/* inline data */
   142			ceph_decode_64_safe(p, end, info->inline_version, bad);
   143			ceph_decode_32_safe(p, end, info->inline_len, bad);
   144			ceph_decode_need(p, end, info->inline_len, bad);
   145			info->inline_data = *p;
   146			*p += info->inline_len;
   147			/* quota */
   148			err = parse_reply_info_quota(p, end, info);
   149			if (err < 0)
   150				goto out_bad;
   151			/* pool namespace */
   152			ceph_decode_32_safe(p, end, info->pool_ns_len, bad);
   153			if (info->pool_ns_len > 0) {
   154				ceph_decode_need(p, end, info->pool_ns_len, bad);
   155				info->pool_ns_data = *p;
   156				*p += info->pool_ns_len;
   157			}
   158	
   159			/* btime */
   160			ceph_decode_need(p, end, sizeof(info->btime), bad);
   161			ceph_decode_copy(p, &info->btime, sizeof(info->btime));
   162	
   163			/* change attribute */
   164			ceph_decode_64_safe(p, end, info->change_attr, bad);
   165	
   166			/* dir pin */
   167			if (struct_v >= 2) {
   168				ceph_decode_32_safe(p, end, info->dir_pin, bad);
   169			} else {
   170				info->dir_pin = -ENODATA;
   171			}
   172	
   173			/* snapshot birth time, remains zero for v<=2 */
   174			if (struct_v >= 3) {
   175				ceph_decode_need(p, end, sizeof(info->snap_btime), bad);
   176				ceph_decode_copy(p, &info->snap_btime,
   177						 sizeof(info->snap_btime));
   178			} else {
   179				memset(&info->snap_btime, 0, sizeof(info->snap_btime));
   180			}
   181	
   182			/* snapshot count, remains zero for v<=3 */
   183			if (struct_v >= 4) {
   184				ceph_decode_64_safe(p, end, info->rsnaps, bad);
   185			} else {
   186				info->rsnaps = 0;
   187			}
   188	
   189			if (struct_v >= 5) {
   190				u32 alen;
   191	
   192				ceph_decode_32_safe(p, end, alen, bad);
   193	
   194				while (alen--) {
   195					u32 len;
   196	
   197					/* key */
   198					ceph_decode_32_safe(p, end, len, bad);
   199					ceph_decode_skip_n(p, end, len, bad);
   200					/* value */
   201					ceph_decode_32_safe(p, end, len, bad);
   202					ceph_decode_skip_n(p, end, len, bad);
   203				}
   204			}
   205	
   206			/* fscrypt flag -- ignore */
   207			if (struct_v >= 6)
   208				ceph_decode_skip_8(p, end, bad);
   209	
   210			info->fscrypt_auth = NULL;
   211			info->fscrypt_auth_len = 0;
   212			info->fscrypt_file = NULL;
   213			info->fscrypt_file_len = 0;
   214			if (struct_v >= 7) {
   215				ceph_decode_32_safe(p, end, info->fscrypt_auth_len, bad);
   216				if (info->fscrypt_auth_len) {
   217					info->fscrypt_auth = kmalloc(info->fscrypt_auth_len,
   218								     GFP_KERNEL);
   219					if (!info->fscrypt_auth)
   220						return -ENOMEM;
   221					ceph_decode_copy_safe(p, end, info->fscrypt_auth,
   222							      info->fscrypt_auth_len, bad);
   223				}
   224				ceph_decode_32_safe(p, end, info->fscrypt_file_len, bad);
   225				if (info->fscrypt_file_len) {
   226					info->fscrypt_file = kmalloc(info->fscrypt_file_len,
   227								     GFP_KERNEL);
   228					if (!info->fscrypt_file)
   229						return -ENOMEM;
   230					ceph_decode_copy_safe(p, end, info->fscrypt_file,
   231							      info->fscrypt_file_len, bad);
   232				}
   233			}
   234	
   235			/* struct_v 8 added a versioned field - skip it */
   236			if (struct_v >= 8) {
 > 237				u8 v8_struct_v, v8_struct_compat;
   238				u32 v8_struct_len;
   239	
   240				ceph_decode_8_safe(p, end, v8_struct_v, bad);
   241				ceph_decode_8_safe(p, end, v8_struct_compat, bad);
   242				ceph_decode_32_safe(p, end, v8_struct_len, bad);
   243				ceph_decode_skip_n(p, end, v8_struct_len, bad);
   244			}
   245	
   246			*p = end;
   247		} else {
   248			/* legacy (unversioned) struct */
   249			if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
   250				ceph_decode_64_safe(p, end, info->inline_version, bad);
   251				ceph_decode_32_safe(p, end, info->inline_len, bad);
   252				ceph_decode_need(p, end, info->inline_len, bad);
   253				info->inline_data = *p;
   254				*p += info->inline_len;
   255			} else
   256				info->inline_version = CEPH_INLINE_NONE;
   257	
   258			if (features & CEPH_FEATURE_MDS_QUOTA) {
   259				err = parse_reply_info_quota(p, end, info);
   260				if (err < 0)
   261					goto out_bad;
   262			} else {
   263				info->max_bytes = 0;
   264				info->max_files = 0;
   265			}
   266	
   267			info->pool_ns_len = 0;
   268			info->pool_ns_data = NULL;
   269			if (features & CEPH_FEATURE_FS_FILE_LAYOUT_V2) {
   270				ceph_decode_32_safe(p, end, info->pool_ns_len, bad);
   271				if (info->pool_ns_len > 0) {
   272					ceph_decode_need(p, end, info->pool_ns_len, bad);
   273					info->pool_ns_data = *p;
   274					*p += info->pool_ns_len;
   275				}
   276			}
   277	
   278			if (features & CEPH_FEATURE_FS_BTIME) {
   279				ceph_decode_need(p, end, sizeof(info->btime), bad);
   280				ceph_decode_copy(p, &info->btime, sizeof(info->btime));
   281				ceph_decode_64_safe(p, end, info->change_attr, bad);
   282			}
   283	
   284			info->dir_pin = -ENODATA;
   285			/* info->snap_btime and info->rsnaps remain zero */
   286		}
   287		return 0;
   288	bad:
   289		err = -EIO;
   290	out_bad:
   291		return err;
   292	}
   293	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

