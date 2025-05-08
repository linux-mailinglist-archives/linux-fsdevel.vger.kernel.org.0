Return-Path: <linux-fsdevel+bounces-48481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D85AAFB4D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374777B9497
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 13:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF522D4D7;
	Thu,  8 May 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T16MpJ1m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9E22577D;
	Thu,  8 May 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710827; cv=none; b=XPvDLn6mKktQ6t5Vm0nyroMfgnB24yJjRacem/iLuGgt8SqZXunOjnCk8oSotEI1YbVPAb2wRezZzY+Zvq1JANYfzCU98GcnPG0vD7yO0JlpD1sIqF8BclUF6pL5LKPvuZ9lKo4GM4lOU/Nac7hHYwq7T5dCPhGrICoT9wyzEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710827; c=relaxed/simple;
	bh=D6Da8xHdnluvwpHVpZn3DSIuOqzeWnOu7ERlbSMv9HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgZGIMIul7sSA7Ns4oj4SQ9Z2lnIna80GteXzfbFgerTh8wC9XItLgYtcd9u+SWJdxfTVIWJ/Z1Pocax8AS9SvFWVlqy+K3SiyloxCo2bpsE3Ql0CFTU3XXXsaaa4Cf+Tth+oX+5w3sLIva8xWoJk3q267mdVByYvwkKFs1a4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T16MpJ1m; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746710824; x=1778246824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D6Da8xHdnluvwpHVpZn3DSIuOqzeWnOu7ERlbSMv9HA=;
  b=T16MpJ1mI7wPvJxyW4MuzDbkDOaTcgmejVIJs93jGwL1nTLu+gT6H+F1
   rOasmtnKUm83y7LfiMA+LBSo54GY6DE7mL0ZEjJLp9EqLYRBd1lOI23M4
   rCJBqprMqUI+jqlkaKdDTjvXt8bBuaSP5duAXR6e5XkrjO/gMaBqLtMXk
   d8PWtArDbCQih3MRvsyyLcDKTSFz4ry1MRy04dzL0AzIediwECO0Jv2LQ
   rx23If6AZsFTn9HCkM+BKmr47+jE9thKfk0iar3D/GOe6ll/1AF83vmuK
   WuE1nVzvCvHIISuMu0mSlqI/fFGFGKjmST3dvv15F/XL2LhQ0te5w5oC9
   Q==;
X-CSE-ConnectionGUID: QKpyri/OTtOQ/jdlrSctLw==
X-CSE-MsgGUID: dppwZdmNQLOztLwagwVOkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48201548"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="48201548"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 06:27:04 -0700
X-CSE-ConnectionGUID: zlF4lWxXT6ybGwDkh0Jg2g==
X-CSE-MsgGUID: 39YJMuXwRM6ZJ7/m13RM+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136304522"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 May 2025 06:27:01 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uD1H9-000Azn-1o;
	Thu, 08 May 2025 13:26:59 +0000
Date: Thu, 8 May 2025 21:26:18 +0800
From: kernel test robot <lkp@intel.com>
To: Yangtao Li <frank.li@vivo.com>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfs: export dbg_flags in debugfs
Message-ID: <202505082102.YBG1Di7L-lkp@intel.com>
References: <20250507145550.425303-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507145550.425303-1-frank.li@vivo.com>

Hi Yangtao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.15-rc5 next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yangtao-Li/hfs-export-dbg_flags-in-debugfs/20250507-224016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250507145550.425303-1-frank.li%40vivo.com
patch subject: [PATCH] hfs: export dbg_flags in debugfs
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20250508/202505082102.YBG1Di7L-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505082102.YBG1Di7L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505082102.YBG1Di7L-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/hfs/bnode.c: In function 'hfs_bnode_dump':
>> fs/hfs/bnode.c:176:29: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
     176 |                         int tmp;
         |                             ^~~
   At top level:
   cc1: note: unrecognized command-line option '-Wno-unterminated-string-initialization' may have been intended to silence earlier diagnostics


