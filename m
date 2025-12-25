Return-Path: <linux-fsdevel+bounces-72079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3EDCDD3E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 04:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 165DD301CFA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 03:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168D2472A6;
	Thu, 25 Dec 2025 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0wIROli"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25AC205E25;
	Thu, 25 Dec 2025 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766632712; cv=none; b=ILsWu9Gk/8AupITuboVwJDNko/vdEfRUI26zWw1ofxfEH2eJiyrFXnMp61zh2q6EcNxGLPEywe9wyqIcD2ux/rOAliEbz83A15zRag4zR7dcY9/XEh9vYThSbnQe8lfdzOG7ImauKG14gXjQtSlfWj8CAQ+uZpJVE4HP8oTiYCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766632712; c=relaxed/simple;
	bh=UhH2roQaIORKlAWJx4LLpOinOzu1elW+yrcxpjEzyHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxuViQs8ESiyLynm3HoBsiAB4/ppGolTAw1lVdAkKnM7/7XuR61BesoKKIFnXbOTj+8r9EFo4Cw+pup1P8PxbUGMlG7yLeFIl00vIQNDyfChyLFN2Y8KXVQDXW10x085kNUJUFwotDt9QewrSx1xjFMxRCGUREL4x9tLxJxEeMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0wIROli; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766632711; x=1798168711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UhH2roQaIORKlAWJx4LLpOinOzu1elW+yrcxpjEzyHw=;
  b=l0wIROliGdmvtANASumhPk7PD8KDkVein4hHj4kOSlEb6XdQOc2Pa6aB
   ZJklowh2yaxtfUgaaljDrQxsvOcViaUzU09//HwQLOTMqUBhsTKaN8t51
   0P0IVbTOvNW2NYoY6egPkU2/Gn61nHD0ejWtnjET08DVDCfsPBp/RkNxP
   UUXHDnqXsQxl5SX0kTlzisZh/G2VPNkyDl/L90GeIAZuz1D8gAjtyzGgR
   k1u3rsbTDqU6HzrlcD5RUxQ4SfQ9xlCGfxAhzu00pO97jjg/V/D90fIQi
   RMVneORSNBUhfw5WPCmhTVRdFNrAdHH+s116sOUBGl3ClXnpdRlYTIWzB
   g==;
X-CSE-ConnectionGUID: /p587xHKTfmPkczJHL/lUg==
X-CSE-MsgGUID: gT9A9KywRcKUmocBjhRZNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="79813744"
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="79813744"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 19:18:30 -0800
X-CSE-ConnectionGUID: eil06ZHzQ6mCSWS3LVhJFg==
X-CSE-MsgGUID: gL86m4FtSj+3r/t0CTxMvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="200111036"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 24 Dec 2025 19:18:27 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYbrs-000000003gt-3bWg;
	Thu, 25 Dec 2025 03:18:24 +0000
Date: Thu, 25 Dec 2025 11:17:42 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, hsiangkao@linux.alibaba.com,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, hch@lst.de
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	lihongbo22@huawei.com
Subject: Re: [PATCH v11 05/10] erofs: support user-defined fingerprint name
Message-ID: <202512251005.yZVSPUOm-lkp@intel.com>
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
config: nios2-randconfig-r071-20251225 (https://download.01.org/0day-ci/archive/20251225/202512251005.yZVSPUOm-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251225/202512251005.yZVSPUOm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512251005.yZVSPUOm-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/erofs/super.c: In function 'erofs_read_superblock':
>> fs/erofs/super.c:302:20: error: 'struct erofs_sb_info' has no member named 'ishare_xattr_pfx'
     302 |                 sbi->ishare_xattr_pfx =
         |                    ^~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CAN_DEV
   Depends on [n]: NETDEVICES [=n] && CAN [=m]
   Selected by [m]:
   - CAN [=m] && NET [=y]


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

