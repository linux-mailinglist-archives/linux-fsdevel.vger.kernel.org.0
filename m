Return-Path: <linux-fsdevel+bounces-700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F827CE793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 21:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D2E281D12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F8450D7;
	Wed, 18 Oct 2023 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pz5L8CSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465B42BE3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 19:19:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DFD120;
	Wed, 18 Oct 2023 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697656760; x=1729192760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iGPJbyS6joPU8I9o2PYhfnt2iIQTBwStBxb7SO7ASug=;
  b=Pz5L8CSieakdmJjKSIhGO4DyqDgVsdLNScv/j7bRe32OJ1pNLxEIBXoX
   7PpkobClHwoopLvZoizCI1NH6eCO/aKPiI3w71XXMx09KKTvIY49E43oK
   +ViZArB1VmjxhU/OiBtJntj5yWuS7pHXHImUSAZWtUvJy3jRSaCkpjGIe
   o6TXwAjuF+/Jj9hoNbMxJYGAIaStKlSNWRJK05XUZNhO7EjjBG5f/lDS0
   vrHKY02qhFsHvr3aEE96+pceV3NbvOhhgQ8iQDFZPKQabqlGnMknbR78m
   2Y0N9wCOdj4MtA+W7acIxvJK81RTh1fmLFxa5gZgpBHEkVx/GNLNCWAZw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="384966120"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="384966120"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930314505"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="930314505"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2023 12:19:18 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qtC4Z-0000tA-2Y;
	Wed, 18 Oct 2023 19:19:15 +0000
Date: Thu, 19 Oct 2023 03:18:46 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Albershteyn <aalbersh@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, djwong@kernel.org, ebiggers@kernel.org,
	david@fromorbit.com, dchinner@redhat.com,
	Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v3 25/28] xfs: add fs-verity support
Message-ID: <202310190201.brxlwE23-lkp@intel.com>
References: <20231006184922.252188-26-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-26-aalbersh@redhat.com>

Hi Andrey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xfs-linux/for-next]
[also build test WARNING on kdave/for-next tytso-ext4/dev jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev linus/master v6.6-rc6 next-20231018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrey-Albershteyn/xfs-Add-new-name-to-attri-d/20231007-025742
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20231006184922.252188-26-aalbersh%40redhat.com
patch subject: [PATCH v3 25/28] xfs: add fs-verity support
config: i386-randconfig-063-20231018 (https://download.01.org/0day-ci/archive/20231019/202310190201.brxlwE23-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190201.brxlwE23-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310190201.brxlwE23-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/xfs/xfs_verity.c:165:1: sparse: sparse: symbol 'xfs_read_merkle_tree_block' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

