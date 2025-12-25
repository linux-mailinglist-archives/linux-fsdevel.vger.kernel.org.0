Return-Path: <linux-fsdevel+bounces-72081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59894CDD486
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 05:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 998A2301F275
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 04:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076DE2848A4;
	Thu, 25 Dec 2025 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAd8yL/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4727A91D;
	Thu, 25 Dec 2025 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766635774; cv=none; b=ibILizlpFWhfJkQyn4E7JzTXbhWWaIopt0b4M+uNEO2VM4zr+PHU3WmlTKnTUZ1HUqe1i3AVNLQeZ7MbiWX+8DIvgnZoO2GnRMINzCUbPNczh1zI44mKzTeeeMvuAnHKWkz6P6FFW9DzB+SVAyxW4ZoRCFP9VZNvxirzdGVrXA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766635774; c=relaxed/simple;
	bh=usci4oWgBXO6Khv7C0L0mAXCj79IKm97m8nFeRZ4CsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huckRzLgvaqypfMGVGfiSDLKZLMPSysfYzvNM0PdPRaN+ZXcbI5u0ytg9j2YJ0hMbART+te6KxspvjsqcM1AfOIdewtEVJjpEWp7oGj58O2u9VvAyhMTuHUAOLT7WKs59tT2aR1JzT2IO9Br9cPoTg7qzRg9YeiNY5DkY9IEH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAd8yL/z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766635773; x=1798171773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=usci4oWgBXO6Khv7C0L0mAXCj79IKm97m8nFeRZ4CsE=;
  b=MAd8yL/zx5nE1CjSn8DZblJPNIQAqjmCXAMI0c+3qKlDv36sCgb9ddoD
   /mNvVo2uLbfMH5ipAaOhQbGEa+HduwD2CSqVCsSxUXsOj1O4AJ6dKBElV
   GOuOepUrK6Gm9TyLmAS+TV+BSOM44YwUzxbdbR3s86Uirp7M9UsQZ8HyZ
   ONrTY2L2FF/rs8d/ISZka7ZVuqiHXomArG6Sb1D3UxVwoUZYEMa54/ftZ
   JqUdsP7w/5WcCePxOIAsNZ0cPqPZe9dOKV1zbhG6PfVJDDqOBAKnbUP9R
   N71s0rtus5mvwWJHosey79W8sc3MUHo2jCfwU5Beg0Fy5teNnYiQz36oI
   Q==;
X-CSE-ConnectionGUID: +yHfIKgBTsuV+Z6aqunqzA==
X-CSE-MsgGUID: OVFiMWoPRD2x4l51QYoedQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="78758163"
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="78758163"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 20:09:32 -0800
X-CSE-ConnectionGUID: f9VP/PgWTvCURk+tklKXXA==
X-CSE-MsgGUID: q/L62GGxS060Bx2vW0qdKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="200634034"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 24 Dec 2025 20:09:28 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYcfG-000000003il-2377;
	Thu, 25 Dec 2025 04:09:26 +0000
Date: Thu, 25 Dec 2025 12:08:44 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, hsiangkao@linux.alibaba.com,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, hch@lst.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH v11 05/10] erofs: support user-defined fingerprint name
Message-ID: <202512251143.WPBiiQZA-lkp@intel.com>
References: <20251224040932.496478-6-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224040932.496478-6-lihongbo22@huawei.com>

