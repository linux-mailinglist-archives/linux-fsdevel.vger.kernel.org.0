Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5BC7779B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjHJNfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHJNfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:35:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8D8171D
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691674515; x=1723210515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QHg4GqOEkKomsCC9eIf23A3BJUv5+Fa3PU75g/XAUS8=;
  b=F0w/2WYmXtIyQD+GVsmGxuhC2ISiLynj+N0zuP5ZuZWzGN5cyZ53BWXr
   Pgx98d+zK270xb1MpOtQpizn5KtY7bzqD0tyS9SNY4pC26kyIORvnMEnS
   D/sZiwydM19ekOzVarbUmGUatRLAPFf2fm3q1f9Zem8GmCKKZ8ZCO8sEh
   gmleKrSwd9RJ/7uNwAKyr+1tu/X5AP+qAXNZfVHD7yA/vwyaW3EGs++gj
   9mtTsvs5L45UOnKCSjLL5VRQ4qWe3O/UdmuVUuypUjTo/PiaOYRlvOsTF
   ZneDcLKJnAJgkqLGdjj7Xi0ayQJdVZKpomVHnI6tW1dcHHQFYuW6mID84
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="435297037"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="435297037"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 06:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="906066818"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="906066818"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2023 06:35:11 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qU5ok-00072C-24;
        Thu, 10 Aug 2023 13:35:10 +0000
Date:   Thu, 10 Aug 2023 21:34:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/5] fuse: implement statx
Message-ID: <202308102130.EEqF5GG3-lkp@intel.com>
References: <20230810105501.1418427-5-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810105501.1418427-5-mszeredi@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-fuse/for-next]
[also build test WARNING on linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miklos-Szeredi/fuse-handle-empty-request_mask-in-statx/20230810-185708
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20230810105501.1418427-5-mszeredi%40redhat.com
patch subject: [PATCH 4/5] fuse: implement statx
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230810/202308102130.EEqF5GG3-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308102130.EEqF5GG3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308102130.EEqF5GG3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/fuse/dir.c:353:6: warning: no previous prototype for 'fuse_valid_size' [-Wmissing-prototypes]
     353 | bool fuse_valid_size(u64 size)
         |      ^~~~~~~~~~~~~~~


vim +/fuse_valid_size +353 fs/fuse/dir.c

   352	
 > 353	bool fuse_valid_size(u64 size)
   354	{
   355		return size <= LLONG_MAX;
   356	}
   357	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