vim +/tmp +176 fs/hfs/bnode.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  147  
^1da177e4c3f415 Linus Torvalds 2005-04-16  148  void hfs_bnode_dump(struct hfs_bnode *node)
^1da177e4c3f415 Linus Torvalds 2005-04-16  149  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  150  	struct hfs_bnode_desc desc;
^1da177e4c3f415 Linus Torvalds 2005-04-16  151  	__be32 cnid;
^1da177e4c3f415 Linus Torvalds 2005-04-16  152  	int i, off, key_off;
^1da177e4c3f415 Linus Torvalds 2005-04-16  153  
c2b3e1f76e5c902 Joe Perches    2013-04-30  154  	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
^1da177e4c3f415 Linus Torvalds 2005-04-16  155  	hfs_bnode_read(node, &desc, 0, sizeof(desc));
c2b3e1f76e5c902 Joe Perches    2013-04-30  156  	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
^1da177e4c3f415 Linus Torvalds 2005-04-16  157  		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
^1da177e4c3f415 Linus Torvalds 2005-04-16  158  		desc.type, desc.height, be16_to_cpu(desc.num_recs));
^1da177e4c3f415 Linus Torvalds 2005-04-16  159  
^1da177e4c3f415 Linus Torvalds 2005-04-16  160  	off = node->tree->node_size - 2;
^1da177e4c3f415 Linus Torvalds 2005-04-16  161  	for (i = be16_to_cpu(desc.num_recs); i >= 0; off -= 2, i--) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  162  		key_off = hfs_bnode_read_u16(node, off);
c2b3e1f76e5c902 Joe Perches    2013-04-30  163  		hfs_dbg_cont(BNODE_MOD, " %d", key_off);
^1da177e4c3f415 Linus Torvalds 2005-04-16  164  		if (i && node->type == HFS_NODE_INDEX) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  165  			int tmp;
^1da177e4c3f415 Linus Torvalds 2005-04-16  166  
^1da177e4c3f415 Linus Torvalds 2005-04-16  167  			if (node->tree->attributes & HFS_TREE_VARIDXKEYS)
^1da177e4c3f415 Linus Torvalds 2005-04-16  168  				tmp = (hfs_bnode_read_u8(node, key_off) | 1) + 1;
^1da177e4c3f415 Linus Torvalds 2005-04-16  169  			else
^1da177e4c3f415 Linus Torvalds 2005-04-16  170  				tmp = node->tree->max_key_len + 1;
c2b3e1f76e5c902 Joe Perches    2013-04-30  171  			hfs_dbg_cont(BNODE_MOD, " (%d,%d",
c2b3e1f76e5c902 Joe Perches    2013-04-30  172  				     tmp, hfs_bnode_read_u8(node, key_off));
^1da177e4c3f415 Linus Torvalds 2005-04-16  173  			hfs_bnode_read(node, &cnid, key_off + tmp, 4);
c2b3e1f76e5c902 Joe Perches    2013-04-30  174  			hfs_dbg_cont(BNODE_MOD, ",%d)", be32_to_cpu(cnid));
^1da177e4c3f415 Linus Torvalds 2005-04-16  175  		} else if (i && node->type == HFS_NODE_LEAF) {
^1da177e4c3f415 Linus Torvalds 2005-04-16 @176  			int tmp;
^1da177e4c3f415 Linus Torvalds 2005-04-16  177  
^1da177e4c3f415 Linus Torvalds 2005-04-16  178  			tmp = hfs_bnode_read_u8(node, key_off);
c2b3e1f76e5c902 Joe Perches    2013-04-30  179  			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
^1da177e4c3f415 Linus Torvalds 2005-04-16  180  		}
^1da177e4c3f415 Linus Torvalds 2005-04-16  181  	}
c2b3e1f76e5c902 Joe Perches    2013-04-30  182  	hfs_dbg_cont(BNODE_MOD, "\n");
^1da177e4c3f415 Linus Torvalds 2005-04-16  183  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  184  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