Hi Hongbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes brauner-vfs/vfs.all linus/master v6.19-rc2 next-20251219]
[cannot apply to mszeredi-fuse/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/iomap-stash-iomap-read-ctx-in-the-private-field-of-iomap_iter/20251224-122950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20251224040932.496478-6-lihongbo22%40huawei.com
patch subject: [PATCH v11 05/10] erofs: support user-defined fingerprint name
config: powerpc-randconfig-001-20251225 (https://download.01.org/0day-ci/archive/20251225/202512251143.WPBiiQZA-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 4ef602d446057dabf5f61fb221669ecbeda49279)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251225/202512251143.WPBiiQZA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512251143.WPBiiQZA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/erofs/super.c:302:8: error: no member named 'ishare_xattr_pfx' in 'struct erofs_sb_info'
     302 |                 sbi->ishare_xattr_pfx =
         |                 ~~~  ^
   1 error generated.


vim +302 fs/erofs/super.c

   263	
   264	static int erofs_read_superblock(struct super_block *sb)
   265	{
   266		struct erofs_sb_info *sbi = EROFS_SB(sb);
   267		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
   268		struct erofs_super_block *dsb;
   269		void *data;
   270		int ret;
   271	
   272		data = erofs_read_metabuf(&buf, sb, 0, false);
   273		if (IS_ERR(data)) {
   274			erofs_err(sb, "cannot read erofs superblock");
   275			return PTR_ERR(data);
   276		}
   277	
   278		dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
   279		ret = -EINVAL;
   280		if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
   281			erofs_err(sb, "cannot find valid erofs superblock");
   282			goto out;
   283		}
   284	
   285		sbi->blkszbits = dsb->blkszbits;
   286		if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
   287			erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
   288			goto out;
   289		}
   290		if (dsb->dirblkbits) {
   291			erofs_err(sb, "dirblkbits %u isn't supported", dsb->dirblkbits);
   292			goto out;
   293		}
   294	
   295		sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
   296		if (erofs_sb_has_sb_chksum(sbi)) {
   297			ret = erofs_superblock_csum_verify(sb, data);
   298			if (ret)
   299				goto out;
   300		}
   301		if (erofs_sb_has_ishare_xattrs(sbi))
 > 302			sbi->ishare_xattr_pfx =
   303				dsb->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;
   304	
   305		ret = -EINVAL;
   306		sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
   307		if (sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT) {
   308			erofs_err(sb, "unidentified incompatible feature %x, please upgrade kernel",
   309				  sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT);
   310			goto out;
   311		}
   312	
   313		sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
   314		if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
   315			erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
   316				  sbi->sb_size);
   317			goto out;
   318		}
   319		sbi->dif0.blocks = le32_to_cpu(dsb->blocks_lo);
   320		sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
   321	#ifdef CONFIG_EROFS_FS_XATTR
   322		sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
   323		sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
   324		sbi->xattr_prefix_count = dsb->xattr_prefix_count;
   325		sbi->xattr_filter_reserved = dsb->xattr_filter_reserved;
   326	#endif
   327		sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
   328		if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
   329			sbi->root_nid = le64_to_cpu(dsb->rootnid_8b);
   330			sbi->dif0.blocks = sbi->dif0.blocks |
   331					((u64)le16_to_cpu(dsb->rb.blocks_hi) << 32);
   332		} else {
   333			sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
   334		}
   335		sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
   336		if (erofs_sb_has_metabox(sbi)) {
   337			if (sbi->sb_size <= offsetof(struct erofs_super_block,
   338						     metabox_nid))
   339				return -EFSCORRUPTED;
   340			sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
   341			if (sbi->metabox_nid & BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
   342				return -EFSCORRUPTED;	/* self-loop detection */
   343		}
   344		sbi->inos = le64_to_cpu(dsb->inos);
   345	
   346		sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
   347		sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
   348		super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
   349	
   350		if (dsb->volume_name[0]) {
   351			sbi->volume_name = kstrndup(dsb->volume_name,
   352						    sizeof(dsb->volume_name), GFP_KERNEL);
   353			if (!sbi->volume_name)
   354				return -ENOMEM;
   355		}
   356	
   357		/* parse on-disk compression configurations */
   358		ret = z_erofs_parse_cfgs(sb, dsb);
   359		if (ret < 0)
   360			goto out;
   361	
   362		ret = erofs_scan_devices(sb, dsb);
   363	
   364		if (erofs_sb_has_48bit(sbi))
   365			erofs_info(sb, "EXPERIMENTAL 48-bit layout support in use. Use at your own risk!");
   366		if (erofs_sb_has_metabox(sbi))
   367			erofs_info(sb, "EXPERIMENTAL metadata compression support in use. Use at your own risk!");
   368		if (erofs_is_fscache_mode(sb))
   369			erofs_info(sb, "[deprecated] fscache-based on-demand read feature in use. Use at your own risk!");
   370	out:
   371		erofs_put_metabuf(&buf);
   372		return ret;
   373	}
   374	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

