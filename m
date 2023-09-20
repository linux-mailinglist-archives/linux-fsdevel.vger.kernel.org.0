Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA5E7A8F9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 00:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjITWwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 18:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjITWws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:52:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43441B4;
        Wed, 20 Sep 2023 15:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695250363; x=1726786363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yVpODLTsfKSSpQf9Ave4nU9ZD6akZUgh1jMAjstIE1w=;
  b=GM7Cd8Pp+Q6KB9DE9Y4dGesUIoN1OvJzqSxMdJSolR+hza3Aneq3EgML
   yd4lGOMbNzExpqYMrIzLouTFlZnhhj6eJvVzKCL1x+6CWrROlZjpYbzV3
   +4fwrrP1ULmzJLCDXjj7hXD3fEXroKdWSDc+hshmPzxme7wHxNND/2xft
   LkcQo8bahxwKUjRmM6rxxzJJ2e/dwYAH7aycfaWQtbjUSllfQ8fKc2Vo6
   cDcas7R42fekm6RnFXc6nxmIe9wKdB7iC51I7ApVPg/6iAXUU3fOPzhHU
   mSJB896J7zitijSSRuL+0VgmX4VKKKmggBKi7eAnm69QDGKu56z1xosVW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360611726"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360611726"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 15:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="993808401"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="993808401"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 20 Sep 2023 15:52:26 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qj63T-0009EW-2b;
        Wed, 20 Sep 2023 22:52:23 +0000
Date:   Thu, 21 Sep 2023 06:51:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Max Kellermann <max.kellermann@ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inotify: support returning file_handles
Message-ID: <202309210656.zoCH7Ysu-lkp@intel.com>
References: <20230919202304.1197654-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919202304.1197654-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on jack-fs/fsnotify]
[also build test ERROR on linus/master v6.6-rc2 next-20230920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/inotify-support-returning-file_handles/20230920-042458
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
patch link:    https://lore.kernel.org/r/20230919202304.1197654-1-max.kellermann%40ionos.com
patch subject: [PATCH] inotify: support returning file_handles
config: mips-ath25_defconfig (https://download.01.org/0day-ci/archive/20230921/202309210656.zoCH7Ysu-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309210656.zoCH7Ysu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309210656.zoCH7Ysu-lkp@intel.com/

All errors (new ones prefixed by >>):

   mips-linux-ld: fs/notify/inotify/inotify_fsnotify.o: in function `inotify_handle_inode_event':
   inotify_fsnotify.c:(.text+0x200): undefined reference to `exportfs_encode_inode_fh'
>> mips-linux-ld: inotify_fsnotify.c:(.text+0x318): undefined reference to `exportfs_encode_inode_fh'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
