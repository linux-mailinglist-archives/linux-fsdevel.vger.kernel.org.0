Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E757BC304
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 01:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjJFXl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 19:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjJFXlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:41:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359B9BE;
        Fri,  6 Oct 2023 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696635714; x=1728171714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MXFKuN98ax1sJBYhFSUvy6stQK/fA6fvQV+pQnQmono=;
  b=BZdbdddbR7M21/5D0gnpf3hKz5JDTwtNZL++AcTVUzOaZVTatlCQPw0f
   S1RIodfMXPLvVbgeZI8w85/xH4JKUlnf7yRNTIS647RTvAvVrG7x3dIJ/
   DYl0WM6smIBYpwB3R+26656Q2TFPEzf/cHyW4j2Giz7RvPnCNVi63lsY7
   s3mXSbF9mYPQmAF4pAs8hgRyEOgSSRISAQfnnQX/j4zIu2TlLtQkSJ1rO
   KxR7hGm9VsRUWYVuwoA8kbClFEr2uVkzqvUOgl2wFpbqqL2prdmIsmhTO
   awEo7+pVh9AC2G0LJMd3m+SPRyf+yqc94tljl6iwGhdW/7c7pIjRePR6g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="374191554"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="374191554"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 16:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818170706"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="818170706"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2023 16:41:36 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qouRq-0003kL-0c;
        Fri, 06 Oct 2023 23:41:34 +0000
Date:   Sat, 7 Oct 2023 07:40:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, djwong@kernel.org,
        ebiggers@kernel.org, david@fromorbit.com, dchinner@redhat.com,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v3 25/28] xfs: add fs-verity support
Message-ID: <202310070701.WiXRnofP-lkp@intel.com>
References: <20231006184922.252188-26-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-26-aalbersh@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xfs-linux/for-next]
[also build test WARNING on kdave/for-next tytso-ext4/dev jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev linus/master v6.6-rc4 next-20231006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrey-Albershteyn/xfs-Add-new-name-to-attri-d/20231007-025742
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20231006184922.252188-26-aalbersh%40redhat.com
patch subject: [PATCH v3 25/28] xfs: add fs-verity support
config: powerpc64-randconfig-002-20231007 (https://download.01.org/0day-ci/archive/20231007/202310070701.WiXRnofP-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070701.WiXRnofP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070701.WiXRnofP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/xfs/xfs_verity.c:165:1: warning: no previous prototype for 'xfs_read_merkle_tree_block' [-Wmissing-prototypes]
     165 | xfs_read_merkle_tree_block(
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/xfs_read_merkle_tree_block +165 fs/xfs/xfs_verity.c

   163	
   164	int
 > 165	xfs_read_merkle_tree_block(
   166		struct inode		*inode,
   167		unsigned int		pos,
   168		struct fsverity_block	*block,
   169		unsigned long		num_ra_pages)
   170	{
   171		struct xfs_inode	*ip = XFS_I(inode);
   172		struct xfs_fsverity_merkle_key name;
   173		int			error = 0;
   174		struct xfs_da_args	args = {
   175			.dp		= ip,
   176			.attr_filter	= XFS_ATTR_VERITY,
   177			.namelen	= sizeof(struct xfs_fsverity_merkle_key),
   178		};
   179		xfs_fsverity_merkle_key_to_disk(&name, pos);
   180		args.name = (const uint8_t *)&name.merkleoff;
   181	
   182		error = xfs_attr_get(&args);
   183		if (error)
   184			goto out;
   185	
   186		WARN_ON_ONCE(!args.valuelen);
   187	
   188		/* now we also want to get underlying xfs_buf */
   189		args.op_flags = XFS_DA_OP_BUFFER;
   190		error = xfs_attr_get(&args);
   191		if (error)
   192			goto out;
   193	
   194		block->kaddr = args.value;
   195		block->len = args.valuelen;
   196		block->cached = args.bp->b_flags & XBF_VERITY_CHECKED;
   197		block->context = args.bp;
   198	
   199		return error;
   200	
   201	out:
   202		kmem_free(args.value);
   203		if (args.bp)
   204			xfs_buf_rele(args.bp);
   205		return error;
   206	}
   207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
